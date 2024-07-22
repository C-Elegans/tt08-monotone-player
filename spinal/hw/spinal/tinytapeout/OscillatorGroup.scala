package tinytapeout

import spinal.core._
import spinal.core.sim._
import spinal.lib._

case class OscillatorGroup(width: Int, numOscillators: Int) extends Component {
  val io = new Bundle {
    val increments = in(Vec(UInt(width bits), numOscillators))
    val oscillator = out(Bool())
  }
  val oscillatorOutputs = Bits(numOscillators bits)

  val outputs = for(input <- io.increments) yield {
    val oscillator = Oscillator(width)
    oscillator.io.increment := input

    oscillator.io.oscillator
  }
  val sigmaDelta = new Area {
    val increment = CountOne(outputs)

    val counter = Reg(cloneOf(increment)) init(0)
    val countResult = counter +^ increment
    counter := countResult.resized
    io.oscillator := RegNext(countResult.msb)
  }

}
