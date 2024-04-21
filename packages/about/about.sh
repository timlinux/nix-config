#!/usr/bin/env bash

export GUM_INPUT_CURSOR_FOREGROUND="#FF0"
export GUM_INPUT_PROMPT_FOREGROUND="#0FF"
export GUM_INPUT_PLACEHOLDER="What's up?"
export GUM_INPUT_PROMPT="* "
export GUM_INPUT_WIDTH=80
  # Choose
  GUM_CHOOSE_CURSOR_FOREGROUND="#F1C069"
  GUM_CHOOSE_HEADER_FOREGROUND="#F1C069"
  GUM_CHOOSE_ITEM_FOREGROUND="#F1C069"
  GUM_CHOOSE_SELECTED_FOREGROUND="#F1C069"
  GUM_CHOOSE_ORDERED
  GUM_CHOOSE_HEIGHT=10
  GUM_CHOOSE_CURSOR="⌨️"
  GUM_CHOOSE_HEADER="Choose one:"
  GUM_CHOOSE_CURSOR_PREFIX="❓️"
  GUM_CHOOSE_SELECTED_PREFIX="👍️"
  GUM_CHOOSE_UNSELECTED_PREFIX="⛔️"
  GUM_CHOOSE_SELECTED=""
  GUM_CHOOSE_TIMEOUT=30
  # Style
  FOREGROUND="#F1C069"
  BACKGROUND="#CDCDCC"
  BORDER="#8A8B8B"
  BORDER_BACKGROUND="#B9D8E9"
  BORDER_FOREGROUND="#F1C069"
  ALIGN="left"
  HEIGHT=30
  WIDTH=80
  MARGIN=1
  PADDING=2
  #BOLD
  #FAINT
  #ITALIC
  #STRIKETHROUGH
  #UNDERLINE
  # Confirm
  GUM_CONFIRM_PROMPT_FOREGROUND="#F1C069"
  GUM_CONFIRM_SELECTED_FOREGROUND="#F1C069"
  GUM_CONFIRM_UNSELECTED_FOREGROUND="#F1C069"
  GUM_CONFIRM_TIMEOUT=30
  # Input
  GUM_INPUT_PLACEHOLDER="-----------"
  GUM_INPUT_PROMPT=">"
  GUM_INPUT_CURSOR_MODE="blink"
  GUM_INPUT_WIDTH=40
  GUM_INPUT_HEADER="💬"
  GUM_INPUT_TIMEOUT=30
  GUM_INPUT_PROMPT_FOREGROUND="#F1C069"
  GUM_INPUT_CURSOR_FOREGROUND="#F1C069"
  GUM_INPUT_HEADER_FOREGROUND="#F1C069"
  # Spin
  GUM_SPIN_SPINNER_FOREGROUND="#F1C069"
  GUM_SPIN_TITLE_FOREGROUND="#F1C069"
  # Table
  GUM_TABLE_BORDER_FOREGROUND="#F1C069"
  GUM_TABLE_CELL_FOREGROUND="#F1C069"
  GUM_TABLE_HEADER_FOREGROUND="#F1C069"
  GUM_TABLE_SELECTED_FOREGROUND="#F1C069"

set +e

read -r -d '\n' MESSAGE << EndOfText
This script will provide useful diagnosis info
about your system.

Tim Sutton, April 2024
EndOfText

read -r -d '\n' LOGO << EndOfText


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

EndOfText
# Above text generated at https://manytools.org/hacker-tools/ascii-banner/
# Using ANSI Shadow font
echo "$LOGO"
set -e
gum style \
  --foreground 212 --border-foreground 212 --border double \
  --align center --width 80 --margin "1 2" --padding "2 4" \
  'About this script:' "${MESSAGE}"


gum spin --spinner dot --title "Generating Hardware Profile" -- sleep 1
CONFIG=$(nixos-generate-config --show-hardware-config)


HOSTNAME=$(hostname)


gum style \
  --foreground 212 --border-foreground 212 --border double \
  --align center --width 80 --margin "1 2" --padding "2 4" \
  'Confirm:' "Would you like to store your hardware profile in 'skate'?"

STORE=$(gum choose "STORE" "FORGET")
if [ "$STORE" == "STORE" ]; then
   # Store user's selection in a key based on hostname using skate
   skate set "$HOSTNAME" "$CONFIG"
fi



