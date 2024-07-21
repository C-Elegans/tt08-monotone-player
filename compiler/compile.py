import struct
import re
from math import *

note_regex = re.compile(r'^([A-Ga-g][#b]?)([0-9])$')

A = 440
clock_frequency = 20e6
prescaler = 2**12
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
    return int(frequency * 2**12 / prescale_frequency)
    

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

def frame():
    f.write(struct.pack('B', 0))
    
note('C4')
frame()
frame()
frame()
frame()
note('E4')
    
