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
parser.add_argument('--percussion-track-index', type=int, default=5, help='The index of the percussion track')
parser.add_argument('--percussion-enable','-p', action='store_true', help='Enables percussion')

args = parser.parse_args()

data = MidiFile(args.midifile)

resolution = data.ticks_per_beat // args.resolution_divider
max_time = (data.max_tick // resolution) + 1


notes = [[0,0,0,0] for i in range(max_time)]
percussion_track = [0 for i in range(max_time)]
for instrument_idx, instrument in enumerate(data.instruments):
    prev_end_idx = 0
    for msg in instrument.notes:
        start_idx = msg.start // resolution
        if start_idx < prev_end_idx:
            start_idx = prev_end_idx
        end_idx = ceil(msg.end / resolution)
        prev_end_idx = end_idx
        for idx in range(start_idx, end_idx):
            if idx >= len(notes): break

            if instrument_idx == args.percussion_track_index:
                percussion_track[idx] = 1 if args.percussion_enable else 0
            elif instrument_idx >= 4:
                break
            elif notes[idx][instrument_idx] == 0:
                notes[idx][instrument_idx] = msg.pitch
            elif 0 in notes[idx]:
                index = notes[idx].index(0)
                notes[idx][index] = msg.pitch


compiler = NoteCompiler(args.romfile)
for i in range(8):
    compiler.nop()

compiler.framelength(args.framelength)
prev_note = [0,0,0,0]
prev_percussion = 0
wait_counter = 0
for note, percussion in zip(notes, percussion_track):
    if (prev_note != note or prev_percussion != percussion) and wait_counter != 0:
        while wait_counter > 16:
            compiler.wait(16, prev_percussion)
            wait_counter -= 16
        compiler.wait(wait_counter, prev_percussion)
        wait_counter = 0
    for osc in range(args.channels):
        if note[osc] != prev_note[osc]:
            if note[osc] == 0:
                compiler.note('', osc)
            else:
                compiler.midinote(note[osc], osc)
                
    wait_counter += 1
            
        
    prev_note = note
    prev_percussion = percussion

for osc in range(args.channels):
    compiler.note('', osc)
compiler.wait(16)
                



