package tinytapeout

import spinal.core._
import spinal.core.sim._
import spinal.lib._

case class NoiseGenerator() extends Component {
  val io = new Bundle {
    val enable = in(Bool())
    val oscillator = out(Bool())
  }
  val lfsrWidth = 12
  val shiftRegister = Reg(Bits(lfsrWidth bits)) init(1)

  io.oscillator := False
  when(io.enable){

    val feedback = shiftRegister(11) ^ shiftRegister(10) ^ shiftRegister(3)
    shiftRegister := shiftRegister(shiftRegister.high-1 downto 0) ## feedback


    io.oscillator := shiftRegister.msb
  }
}
