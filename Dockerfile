FROM node:12-buster

RUN set -e; \
    apt update; \
    apt install -y gettext; \
    rm -rf /var/lib/apt/lists/*

ARG branch=master

ENV NODE_ENV production
WORKDIR /opt/magic_mirror

RUN git clone --depth 1 -b ${branch} https://github.com/MichMich/MagicMirror.git .
RUN cp -R modules /opt/default_modules
RUN cp -R config /opt/default_config
RUN npm install --unsafe-perm --silent

COPY mm-docker-config.js docker-entrypoint.sh ./

EXPOSE 8080
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["node", "serveronly"]
