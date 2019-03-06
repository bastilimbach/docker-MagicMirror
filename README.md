[![MagicMirror²: The open source modular smart mirror platform. ](https://github.com/MichMich/MagicMirror/raw/master/.github/header.png)](https://github.com/MichMich/MagicMirror)

**MagicMirror²** is an open source modular smart mirror platform. With a growing list of installable modules, the **MagicMirror²** allows you to convert your hallway or bathroom mirror into your personal assistant.

[![DockerHub Badge](https://dockeri.co/image/bastilimbach/docker-magicmirror)](https://hub.docker.com/r/bastilimbach/docker-magicmirror/)

# Why Docker? [![Build Status](https://travis-ci.org/bastilimbach/docker-MagicMirror.svg?branch=master)](https://travis-ci.org/bastilimbach/docker-MagicMirror)
In some cases, you want to start the application without an actual app window. In this case, you can start MagicMirror² in server only mode by manually running `node serveronly` or using Docker. This will start the server, after which you can open the application in your browser of choice.

# Supported tags:

- `latest` - Latest MagicMirror² server ([Dockerfile](https://github.com/bastilimbach/docker-MagicMirror/blob/master/Dockerfile))

# Supported architectures: ([more info](https://github.com/docker-library/official-images#architectures-other-than-amd64))
`amd64`, `arm32v6`, `arm32v7`, `arm64v8`, `i386`, `ppc64le`, `s390x`

> The docker images are getting updated daily by a cron job from Travis CI.

# Run MagicMirror² in server only mode
After a successful [Docker installation](https://docs.docker.com/engine/installation/) you just need to execute the following command in the shell:

```bash
docker run  -d \
	--publish 80:8080 \
	--restart always \
	--volume ~/magic_mirror/config:/opt/magic_mirror/config \
	--volume ~/magic_mirror/modules:/opt/magic_mirror/modules \
	--name magic_mirror \
	bastilimbach/docker-magicmirror
```

# Volumes
| **Volume** | **Description** |
| --- | --- |
| `/opt/magic_mirror/config` | Mount this folder to insert your own config into the docker container. |
| `/opt/magic_mirror/modules` | Mount this folder to add your own custom modules into the docker container. |
| `/opt/magic_mirror/css/custom.css` | Mount this file to add your own custom css into the docker container. <br><br> **Important:** You need to create the file before you run the container. Otherwise Docker will create a `custom.css` folder. |

# Config
You need to configure your MagicMirror² config to listen on any interface and allow every ip address.

```javascript
var config = {
    address: "",
    port: 8080,
    ipWhitelist: []
}

if (typeof module !== "undefined") { module.exports = config; }
```

# Contribution
I'm happy to accept Pull Requests! Please note that this project is released with a [Contributor Code of Conduct](https://github.com/bastilimbach/docker-MagicMirror/blob/master/CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

# License
[MIT](https://github.com/bastilimbach/docker-MagicMirror/blob/master/LICENSE) ❤️
