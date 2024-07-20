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
      whenCompleted {
        io.resp.valid := True
        when(io.cmd.valid){
          io.cmd.ready := True
          dataOut := io.cmd.payload
          goto(dataSend)
        }.otherwise {
          goto(txEnd)
        }
      }
    }
    val txEnd : State = new State {
      whenIsActive {
        spi.ss := ~ss_active
        goto(idle)
      }
    }
    setEntry(idle)
  }

  def sendFsm() = new StateMachine {
    def drive(next: State) = new State {
      whenIsActive {
        spi.sclk := !sclk_active
        spi.mosi := dataOut.msb
        goto(next)
      }
    }
    def clock(next: State) = new State {
      whenIsActive {
        spi.sclk := sclk_active
        dataOut := dataOut |<< 1
        dataIn := dataIn(6 downto 0) ## spi.miso
        goto(next)
      }
    }
    val clockB7 : State = new State {
      whenIsActive {
        spi.sclk := !sclk_active
        dataIn := dataIn(6 downto 0) ## spi.miso
        exit()
      }
    }

    val driveB7 : State = drive(clockB7)
    val clockB6 : State = clock(driveB7)
    val driveB6 : State = drive(clockB6)
    val clockB5 : State = clock(driveB6)
    val driveB5 : State = drive(clockB5)
    val clockB4 : State = clock(driveB5)
    val driveB4 : State = drive(clockB4)
    val clockB3 : State = clock(driveB4)
    val driveB3 : State = drive(clockB3)
    val clockB2 : State = clock(driveB3)
    val driveB2 : State = drive(clockB2)
    val clockB1 : State = clock(driveB2)
    val driveB1 : State = drive(clockB1)
    val clockB0 : State = clock(driveB1)
    val driveB0 : State = drive(clockB0)
    setEntry(driveB0)

  }
}
