#!/usr/bin/env bash


NOVNC_VERSION=1.0.0-beta
WEBSOCKIFY_VERSION=0.8.0
TURBOVNC_VERSION=2.1.2
LIBJPEG_VERSION=1.5.2

CWD=$(pwd)
mkdir -p /opt


cd /tmp \
   && curl -fsSL -O https://svwh.dl.sourceforge.net/project/turbovnc/${TURBOVNC_VERSION}/turbovnc_${TURBOVNC_VERSION}_amd64.deb \
   && curl -fsSL -O https://svwh.dl.sourceforge.net/project/libjpeg-turbo/${LIBJPEG_VERSION}/libjpeg-turbo-official_${LIBJPEG_VERSION}_amd64.deb \
   && dpkg -i *.deb \
   && rm -f /tmp/*.deb \
   && sed -i 's/$host:/unix:/g' /opt/TurboVNC/bin/vncserver
cd ${CWD}

export PATH=${PATH}:/opt/VirtualGL/bin:/opt/TurboVNC/bin


curl -fsSL https://github.com/novnc/noVNC/archive/v${NOVNC_VERSION}.tar.gz | tar -xzf - -C /opt && \
curl -fsSL https://github.com/novnc/websockify/archive/v${WEBSOCKIFY_VERSION}.tar.gz | tar -xzf - -C /opt && \
rm -rf /opt/noVNC && \
mv /opt/noVNC-${NOVNC_VERSION} /opt/noVNC && \
rm -rf /opt/websockify && \
mv /opt/websockify-${WEBSOCKIFY_VERSION} /opt/websockify && \
ln -s /opt/noVNC/vnc_lite.html /opt/noVNC/index.html && \
cd /opt/websockify && make


cat << EoF >/etc/turbovncserver-security.conf
no-remote-connections
no-httpd
no-x11-tcp-connections
no-pam-sessions
permitted-security-types = otp
EoF


apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        libc6-dev \
        libglu1 \
        libsm6 \
        libxv1 \
        x11-xkb-utils \
        xauth \
        xfonts-base \
        xkb-data \
        openbox \
        xterm \
    >/dev/null


cd ${CWD}
