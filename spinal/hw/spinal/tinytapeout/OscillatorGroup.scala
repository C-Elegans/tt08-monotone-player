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

  io.oscillator := Vec(outputs).reduceBalancedTree((l, r) => l ^ r)
}
