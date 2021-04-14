# autopsy-docker

Runs The Sleuth Kit's Autopsy in a Docker container.

Tested on MacOS Catalina. Should work on Linux. Not tested yet under Windows.

The resulting image is big (2.5G uncompressed, 1GB compressed/HUB), but it contains many integrated tools like TSK, EWF Tools, gstreamer, Jython (for extensions), Java/FX (for extensions), photorec, plaso, SolR, Volatility, Tesseract OCR, xmount. The extracted Autopsy ZIP package alone is nearly 2 GB. 

## Versions

  * 1.0-4.15.0, 05.2020, Autopsy 4.15.0, Basis Autopsy runtime. 
  * 1.1-4.18.0, 04.2021, Autopsy 4.18.0, Basis Autopsy runtime. 

## Licenses

  * This project/Docker file is licensed under GNU GENERAL PUBLIC LICENSE 3.0
  * TSK Autopsy is Apache License 2.0, see https://github.com/sleuthkit/autopsy
  * TSK has various licenses, see https://github.com/sleuthkit/sleuthkit

## Building

  * Checkout https://github.com/imifos/autopsy-docker
  * Enter directory
  * Add autopsy-4.18.0.zip from https://www.autopsy.com/download/
  * Add sleuthkit-java_4.10.2-1_amd64.deb from https://www.autopsy.com/download/
  * docker build -t autopsy .
  
The multi-stage build creates an intermediary image that should be removed, for instance with ```docker image prune```. Building with the experimental '--squash' flag saves additional 300MB.

The image is also on Docker Hub: https://hub.docker.com/repository/docker/imifos/autopsy
   
## Usage pre-requisites MacOS

In order to display a GUI on the host system, we need to run a X11 server and mount the IPC connection points into the container. 

For MacOS, a good description on how to do this can be found here: https://medium.com/@dimitris.kapanidis/running-gui-apps-in-docker-containers-3bd25efa862a

Quick-start version for MacOS:

  * Download and install XQuartz from https://www.xquartz.org or via ```brew cask install xquartz```.
  * Logout-login or reboot. 
  * Determine your host IP address (```<your IP>```).
  * Open terminal.
  * Start XQuartz: ```open -a Xquartz```. This HAS to be done from the terminal, otherwise the process will not run with the correct rights.
  * (Do Once) In the XQuartz X11 Preferences, Security, Allow connections from network clients.
  * (Do Once) Open a new terminal window to make sure the new $DISPLAY environment variable value is set in our shell. Close the previous one. 
  * Whitelist the host IP to allow X11 connections from host to host via the network interface: ```/opt/X11/bin/xhost + <your IP>```. This has to be done with $DISPLAY on default or operational value as xhost connects to the X11 server using the currently configured way. We do NOT set the local $DISPLAY environment variable. Do not run "xhost +" without IP.
  * Start a test container to verify the Autopsy GUI pops-up: ```docker run --rm -ti -e DISPLAY=<your IP>:0 -v /tmp/.X11-unix:/tmp/.X11-unix autopsy```
  * In case of error (Catalina), you need to give your shell (/bin/bash, /bin/zsh or both) 'Full Disk Access' in Preferences, Security & Privacy, Privacy. Re-open a new terminal window and retry. Ref: https://github.com/XQuartz/XQuartz/issues/6

## Use Cases

Replace 192.168.1.xxx below with ```<your IP>```. Do NOT run the container as privileged.

Displays this README:
  * ```docker run --rm -ti autopsy```

Start AUTOPSY, mounting a case volume:
  * ```docker run --rm -ti -e DISPLAY=192.168.1.xxx:0 -v /tmp/.X11-unix:/tmp/.X11-unix -v /myhost_case_files:/container_case_files autopsy```

Start AUTOPSY, mounting current directory as case volume:
  * ```docker run --rm -ti -e DISPLAY=192.168.1.xxx:0 -v /tmp/.X11-unix:/tmp/.X11-unix -v `pwd`:/container_case_files autopsy```


## Pushing to Docker HUB

```
docker build -t imifos/autopsy .
docker tag imifos/autopsy:latest imifos/autopsy:1.1-4.18.0
Docker login
docker push imifos/autopsy:1.1-4.18.0
```

## TODO

Test if this works on windows: https://github.com/microsoft/WSL/issues/4106#issuecomment-636446405

