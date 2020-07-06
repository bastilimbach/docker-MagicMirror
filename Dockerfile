FROM node:12-alpine AS BUILD_IMAGE

ARG branch=master

ENV NODE_ENV production
WORKDIR /opt/magic_mirror

# get magic mirror
RUN apk update && apk add --no-cache git \
    && git clone --depth 1 -c advice.detachedHead=false -b ${branch} https://github.com/MichMich/MagicMirror.git . \
    && apk del git \
    && rm -rf /var/cache/apk/*

# save default modules and configuration and install dependencies
RUN cp -R modules /opt/magic_mirror/default_modules \
    && cp -R config /opt/magic_mirror/default_config \
    && npm set unsafe-perm true \
    && npm ci \
    # && npm prune --production
    && wget -q https://install.goreleaser.com/github.com/tj/node-prune.sh | sh



FROM node:12-alpine

WORKDIR /opt/magic_mirror

RUN set -x \
    && apk add --update libintl \
    && apk add --virtual build_deps gettext \
    && apk del build_deps

COPY --from=BUILD_IMAGE /opt/magic_mirror/node_modules ./node_modules
COPY --from=BUILD_IMAGE /opt/magic_mirror/config ./config
COPY --from=BUILD_IMAGE /opt/magic_mirror/css ./css
COPY --from=BUILD_IMAGE /opt/magic_mirror/fonts ./fonts
COPY --from=BUILD_IMAGE /opt/magic_mirror/js/ ./js
COPY --from=BUILD_IMAGE /opt/magic_mirror/serveronly ./serveronly
COPY --from=BUILD_IMAGE /opt/magic_mirror/translations ./translations
COPY --from=BUILD_IMAGE /opt/magic_mirror/vendor ./vendor
COPY --from=BUILD_IMAGE /opt/magic_mirror/index.html /opt/magic_mirror/package.json /opt/magic_mirror/package-lock.json ./
COPY --from=BUILD_IMAGE /opt/magic_mirror/default_config ./default_config
COPY --from=BUILD_IMAGE /opt/magic_mirror/default_modules/ ./default_modules

EXPOSE 8080

COPY mm-docker-config.js docker-entrypoint.sh ./
RUN chmod +x ./docker-entrypoint.sh

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["node", "serveronly"]
