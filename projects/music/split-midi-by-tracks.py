from pathlib import Path
import mido
import json


def split_midi(midi_file):
    # Load the MIDI file
    midi = mido.MidiFile(midi_file)
    
    # Initialize the platforms list
    platforms = []
    print(len(midi.tracks))
#     ticks_per_beat = midi.ticks_per_beat  # Get ticks per beat for scaling time
#     print(ticks_per_beat)
#     time_offset = 0  # Keep track of elapsed time
#     scale = 1
#     beat_per_second = BPM / 60
#     sec_per_beat = 1 / beat_per_second
#     # Process each track in the MIDI file
#     for i, track in enumerate(midi.tracks):
#         print(f"Processing track {i}: {track.name}")
#         note_start_times = {}  # To track active notes and their start times
        
#         for msg in track:
#             # Accumulate elapsed time
#             time_offset += msg.time
            
#             # Handle note-on messages
#             if msg.type == 'note_on' and msg.velocity > 0:
#                 note_pitch = msg.note
#                 if note_pitch not in note_start_times:
#                     note_start_times[note_pitch] = time_offset  # Record start time

#             # Handle note-off or note-on with velocity=0 messages
#             elif (msg.type == 'note_off' or (msg.type == 'note_on' and msg.velocity == 0)):
#                 note_pitch = msg.note
#                 if note_pitch in note_start_times:
#                     # Calculate duration between note_on and note_off
#                     note_start = note_start_times.pop(note_pitch)
#                     note_duration = time_offset - note_start
#                     note_on_tick = int((note_start / ticks_per_beat) * 4)
#                     note_length = int((note_duration / ticks_per_beat) * 4)

#                     # Calculate platform properties
#                     if int(note_duration) > 0:
#                         platform = {
#                             "tick": note_on_tick % 16,  # Scale start time to x position
#                             "note_pitch": 127 - note_pitch,             # Height inversely related to pitch
#                             "note_length": note_length,  # Scale duration to width
#                             "tact": int(note_on_tick / 16),
#                             "unrounded": note_duration,
#                             "ticks_per_beat": ticks_per_beat,
#                             "note_start": note_start,
#                         }
#                         platforms.append(platform)
#     return platforms
    

# Example usage
midi_file = "garden jam midi datei.midi"

output_file = f"{Path(midi_file).name}.json"
plts = split_midi(midi_file)

# # Save platforms as a JSON file
# with open(output_file, 'w') as f:
#     json.dump(out_data, f, indent=4)
# print(f"Platforms saved to {output_file}")
