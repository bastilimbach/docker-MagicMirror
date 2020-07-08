FROM node:12-alpine AS BUILD_IMAGE

ARG branch=master

ENV NODE_ENV production
WORKDIR /opt/magic_mirror

# get magic mirror
RUN apk update && apk add --no-cache git \
    && git clone --depth 1 -c advice.detachedHead=false -b ${branch} https://github.com/MichMich/MagicMirror.git . \
    && apk del git

# save default modules and configuration and install dependencies
RUN set -o pipefail \
    && mkdir dist \
    && cp -R config /opt/magic_mirror/dist/default_config \
    && cp -R modules /opt/magic_mirror/dist/default_modules \
    && npm set unsafe-perm true \
    && npm ci \
    # removes required depdencies and should not be used
    # && npm prune --production --json \
    # prune unnecessary files from ./node_modules, such as markdown, typescript source files, and so on. https://github.com/tj/node-prune
    && wget -q https://install.goreleaser.com/github.com/tj/node-prune.sh | sh \
    # it is intentional that modules are not copied to dist folder. Please keep alphabetically sorted
    && cp -R \
        config \
        css \
        fonts \
        index.html \
        js \
        node_modules \
        package.json \ 
        package-lock.json \ 
        serveronly \
        translations \
        vendor /opt/magic_mirror/dist


FROM node:12-alpine

WORKDIR /opt/magic_mirror

RUN set -x \
    && apk add --no-cache --update libintl \
    && apk add --no-cache --virtual build_deps gettext \
    && apk del build_deps

COPY --from=BUILD_IMAGE /opt/magic_mirror/dist/ .

EXPOSE 8080

COPY mm-docker-config.js docker-entrypoint.sh ./

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["node", "serveronly"]
