from pathlib import Path
import mido
import json
import math

"""
Midi am besten zischen c3 und c4
"""
BPM = 100


def midi_to_platforms(midi_file):
    # Load the MIDI file
    midi = mido.MidiFile(midi_file)
    
    # Initialize the platforms list
    track_extracts = []
    ticks_per_beat = midi.ticks_per_beat  # Get ticks per beat for scaling time
    print(ticks_per_beat)
    # Process each track in the MIDI file
    for i, track in enumerate(midi.tracks):
        time_offset = 0  # Keep track of elapsed time
        print(f"Processing track {i}: {track.name}")
        note_start_times = {}  # To track active notes and their start times
        platforms = []
        for msg in track:
            # Accumulate elapsed time
            time_offset += msg.time
            
            # Handle note-on messages
            if msg.type == 'note_on' and msg.velocity > 0:
                note_pitch = msg.note
                if note_pitch not in note_start_times:
                    note_start_times[note_pitch] = time_offset  # Record start time

            # Handle note-off or note-on with velocity=0 messages
            elif (msg.type == 'note_off' or (msg.type == 'note_on' and msg.velocity == 0)):
                note_pitch = msg.note
                if note_pitch in note_start_times:
                    # Calculate duration between note_on and note_off
                    note_start = note_start_times.pop(note_pitch)
                    note_duration = time_offset - note_start
                    note_on_tick = round((note_start / ticks_per_beat) * 4)
                    note_length = math.ceil((note_duration / ticks_per_beat) * 4)

                    # Calculate platform properties
                    if int(note_duration) > 0:
                        platform = {
                            "tick": note_on_tick % 16,  # Scale start time to x position
                            "note_pitch": 127 - note_pitch,             # Height inversely related to pitch
                            "note_length": note_length,  # Scale duration to width
                            "tact": int(note_on_tick / 16),
                        }
                        platforms.append(platform)
        track_extracts.append(platforms)
    return track_extracts

    

# Example usage
midi_file = "garden jam midi datei.midi"

plts = midi_to_platforms(midi_file)
for i, track in enumerate(plts):
    out_data = {
        "platforms": track
    }
    # Save platforms as a JSON file
    output_file = f"../../turnip-the-beet/assets/music/{Path(midi_file).name}_{i}.json"
    with open(output_file, 'w') as f:
        json.dump(out_data, f, indent=4)
    print(f"Platforms saved to {output_file}")
