FROM hypriot/rpi-node:latest

ENV NODE_ENV production
EXPOSE 8080

RUN apt-get update

# needed for running:
RUN apt-get -qy install dos2unix libgtk2.0-0 libx11-xcb-dev libxtst6 libxss1 libgconf-2-4 libnss3-dev libasound2

# arp-scan only needed for the module MMM-NetworkScanner, nano as editor:
RUN apt-get -qy install nano arp-scan

WORKDIR /opt/magic_mirror
# getting MagicMirror from github
RUN git clone --depth 1 -b master https://github.com/MichMich/MagicMirror.git .

# install (without param the mirror remains black):
RUN npm install --unsafe-perm

# copy sample to real config:
RUN cp config/config.js.sample config/config.js

# create copies for unmount:
RUN cp -R modules /opt/magic_mirror/unmount_modules
RUN cp -R config /opt/magic_mirror/unmount_config

# copy startscript into container:
COPY docker-entrypoint.sh /opt/magic_mirror
RUN dos2unix docker-entrypoint.sh && chmod +x docker-entrypoint.sh

ENTRYPOINT ["/opt/magic_mirror/docker-entry-raspberry.sh"]