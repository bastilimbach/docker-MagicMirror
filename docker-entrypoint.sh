#!/bin/bash

if [ ! -f /opt/magic_mirror/modules ]; then
    cp -Rn /opt/default_modules/. /opt/magic_mirror/modules
fi

if [ ! -f /opt/magic_mirror/config ]; then
    cp -Rn /opt/default_config/. /opt/magic_mirror/config
fi

$1
