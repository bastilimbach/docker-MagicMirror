FROM hypriot/rpi-node:latest

ENV NODE_ENV production
EXPOSE 8080

RUN apt-get update

# needed for running:
RUN apt-get -y install dos2unix libgtk2.0-0 libx11-xcb-dev libxtst6 libxss1 libgconf-2-4 libnss3-dev libasound2

# arp-scan only needed for the module MMM-NetworkScanner:
RUN apt-get -y install nano arp-scan

# getting MagicMirror from github
RUN git clone https://github.com/MichMich/MagicMirror.git /opt/magic_mirror/
WORKDIR /opt/magic_mirror
RUN git checkout origin/master

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

# delete "core" on startup
#COPY del_core.sh /etc/init.d/del_core.sh
#RUN dos2unix /etc/init.d/del_core.sh
#RUN chmod 755 /etc/init.d/del_core.sh
#RUN update-rc.d del_core.sh defaults

ENTRYPOINT ["/opt/magic_mirror/docker-entry-raspberry.sh"]