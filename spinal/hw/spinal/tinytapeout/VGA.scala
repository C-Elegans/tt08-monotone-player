package tinytapeout

import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.fsm._

case class VGA() extends Bundle {
  val hsync = Bool()
  val vsync = Bool()

  val r = UInt(2 bits)
  val g = UInt(2 bits)
  val b = UInt(2 bits)
}

case class VGATimingGenerator() extends Component {
  val xResolution = 640
  val yResolution = 480
  val io = new Bundle {
    val hsync = out(Bool())
    val vsync = out(Bool())

    val video_active = out(Bool())
    val frame_start = out(Bool())
    val line_start = out(Bool())
    val x_coord = out(UInt(log2Up(xResolution) bits))
    val y_coord = out(UInt(log2Up(yResolution) bits))
  }
  val hFrontPorchTime = 0.635 us
  val hSyncPulseTime = 3.8133 us
  val hBackPorchTime = 1.906 us
  val hVisibleTime = 25.422 us

  val vFrontPorchLines = 10
  val vSyncLines = 2
  val vBackPorchLines = 33
  val vVisibleLines = 480

  val xCounter = Reg(UInt(log2Up(xResolution) bits)) init(0)
  val yCounter = Reg(UInt(log2Up(yResolution) bits)) init(0)
  io.x_coord := 0
  io.y_coord := 0
  io.hsync := False
  io.vsync := False
  io.frame_start := False
  io.line_start := False
  io.video_active := False

  val newLine = Bool()
  newLine := False

  val hSyncFsm = new StateMachine {
    val frontPorch : State = new State with EntryPoint {
      whenIsActive {
        xCounter := xCounter + 1
        when(xCounter === (hFrontPorchTime * ClockDomain.current.frequency.getValue - 1).toBigInt){
          xCounter := 0
          io.line_start := True
          goto(visible)
        }
      }
    }
    val visible : State = new State {
      whenIsActive {
        xCounter := xCounter + 1
        io.x_coord := xCounter
        io.video_active := True
        when(xCounter === (hVisibleTime * ClockDomain.current.frequency.getValue - 1).toBigInt){
          xCounter := 0
          goto(backPorch)
        }
      }
    }
    val backPorch: State = new State {
      whenIsActive {
        xCounter := xCounter + 1
        when(xCounter === (hBackPorchTime * ClockDomain.current.frequency.getValue).toBigInt){
          xCounter := 0
          goto(sync)
        }
      }

    }
    val sync: State = new State {
      whenIsActive {
        xCounter := xCounter + 1
        io.hsync := True
        when(xCounter === (hSyncPulseTime * ClockDomain.current.frequency.getValue - 1).toBigInt){
          xCounter := 0
          newLine := True
          goto(frontPorch)
        }
      }
    }
  }

  val vSyncFsm = new StateMachine {
    val frontPorch : State = new State with EntryPoint {
      whenIsActive {
        io.video_active := False
        when(newLine){
          yCounter := yCounter + 1
          when(yCounter === vFrontPorchLines-1){
            yCounter := 0
            io.frame_start := True
            goto(visible)
          }
        }
      }
    }
    val visible : State = new State {
      whenIsActive {
        io.y_coord := yCounter
        when(newLine){
          yCounter := yCounter + 1
          when(yCounter === vVisibleLines-1){
            yCounter := 0
            goto(backPorch)
          }
        }
      }
    }
    val backPorch: State = new State {
      whenIsActive {
        io.video_active := False
        when(newLine){
          yCounter := yCounter + 1
          when(yCounter === vBackPorchLines-1){
            yCounter := 0
            goto(sync)
          }
        }
      }

    }
    val sync: State = new State {
      whenIsActive {
        io.vsync := True
        io.video_active := False
        when(newLine){
          yCounter := yCounter + 1
          when(yCounter === vSyncLines-1){
            yCounter := 0
            goto(frontPorch)
          }
        }
      }
    }
  }



}
