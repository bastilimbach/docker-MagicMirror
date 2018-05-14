FROM hypriot/rpi-node:latest

# ENV NODE_ENV production - Temporary fix until "https://github.com/MichMich/MagicMirror/pull/1250" is merged into master.

WORKDIR /opt/magic_mirror

RUN git clone --depth 1 -b master https://github.com/MichMich/MagicMirror.git .

RUN cp -R modules /opt/default_modules
RUN cp -R config /opt/default_config
RUN npm install --unsafe-perm --silent

COPY docker-entrypoint.sh /opt
RUN apt-get update \
  && apt-get -qy install dos2unix \
  && dos2unix /opt/docker-entrypoint.sh \
  && chmod +x /opt/docker-entrypoint.sh

EXPOSE 8080
CMD ["node serveronly"]
ENTRYPOINT ["/opt/docker-entrypoint.sh"]
