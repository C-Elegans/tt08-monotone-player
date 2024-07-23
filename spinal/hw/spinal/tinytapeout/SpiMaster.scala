package tinytapeout

import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.fsm._

case class SpiMaster() extends Component {
  val io = new Bundle {
    val spi = master(com.spi.SpiMaster(ssWidth =1, useSclk = true))
    val cmd = slave(Stream(Bits(8 bits)))
    val resp = master(Flow(Bits(8 bits)))
  }

  val sclk_active = True
  val ss_active = B(0, 1 bits)

  val dataOut = Reg(Bits(8 bits))
  val dataIn = Reg(Bits(8 bits))
  val spi = Reg(cloneOf(io.spi))
  spi.ss init(~ss_active)
  spi.sclk init(!sclk_active)
  spi.mosi init(False)
  io.spi <> spi

  io.cmd.ready := False
  io.resp.valid := False
  io.resp.payload := dataIn

  val bitCount = Reg(UInt(3 bits))

  val en = Reg(False)
  en := !en

  val fsm = new StateMachine {
    val idle : State = new State {
      whenIsActive {
        io.cmd.ready := True
        when(io.cmd.valid){
          dataOut := io.cmd.payload
          goto(txBegin)
        }
      }
    }
    val txBegin : State = new State {
      whenIsActive {
        spi.ss := ss_active
        goto(dataSend)
      }
    }
    val dataSend : State = new StateFsm(sendFsm()) {
      onEntry {
        bitCount := 7
      }
      whenCompleted {
        goto(txEnd)
      }
    }
    val txEnd : State = new State {
      whenIsActive {
        io.resp.valid := True
        spi.sclk := !sclk_active
        when(io.cmd.valid){
          io.cmd.ready := True
          dataOut := io.cmd.payload
          goto(dataSend)
        }.otherwise {
          spi.ss := ~ss_active
          goto(idle)
        }
      }
    }
    setEntry(idle)
  }

  def sendFsm() = new StateMachine {

    val drive : State = new State {
      whenIsActive {
        when(en) {
          spi.sclk := !sclk_active
          spi.mosi := dataOut.msb
          goto(clock)
        }
      }
    }
    val clock : State = new State {
      whenIsActive {
        when(en){
          spi.sclk := sclk_active
          dataOut := dataOut |<< 1
          dataIn := dataIn(6 downto 0) ## spi.miso
          when(bitCount === 0){
            goto(exitState)
          }.otherwise {
            bitCount := bitCount - 1
            goto(drive)
          }
        }
      }
    }
    val exitState : State = new State {
      whenIsActive {
        when(en){
          exit()
        }
      }
    }

    setEntry(drive)

  }
}
