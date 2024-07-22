import struct
import re
from math import *

note_regex = re.compile(r'^([A-Ga-g][#b]?)([0-9])$')

A = 440
clock_frequency = 20e6
prescaler = 2**6
prescale_frequency = clock_frequency / prescaler


notes = {
    'A': A * pow(2, 12/12.0),
    'A#': A * pow(2, 13/12.0),
    'Bb': A * pow(2, 13/12.0),
    'B': A * pow(2, 14/12.0),
    'C': A * pow(2, 3/12.0),
    'C#': A * pow(2, 4/12.0),
    'Db': A * pow(2, 4/12.0),
    'D': A * pow(2, 5/12.0),
    'D#': A * pow(2, 6/12.0),
    'Eb': A * pow(2, 6/12.0),
    'E': A * pow(2, 7/12.0),
    'F': A * pow(2, 8/12.0),
    'F#': A * pow(2, 9/12.0),
    'Gb': A * pow(2, 9/12.0),
    'G': A * pow(2, 10/12.0),
    'G#': A * pow(2, 11/12.0),
    'Ab': A * pow(2, 11/12.0)
    }

f = open('memory.bin', 'wb')

def note_frequency(note_str):
    if not note_str:
        return 0
    m = note_regex.search(note_str)
    if not m:
        raise RuntimeError("Invalid note")
    note_frequency = notes[m.group(1)]
    power = int(m.group(2)) - 4
    return note_frequency * pow(2, power)

def oscillator_frequency(divider):
    return prescale_frequency * divider / (2**12)

def calc_divider(frequency):
    if frequency == 0:
        return 0
    return int(prescale_frequency / frequency)
    

def note(note_str, oscillator=0):
    freq = note_frequency(note_str)
    period = 1/freq * 1e6 if freq else 0
    print(f'{note_str} = {freq} Hz, {period=} us')
    div = calc_divider(freq)
    if div:
        div -= 1
    cmd1 = (0x3 << 6) | (oscillator << 4) | ((div >> 8) & 0xF)
    f.write(struct.pack('B', cmd1))
    cmd2 = div & 0xff
    f.write(struct.pack('B', cmd2))

def wait(numFrames=1):
    cmd = 0x1 << 4 | (numFrames-1 & 0xF)
    f.write(struct.pack('B', cmd))
    
def jump(addr):
    cmd1 = 0x2 << 4 | ((addr >> 12) & 0xF)
    cmd2 = ((addr >> 4) & 0xFF)
    f.write(struct.pack('BB', cmd1, cmd2))

note('F4')
note('', 1)
wait()
note('Eb4')
wait()
note('F4')
wait()
note('G4')
wait()
note('Ab4')
note('F3', 1)
wait()
note('Eb3', 1)
wait()
note('F3', 1)
wait()
note('Bb4')
note('G3', 1)
wait()
# measure 2
note('C5')
note('Ab3', 1)
wait(2)
note('Ab4')
note('C4', 1)
wait(2)
note('G4')
note('Bb3', 1)
wait(3)
note('Ab4')
note('Ab3', 1)
wait()
# measure 3
note('Bb4')
note('G3', 1)
wait(2)
note('G4')
note('Bb3', 1)
wait(2)
note('F4')
note('Ab3', 1)
wait(3)
note('G4')
note('Bb3', 1)
wait(1)
# measure 4
note('Ab4')
note('Ab3', 1)
wait(2)
note('G4')
note('Bb3', 1)
wait()
note('Eb4')
wait()
#measure 5
note('F4')
note('C4', 1)
wait(8)
wait(8)
jump(0)
