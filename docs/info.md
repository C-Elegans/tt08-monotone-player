# What is it?

# Pinout

| Pin # | Input | Output (VGA PMOD) | Bidirectional I/O |
|:------|:------|:------------------|:------------------|
| 0     | X     | VGA - R1          | Out: SPI CS_n     |
| 1     | X     | VGA - G1          | Out: SPI MOSI     |
| 2     | X     | VGA - B1          | In:  SPI MISO     |
| 3     | X     | VGA - VSync       | Out: SPI SCK      |
| 4     | X     | VGA - R0          |                   |
| 5     | X     | VGA - G0          |                   |
| 6     | X     | VGA - B0          |                   |
| 7     | X     | VGA - HSync       | Out: PWM Audio    |

# How it works #

## Audio ##

The audio system consists of a 4 voice synthesizer controlled by a
command processor. The command processor reads a stream of commands
from SPI RAM/ROM and uses those commands to control the voices of the
synthesizer.

Timing:

In addition to the clock, the audio system uses two other timebases,
the oscillator clock and the frame. The oscillator voices operate on a
prescaled system clock with frequency f_sysclk/32. This was done to
give enough frequency resolution to the oscillators while having a
high enough PWM frequency to not be audible.

The command processor has a command to delay for a number of "frames"
before moving to the next command, this is used to set the timing of
note changes and rests. The length of a frame is controlled by the
Frame Control Register, part of which is writable by the command
processor. The frame control register is as follows:

<table>
  <tr>
    <td>15</td>
    <td>14</td>
    <td>13</td>
    <td>12</td>
    <td>11</td>
    <td>10</td>
    <td>9</td>
    <td>8</td>
    <td>7</td>
    <td>6</td>
    <td>5</td>
    <td>4</td>
    <td>3</td>
    <td>2</td>
    <td>1</td>
    <td>0</td>
  </tr>
  <tr>
    <td colspan=4> Writable </td>
    <td>1</td>
    <td>1</td>
    <td>1</td>
    <td>1</td>
    <td>1</td>
    <td>1</td>
    <td>1</td>
    <td>1</td>
    <td>1</td>
    <td>1</td>
    <td>1</td>
    <td>1</td>
  </tr>
</table>


Thus a frame is between 2^12 and 2^16 ticks of the PWM prescaled clock.


Command processor:

### Nop ###

| 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
|:--|:--|:--|:--|:--|:--|:--|:--|
| 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |

This command does nothing, the command processor just fetches the next command

### Set Framelength ###

<table>
  <tr>
    <td>7</td>
    <td>6</td>
    <td>5</td>
    <td>4</td>
    <td>3</td>
    <td>2</td>
    <td>1</td>
    <td>0</td>
  </tr>
  <tr>
    <td>0</td>
    <td>0</td>
    <td>0</td>
    <td>1</td>
    <td colspan=4> Framelength </td>
  </tr>
</table>



This command writes to the upper bits of the framelength control register with the bottom 4 bits of the command. The framelength control register controls how long a "frame" is:

Framelength Control(15 downto 12) := Command(3 downto 0)

### Wait for Frame End ###
<table>
  <tr>
    <td>7</td>
    <td>6</td>
    <td>5</td>
    <td>4</td>
    <td>3</td>
    <td>2</td>
    <td>1</td>
    <td>0</td>
  </tr>
  <tr>
    <td>0</td>
    <td>0</td>
    <td>0</td>
    <td>1</td>
    <td colspan=4> Num Frames </td>
  </tr>
</table>



This command waits for `Num Frames` frames before executing another
command. Additionally, the `P` bit of the command controls whether the
noise generator voice is enabled

### Oscillator Set ###

<table>
  <tr>
    <td>7</td>
    <td>6</td>
    <td>5</td>
    <td>4</td>
    <td>3</td>
    <td>2</td>
    <td>1</td>
    <td>0</td>
  </tr>
  <tr>
    <td>1</td>
    <td>1</td>
    <td colspan=2> Oscillator Index </td>
    <td colspan=4> Oscillator Period(11 downto 8) </td>
  </tr>
  <tr>
    <td colspan=8> Oscillator Period(7 downto 0) </td>
  </tr>
</table>
(This is a two byte command)

This command writes to the oscillator period register selected by Oscillator Index.


## Oscillators and DAC ##

The system contains 4 square wave oscillators and one noise generator,
connected to the audio output with a delta sigma DAC.

Each oscillator contains a 12 bit oscillator period register and a 12 bit count register. The oscillator increments its count register every prescaler clock tick. When the oscillator count register equals the period register, the oscillator toggles its output and resets its count register.
The frequency of the oscillator therefore is f_sysclk / (divider * 2**7)

The noise generator consists of a 12 bit LFSR and an enable bit. When enabled, the noise generator steps the LFSR every 256 prescaler clock ticks.

The DAC consists of a small counter which counts up by the number of set bits among the 4 oscillator outputs and the noise generator every prescaler clock tick. The output of the DAC is taken from the carry out of this counter. 

