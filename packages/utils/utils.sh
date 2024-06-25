#!/usr/bin/env bash
set -e
setup_gum() {
    # Choose
    export GUM_CHOOSE_CURSOR_FOREGROUND="#F1C069"
    export GUM_CHOOSE_HEADER_FOREGROUND="#F1C069"
    export GUM_CHOOSE_ITEM_FOREGROUND="#F1C069"
    export GUM_CHOOSE_SELECTED_FOREGROUND="#F1C069"
    export GUM_CHOOSE_HEIGHT=20
    export GUM_CHOOSE_CURSOR="👉️"
    export GUM_CHOOSE_HEADER="Choose one:"
    export GUM_CHOOSE_CURSOR_PREFIX="❓️"
    export GUM_CHOOSE_SELECTED_PREFIX="👍️"
    export GUM_CHOOSE_UNSELECTED_PREFIX="⛔️"
    export GUM_CHOOSE_SELECTED=""
    export GUM_CHOOSE_TIMEOUT=30
    # Style
    export FOREGROUND="#F1C069"
    export BACKGROUND="#1F1F1F"
    export BORDER="rounded"
    export BORDER_BACKGROUND="#1F1F1F"
    export BORDER_FOREGROUND="#F1C069"
    #ALIGN="left"
    export HEIGHT=3
    export WIDTH=80
    export MARGIN=1
    export PADDING=2
    #BOLD
    #FAINT
    #ITALIC
    #STRIKETHROUGH
    #UNDERLINE
    # Confirm
    export GUM_CONFIRM_PROMPT_FOREGROUND="#F1C069"
    export GUM_CONFIRM_SELECTED_FOREGROUND="#F1C069"
    export GUM_CONFIRM_UNSELECTED_FOREGROUND="#F1C069"
    export GUM_CONFIRM_TIMEOUT=30s
    # Input
    export GUM_INPUT_PLACEHOLDER="-----------"
    export GUM_INPUT_PROMPT=">"
    export GUM_INPUT_CURSOR_MODE="blink"
    export GUM_INPUT_WIDTH=40
    export GUM_INPUT_HEADER="💬"
    export GUM_INPUT_TIMEOUT=30s
    export GUM_INPUT_PROMPT_FOREGROUND="#F1C069"
    export GUM_INPUT_CURSOR_FOREGROUND="#F1C069"
    export GUM_INPUT_HEADER_FOREGROUND="#F1C069"
    # Spin
    export GUM_SPIN_SPINNER_FOREGROUND="#F1C069"
    export GUM_SPIN_TITLE_FOREGROUND="#F1C069"
    # Table
    export GUM_TABLE_BORDER_FOREGROUND="#F1C069"
    export GUM_TABLE_CELL_FOREGROUND="#F1C069"
    export GUM_TABLE_HEADER_FOREGROUND="#F1C069"
    export GUM_TABLE_SELECTED_FOREGROUND="#F1C069"
    # Filter
    export GUM_FILTER_INDICATOR="👉️"
    export GUM_FILTER_SELECTED_PREFIX="💎"
    export GUM_FILTER_UNSELECTED_PREFIX=""
    export GUM_FILTER_HEADER="Chooser"
    export GUM_FILTER_PLACEHOLDER="."
    export GUM_FILTER_PROMPT="Select an option:"
    #export GUM_FILTER_WIDTH
    #export GUM_FILTER_HEIGHT
    #export GUM_FILTER_VALUE
    #export GUM_FILTER_REVERSE
    #export GUM_FILTER_FUZZY
    #export GUM_FILTER_SORT
    export GUM_FILTER_TIMEOUT=30s

    export GUM_FILTER_INDICATOR_FOREGROUND="#F1C069"
    export GUM_FILTER_SELECTED_PREFIX_FOREGROUND="#F1C069"
    export GUM_FILTER_UNSELECTED_PREFIX_FOREGROUND="#F8E3BD"
    export GUM_FILTER_HEADER_FOREGROUND="#F1C069"
    export GUM_FILTER_TEXT_FOREGROUND="#F1C069"
    export GUM_FILTER_CURSOR_TEXT_FOREGROUND="#F1C069"
    export GUM_FILTER_MATCH_FOREGROUND="#F1C069"
    export GUM_FILTER_PROMPT_FOREGROUND="#F1C069"
}

about() {
    set +e
    read -r -d '\n' MESSAGE <<EndOfText
This script will provide useful tools and info for managing and setting up your NixOS system.

Tim Sutton, April 2024
Kartoza.com

EndOfText

    gum style 'About this script:' "${MESSAGE}"
    set -e
}

welcome() {
    set +e
    read -r -d '\n' LOGO <<EndOfText
    ------------------------------------------------------------------------------
             ██╗  ██╗ █████╗ ██████╗ ████████╗ ██████╗ ███████╗ █████╗
             ██║ ██╔╝██╔══██╗██╔══██╗╚══██╔══╝██╔═══██╗╚══███╔╝██╔══██╗
             █████╔╝ ███████║██████╔╝   ██║   ██║   ██║  ███╔╝ ███████║
             ██╔═██╗ ██╔══██║██╔══██╗   ██║   ██║   ██║ ███╔╝  ██╔══██║
             ██║  ██╗██║  ██║██║  ██║   ██║   ╚██████╔╝███████╗██║  ██║
             ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚══════╝╚═╝  ╚═╝

                       ███╗   ██╗██╗██╗  ██╗ ██████╗ ███████╗
                       ████╗  ██║██║╚██╗██╔╝██╔═══██╗██╔════╝
                       ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║███████╗
                       ██║╚██╗██║██║ ██╔██╗ ██║   ██║╚════██║
                       ██║ ╚████║██║██╔╝ ██╗╚██████╔╝███████║
                       ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝
    -----------------------------------------------------------------------------
EndOfText
    # Above text generated at https://manytools.org/hacker-tools/ascii-banner/
    # Using ANSI Shadow font
    echo ""
    echo "$LOGO"
    set -e
}

push_value_to_store() {
    # This function will publish
    # the supplied value to the skate
    # distributed key/value store
    # The key will automatically
    # be prefixed with the hostname
    # See other skate functions in this
    # file to see how to access values
    # and https://github.com/charmbracelet/skate

    # Parse named parameters
    while [[ $# -gt 0 ]]; do
        case "$1" in
        -key)
            key="$2"
            shift 2
            ;;
        -value)
            value="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
        esac
    done

    # Check if both parameters are provided
    if [[ -z "$key" || -z "$value" ]]; then
        echo "Error: Both parameters are required."
        exit 1
    fi
    prompt_to_continue
    clear
    echo "🛼 Skate key publisher."
    gum style '❓️ Confirm:' \
        "🛼 Would you like to store your the data for 🔑$(hostname)-${key} in our distributed key/value store?"
    STORE=$(gum choose "YES" "NO")
    if [ "$STORE" == "YES" ]; then
        # Store user's selection in a key based on hostname using skate
        skate set "$(hostname)-${key}" "${value}"
    fi
}

ntfy_error() {
    ERROR_CHANNEL=$(skate get "ntfy-error")
    # check if the value is "Key not found"
    if [ "$ERROR_CHANNEL" == "Key not found" ]; then
        echo "No ntfy-error channel found. Please set one up."
        exit 1
    fi
    # Check this function received at least one parameter
    if [ -z "$1" ]; then
        echo "Error: At least one parameter is required."
        exit 1
    fi
    # Send the error message to the ntfy-error channel
    ntfy send "$ERROR_CHANNEL" "$(hostname): $1"

}

ntfy_message() {
    MESSAGE_CHANNEL=$(skate get "ntfy-message")
    # check if the value is "Key not found"
    if [ "$MESSAGE_CHANNEL" == "Key not found" ]; then
        echo "No ntfy-message channel found. Please set one up."
        exit 1
    fi
    # Check this function received at least one parameter
    if [ -z "$1" ]; then
        echo "Error: At least one parameter is required."
        exit 1
    fi
    # Send the info message to the ntfy-message channel
    ntfy send "$MESSAGE_CHANNEL" "$(hostname): $1"
}

# Function to generate system hardware profile
generate_hardware_profile() {
    echo "Generating system hardware profile..."
    # Add your commands to generate hardware profile here
    gum spin --spinner dot --title "Generating Hardware Profile..." -- sleep 1
    CONFIG=$(nixos-generate-config --show-hardware-config | grep -v '^  #' | grep -v '^#')
    echo -e "$CONFIG" | glow -
    push_value_to_store -key "hardware-config" -value "${CONFIG}"
}

start_syncthing() {
    systemctl --user enable syncthing
    systemctl --user start syncthing
    systemctl --user status syncthing
    services=$(systemctl --user list-unit-files --type=service --state=enabled | grep -E 'enabled' | sed 's/enabled enabled/🚀/g')
    gum style --width 120 "These services are running:" "${services}"
}

prompt_to_continue() {
    echo ""
    echo "Press any key to continue..."
    # Dont call this key - it will make side effects
    # elsewhere in this script
    read -n 1 -s -r keystroke
    echo "$keystroke Continuing..."
    clear
}
run_minimal_gnome_test_vm() {

    echo "🏃Running flake in a test minimal GNOME vm"

    if ls test.qcow2 1>/dev/null 2>&1; then
        rm -f test.qcow2
    fi
    # #test-gnome is the name of the host config as listed in flake.nix
    nixos-rebuild build-vm --flake .#test-gnome-minimal && result/bin/run-test-vm

}

run_full_gnome_test_vm() {

    echo "🏃Running flake in a test full GNOME vm"

    if ls test.qcow2 1>/dev/null 2>&1; then
        rm -f test.qcow2
    fi
    # #test-gnome is the name of the host config as listed in flake.nix
    nixos-rebuild build-vm --flake .#test-gnome-full && result/bin/run-test-vm

}

run_kde5_test_vm() {

    echo "🏃Running flake in a test KDE-5 vm"

    if ls test.qcow2 1>/dev/null 2>&1; then
        rm -f test.qcow2
    fi
    # #test-kde is the name of the host config as listed in flake.nix
    nixos-rebuild build-vm --flake .#test-kde5 && result/bin/run-test-vm

}

run_kde6_test_vm() {

    echo "🏃Running flake in a test KDE-6 vm"

    if ls test.qcow2 1>/dev/null 2>&1; then
        rm -f test.qcow2
    fi
    # #test-kde is the name of the host config as listed in flake.nix
    nixos-rebuild build-vm --flake .#test-kde6 && result/bin/run-test-vm
}

list_open_ports() {
    set +e
    open_ports=$(netstat -tuln | grep '^tcp' | awk '{print $4}')

    # Initialize variable to store Markdown table
    markdown_table="| Port | Service |\n|------|---------|\n"

    # Iterate over each open port
    while read -r line; do
        # Extract port number
        port=$(echo "$line" | cut -d ":" -f 2)

        # Lookup service name based on port number
        service=$(getent services "$port" | awk '{print $1}')

        # If service not found, use port number
        if [ -z "$service" ]; then
            service="$port"
        fi

        # Add row to Markdown table
        markdown_table+="| $port | $service |\n"
    done <<<"$open_ports"
    # Output Markdown table
    # -e to render newlines
    echo -e "$markdown_table" | glow -

    push_value_to_store -key "ports" -value "${markdown_table}"
    set -e
}

change_zfs_passphrase() {
    # First list keys on NIXROOT
    echo "🔑 Listing ZFS keys"
    sudo zfs get keylocation NIXROOT
    echo "🔑 Changing ZFS passphrase"
    sudo zfs change-key -i NIXROOT
    echo "🔁 Rebooting the system"
    sudo reboot -h now
}

backup_zfs() {

    # Based partly on logic described here:
    # https://gist.github.com/kapythone/dbdbf7ad1961c606e62e215e5d30de98

    # Initially create the pool on a new external drive like this:
    # sudo zpool create NIXBACKUPS /dev/sda
    # Then unmount it before running this script
    # zpool export NIXBACKUPS

    # Clearing old snapshots and restarting the snapshot sync process:
    # Run all these steps as root
    # zfs list -H -o name -t snapshot | xargs -n1 zfs destroy
    # zfs snapshot NIXROOT/home@baseline
    # zfs send NIXROOT/home@baseline | zfs receive -F NIXBACKUPS/home
    # zpool export NIXBACKUPS

    DATE=$(date '+%Y-%m-%d.%Hh-%M')
    echo "🐴 Mounting NIXBACKUPS volume from USB drive"
    sudo zpool import NIXBACKUPS
    echo "🗓️ Preparing a snapshot for $DATE"
    echo "📸 Taking a snapshot"
    sudo zfs snapshot NIXROOT/home@"$DATE"-Home
    zfs list -t snapshot
    zfs list
    echo "📨Sending the snapshot to the external USB disk"
    sudo syncoid NIXROOT/home NIXBACKUPS/home
    echo "📝Listing the snapshots now that it is copied to the USB disk"
    zfs list -t snapshot
    # Stop zfs looking for this pool
    echo "🔌Unplugging the backup zpool"
    sudo zpool export NIXBACKUPS
    # Power off the  USB drive:
    echo "⚡️Powering off the USB drive"
    sudo udisksctl power-off -b /dev/sda
}

list_partitions() {
    set +e
    # Execute blkid command and store the output in a variable
    blkid_output=$(blkid)

    # Execute lsblk command to get a list of block devices and their UUIDs
    lsblk_output=$(lsblk -o NAME,UUID --noheadings --list)

    # Initialize Markdown table variable
    markdown_table="| Volume | Name | UUID |\n|--------|------|------|\n"

    # Process mounted partitions from blkid output
    while IFS= read -r line; do
        # Extract device, label, and UUID
        device=$(echo "$line" | awk -F ': ' '{print $1}' | cut -c1-20)
        label=$(echo "$line" | awk -F ' LABEL=' '{print $2}' | awk -F 'UUID=' '{print $1}' | sed 's/"//g')
        uuid=$(echo "$line" | awk -F 'UUID="' '{print $2}' | awk -F '"' '{print $1}')

        # Append device, label, and UUID to Markdown table
        markdown_table+="| $device | $label | $uuid |\n"
    done <<<"$blkid_output"

    # Process unmounted partitions from lsblk output
    while IFS= read -r line; do
        # Extract device and UUID
        device=$(echo "$line" | awk '{print $1}')
        uuid=$(echo "$line" | awk '{print $2}')

        # Skip lines with no UUID
        if [ -z "$uuid" ]; then
            continue
        fi

        # Append device and UUID to Markdown table
        markdown_table+="| $device | | $uuid |\n"
    done <<<"$lsblk_output"
    markdown_table+="\nZFS Datasets:\n"
    markdown_table+=$(zfs list)
    # Show the Markdown table
    # -e to render newlines
    clear
    echo -e "$markdown_table" | glow -
    push_value_to_store -key "partitions" -value "${markdown_table}"
    set -e
}

confirm_format() {
    echo "This tool is destructive! It will delete all your partitions on your hard drive. Do you want to continue?"
    DESTROY=$(gum choose "DESTROY" "CANCEL")
    if [ "$DESTROY" == "DESTROY" ]; then
        sudo nix run --extra-experimental-features nix-command --extra-experimental-features flakes github:timlinux/nix-config#setup-zfs-machine
    fi
}

enter_skate_link() {
    echo "🛼 Link a skate key to this machine."
    KEY=$(gum input --prompt "What is linking key for this new machine?: ")
    gum spin --spinner dot --title "Linking to the distributed key/value store..." -- sleep 5 &
    skate link "${KEY}"
}

main_menu() {
    gum style "🏠️ Kartoza NixOS :: Main Menu"
    choice=$(
        gum choose \
            "💁🏽 Help" \
            "🚀 System management" \
            "❓️ System info" \
            "🖥️ Test VMs" \
            "🛼 Create link" \
            "🛼 Enter link" \
            "🛼 Show value for key" \
            "🎬️ Make history video" \
            "💿️ System setup" \
            "💡 About" \
            "🛑 Exit"
    )

    case $choice in
    "💁🏽 Help") help_menu ;;
    "🚀 System management") system_menu ;;
    "❓️ System info") system_info_menu ;;
    "🖥️ Test VMs") test_vms_menu ;;
    "🛼 Create link")
        gum spin --spinner dot --title "Getting link for the key/value store..." -- sleep 5 &
        skate link
        prompt_to_continue
        main_menu
        ;;
    "🛼 Enter link")
        enter_skate_link
        prompt_to_continue
        main_menu
        ;;
    "🛼 Show value for key")
        echo "🛼 Skate key viewer."
        gum spin --spinner dot --title "Getting key list from the key/value store..." -- sleep 5 &
        KEYS=$(skate list -k)
        # We need spaces expanded for this one so disable shellcheck
        # shellcheck disable=SC2086
        KEY=$(gum choose "🔑 Enter key name:" ${KEYS})
        # shellcheck disable=SC2046
        gum spin --spinner dot --title "Getting value for key: ${KEY} from the key/value store..." -- sleep 5 &
        skate get "${KEY}"
        prompt_to_continue
        main_menu
        ;;
    "🎬️ Make history video")
        echo "🎬️ Making a video of your history."
        gource --seconds-per-day 0.1 --time-scale 4 --auto-skip-seconds 1 \
            --key --file-idle-time 0 --max-files 0 --max-file-lag 0.1 \
            --title "Project History" --bloom-multiplier 0.5 --bloom-intensity 0.5 \
            --background 000000 --hide filenames,mouse,progress \
            --output-ppm-stream - |
            ffmpeg -probesize 50M -analyzeduration 100M -y -r 60 -f image2pipe -vcodec ppm -i - \
                -vf scale=1280:-1 -vcodec libx264 -preset fast -pix_fmt yuv420p -crf 1 -threads 0 -bf 0 history.mp4
        ffmpeg -i history.mp4 -vf "fps=10,scale=1280:-1:flags=lanczos" -loop 0 img/history.gif
        prompt_to_continue
        main_menu
        ;;
    "💿️ System setup") setup_menu ;;
    "💡 About") about ;;
    "🛑 Exit") exit 1 ;;
    *) echo "Invalid choice. Please select again." ;;
    esac
}

setup_menu() {
    gum style "🚀 Kartoza NixOS :: System Menu"
    choice=$(
        gum choose \
            "🏠️ Main menu" \
            "🛼 Enter link" \
            "🌐 Set up VPN" \
            "🔑 Install Tim's SSH keys" \
            "💿️ Checkout Nix flake" \
            "🏠️ Show your VPN IP address" \
            "🪪 Generate host id" \
            "⚠️ Format disk with ZFS ⚠️" \
            "🖥️ Install system" \
            "🛟 Rescue System" \
            "🗑️ Purge nix cache"
    )

    case $choice in
    "🛼 Enter link")
        # This connects the end user device to our
        # distributed key/value store
        # that lets me push content to their machine easily
        # (like their vpn credentials)
        # See also 'create link' from the main menu
        enter_skate_link
        prompt_to_continue
        setup_menu
        ;;
    "🌐 Set up VPN")
        NEW_HOSTNAME=$(gum input --prompt "What is hostname for this new machine?: " --placeholder "ROCK")
        gum style "VPN Setup" "Before you run this, your admin needs to save the key in ${NEW_HOSTNAME}-wireguard. When this is done, press any key to continue."
        prompt_to_continue
        sudo hostname "${NEW_HOSTNAME}"
        # check if dir exists, if not, create it
        [ -d ~/.wireguard/ ] || mkdir ~/.wireguard/
        # check if the file exists, if not, create it
        [ -f ~/.wireguard/kartoza-vpn.conf ] || skate get "${NEW_HOSTNAME}-wireguard" >~/.wireguard/kartoza-vpn.conf
        nmcli connection import type wireguard file ~/.wireguard/kartoza-vpn.conf
        nmcli connection up wg0
        nmcli connection show
        prompt_to_continue
        setup_menu
        ;;
    "🔑 Install Tim's SSH keys")
        [ -d ~/.ssh/ ] || mkdir ~/.ssh
        curl https://github.com/timlinux.keys >~/.ssh/authorized_keys
        prompt_to_continue
        setup_menu
        ;;
    "💿️ Checkout Nix flake")
        # This should usually not be needed during initial setup
        # since we run the flake remotely. But after the system is installed
        # or if we want to tweak things during setup, having this
        # flake checked out can be handy...
        cd ~
        [ -d ~/dev/ ] || mkdir ~/dev
        [ -d ~/dev/nix-config/ ] || git clone https://github.com/timlinux/nix-config.git ~/dev/nix-config
        cd ~/dev/nix-config/
        git pull
        cd ~
        prompt_to_continue
        setup_menu
        ;;
    "🏠️ Show your VPN IP address")
        ip addr
        prompt_to_continue
        setup_menu
        ;;
    "🪪 Generate host id")
        echo "Your unique host ID is:"
        head -c 8 /etc/machine-id
        skate set "$(hostname)-machine-id" "$(head -c 8 /etc/machine-id)"
        prompt_to_continue
        setup_menu
        ;;
    "🛟 Rescue System")
        echo "Make sure you are booted off the live CD"
        echo "Here are the commands to run to rebuild your system."
        echo "Modify as needed..."
        echo """
        sudo zpool import -f NIXROOT
        sudo zfs load-key NIXROOT
        sudo mkdir /mnt/boot
        sudo mkdir /mnt/home
        sudo mkdir /mnt/nix    
        sudo mount /dev/nvme0n1p1 /mnt/boot
        sudo mount -t zfs NIXROOT/root /mnt
        sudo mount -t zfs NIXROOT/home /mnt/home
        sudo mount -t zfs NIXROOT/nix /mnt/nix
        sudo nixos enter
        # see https://discourse.nixos.org/t/nixos-rebuild-failing-while-chrooted/40176/5
        unset SUDO_USER
        NIXPKGS_ALLOW_INSECURE=1 NIXPKGS_ALLOW_UNFREE=1 nixos-rebuild switch --show-trace --impure --option sandbox false --flake .#crest
        """
        prompt_to_continue
        setup_menu
        ;;
    "⚠️ Format disk with ZFS ⚠️")
        confirm_format
        prompt_to_continue
        setup_menu
        ;;
    "🖥️ Install system")
        gum style --foreground red "You are about to fully replace the operating system on this host!"
        NEW_HOSTNAME=$(gum input --prompt "Confirm the hostname for this new machine?: " --placeholder "$(hostname)")
        sudo hostname "${NEW_HOSTNAME}"
        echo "Are you sure you want to install with the flake profile for $NEW_HOSTNAME?"
        FLAKE=$(gum choose "YES" "NO")
        if [ "$FLAKE" == "YES" ]; then
            sudo nixos-install --option eval-cache false --flake /mnt/etc/nixos#"${NEW_HOSTNAME}"
        fi
        prompt_to_continue
        setup_menu
        ;;
    "🗑️ Purge nix cache")
        # Untested, needs checking
        rm -rf ~/.cache/nix/*
        sudo rm -rf ~/.cache/nix/*
        prompt_to_continue
        setup_menu
        ;;
    "🏠️ Main menu")
        clear
        main_menu
        ;;
    *) echo "🛑 Invalid choice. Please select again." ;;
    esac
}

system_menu() {
    gum style "🚀 Kartoza NixOS :: System Menu"
    choice=$(
        gum choose \
            "🏠️ Main menu" \
            "🏃 Update system" \
            "🦠 Virus scan your home" \
            "🔑 Change ZFS Passphrase for NIXROOT" \
            "💿️ Backup ZFS to USB disk" \
            "🧹 Clear disk space" \
            "💻️ Update firmware" \
            "❄️ Update flake lock" \
            "⚙️ Start syncthing" \
            "👀 Watch dconf" \
            "🎬️ Mimetypes diff"
    )

    case $choice in
    "Help") help_menu ;;
    "🏃 Update system")
        sudo NIXPKGS_ALLOW_INSECURE=1 NIXPKGS_ALLOW_UNFREE=1 nix build --impure
        # Don't exit on errors
        set +e
        ntfy_message "Running nixos-rebuild switch"
        sudo NIXPKGS_ALLOW_INSECURE=1 NIXPKGS_ALLOW_UNFREE=1 nixos-rebuild switch --show-trace --impure --flake .
        ntfy_message "System updated"
        # Re-enable exit on errors
        set -e
        prompt_to_continue
        system_menu
        ;;
    "🦠 Virus scan your home")
        clamscan -i /home/"$(whoami)"
        prompt_to_continue
        system_menu
        ;;
    "💿️ Backup ZFS to USB disk")
        backup_zfs
        prompt_to_continue
        system_menu
        ;;
    "🔑 Change ZFS Passphrase for NIXROOT")
        change_zfs_passphrase
        prompt_to_continue
        system_menu
        ;;
    "🧹 Clear disk space")
        sudo nix-collect-garbage -d
        prompt_to_continue
        system_menu
        ;;
    "💻️ Update firmware")
        sudo fwupdmgr refresh --force
        sudo fwupdmgr get-updates
        sudo fwupdmgr update
        prompt_to_continue
        system_menu
        ;;
    "❄️ Update flake lock")
        gum style "Flake update" "Running flake update to update the lock file."
        nix flake update
        prompt_to_continue
        system_menu
        ;;
    "⚙️ Start syncthing")
        start_syncthing
        prompt_to_continue
        system_menu
        ;;
    "👀 Watch dconf")
        # See here for a way to cat and digg dconf
        # https://heywoodlh.io/nixos-gnome-settings-and-keyboard-shortcuts
        # dconf dump / > old-conf.txt
        # dconf dump / > new-conf.txt
        # diff old-conf.txt new-conf.txt
        echo "Click around in gnome settings etc. to see what changes. Then propogate those changes to your nix configs."
        dconf watch /
        ;;
    "🎬️ Mimetypes diff")
        echo "Use the file manager to open different file types, then see the diff here to add them to home/xdg/default.nix to make these the default for all users."
        echo "TODO: ls -lah ~/.config/mimeapps.list"
        ;;
    "🏠️ Main menu")
        clear
        main_menu
        ;;
    *) echo "🛑 Invalid choice. Please select again." ;;
    esac
}

system_info_menu() {

    gum style "❓️ Kartoza NixOS :: System Info Menu:"
    choice=$(
        gum choose \
            "🏠️ Main menu" \
            "💻️ Generate your system hardware profile" \
            "🗃️ General system info" \
            "💿️ List disk partitions" \
            "🏃🏽 Generate CPU Benchmark" \
            "🚢 Open ports - nmap" \
            "🚢 Open ports - netstat" \
            "🔍️ Scan local network 10." \
            "🔍️ Scan local network 192.168.1" \
            "🔍️ Scan local network 192.168.0" \
            "👨🏽‍🍳 Running Services" \
            "📃 Live system logs" \
            "😺 Git stats" \
            "👨🏽‍🏫 GitHub user info" \
            "🌐 Your ISP and IP" \
            "🐿️ CPU info" \
            "🐏 RAM info" \
            "⭐️ Show me a star constellation"
    )

    case $choice in
    "💻️ Generate your system hardware profile")
        generate_hardware_profile
        prompt_to_continue
        system_info_menu
        ;;
    "🗃️ General system info")
        fastfetch
        push_value_to_store -key "fastfetch" -value "$(fastfetch)"
        prompt_to_continue
        system_info_menu
        ;;
    "💿️ List disk partitions")
        list_partitions
        prompt_to_continue
        system_info_menu
        ;;
    "🏃🏽 Generate CPU Benchmark")
        CPU_COUNT=$(lscpu | grep '^CPU(s):' | grep -o "[0-9]*")
        sysbench --threads="${CPU_COUNT}" cpu run
        prompt_to_continue
        system_info_menu
        ;;
    "🚢 Open ports - nmap")
        nmap localhost
        prompt_to_continue
        system_info_menu
        ;;
    "🚢 Open ports - netstat")
        list_open_ports
        prompt_to_continue
        system_info_menu
        ;;
    "🔍️ Scan local network 10.")
        nmap -sn 10.100.0.0/24
        prompt_to_continue
        system_info_menu
        ;;
    "🔍️ Scan local network 192.168.1")
        nmap -sn 192.168.1.0/24
        prompt_to_continue
        system_info_menu
        ;;
    "🔍️ Scan local network 192.168.0")
        nmap -sn 192.168.0.0/24
        prompt_to_continue
        system_info_menu
        ;;
    "👨🏽‍🍳 Running Services")
        SERVICES=$(systemctl list-units --type=service --all)
        echo -e "${SERVICES}"
        push_value_to_store -key "systemd" -value "${SERVICES}"
        prompt_to_continue
        system_info_menu
        ;;
    "📃 Live system logs")
        journalctl --user -f
        prompt_to_continue
        system_info_menu
        ;;
    "😺 Git stats")
        onefetch
        prompt_to_continue
        system_info_menu
        ;;
    "👨🏽‍🏫 GitHub user info")
        octofetch timlinux
        prompt_to_continue
        system_info_menu
        ;;
    "🌐 Your ISP and IP")
        ipfetch
        ip addr | grep "inet "
        prompt_to_continue
        system_info_menu
        ;;
    "🐿️ CPU info")
        cpufetch
        prompt_to_continue
        system_info_menu
        ;;
    "🐏 RAM info")
        ramfetch
        prompt_to_continue
        system_info_menu
        ;;
    "⭐️ Show me a star constellation")
        starfetch
        prompt_to_continue
        system_info_menu
        ;;
    "🏠️ Main menu")
        clear
        main_menu
        ;;
    *) echo "Invalid choice. Please select again." ;;

    esac

}

test_vms_menu() {
    gum style "🖥️ Kartoza NixOS :: Test VMs Menu" "See https://lhf.pt/posts/demystifying-nixos-basic-flake/ For a detailed explanation"

    choice=$(
        gum choose \
            "🏠️ Main menu" \
            "🏗️ Build Kartoza NixOS ISO" \
            "❄️ Run Kartoza NixOS ISO" \
            "🖥️ Minimal Gnome VM" \
            "🖥️ Full Gnome VM" \
            "🖥️ Minimal KDE-5 VM" \
            "🖥️ Minimal KDE-6 VM" \
            "🖥️ Complete Gnome VM (for screen recording)"
    )

    case $choice in
    "🏗️ Build Kartoza NixOS ISO")
        clear
        nix build .#nixosConfigurations.live.config.system.build.isoImage
        qemu-system-x86_64 -m 2048M -cdrom result/iso/*.iso
        main_menu
        ;;
    "❄️ Run Kartoza NixOS ISO")
        clear
        nix-shell -p qemu --command "qemu-system-x86_64 -enable-kvm -m 4096 -cdrom result/iso/nixos-*.iso"
        main_menu
        ;;
    "🖥️ Minimal Gnome VM")
        clear
        run_minimal_gnome_test_vm
        main_menu
        ;;
    "🖥️ Full Gnome VM")
        clear
        run_full_gnome_test_vm
        main_menu
        ;;
    "🖥️ Minimal KDE-5 VM")
        clear
        run_kde5_test_vm
        main_menu
        ;;
    "🖥️ Minimal KDE-6 VM")
        clear
        run_kde6_test_vm
        main_menu
        ;;
    "🖥️ Complete Gnome VM (for screen recording)")
        clear
        main_menu
        ;;
    "🏠️ Main menu")
        clear
        main_menu
        ;;
    *) echo "🛑 Invalid choice. Please select again." ;;
    esac
}

help_menu() {
    gum style "💁🏽 Kartoza NixOS :: Help Menu:"
    choice=$(
        gum choose \
            "🏠️ Main menu" \
            "📃 Documentation (in terminal)" \
            "🌍️ Documentation (in browser)"
    )

    case $choice in
    "📃 Documentation (in terminal)")
        glow -p -s dark https://raw.githubusercontent.com/timlinux/nix-config/main/README.md
        help_menu
        ;;
    "🌍️ Documentation (in browser)")
        xdg-open https://github.com/timlinux/nix-config/blob/main/README.md
        help_menu
        ;;
    "🏠️ Main menu")
        clear
        main_menu
        ;;
    *) echo "🛑 Invalid choice. Please select again." ;;
    esac
}

# Call the main menu function
setup_gum
clear
welcome
main_menu
