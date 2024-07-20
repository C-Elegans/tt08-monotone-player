package tinytapeout

import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.sim._

import org.scalatest._
import org.scalatest.funsuite.AnyFunSuite

class SpinalMasterTb extends AnyFunSuite {
  test("8 bits") {
    Config.sim.compile(SpiMaster()).doSim{ dut =>
      dut.io.cmd.valid #= false
      dut.clockDomain.forkStimulus(1000)

      dut.clockDomain.waitSampling(10)

      dut.io.cmd.payload #= 0x0F
      dut.io.cmd.valid #= true
      dut.clockDomain.waitSampling(1)
      dut.io.cmd.valid #= false
      dut.clockDomain.waitSampling(20)

    }
  }

}
