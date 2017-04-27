FROM hypriot/rpi-node:latest

ENV NODE_ENV production
ENV MM_PORT 8080

RUN apt-get update

# needed later in run command:
RUN apt-get -y install dos2unix

# not needed:
#RUN apt-get -y install curl wget git build-essential unzip

# only for having nano as editor:
RUN apt-get -y install nano

# only needed for the module MMM-NetworkScanner:
RUN apt-get -y install arp-scan

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

COPY docker-entrypoint.sh /opt/magic_mirror

RUN ["dos2unix", "docker-entrypoint.sh"]
RUN ["chmod", "+x", "docker-entrypoint.sh"]

# delete "core" on startup
#COPY del_core.sh /etc/init.d/del_core.sh
#RUN dos2unix /etc/init.d/del_core.sh
#RUN chmod 755 /etc/init.d/del_core.sh
#RUN update-rc.d del_core.sh defaults

EXPOSE $MM_PORT
ENTRYPOINT ["/opt/magic_mirror/docker-entrypoint.sh"]