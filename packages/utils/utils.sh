#!/usr/bin/env bash
set -e
setup_gum() {
    # Choose
    export GUM_CHOOSE_CURSOR_FOREGROUND="#F1C069"
    export GUM_CHOOSE_HEADER_FOREGROUND="#F1C069"
    export GUM_CHOOSE_ITEM_FOREGROUND="#F1C069"
    export GUM_CHOOSE_SELECTED_FOREGROUND="#F1C069"
    export GUM_CHOOSE_HEIGHT=10
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

# Function to generate system hardware profile
generate_hardware_profile() {
    echo "Generating system hardware profile..."
    # Add your commands to generate hardware profile here
    gum spin --spinner dot --title "Generating Hardware Profile" -- sleep 1
    CONFIG=$(nixos-generate-config --show-hardware-config)
    gum style 'Confirm:' "Would you like to store your hardware profile in 'our distributed key/value store'?"
    STORE=$(gum choose "STORE" "FORGET")
    if [ "$STORE" == "STORE" ]; then
        # Store user's selection in a key based on hostname using skate
        skate set "$(hostname)" "$CONFIG"
    fi
}

show_hardware_profile() {
    gum spin --spinner dot --title "Fetching hardware profiles from distributed key/value store..." -- sleep 5 &
    gum style 'Browse:' "Choose a hardware profile in 'skate' that you would like to see?"
    skate list -k | gum filter | xargs skate get | gum style
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
    read -n 1 -s -r key
    echo "$key Continuing..."
    clear
}

main_menu() {
    gum style "🏠️ Kartoza NixOS :: Main Menu"
    choice=$(
        gum choose \
            "💁🏽 Help" \
            "🚀 System management" \
            "❓️ System info" \
            "💡 About" \
            "🛑 Exit"
    )

    case $choice in
    "💁🏽 Help") help_menu ;;
    "🚀 System management") system_menu ;;
    "❓️ System info") system_info_menu ;;
    "💡 About") about ;;
    "🛑 Exit") exit 1 ;;
    *) echo "Invalid choice. Please select again." ;;
    esac
}

confirm_format() {
    echo "This tool is destructive! It will delete all your partitions on your hard drive. Do you want to continue?"
    DESTROY=$(gum choose "DESTROY" "CANCEL")
    if [ "$DESTROY" == "DESTROY" ]; then
        nix run .#setup-zfs-machine
    fi
}

system_menu() {
    gum style "🚀 Kartoza NixOS :: System Menu"
    choice=$(
        gum choose \
            "🏃🏽‍♂️ Update system" \
            "⚙️ Start syncthing" \
            "🪪 Generate host id" \
            "⚠️ Format disk with ZFS ⚠️" \
            "🏠️ Main menu"
    )

    case $choice in
    "Help") help_menu ;;
    "🏃🏽‍♂️ Update system")
        if [ "$EUID" -ne 0 ]; then
            echo "🛑 Run this as SUDO!"
            exit
        fi
        NIXPKGS_ALLOW_INSECURE=1 NIXPKGS_ALLOW_UNFREE=1 nix build --impure
        NIXPKGS_ALLOW_INSECURE=1 NIXPKGS_ALLOW_UNFREE=1 nixos-rebuild switch --impure --flake .
        prompt_to_continue
        system_menu
        ;;
    "⚙️ Start syncthing")
        start_syncthing
        prompt_to_continue
        system_menu
        ;;
    "🪪 Generate host id")
        echo "Your unique host ID is:"
        head -c 8 /etc/machine-id
        prompt_to_continue
        system_menu
        ;;
    "⚠️ Format disk with ZFS ⚠️")
        confirm_format
        prompt_to_continue
        system_menu
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
            "📃 Documentation (in terminal)" \
            "🌍️ Documentation (in browser)" \
            "🏠️ Main menu"
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

system_info_menu() {

    gum style "❓️ Kartoza NixOS :: System Info Menu:"
    choice=$(
        gum choose \
            "💻️ Generate your system hardware profile" \
            "🗃️ General System info" \
            "😺 Git stats" \
            "👨🏽‍🏫 GitHub user info" \
            "🌐 Your ISP and IP" \
            "🐿️ CPU info" \
            "🐏 RAM info" \
            "⭐️ Show me a star constellation" \
            "🏠️ Main menu"
    )

    case $choice in
    "💻️ Generate your system hardware profile")
        generate_hardware_profile
        prompt_to_continue
        system_info_menu
        ;;
    "🗃️ General System info")
        neofetch
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
# Call the main menu function
setup_gum
welcome
main_menu
