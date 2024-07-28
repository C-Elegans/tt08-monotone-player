package tinytapeout

import spinal.core._
import spinal.core.sim._
import spinal.lib._

case class OscillatorGroup(width: Int, numOscillators: Int) extends Component {
  val io = new Bundle {
    val increments = in(Vec(UInt(width bits), numOscillators))
    val noise_enable = in(Bool())
    val noise_clocken = in(Bool())
    val oscillator_outputs = out(Bits(numOscillators bits))
    val oscillator = out(Bool())
  }
  val oscillatorOutputs = Bits(numOscillators+1 bits)
  io.oscillator_outputs := oscillatorOutputs(numOscillators-1 downto 0)

  val outputs = for(input <- io.increments) yield {
    val oscillator = Oscillator(width)
    oscillator.io.increment := input

    oscillator.io.oscillator
  }

  val noiseEnableArea = new ClockEnableArea(io.noise_clocken){
    val noiseGenerator = NoiseGenerator()
  }
  noiseEnableArea.noiseGenerator.io.enable := io.noise_enable

  oscillatorOutputs := Vec(outputs).asBits ## noiseEnableArea.noiseGenerator.io.oscillator


  val sigmaDelta = new Area {
    val increment = CountOne(oscillatorOutputs) + 1

    val counter = Reg(cloneOf(increment)) init(0)
    val countResult = counter +^ increment
    counter := countResult.resized
    io.oscillator := RegNext(countResult.msb)
  }

}
