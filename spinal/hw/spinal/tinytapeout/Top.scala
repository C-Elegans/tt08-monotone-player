package tinytapeout

import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.io._

object Config {
  def spinal = SpinalConfig(
    targetDirectory = "hw/gen",
    defaultConfigForClockDomains = ClockDomainConfig(
      resetActiveLevel = LOW,
      resetKind = ASYNC
    ),
    onlyStdLogicVectorAtTopLevelIo = true
  )

  def sim = SimConfig.withConfig(spinal).withFstWave
}

// Hardware definition
case class TapeoutTop() extends Component {
  val io = new Bundle {
    val ui_in = in Bits(8 bits)
    val uo_out = out Bits(8 bits)
    val uio = master(TriStateArray(8 bits))
    val ena = in Bool()
  }
  io.uio.writeEnable.setName("uio_oe")
  io.uio.write.setName("uio_out")
  io.uio.read.setName("uio_in")
  ClockDomain.current.reset.setName("rst_n")
  noIoPrefix()
  setDefinitionName("tt_um_elegans_design")

  io.uio.writeEnable := 0
  io.uio.write := 0
  io.uo_out := 0
  io.uo_out.allowOverride
  io.uio.writeEnable.allowOverride
  io.uio.write.allowOverride

  val top = Top(12)
  top.io.increment_in := (io.ui_in ## B(0, 4 bits)).asUInt
  top.io.increment_sel := io.uio.read(1 downto 0).asUInt
  top.io.increment_we := io.uio.read(2)
  io.uo_out(0) := top.io.oscillator

}
case class Top(width: Int) extends Component {
  val io = new Bundle {
    val increment_in = in(UInt(width bits))
    val increment_sel = in(UInt(2 bits))
    val increment_we = in(Bool())
    val oscillator = out(Bool())
  }
  val oscillator = OscillatorGroup(12, 4)

  val increments = Reg(cloneOf(oscillator.io.increments))
  when(io.increment_we) {
    increments(io.increment_sel) := io.increment_in
  }
  oscillator.io.increments := increments
  io.oscillator := oscillator.io.oscillator
}




object VerilogTop extends App {
  Config.spinal.generateVerilog(TapeoutTop())
}

