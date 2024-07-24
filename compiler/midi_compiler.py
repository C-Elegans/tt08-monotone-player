from argparse import ArgumentParser
from miditoolkit import MidiFile
from math import ceil
import note_compiler

parser = ArgumentParser(prog='midi_compiler')
parser.add_argument('midifile')

args = parser.parse_args()

data = MidiFile(args.midifile)

resolution = data.ticks_per_beat//4
max_time = data.max_tick // resolution


notes = [[] for i in range(max_time)]
for instrument in data.instruments:
    for msg in instrument.notes:
        start_idx = msg.start // resolution
        end_idx = ceil(msg.end / resolution)
        for idx in range(start_idx, end_idx):
            if idx >= len(notes): break
            notes[idx].append(msg.pitch)

print(notes[:50])

note_compiler.framelength(0x6)
prev_note = []
wait_counter = 0
for note in notes:
    if prev_note != note and wait_counter != 0:
        print(f'waiting {wait_counter}')
        note_compiler.wait(wait_counter)
        wait_counter = 0
    for osc in range(3):
        if osc >= len(note) and osc >= len(prev_note):
            pass
        elif osc >= len(note) and osc < len(prev_note):
            print(f'writing rest to {osc}')
            note_compiler.note('', osc)
        elif (osc < len(note) and osc >= len(prev_note)) or \
             (note[osc] != prev_note[osc]):
            print(f'writing midi note {note[osc]} to {osc}')
            note_compiler.midinote(note[osc], osc)
    wait_counter += 1
            
        
    prev_note = note
                



