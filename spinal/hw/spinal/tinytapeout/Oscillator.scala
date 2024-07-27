package tinytapeout

import spinal.core._
import spinal.core.sim._
import spinal.lib._

case class Oscillator(width: Int) extends Component {
  val io = new Bundle {
    val increment = in(UInt(width bits))
    val oscillator = out(Bool())
  }

  val counter = Reg(UInt(width+1 bits)) init(0)
  val toggle = Reg(False)
  when(counter === 0){
    counter := (io.increment ## U(0, 1 bits)).asUInt
    when(io.increment =/= 0) {
      toggle := !toggle
    }
  }.otherwise {
    counter := counter - 1
  }
  io.oscillator := toggle
}
