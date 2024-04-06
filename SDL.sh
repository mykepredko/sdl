#! /bin/bash

# This application provides the ability to format and save the current system copy of klipper.bin or katapult.bin on a newly formatted SD Card.
# mykepredko@3dapothecary.xyz
# (C) Copyright 2024 myke predko (mykepredko@3dapothecary.xyz)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
#
#
# Release History:
# 2024.04.05 - Initial release, Version 0.01
# 2024.04.05 - Version 0.02: Added check for filename longer than 8 characters
#                          : Updated final message to tell user they can use the SD Card in their Main Controller Card
#
# NOTE: to change hostname on BTT system, use: "sudo hostnamectl set-hostname <newhostname>"
#


set -e
originalDir="$(pwd)"
cd ~
homeDir="$(pwd)"

getVersion() {
  echo "0.01"
}


########################################################################
# Display (Constant) Variables and Methods
########################################################################
BLACK='\e[0;30m'
RED='\e[0;31m'
GREEN='\e[0;32m'
BROWN='\e[0;33m'
BLUE='\e[0;34m'
PURPLE='\e[0;35m'
CYAN='\e[0;36m'
LIGHTGRAY='\e[0;37m'
DARKGRAY='\e[1;30m'
LIGHTRED='\e[1;31m'
LIGHTGREEN='\e[1;32m'
YELLOW='\e[1;33m'
LIGHTBLUE='\e[1;34m'
LIGHTPURPLE='\e[1;35m'
LIGHTCYAN='\e[1;36m'
WHITE='\e[1;37m'
BASE='\e[0m'

outline=$RED
highlight=$LIGHTBLUE
active=$LIGHTGRAY
inactive=$DARKGRAY
warningColor=$YELLOW

#                      1111111111222222222233333333334444444444555555555566666666667777
#            01234567890123456789012345678901234567890123456789012345678901234567890123
EMPTYSTRING="                                                                          "
PHULLSTRING="##########################################################################"
displayWidth=${#EMPTYSTRING}
getYNChar=""
fileName=""

########################################################################
# Display Methods
########################################################################
clearScreen() {
  printf "\ec"
}
drawHeader() {
headerName="$1"

  clearScreen
#                        111111111122222222223333333333444444444455555555556666666666
#              0123456789012345678901234567890123456789012345678901234567890123456789 
  echo -e "$outline$PHULLSTRING"
  tblankscreen=${BLANKSTRING}
  version=$(getVersion) 
  headerLength=${#headerName}
  versionLength=${#version}
  stringLength=$(( displayWidth - ( 4 + 4 + 4 + 2 + versionLength + headerLength )))
  echo -e "##$highlight  SDL $version ${EMPTYSTRING:0:$stringLength} ${1}  $outline##"

  echo -e "$PHULLSTRING$BASE"
}
drawWarn() {
warnHeaderMessage="$1"
warnString="$2"

  drawHeader "$warnHeaderMessage"
#                            1111111111222222222233333333334444444444555555555566666666667777
#                  01234567890123456789012345678901234567890123456789012345678901234567890123 
  echo -e "$outline##                                                                      ##
##$warningColor WWW     WWW     WWW     AAA        RRRRRRRRRRR     NNN           NNN $outline##
##$warningColor WWW     WWW     WWW     AAA        RRRRRRRRRRRRR   NNNN          NNN $outline##
##$warningColor WWW     WWW     WWW    AAAAA       RRR        RRR  NNNNN         NNN $outline##
##$warningColor  WWW   WWWWW   WWW     AAAAA       RRR        RRR  NNNNNN        NNN $outline##
##$warningColor  WWW   WWWWW   WWW    AAA AAA      RRR        RRR  NNN NNN       NNN $outline##
##$warningColor  WWW   WWWWW   WWW    AAA AAA      RRR       RRR   NNN  NNN      NNN $outline##
##$warningColor   WWW WWW WWW WWW    AAA   AAA     RRRRRRRRRRRR    NNN   NNN     NNN $outline##
##$warningColor   WWW WWW WWW www    AAA   AAA     RRRRRRRRRRR     NNN    NNN    NNN $outline##
##$warningColor   WWW WWW WWW WWW   AAA     AAA    RRR RRR         NNN     NNN   NNN $outline##
##$warningColor    WWWWW   WWWWW    AAA     AAA    RRR  RRR        NNN      NNN  NNN $outline##
##$warningColor    WWWWW   WWWWW   AAAAAAAAAAAAA   RRR   RRR       NNN       NNN NNN $outline##
##$warningColor    WWWWW   WWWWW   AAAAAAAAAAAAA   RRR    RRR      NNN        NNNNNN $outline##
##$warningColor     WWW     WWW   AAA         AAA  RRR     RRR     NNN         NNNNN $outline##
##$warningColor     WWW     WWW   AAA         AAA  RRR      RRR    NNN          NNNN $outline##
##$warningColor     WWW     WWW   AAA         AAA  RRR      RRR    NNN           NNN $outline##
##                                                                      ##
$PHULLSTRING"
  warnLength=${#warnString}
  stringLength=$(( displayWidth - ( 4 + 2 + warnLength )))
  echo -e     "##$highlight  $warnString${EMPTYSTRING:0:stringLength}$outline##"

  echo -e     "$PHULLSTRING$BASE"
}
drawError() {
errorHeaderMessage="$1"
errorString="$2"

  drawHeader "$errorHeaderMessage"
#                            1111111111222222222233333333334444444444555555555566666666667777
#                  01234567890123456789012345678901234567890123456789012345678901234567890123 
  echo -e "$outline##                                                                      ##
##  EEEEEEEEEEE   RRRRRRRR      RRRRRRRR         OOOOO      RRRRRRRR    ##
##  EEEEEEEEEEE   RRRRRRRRRR    RRRRRRRRRR     OOOOOOOOO    RRRRRRRRRR  ##
##  EEE     EEE   RRR     RRR   RRR     RRR   OOOO   OOOO   RRR     RRR ##
##  EEE           RRR     RRR   RRR     RRR   OOO     OOO   RRR     RRR ##
##  EEE           RRR     RRR   RRR     RRR   OOO     OOO   RRR     RRR ##
##  EEE            RRR   RRRR   RRR    RRR    OOO     OOO   RRR    RRR  ##
##  EEEEEE        RRRRRRRR      RRRRRRRR      OOO     OOO   RRRRRRRR    ##
##  EEEEEE        RRRRRRRR      RRRRRRRR      OOO     OOO   RRRRRRRR    ##
##  EEE           RRR RRR       RRR RRR       OOO     OOO   RRR RRR     ##
##  EEE           RRR  RRR      RRR  RRR      OOO     OOO   RRR  RRR    ##
##  EEE           RRR   RRR     RRR   RRR     OOO     OOO   RRR   RRR   ##
##  EEE     EEE   RRR    RRR    RRR    RRR    OOOO   OOOO   RRR    RRR  ##
##  EEEEEEEEEEE   RRR     RRR   RRR     RRR    OOOOOOOOO    RRR     RRR ##
##  EEEEEEEEEEE   RRR     RRR   RRR     RRR      OOOOO      RRR     RRR ##
##                                                                      ##
$PHULLSTRING"
  errorLength=${#errorString}
  stringLength=$(( displayWidth - ( 4 + 2 + errorLength )))
  echo -e     "##$highlight  $errorString${EMPTYSTRING:0:stringLength}$outline##"

  echo -e     "$PHULLSTRING$BASE"
}
drawSplash() {
splashHeaderMessage="$1"

  drawHeader "$splashHeaderMessage"
#                            1111111111222222222233333333334444444444555555555566666666667777
#                  01234567890123456789012345678901234567890123456789012345678901234567890123 
  echo -e "$outline##                                                                      ##
##$active                                                                      $outline##
##$active                                                                      $outline##
##$active                            HOST                                      $outline##
##$active                                                                      $outline##
##$active                        +----------+                                  $outline##
##$active                        |          |                                  $outline##
##$active                        |    USB   |                                  $outline##
##$active                        |  Socket  |                                  $outline##
##$active                        |          |                                  $outline##
##$active  ----------------------+----------+--------------------------------  $outline##
##$active                             ^                                        $outline##
##$active                             |                                        $outline##
##$active                        +----------+                                  $outline##
##$active                        |          |                                  $outline##
##$active                        |          |                                  $outline##
##$active                        |          |                                  $outline##
##$active                        |          |                                  $outline##
##$active                      +-+----------+-+                                $outline##
##$active                      |              |                                $outline##
##$active                      |Micro SD Card |                                $outline##
##$active                      |to USB Socket |                                $outline##
##$active                      |   Adapter    |                                $outline##
##$active                      +--------------+                                $outline##
##$active                             ^                                        $outline##
##$active                             |                                        $outline##
##$active                        +---------+                                   $outline##
##$active                        |         |                                   $outline##
##$active                        |Micro SD |                                   $outline##
##$active                        |  Card   |                                   $outline##
##$active                        |          \                                  $outline##
##$active                        |          |                                  $outline##
##$active                                                                      $outline##
$PHULLSTRING"
}
drawMessage() {
#$# $1 strings to display

  echo -e "$outline$PHULLSTRING$BASE"

  for argument in "$@"; do
    appendString=$argument
    appendLength=${#appendString}
    stringLength=$(( displayWidth - ( 4 + 4 + 1 + appendLength )))
    echo -e "$outline##$highlight  $appendString ${EMPTYSTRING:0:$stringLength}  $outline##"
  done

  echo -e "$PHULLSTRING$BASE"
}
doMessage() {
#$# $1 strings to display

  echo -e "$outline$PHULLSTRING$BASE"

  for argument in "$@"; do
    appendString=$argument
    appendLength=${#appendString}
    if [ "!" == "${appendString:0:1}" ]; then
      appendString="${appendString:1}"
      appendLength=$(( $appendLength - 1 ))
    fi
    stringLength=$(( displayWidth - ( 4 + 4 + 1 + appendLength )))
    echo -e "$outline##$highlight  $appendString ${EMPTYSTRING:0:$stringLength}  $outline##"
  done

  echo -e "$PHULLSTRING$BASE"
  
  for argument in "$@"; do
    appendString=$argument
    if [ "!" != "${appendString:0:1}" ]; then
      $appendString
    fi
  done
}
drawAppend() {
#$# $1 strings to display

  for argument in "$@"; do
    appendString=$argument
    appendLength=${#appendString}
    stringLength=$(( displayWidth - ( 4 + 4 + 1 + appendLength )))
    echo -e "$outline##$highlight  $appendString ${EMPTYSTRING:0:$stringLength}  $outline##"
  done

  echo -e "$PHULLSTRING$BASE"
}
doAppend() {
#$# $1 strings to display/execute

  for argument in "$@"; do
    appendString=$argument
    appendLength=${#appendString}
    if [ "!" == "${appendString:0:1}" ]; then
      appendString="${appendString:1}"
      appendLength=$(( $appendLength - 1 ))
    fi
    stringLength=$(( displayWidth - ( 4 + 4 + 1 + appendLength )))
    echo -e "$outline##$highlight  $appendString ${EMPTYSTRING:0:$stringLength}  $outline##"
  done

  echo -e "$PHULLSTRING$BASE"
  
  for argument in "$@"; do
    appendString=$argument
    if [ "!" != "${appendString:0:1}" ]; then
      $appendString
    fi
  done
}
getYN() {

  invalidResponseString="Invalid Response    "
  invalidResponseStringLength=${#invalidResponseString}

  validFlag=0
  invalidPromptString=${EMPTYSTRING:0:invalidResponseStringLength}
  while [ $validFlag -eq 0 ]; do
    read -p "$invalidPromptString(Y/N): " getYNChar
    invalidPromptString="$invalidResponseString"
    if [[ "$getYNChar" != "" ]]; then
      getYNChar="${getYNChar^^}"
      getYNChar="${getYNChar:0:1}"
      if [[ "$getYNChar" == "Y" ]] || [[ "$getYNChar" == "N" ]]; then
        validFlag=1
      fi
    fi
    if [ $validFlag -eq 0 ]; then
      echo -en "\033[1A\033[2K"
    fi
  done
}
getFileName() {

  invalidResponseString="Invalid Response    "
  invalidResponseStringLength=${#invalidResponseString}

  validFlag=0
  invalidPromptString=${EMPTYSTRING:0:(( $invalidResponseStringLength - 1))}
  while [ $validFlag -eq 0 ]; do
    read -p "$invalidPromptString Enter filename.ext: " fileName
    invalidPromptString="${invalidResponseString:0:(( $invalidResponseStringLength - 1))}"
    fileNameSize=${#fileName}
    if [ $fileNameSize -gt 4 ] && [ $fileNameSize -lt 13 ]; then
      if [[ "${fileName:(( $fileNameSize - 4 )):1}" == "." ]]; then
        validFlag=1
      fi
    fi
    if [ $validFlag -eq 0 ]; then
      echo -en "\033[1A\033[2K"
    fi
  done
}


# Instructions to execute/Assumes user has loaded Klipper and created klipper.bin or katapult.bin
#  sudo apt update
#    Make sure system is up to date
#  sudo fdisk --list
#    Returns Devices available
#    - Look for "Disk /dev/sd(a/b/c/...)" to indicate presence of removable storage
#      - Not sure how to handle multiple devices - ignore for now
#    - Full line looks like "Disk /dev/sda: [#...]#.## GiB, ###### bytes, #### sectors"
#      - Should be able to convert the "[#...]#.##" string to a number
#      - If number is greater than 4 give warning that SD Card may be too large
#  sudo mkfs -t exfat /dev/sda
#    Formats the Drive
#    - Works fine for rPi Hosts
#    - Fails for BTT hosts: "mkfs: failed to execute mkfs.exfat: No such file or directory"
#      - execute "sudo apt-get install autoconf libtool pkg-config"
#                "sudo apt install exfatprogs"
#        Then try the "mkfs" command again and should format the drive
#  mkdir drive
#    Creates a folder for mounting the Drive
#  sudo mount -t exfat /dev/sda drive
#    Mount the drive into the "drive" folder
#  sudo cp out/klipper.bin drive
#    Copy the kipper.bin file into the mounted "drive" folder
#    - Note that the user will have to have specified a file name
#  sudo umount drive
#    Unmount the drive

####################################################################################################
# Mainline
####################################################################################################

drawSplash "SD Card Load"
doAppend "!Making sure system is up to date:" "sudo apt update -y" "sudo apt upgrade -y" "sudo apt-get upgrade -y" "sudo apt-get install bc"


drawHeader "Set Firmware Filename"
fileNameValid=0
while [[ $fileNameValid -eq 0 ]]; do
  getFileName
  echo -e "Is the file name correct?"
  getYN
  if [[ "$getYNChar" == "Y" ]]; then
    fileNameValid=1
  fi
done


drawHeader "Check SD Card"
drawAppend "sudo fdisk --list" "- Make Sure there is a single removable drive" "- Check size of removable drive"
fDiskListSDAStart="Disk /dev/sda: "
fDiskListSDBStart="Disk /dev/sdb: "
fDiskListSBEnd=" GiB,"
fDiskList=`sudo fdisk --list`
fDiskListSDASize=${fDiskList#*$fDiskListSDAStart}
if [[ "$fDiskListSDASize" == "$fDiskList" ]]; then
  drawError "No Removable Storage Devices" "Add Removable Storage Device and Restart"
  cd "$originalDir"
  exit 1
fi
fDiskListSDALast="$fDiskList"
while [[ "$fDiskListSDASize" != "$fDiskListSDALast" ]]; do
  fDiskListSDALast="$fDiskListSDASize"
  fDiskListSDASize=${fDiskListSDASize%$fDiskListSBEnd*}
done
fDiskListSDB=${fDiskList#*$fDiskListSDBStart}
if [[ "$fDiskListSDB" != "$fDiskList" ]]; then
  drawError "Multiple Removable Storage Devices" "Remove Unused Removable Storage Devices"
  cd "$originalDir"
  exit 1
fi
if (( $(echo "$fDiskListSDASize > 8.0" | bc -l) )); then
  drawWarn "SD Card Size Warning" "Continue with Removable Storage Device Greater than 8GB?"
  getYN
  if [[ "$getYNChar" == "N" ]]; then
    cd "$originalDir"
    exit 0
  fi
fi


katapultFile="Katapult/out/katapult.bin"
klipperFile="klipper/out/klipper.bin"
sourceFile=""
if [ -f $katapultFile ]; then
  sourceFile="$katapultFile"
elif [ -f $klipperFile ]; then
  sourceFile="$klipperFile"
else 
  drawError "No .bin files" "Must create .bin files for Katapult or Klipper"
  cd "$originalDir"
  exit 1
fi


{ # try to format sda
  sudo mkfs -t exfat /dev/sda
} || { # catch error, install correct options
  doMessage "sudo apt-get install autoconf libtool pkg-config -y" "sudo apt install exfatprogs -y" "sudo mkfs -t exfat /dev/sda"
}


sudo mkdir sdaTempMount
sudo mount -t exfat /dev/sda sdaTempMount
sudo cp $sourceFile sdaTempMount/$fileName
sudo umount sdaTempMount
sudo rmdir sdaTempMount


drawMessage "SD Card loaded with $sourceFile as $fileName" "" "SD Card can be removed and" "Used to update main controller firmware"

cd "$originalDir"
exit 0
