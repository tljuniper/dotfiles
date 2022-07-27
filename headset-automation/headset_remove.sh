#!/bin/bash
# Headset has been removed from charger --> change audio to headset

# Find out the sink names with
# pacmd list-sinks

# Change default sink to headset
NEW_SINK="alsa_output.usb-Plantronics_Plantronics_BT600_a056d9f0c35ea34b99704caa539a6fe0-00.analog-stereo"

SINK=$(pacmd set-default-sink $NEW_SINK)
INPUT=$(pacmd list-sink-inputs | grep index | awk '{print $2}')

pacmd move-sink-input $INPUT $NEW_SINK
echo "Moving input: $INPUT to sink: $NEW_SINK";
echo "Setting default sink to: $NEW_SINK";

notify-send --urgency=low --hint int:transient:1 "Audio Switching" "Now playing on headset"

