# sdl
Klipper/Katapult SD Card Load Utility

![SBC Host, USB to micro SD Card Adapter and micro SD Card](https://raw.githubusercontent.com/mykepredko/sdl/main/photos/Required_SDL_Parts.png)

This application was originally created to provide a simple, relatively fast and consisten method to flash an SD Card with Katapult firmware onto different main controller boards.  I found this approach to work better than using the flash-sdcard utility available in Klipper.

I know there are a number different instructions (with applications and scripts) for putting a Katapult/Klipper firmware image onto an SD Card image.  Unfortunately, many are incomplete, require the user to already understand how to mount drives, quite a few recommend transferring the .bin file to a PC using WinSCP or NotePad++ and writing the micro SD Card from there while others simply won't work.  

### Requirements
1. Host system (ie. Single Board Computer) with Klipper and, optionally, Katapult installed
  - Klipper and/or Katapult must be built for the main controller board to be loaded with Klipper/Katapult
2. SSH connection to the host system
3. USB to micro SD Card adapter
4. micro SD Card.  NOTE: This application checks the size of the SD Card and issues a warning if it is larger than 8GB (as many main controller boards have issues with larger SD Cards)
5. Main controller board with understanding of what the firmware's file name needs to be for the bootload to updating the main controller board's flash

### SD Card Firmware Load Procedure
1. Build Katapult/Klipper for the main controller board
2. Pull out all removable storage devices in the host's USB Ports
  - The application cannot identify a specific device and I didn't want to create a menu of the removable storage devices found on the host
  - **NOTE:** Do not pull out the micro SD Card that the host's operating system is stored on.  Just remove the devices in the host's USB Ports
4. Insert the USB to micro SD Card adapter into one of the host's USB ports
  - **NOTE:** The micro SD Card will be formatted so make sure you do NOT have any important information on it
5. Run the SDL application by copying the following statement and executing it from the command line of your SSH terminal:

```
bash <(curl -s https://raw.githubusercontent.com/mykepredko/sdl/main/SDL.sh)
```

  - You will be prompted for the appropriate filename ("firmware.bin" is a very common one)
  - If there are any issues with the host configuration, micro SD Card, you will be notified
6. Install the mciro SD Card into the main controller board and follow the manufacturer's instructions for installing new firmware

### Test Hosts & Main Controller Boards

This script has been tested on:
1. Raspberry Pi Zero 2 W running the current 32bit Lite Raspberry Pi OS
2. Raspberry Pi CM4 on a BTT rPi4B Adapter running the current 32bit Lite Raspberry Pi OS
3. Raspberry Pi 4B running the current 32bit Lite Raspberry Pi OS
4. Raspberry Pi 5 running the current 64bit Lite Raspberry Pi OS
5. BTT CB1 on a BTT rPi4B Adapter running BTT's latest version of Debian 11
6. BTT RPI$ V1.2 running BTT's latest version of Debian 11 and the latest Armbian for CB1 image

With the main controller boards:
1. BTT SKR Mini E3 V3
2. BTT Octopus
3. MKS Robin Nano V3.01

These lists will be updated as I (and others) use the script on additional hosts and main controller boards.  

### Caveats

I've tried to test this application on a representative set of hosts and main controller boards and I'm satisfied that there shouldn't be anything commands that will result in something bad happening (ie bricking a host or main controller board) but I can't give a 100% guarantee; you are using the script at your own risk.  

If any problems are encountered by users, I will post them here as soon as I am notified about them and can talk to the affected user to understand the issue.  

mykepredko@3dapothecary.xyz
