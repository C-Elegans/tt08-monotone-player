import struct
import re
from math import *

note_regex = re.compile(r'^([A-Ga-g][#b]?)([0-9])$')

A = 440
clock_frequency = 20e6
prescaler = 2**7
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

def note_frequency(note_str):
    if not note_str:
        return 0
    m = note_regex.search(note_str)
    if not m:
        raise RuntimeError("Invalid note")
    note_frequency = notes[m.group(1)]
    power = int(m.group(2)) - 4
    return note_frequency * pow(2, power)

def midi_note_frequency(note_id):
    power = note_id - 69
    return A * pow(2, power/12.0)

def oscillator_frequency(divider):
    return prescale_frequency * divider / (2**12)

def calc_divider(frequency):
    if frequency == 0:
        return 0
    return int(prescale_frequency / frequency)
    
class NoteCompiler:
    def __init__(self, filename):
        self.rom = open(filename, 'wb')


    def writeNote(self, freq, oscillator=0):
        period = 1/freq * 1e6 if freq else 0
        div = calc_divider(freq)
        if div:
            div -= 1
        cmd1 = (0x3 << 6) | (oscillator << 4) | ((div >> 8) & 0xF)
        self.rom.write(struct.pack('B', cmd1))
        cmd2 = div & 0xff
        self.rom.write(struct.pack('B', cmd2))

    def note(self,notestr, oscillator=0):
        freq = note_frequency(notestr)
        self.writeNote(freq, oscillator)

    def midinote(self,noteid, oscillator=0):
        freq = midi_note_frequency(noteid)
        self.writeNote(freq, oscillator)

    def wait(self, numFrames=1, percussionEn=False):
        cmd = 0x2 << 4 | (percussionEn << 4) | (numFrames-1 & 0xF)
        self.rom.write(struct.pack('B', cmd))

    def framelength(self, count):
        cmd1 = 0x1 << 4 | (count & 0xf)
        self.rom.write(struct.pack('B', cmd1))

    def nop(self):
        self.rom.write(struct.pack('B', 0))

