# autopsy-docker

Runs The Sleuth Kit's Autopsy in a Docker container.

Tested on MacOS Catalina. Should work on Linux. Not tested yet under Windows.

## Licenses

  * This project/Docker file is licensed under GNU GENERAL PUBLIC LICENSE 3.0
  * TSK Autopsy is Apache License 2.0 / https://github.com/sleuthkit/autopsy
  * TSK has various licenses, please see https://github.com/sleuthkit/sleuthkit

## Building

  * Checkout https://github.com/imifos/autopsy-docker
  * Enter directory
  * Add autopsy-4.15.0.zip from https://www.autopsy.com/download/
  * Add sleuthkit-java_4.9.0-1_amd64.deb from https://www.autopsy.com/download/
  * docker build -t autopsy .

Alternatively, download from Docker Hub. It's however a big file.
   
## Pre-requisites 

In order to display a GUI on our host system, we need to run a X11 server on our host system and mount the IPC connection points into our container. 

For MacOS, a good description on how to do this can be found here: https://medium.com/@dimitris.kapanidis/running-gui-apps-in-docker-containers-3bd25efa862a

Quick-start version for MacOS:

  * Download and install XQuartz from https://www.xquartz.org or via ```brew cask install xquartz```.
  * Logout-login or reboot. 
  * Determine your host IP address (```<your IP>```).
  * Open terminal.
  * Start XQuartz: ```open -a Xquartz```. This HAS to be done from the console, otherwise the process will not run with the correct rights.
  * (Do Once) In the XQuartz X11 Preferences, Security, Allow connections from network clients.
  * (Do Once) Open a new terminal window, close the previous one.
  * Whitelist your host IP to allow X11 connections from your host to our host via the network interface: ```/opt/X11/bin/xhost + <your IP>```. This has to be done with $DISPLAY on default or operational value as xhost connects to X11 server used the currently configured way. We do NOT set the local $DISPLAY environment variable.
  * Start a test container to verify the Autopsy GUI pops-up: ```docker run --rm -ti -e DISPLAY=<your IP>:0 -v /tmp/.X11-unix:/tmp/.X11-unix autopsy```
  * In case of error (Catalina), you need to give your shell (/bin/bash, /bin/zsh or both) 'Full Disk Access' in Preferences, Security & Privacy, Privacy. Re-open a new terminal window and retry. Ref: https://github.com/XQuartz/XQuartz/issues/6

## Use Cases

Replace 192.168.1.xxx below with ```<your IP>```. Do NOT run the container as privileged.

Help:
  * ```docker run --rm -ti autopsy```

Start AUTOPSY, mounting a case volume:
  * ```docker run --rm -ti -e DISPLAY=192.168.1.xxx:0 -v /tmp/.X11-unix:/tmp/.X11-unix -v /myhost_case_files:/container_case_files autopsy```

Start AUTOPSY, mounting current directory as case volume:
  * ```docker run --rm -ti -e DISPLAY=192.168.1.xxx:0 -v /tmp/.X11-unix:/tmp/.X11-unix -v `pwd`:/container_case_files autopsy```
