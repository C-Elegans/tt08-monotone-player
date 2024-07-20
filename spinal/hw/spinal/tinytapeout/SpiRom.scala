package tinytapeout

import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.fsm._

case class SpiRom() extends Component {
  val io = new Bundle {
    val spi = master(com.spi.SpiMaster(ssWidth =1, useSclk = true))
    val readReq = slave(Stream(UInt(16 bits)))
    val readResp = master(Flow(Bits(8 bits)))
  }
  io.readReq.ready := False
  io.readResp.valid := False
  io.readResp.payload := 0

  val spiMaster = SpiMaster()
  spiMaster.io.spi <> io.spi
  spiMaster.io.cmd <> spiMaster.io.cmd.getZero

  val READ_CMD = 0x03

  val fsm = new StateMachine {
    val idle : State = new State {
      whenIsActive {
        when(io.readReq.valid){
          goto(readCmd)
        }
      }
    }
    val readCmd: State = new State {
      whenIsActive {
        spiMaster.io.cmd.payload := READ_CMD
        spiMaster.io.cmd.valid := True
        when(spiMaster.io.cmd.ready){
          goto(readAddr1)
        }
      }
    }
    val readAddr1: State = new State {
      whenIsActive {
        spiMaster.io.cmd.payload := io.readReq.payload(15 downto 8).asBits
        spiMaster.io.cmd.valid := True
        when(spiMaster.io.cmd.ready){
          goto(readAddr2)
        }
      }
    }
    val readAddr2: State = new State {
      whenIsActive {
        spiMaster.io.cmd.payload := io.readReq.payload(7 downto 0).asBits
        spiMaster.io.cmd.valid := True
        when(spiMaster.io.cmd.ready){
          io.readReq.ready := True
          goto(readData)
        }
      }
    }
    val readData: State = new State {
      whenIsActive {
        spiMaster.io.cmd.payload := 0
        spiMaster.io.cmd.valid := True
        when(spiMaster.io.cmd.ready){
          goto(readDataWait)
        }
      }
    }
    val readDataWait: State = new State {
      whenIsActive {
        io.readResp <> spiMaster.io.resp
        when(spiMaster.io.resp.valid){
          goto(idle)
        }
      }
    }

    setEntry(idle)
  }


}
