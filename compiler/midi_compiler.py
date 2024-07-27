from argparse import ArgumentParser
from miditoolkit import MidiFile
from math import ceil
from note_compiler import NoteCompiler

parser = ArgumentParser(prog='midi_compiler')
parser.add_argument('midifile')
parser.add_argument('romfile')
parser.add_argument('--framelength', '-f', type=int, default=15, help='The frame length to set in the config')
parser.add_argument('--resolution-divider', '-d', type=int, default=4, help='The minimum fraction of a beat')
parser.add_argument('--channels', '-c', type=int, default=3, help='The number of channels to output to the rom')

args = parser.parse_args()

data = MidiFile(args.midifile)

resolution = data.ticks_per_beat // args.resolution_divider
max_time = data.max_tick // resolution


notes = [[] for i in range(max_time)]
for instrument in data.instruments:
    prev_end_idx = 0
    for msg in instrument.notes:
        start_idx = msg.start // resolution
        if start_idx < prev_end_idx:
            start_idx = prev_end_idx
        end_idx = ceil(msg.end / resolution)
        prev_end_idx = end_idx
        for idx in range(start_idx, end_idx):
            if idx >= len(notes): break
            if not msg.pitch in notes[idx]:
                notes[idx].append(msg.pitch)

print(notes[:50])

compiler = NoteCompiler(args.romfile)

compiler.framelength(args.framelength)
prev_note = []
wait_counter = 0
for note in notes:
    if prev_note != note and wait_counter != 0:
        print(f'waiting {wait_counter}')
        while wait_counter > 16:
            compiler.wait(16)
            wait_counter -= 16
        compiler.wait(wait_counter)
        wait_counter = 0
    for osc in range(args.channels):
        if osc >= len(note) and osc >= len(prev_note):
            pass
        elif osc >= len(note) and osc < len(prev_note):
            print(f'writing rest to {osc}')
            compiler.note('', osc)
        elif (osc < len(note) and osc >= len(prev_note)) or \
             (note[osc] != prev_note[osc]):
            print(f'writing midi note {note[osc]} to {osc}')
            compiler.midinote(note[osc], osc)
    wait_counter += 1
            
        
    prev_note = note
                



