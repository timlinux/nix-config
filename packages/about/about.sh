#!/usr/bin/env bash
BLUE=34
CYAN=36
RED=31

set +e

read -d '\n' MESSAGE << EndOfText
This script is intended to be used to rescue a NixOS system
that has been installed with ZFS using the accompanying 
setup-host-with-zfs.sh script. 

It will mount the ZFS drives back in /mnt as it did during
the setup process and then put you in a chroot so you can 
explore and modify the files of the system you are rescuing.

Tim Sutton, March 2024
EndOfText



read -d '\n' LOGO << EndOfText
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
                                                                      
███╗   ██╗██╗██╗  ██╗ ██████╗ ███████╗    ███████╗███████╗███████╗    
████╗  ██║██║╚██╗██╔╝██╔═══██╗██╔════╝    ╚══███╔╝██╔════╝██╔════╝    
██╔██╗ ██║██║ ╚███╔╝ ██║   ██║███████╗      ███╔╝ █████╗  ███████╗    
██║╚██╗██║██║ ██╔██╗ ██║   ██║╚════██║     ███╔╝  ██╔══╝  ╚════██║    
██║ ╚████║██║██╔╝ ██╗╚██████╔╝███████║    ███████╗██║     ███████║    
╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝    ╚══════╝╚═╝     ╚══════╝    
                                                                      

EndOfText
# Above text generated at https://manytools.org/hacker-tools/ascii-banner/
# Using ANSI Shadow font
echo "$LOGO"
set -e
gum style \
  --foreground 212 --border-foreground 212 --border double \
  --align center --width 80 --margin "1 2" --padding "2 4" \
  'About this script:' "${MESSAGE}"

