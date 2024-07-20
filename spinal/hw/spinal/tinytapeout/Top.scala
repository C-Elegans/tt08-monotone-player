package tinytapeout

import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.io._

object Config {
  def spinal = SpinalConfig(
    targetDirectory = "../src",
    defaultConfigForClockDomains = ClockDomainConfig(
      resetActiveLevel = LOW,
      resetKind = ASYNC
    ),
    onlyStdLogicVectorAtTopLevelIo = true
  )

  def sim = SimConfig.withConfig(spinal).withFstWave
}

// Hardware definition
case class TopLevel() extends Component {
  val io = new Bundle {
    val ui_in = in Bits(8 bits)
    val ui_out = out Bits(8 bits)
    val uio = master(TriStateArray(8 bits))
    val ena = in Bool()
  }
  setDefinitionName("tt_um_elegans_design")
  io.uio.writeEnable.setName("uio_oe")
  io.uio.write.setName("uio_out")
  io.uio.read.setName("uio_in")
  ClockDomain.current.reset.setName("rst_n")


  io.uio.writeEnable := 0
  io.uio.write := 0

  val counter = Reg(UInt(16 bits)) init(0)
  counter := counter + 1

  io.ui_out := counter(15 downto 8).asBits

  noIoPrefix()
}

object VerilogTop extends App {
  Config.spinal.generateVerilog(TopLevel())
}

