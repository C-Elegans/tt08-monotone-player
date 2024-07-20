package tinytapeout

import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.sim._

import org.scalatest._
import org.scalatest.funsuite.AnyFunSuite

class SpiRomTb extends AnyFunSuite {

  def spiListener(spi: com.spi.SpiMaster, scoreboard: ScoreboardInOrder[Byte], clockDomain: ClockDomain) : Unit = {
    var clockState : Boolean = false
    var dataOut : Byte = 0
    var dataCount : Int = 0

    clockDomain.onSamplings {
      if(spi.sclk.toBoolean && !clockState){
        println("Rising edge")
        dataOut = ((dataOut << 1) | spi.mosi.toBoolean.toInt).toByte
        dataCount += 1
        if(dataCount == 8){
          scoreboard.pushDut(dataOut)
          dataCount = 0
          println(f"Received data: ${dataOut}")
        }
      }
      clockState = spi.sclk.toBoolean
    }
  }

  test("read") {
    Config.sim.compile(SpiRom()).doSim{ dut =>
      dut.io.readReq.valid #= false
      dut.clockDomain.forkStimulus(1000)

      val scoreboard = ScoreboardInOrder[Byte]()
      spiListener(dut.io.spi, scoreboard, dut.clockDomain)

      dut.clockDomain.waitSampling(10)
      StreamDriver(dut.io.readReq, dut.clockDomain) { payload =>
        payload.randomize()
        true
      }
      StreamMonitor(dut.io.readReq, dut.clockDomain) { payload =>
        val addr = payload.toInt
        scoreboard.pushRef(0x03)
        scoreboard.pushRef((addr >> 8).toByte)
        scoreboard.pushRef((addr & 0xff).toByte)
        scoreboard.pushRef((0).toByte)
      }
      dut.clockDomain.waitActiveEdgeWhere(scoreboard.matches == 100)

    }
  }

}
