FROM hypriot/rpi-node:latest

ENV NODE_ENV production
ENV MM_PORT 8080

RUN apt-get update

# arp-scan only needed for the module MMM-NetworkScanner:
RUN apt-get -y install dos2unix nano arp-scan

# getting MagicMirror from github
RUN cd /opt  
RUN git clone https://github.com/MichMich/MagicMirror.git /opt/magic_mirror/
WORKDIR /opt/magic_mirror
RUN cd /opt/magic_mirror
RUN git checkout origin/develop

# install (without param the mirror remains black):
RUN npm install --unsafe-perm

# copy sample to real config:
RUN cp config/config.js.sample config/config.js

# create copies for unmount:
RUN cp -R modules /opt/magic_mirror/unmount_modules
RUN cp -R config /opt/magic_mirror/unmount_config

COPY docker-entry-raspberry.sh /opt/magic_mirror
RUN dos2unix docker-entry-raspberry.sh && chmod +x docker-entry-raspberry.sh

COPY docker-entry-serveronly.sh /opt/magic_mirror
RUN dos2unix docker-entry-serveronly.sh && chmod +x docker-entry-serveronly.sh

# delete "core" on startup
#COPY del_core.sh /etc/init.d/del_core.sh
#RUN dos2unix /etc/init.d/del_core.sh
#RUN chmod 755 /etc/init.d/del_core.sh
#RUN update-rc.d del_core.sh defaults

EXPOSE $MM_PORT
ENTRYPOINT ["/opt/magic_mirror/docker-entry-raspberry.sh"]