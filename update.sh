#!/bin/bash
set -Eeuo pipefail

cd "$(dirname "$(readlink "$BASH_SOURCE")")"

versions=( "$@" )
if [ ${#versions[@]} -eq 0 ]; then
	versions=( */ )
fi
versions=( "${versions[@]%/}" )

for version in "${versions[@]}"; do
    for variant in \
            12{-alpine,-buster} \
            14{-alpine,-buster} \
        ; do
            tag="$variant"
            template='debian'
            case "$variant" in
                *alpine*) tag="${variant#alpine}"; template='alpine' ;;
            esac

            if [ ! -d "$version/$variant" ]; then
                mkdir -p ./$version/$variant
                touch ./$version/$variant/Dockerfile
            fi 
            echo $tag
            echo $variant
            echo $template
            
            sed -e 's!%%TAG%%!'"$tag"'!g' \
                "./Dockerfile-${template}.template" > "$version/$variant/Dockerfile"
            
            cp docker-entrypoint.sh $version/$variant/
            cp mm-docker-config.js $version/$variant/
	done
done