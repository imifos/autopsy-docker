# autopsy-docker

Runs The Sleuth Kit's Autopsy in a Docker container.

## Pre-requisites:

# (for MacOS or lInux with X11 server)
#
# https://medium.com/@dimitris.kapanidis/running-gui-apps-in-docker-containers-3bd25efa862a
# brew cask install docker (or from https://www.xquartz.org/)
# config quartz= allow entwork
#
# https://github.com/XQuartz/XQuartz/issues/6
# Add you shell to FILL DISK ACCESS in control panel 
# START quartz from TERMINAL ie shell not spotlight or bar) - access rights - open -a XQuartz
# 
# Build the image:
# # my IP = IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
# set display IP:0
# (default is /private/tmp/com.apple.launchd.WrUOD1vCUR/org.macosforge.xquartz:0)
#


## Building:

  * Install Docker
  * Checkout this repo: ```git clone https://github.com/imifos/docker-workspace```
  * Enter the container directory.
  * Run ```docker build -t cyberchef .``` (you can choose a different name).
   
## Use cases:
  
  * ```docker run --rm -p 6401:8080 cyberchef```
  * http://localhost:6401/
  * Exit: Ctrl+C in container window

  
