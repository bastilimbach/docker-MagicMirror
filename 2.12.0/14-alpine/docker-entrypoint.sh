#!/bin/sh
set -e

if [ ! "$(ls -A /opt/magic_mirror/modules)" ]; then
    cp -R /opt/magic_mirror/default_modules/. /opt/magic_mirror/modules
fi

if [ ! "$(ls -A /opt/magic_mirror/config)" ]; then
    cp /opt/magic_mirror/mm-docker-config.js /opt/magic_mirror/config/config.js
fi

if [ -f "/opt/magic_mirror/config/config.js.template" ]; then
    envsubst < /opt/magic_mirror/config/config.js.template > /opt/magic_mirror/config/config.js
fi

exec "$@"
