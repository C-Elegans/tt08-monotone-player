package tinytapeout

import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.sim._

import org.scalatest._
import org.scalatest.funsuite.AnyFunSuite

class VGATimingGeneratorTb extends AnyFunSuite {


  test("vga_timing") {
    Config.sim.withTimeSpec(1 sec, 1 ps).compile(VGATimingGenerator()).doSim{ dut =>
      dut.clockDomain.forkStimulus()

      dut.clockDomain.waitActiveEdgeWhere(dut.io.hsync.toBoolean)
      val hsync1Time = simTime()
      dut.clockDomain.waitActiveEdgeWhere(!dut.io.hsync.toBoolean)
      dut.clockDomain.waitActiveEdgeWhere(dut.io.hsync.toBoolean)
      val hsync2Time = simTime()
      println(f"Scanline time ${(hsync2Time - hsync1Time)/1e3} us")

      dut.clockDomain.waitActiveEdgeWhere(dut.io.vsync.toBoolean)
      val vsync1Time = simTime()
      dut.clockDomain.waitActiveEdgeWhere(!dut.io.vsync.toBoolean)
      dut.clockDomain.waitActiveEdgeWhere(dut.io.vsync.toBoolean)
      val vsync2Time = simTime()
      println(f"Total frame time ${(vsync2Time - vsync1Time)/1e6} ms")
      dut.clockDomain.waitActiveEdgeWhere(!dut.io.vsync.toBoolean)
      dut.clockDomain.waitActiveEdgeWhere(dut.io.y_coord.toInt != 0)

    }
  }

}
