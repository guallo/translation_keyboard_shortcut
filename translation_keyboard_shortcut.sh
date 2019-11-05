#!/usr/bin/env bash

# Settings / Devices / Keyboard / +
#   F7: bash translation_keyboard_shortcut.sh --hub-addr localhost:8091
#   F8: bash translation_keyboard_shortcut.sh --hub-addr localhost:8095

# https://askubuntu.com/questions/26056/where-are-gnome-keyboard-shortcuts-stored/217310
# $ CURRENTLY_EXISTING_CUSTOMS="gsettings list-recursively org.gnome.settings-daemon.plugins.media-keys | grep custom-keybindings | grep -o \"'.*'\""
# $ gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom10/ name "thename"
# $ gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom10/ command "thecommand"
# $ gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom10/ binding "F9"
# $ gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "[$CURRENTLY_EXISTING_CUSTOMS, '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom10/']"
# $ dconf-editor
# $ gsettings reset-recursively org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom10/

while (( "$#" )); do
    case "$1" in
        --hub-addr)
            hub_addr="$2"
            shift 2
            ;;
        *)
            echo "error: unsupported option: $1" >&2
            exit 1
            ;;
    esac
done

if [ -z ${hub_addr+x} ]; then
    echo "error: the option --hub-addr is required" >&2
    exit 2
fi

zenity --notification --text "$(HUB_ADDR="$hub_addr" python translation_hub_client_cli/tr.py "$(xclip -o)")"
