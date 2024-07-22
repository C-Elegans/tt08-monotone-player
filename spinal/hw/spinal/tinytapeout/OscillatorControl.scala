package tinytapeout

import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.fsm._

case class OscillatorControl(numOscillators: Int, frameLength: Int) extends Component {
  val io = new Bundle {
    val readReq = master(Stream(UInt(16 bits)))
    val readResp = slave(Flow(Bits(8 bits)))
    val oscillatorIncrements = out(Vec(UInt(12 bits), numOscillators))
    val oscillator_en = out(Bool())
  }

  val pc = Reg(UInt(16 bits)) init(0)

  val oscillatorPrescaler = Counter(64, True)
  val oscillatorEn = oscillatorPrescaler.willOverflow
  io.oscillator_en := oscillatorEn

  val counter = Counter(frameLength, oscillatorEn)
  val frameStart = counter.willOverflow

  io.readReq.payload := pc
  io.readReq.valid := False

  val oscillatorControl = Reg(Vec(UInt(12 bits), numOscillators))
  io.oscillatorIncrements := oscillatorControl



  val oscillatorSel = Reg(UInt(2 bits))
  val tempData = Reg(UInt(4 bits))
  val controlFsm = new StateMachine {
    val fetchCmd: State = new State {
      whenIsActive {
        io.readReq.valid := True
        when(io.readReq.ready){
          pc := pc + 1
          goto(decodeCmd)
        }
      }
    }
    val decodeCmd : State = new State {
      whenIsActive {
        when(io.readResp.valid){
          val command = io.readResp.payload(7 downto 4)
          val data = io.readResp.payload(3 downto 0)
          switch(command) {
            is(0) {
              goto(fetchCmd)
            }
            is(1) {
              tempData := data.asUInt
              goto(waitFrameEnd)
            }
            is(2) {
              tempData := data.asUInt
              goto(readPC)
            }
            is(0xc) {
              oscillatorSel := 0
              tempData := data.asUInt
              goto(setOscillatorRead)
            }
            if(numOscillators >= 2)
            is(0xd) {
              oscillatorSel := 1
              tempData := data.asUInt
              goto(setOscillatorRead)
            }
            if(numOscillators >= 3)
            is(0xe) {
              oscillatorSel := 2
              tempData := data.asUInt
              goto(setOscillatorRead)
            }
            if(numOscillators >= 4)
            is(0xf) {
              oscillatorSel := 3
              tempData := data.asUInt
              goto(setOscillatorRead)
            }
          }
        }
      }
      val waitFrameEnd : State = new State {
        whenIsActive {
          when(frameStart){
            when(tempData =/= 0){
              tempData := tempData - 1
            }.otherwise {
              goto(fetchCmd)
            }
          }
        }
      }
    }

    val setOscillatorRead: State = new State {
      whenIsActive {
        io.readReq.valid := True
        when(io.readReq.ready){
          pc := pc + 1
          goto(setOscillatorData)
        }
      }
    }
    val setOscillatorData : State = new State {
      whenIsActive {
        when(io.readResp.valid){
          oscillatorControl(oscillatorSel) := (tempData ## io.readResp.payload).asUInt
          goto(fetchCmd)
        }
      }
    }
    val readPC: State = new State {
      whenIsActive {
        io.readReq.valid := True
        when(io.readReq.ready){
          pc := pc + 1
          goto(setPC)
        }
      }
    }
    val setPC : State = new State {
      whenIsActive {
        when(io.readResp.valid){
          pc := (tempData ## io.readResp.payload ## B(0, 4 bits)).asUInt 
          goto(fetchCmd)
        }
      }
    }



    setEntry(fetchCmd)
  }





}
