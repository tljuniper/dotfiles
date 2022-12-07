{ pkgs, ... }:
let
  remove_script = pkgs.writeScript "headset_remove.sh" ''
    #!/usr/bin/env bash
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

    DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send --urgency=normal --hint int:transient:1 "Audio Switching" "Now playing on headset"
  '';

  add_script = pkgs.writeScript "headset_add.sh" ''
    #!/usr/bin/env bash
    # Headset has been put back into charger --> switch to laptop audio
    notify-send --urgency=low --hint int:transient:1 "Audio Switching" "Now playing on headset"

    # Find out the sink names with
    # pacmd list-sinks

    # Change default sink to laptop speakers
    NEW_SINK="alsa_output.pci-0000_00_1f.3.analog-stereo"

    SINK=$(pacmd set-default-sink $NEW_SINK)
    INPUT=$(pacmd list-sink-inputs | grep index | awk '{print $2}')

    pacmd move-sink-input $INPUT $NEW_SINK
    echo "Moving input: $INPUT to sink: $NEW_SINK";
    echo "Setting default sink to: $NEW_SINK";

    DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send --urgency=normal --hint int:transient:1 "Audio Switching" "Now playing on laptop speakers"
  ''
  ;
in
{
    # Add additional UDEV rule to switch audio over to headset
    services.udev.packages = with pkgs; [
      sudo
    ];

    services.udev.extraRules = ''
      ACTION=="remove", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ENV{PRODUCT}=="47f/127/500", RUN+="${pkgs.su}/bin/su agillert --command=${remove_script}"
      ACTION=="add", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ENV{PRODUCT}=="47f/127/500", RUN+="${pkgs.su}/bin/su agillert --command=${add_script}"
    '';
      # ACTION=="remove", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ENV{PRODUCT}=="47f/127/500", RUN+="${pkgs.sudo}/bin/sudo su agillert --command=${remove_script}"
}
