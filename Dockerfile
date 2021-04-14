# TSK Autopsy in Docker
#
# Licenses:
#   This project/Docker file is GNU GENERAL PUBLIC LICENSE 3.0
#   TSK Autopsy is Apache License 2.0 / https://github.com/sleuthkit/autopsy
#   TSK has various licenses, please see https://github.com/sleuthkit/sleuthkit
#
# Documentation:
#   See README.md
# 
# Requires autopsy-X.XX.X.zip and sleuthkit-java_X.X.X-1_amd64.deb downloaded 
# into the Dockerfile directory before building. This is better than downloading 
# the files each time the image is built.
#
# Version:
#   1.0-4.15.0, 05.2020, Autopsy 4.15.0
#
FROM ubuntu:18.04 AS unzip-stage
MAINTAINER @imifos

RUN mkdir /tools \
 && apt update \
 && apt install -y --no-install-recommends unzip 
 
COPY autopsy-4.18.0.zip /tools
COPY sleuthkit-java_4.10.2-1_amd64.deb /tools
COPY README.md /tools
COPY autopsy.sh /tools

RUN cd /tools \
 && unzip autopsy-4.18.0.zip \
 && rm autopsy-4.18.0.zip
 
#

FROM ubuntu:18.04 AS finale-stage
MAINTAINER @imifos

COPY --from=unzip-stage /tools/ /tools/

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get install -y testdisk unzip afflib-tools xmount libewf2 libafflib-dev libbfio-dev libbfio1 libc-dev-bin \
                       libc3p0-java libc6-dev libewf-dev libpostgresql-jdbc-java libpq5 libsqlite3-dev libvhdi-dev \
                       libvhdi1 libvmdk-dev libvmdk1 linux-libc-dev zlib1g-dev openjdk-8-jre \
                       openjfx=8u161-b12-1ubuntu2 libopenjfx-java=8u161-b12-1ubuntu2 libopenjfx-jni=8u161-b12-1ubuntu2 \
 && apt-mark hold libopenjfx-java libopenjfx-jni openjfx \
 && rm -rf /var/lib/apt/lists/* 

RUN cd /tools \
 && chmod 744 autopsy.sh \
 && dpkg -i sleuthkit-java_4.10.2-1_amd64.deb \
 && rm sleuthkit-java_4.10.2-1_amd64.deb \
 && cd /tools/autopsy-4.18.0 \
 && chmod 744 unix_setup.sh \
 && ./unix_setup.sh

WORKDIR /

# Note: Best run autopsy as root inside the container. Don't run the container as privileged.
ENTRYPOINT [ "/bin/bash","/tools/autopsy.sh" ] 
