package tinytapeout

import spinal.core._
import spinal.core.sim._
import spinal.lib._

case class Oscillator(width: Int) extends Component {
  val io = new Bundle {
    val increment = in(UInt(width bits))
    val oscillator = out(Bool())
  }

  val counter = Reg(UInt(width bits)) init(0)
  val toggle = Reg(False)
  when(counter === 0){
    counter := io.increment
    when(io.increment =/= 0) {
      toggle := !toggle
    }
  }.otherwise {
    counter := counter - 1
  }
  io.oscillator := toggle
}
