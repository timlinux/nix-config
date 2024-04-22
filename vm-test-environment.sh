#!/usr/bin/env bash

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

set +e

read -r -d '\n' MESSAGE << EndOfText
This script will run a test instance of our flake in a vm.

Tim Sutton, April 2024
EndOfText

read -r -d '\n' LOGO << EndOfText
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

------------------------------------------------------------------------------
EndOfText
# Above text generated at https://manytools.org/hacker-tools/ascii-banner/
# Using ANSI Shadow font
echo ""
echo "$LOGO"
set -e
gum style 'About this script:' "${MESSAGE}"


gum spin --spinner dot --title "Generating Hardware Profile" -- sleep 1
gum style 'Confirm:' "Which test vm would you like to run?"

VM=$(gum choose "GNOME" "PLASMA6")

echo "🏃Running flake in a test ${VM} vm"
echo "See https://lhf.pt/posts/demystifying-nixos-basic-flake/"
echo "For a detailed explanation"
if ls *.cow2 1> /dev/null 2>&1; then
    rm -f *.cow2
fi


if [ "$VM" == "GNOME" ]; then
  # #test is the name of the host config as listed in flake.nix
  nixos-rebuild build-vm --flake .#test-gnome && result/bin/run-*-vm
else
  # #test is the name of the host config as listed in flake.nix
  nixos-rebuild build-vm --flake .#test-kde && result/bin/run-*-vm

fi

