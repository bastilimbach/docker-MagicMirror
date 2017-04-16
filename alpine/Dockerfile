FROM node:alpine

ENV NODE_ENV production
ENV MM_PORT 8080

WORKDIR /opt/magic_mirror

RUN apk update \
    && apk add dos2unix --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted \
    && apk add git

RUN git clone --depth 1 -b master https://github.com/MichMich/MagicMirror.git .

RUN cp -R modules /opt/magic_mirror/unmount_modules
RUN cp -R config /opt/magic_mirror/unmount_config
RUN npm install

COPY docker-entrypoint.sh /opt/magic_mirror
RUN dos2unix docker-entrypoint.sh \
    && chmod +x docker-entrypoint.sh

EXPOSE $MM_PORT
ENTRYPOINT ["/opt/magic_mirror/docker-entrypoint.sh"]
