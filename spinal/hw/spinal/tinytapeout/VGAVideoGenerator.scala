package tinytapeout

import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.fsm._

case class VGAVideoGenerator() extends Component {
  val io = new Bundle {
    val vga = out(VGA())
  }
  val timing_generator = new VGATimingGenerator()

  io.vga.hsync := timing_generator.io.hsync
  io.vga.vsync := timing_generator.io.vsync

  val frame_count = Reg(UInt(8 bits))
  when(timing_generator.io.frame_start){
    frame_count := frame_count + 1
  }

  when(timing_generator.io.video_active){
    io.vga.r := timing_generator.io.x_coord(8 downto 7)
    io.vga.g := frame_count(5 downto 4)
    io.vga.b := frame_count(7 downto 6)

  }.otherwise {
    io.vga.r := 0
    io.vga.g := 0
    io.vga.b := 0
  }
}
