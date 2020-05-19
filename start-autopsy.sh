# This is how a basic start script could look like...
open -a XQuartz.app
/opt/X11/bin/xhost + 192.168.1.142
docker run --rm -ti -e DISPLAY=192.168.1.142:0 -v /tmp/.X11-unix:/tmp/.X11-unix -v `pwd`:/data autopsy
