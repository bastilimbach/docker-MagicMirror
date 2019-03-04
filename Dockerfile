FROM node:lts-alpine

RUN apk update && apk add git

ENV NODE_ENV production

WORKDIR /opt/magic_mirror

RUN git clone --depth 1 -b master https://github.com/MichMich/MagicMirror.git .

RUN cp -R modules /opt/magic_mirror/default_modules
RUN cp -R config /opt/magic_mirror/default_config

RUN npm install --unsafe-perm --silent

COPY docker-entrypoint.sh /opt/magic_mirror
RUN chmod +x /opt/magic_mirror/docker-entrypoint.sh

EXPOSE 8080
CMD ["node serveronly"]
ENTRYPOINT ["/opt/magic_mirror/docker-entrypoint.sh"]
