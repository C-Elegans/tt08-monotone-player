package tinytapeout

import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.fsm._



case class VGAVideoGenerator(oscillatorWidth: Int, numOscillators: Int) extends Component {
  val io = new Bundle {
    val vga = out(VGA())
    val oscillatorData = in(new Bundle {
      val increments = Vec(UInt(oscillatorWidth bits), numOscillators)
      val combined = Bool()
      val outputs = Bits(numOscillators bits)
      val enable = Bool()
    })
  }
  val timing_generator = new VGATimingGenerator()

  io.vga.hsync := timing_generator.io.hsync
  io.vga.vsync := timing_generator.io.vsync
  io.vga.r := 0
  io.vga.g := 0
  io.vga.b := 0

  val frame_count = Reg(UInt(8 bits))
  when(timing_generator.io.frame_start){
    frame_count := frame_count + 1
  }

  when(timing_generator.io.video_active){
    when(timing_generator.io.y_coord < 100 ){
      when(timing_generator.io.x_coord < ~io.oscillatorData.increments(0)(11 downto 3)
        && io.oscillatorData.increments(0) =/= 0){
        io.vga.r := 3
      }
    }.elsewhen(timing_generator.io.y_coord < 200){
      when(timing_generator.io.x_coord < ~io.oscillatorData.increments(1)(11 downto 3)
        && io.oscillatorData.increments(1) =/= 0){
        io.vga.g := 3
      }
    }.elsewhen(timing_generator.io.y_coord < 300){
      when(timing_generator.io.x_coord < ~io.oscillatorData.increments(2)(11 downto 3)
        && io.oscillatorData.increments(2) =/= 0){
        io.vga.b := 3
      }
    }.elsewhen(timing_generator.io.y_coord < 400){
      when(timing_generator.io.x_coord < ~io.oscillatorData.increments(3)(11 downto 3)
        && io.oscillatorData.increments(3) =/= 0){
        io.vga.g := 3
        io.vga.r := 3
      }
    }
  }

}
