#!/bin/bash
set -euo pipefail

# Convert comma delimited cli arguments to arrays
# E.g. ./build.sh 10,12 slim,alpine
# "10,12" becomes "10 12" and "slim,alpine" becomes "slim alpine"
IFS=',' read -ra versions_arg <<< "${1:-}"
IFS=',' read -ra variant_arg <<< "${2:-}"
if [ -n "${3-}" ]; then
  push="${3}"
else
  push=""
fi

function build() {
  local version
  local tag
  local variant
  local full_tag
  version="$1"
  shift
  variant="$1"
  shift
  tag="$1"
  shift

  full_tag=${tag}
  case "$variant" in
    *alpine*) full_tag="${version}-alpine" ;;
  esac

  echo "Building ${full_tag}..."
  branch="${version}"
  if [ "${version}" != "master" ] && [ "${version}" != "develop" ]; then
    branch="v${version}"
  fi

  latest_tag=""
  latest_release=$(git ls-remote --tags --refs --sort="v:refname" https://github.com/MichMich/MagicMirror.git | tail -n1 | sed 's/.*\///')
  if [ "${latest_release}" = "v${version}" ] && [ "${full_tag}" != *"alpine"* ]; then
    latest_tag="-t bastilimbach/docker-magicmirror:latest"
  fi  

  if [ "${push}" ]; then
    docker buildx build --progress plain \
                        --platform=linux/amd64,linux/arm64,linux/arm/v7 \
                        ${push} \
                        --build-arg branch="${branch}" \
                        -t bastilimbach/docker-magicmirror:"${full_tag}" \
                        ${latest_tag} \
                        "${version}/${variant}/"
  else
    if ! docker build --cpuset-cpus="0,1" \
                      --build-arg branch="${branch}" \
                      -t bastilimbach/docker-magicmirror:"${full_tag}" \
                      ${latest_tag} \
                       "${version}/${variant}/"; then
      echo "Build of ${full_tag} failed!"
      exit 2
    fi
    echo "Build of ${full_tag} succeeded."
  fi
}

IFS=' ' read -ra versions <<< "${versions_arg[@]}"
IFS=' ' read -ra variants <<< "${variant_arg[@]}"
for version in "${versions[@]}"; do
  tag="${version}"

  for variant in "${variants[@]}"; do
        # Skip non-docker directories
        [ -f "${version}/${variant}/Dockerfile" ] || continue

        build "${version}" "${variant}" "${tag}"
        #test_image "${full_version}" "${variant}" "${tag}"
  done

done

echo "All builds successful!"

exit 0

# https://stackoverflow.com/a/51761312/4934537
# latest_release=$(git ls-remote --tags --refs --sort="v:refname" https://github.com/MichMich/MagicMirror.git | tail -n1 | sed 's/.*\///')
# if [ "$(docker manifest inspect bastilimbach/docker-magicmirror:"${latest_release}" > /dev/null; echo $?)" != 0 ]; then
#   docker buildx build --progress plain --platform=linux/amd64,linux/arm64,linux/arm/v7 ${1} --build-arg branch="${latest_release}" -t bastilimbach/docker-magicmirror:"${latest_release}" -t bastilimbach/docker-magicmirror:latest .
# fi

# docker buildx build --progress plain --platform=linux/amd64,linux/arm64,linux/arm/v7 ${1} --build-arg branch=develop -t bastilimbach/docker-magicmirror:develop .
