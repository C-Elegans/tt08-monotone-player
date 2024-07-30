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

  val channelCounts = for(i <- io.oscillatorData.outputs.bitsRange) yield {
    val output = io.oscillatorData.outputs(i)
    val chCount = Reg(UInt(5 bits))
    when(output =/= RegNext(output)){
      chCount := chCount + 1
    }
    when(timing_generator.io.frame_start){
      chCount := 0
    }
    chCount
  }



  when(timing_generator.io.video_active){
    when(timing_generator.io.x_coord / 32 < channelCounts(1)){
      io.vga.r := 3
    }
    when(timing_generator.io.x_coord / 32 < channelCounts(2)){
      io.vga.g := 3
    }
    when(timing_generator.io.x_coord / 32 < channelCounts(3)){
      io.vga.b := 3
    }
  }


}
