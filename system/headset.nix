{ pkgs, ... }:
let
  # Manual setup steps:

  # Find out the sink and source names for your audio devices with
  # pacmd list-sinks
  # pacmd list-sources
  # --> replace in SPEAKER/MIC variables

  # Find out where the pulseaudio server lives so we can access it from this session
  # pactl info | grep "Server String"
  # --> replace in pactl commands

  # Find out which DBUS session we use by looking at the output of `env` in a normal session
  # env | grep DBUS_SESSION_BUS_ADDRESS
  # --> replace in call to notify-send

  # Find PRODUCT string for your headset by keeping udevadm running and connecting the headset:
  # udevadm monitor --environment --udev | grep PRODUCT
  # --> replace in udev rule

  audio_switch_script = pkgs.writeScript "audio_switch_script.sh" ''
    #!/usr/bin/env bash
    # See: https://gist.github.com/ruzickap/53080ade88544661afa52bc7c7892cf4
    set -euo pipefail

    # Note: We always switch the mic too so chances are higher the setup's correct upon reboot

    if [ "$1" = "headset" ]; then

      SPEAKER="alsa_output.usb-Plantronics_Plantronics_BT600_a056d9f0c35ea34b99704caa539a6fe0-00.analog-stereo"
      MIC="alsa_output.usb-Plantronics_Plantronics_BT600_a056d9f0c35ea34b99704caa539a6fe0-00.analog-stereo.monitor"

      # Wait a second so user can put the headset on
      sleep 2

    elif [ "$1" = "speakers" ]; then

      SPEAKER="alsa_output.pci-0000_00_1f.3.analog-stereo"
      MIC="alsa_output.usb-Plantronics_Plantronics_BT600_a056d9f0c35ea34b99704caa539a6fe0-00.analog-stereo.monitor"

    else
      echo "Usage: audio_switch_script.sh [headset|speakers]"
    fi

    cmd="pactl --server=/run/user/1000/pulse/native"

    $cmd set-default-sink $SPEAKER
    $cmd set-default-source $MIC

    $cmd set-sink-mute "$SPEAKER" 0
    $cmd set-sink-volume "$SPEAKER" 70%

    $cmd set-source-mute "$MIC" 0
    $cmd set-source-volume "$MIC" 80%

    INPUTS=`$cmd list sink-inputs short | cut -f 1`
    for i in $INPUTS; do
      $cmd move-sink-input $i "$SPEAKER"
    done

    OUTPUTS=`$cmd list source-outputs short | cut -f 1`
    for i in $OUTPUTS; do
      $cmd move-source-output $i "$MIC"
    done

    DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send --urgency=normal --hint int:transient:1 "Audio Switching" "Now playing on $1"
  '';
in
{
    # Add additional UDEV rule to switch audio over to headset
    services.udev.extraRules = ''
      ACTION=="remove", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ENV{PRODUCT}=="47f/127/500", RUN+="${pkgs.su}/bin/su agillert --command='${audio_switch_script} headset'"
      ACTION=="add", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ENV{PRODUCT}=="47f/127/500", RUN+="${pkgs.su}/bin/su agillert --command='${audio_switch_script} speakers'"
    '';
}
