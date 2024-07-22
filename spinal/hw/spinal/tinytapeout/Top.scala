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
  setDefinitionName("tt_um_monotone_player")

  io.uio.writeEnable := 0
  io.uio.write := 0
  io.uo_out := 0
  io.uo_out.allowOverride
  io.uio.writeEnable.allowOverride
  io.uio.write.allowOverride

  val top = Top(12)

  io.uo_out(0) := top.io.spi.ss(0)
  io.uo_out(1) := top.io.spi.sclk
  io.uo_out(2) := top.io.spi.mosi
  top.io.spi.miso := io.ui_in(0)


  io.uo_out(7) := top.io.osc

}


case class Top(width: Int) extends Component {
  val numOscillators = 3
  val io = new Bundle {
    val spi = master(com.spi.SpiMaster(ssWidth =1, useSclk = true))
    val osc = out(Bool())
  }
  val oscillatorControl = OscillatorControl(numOscillators)
  val enableArea = new ClockEnableArea(oscillatorControl.io.oscillator_en){
    val oscillatorGroup = OscillatorGroup(12, numOscillators)
  }

  val spiRom = SpiRom()
  io.spi <> spiRom.io.spi

  oscillatorControl.io.readReq >> spiRom.io.readReq
  oscillatorControl.io.readResp << spiRom.io.readResp
  enableArea.oscillatorGroup.io.increments := oscillatorControl.io.oscillatorIncrements
  io.osc := enableArea.oscillatorGroup.io.oscillator

  noIoPrefix();
}




object VerilogTop extends App {
  Config.spinal.generateVerilog(TapeoutTop())
  Config.spinal.generateVerilog(Top(12))
}

