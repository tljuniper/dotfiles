#!/bin/bash
# Headset has been put back into charger --> switch to laptop audio

# Find out the sink names with
# pacmd list-sinks

# Change default sink to laptop speakers
NEW_SINK="alsa_output.pci-0000_00_1f.3.analog-stereo"

SINK=$(pacmd set-default-sink $NEW_SINK)
INPUT=$(pacmd list-sink-inputs | grep index | awk '{print $2}')

pacmd move-sink-input $INPUT $NEW_SINK
echo "Moving input: $INPUT to sink: $NEW_SINK";
echo "Setting default sink to: $NEW_SINK";

notify-send --urgency=low "Audio Switching" --hint int:transient:1 "Now playing on laptop speakers"

