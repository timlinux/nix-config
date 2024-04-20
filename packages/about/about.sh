#!/usr/bin/env bash

set +e

read -r -d '\n' MESSAGE << EndOfText
This script will provide useful diagnosis info
about your system.

Tim Sutton, April 2024
EndOfText

read -r -d '\n' LOGO << EndOfText

                      ///             
                  ///////////         
                 ////     ////        
                 ///       ///        
                 ////      *//        
              ,,, //// //////////     
           ,,,,,   ////        /////  
          ,,,         ,,,,        /// 
          ,,,       ,,,,  /      //// 
           ,,,,,,,,,,,   ///////////  
              ,,,,           ///* 

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



