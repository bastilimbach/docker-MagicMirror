#!/bin/sh

if [ ! -d /opt/magic_mirror/modules/default ]; then
    echo "Copying default modules"
    cp -r /opt/magic_mirror/default_modules/. /opt/magic_mirror/modules
fi

if [ ! -d /opt/magic_mirror/modules/node_modules/node_helper ]; then
    echo "Copying node_helper dependencies"
    cp -r /opt/magic_mirror/default_modules/node_modules /opt/magic_mirror/modules/
fi

if [ ! -d /opt/magic_mirror/config ]; then
    echo "Copying default config"
    cp -r /opt/magic_mirror/default_config/. /opt/magic_mirror/config
fi

$1
