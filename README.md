![MagicMirror²: The open source modular smart mirror platform. ](https://github.com/MichMich/MagicMirror/raw/master/.github/header.png)

[![](https://david-dm.org/MichMich/MagicMirror.svg)](https://david-dm.org/MichMich/MagicMirror) [![](https://david-dm.org/MichMich/MagicMirror/dev-status.svg)](https://david-dm.org/MichMich/MagicMirror#info=devDependencies) [![](https://bestpractices.coreinfrastructure.org/projects/347/badge)](https://bestpractices.coreinfrastructure.org/projects/347) [![](https://img.shields.io/badge/license-MIT-blue.svg)](http://choosealicense.com/licenses/mit) [![](https://travis-ci.org/MichMich/MagicMirror.svg)](https://travis-ci.org/MichMich/MagicMirror) [![](https://snyk.io/test/github/MichMich/MagicMirror/badge.svg)](https://snyk.io/test/github/MichMich/MagicMirror)

**MagicMirror²** is an open source modular smart mirror platform. With a growing list of installable modules, the **MagicMirror²** allows you to convert your hallway or bathroom mirror into your personal assistant. **MagicMirror²** is built by the creator of [the original MagicMirror](http://michaelteeuw.nl/tagged/magicmirror) with the incredible help of a [growing community of contributors](https://github.com/MichMich/MagicMirror/graphs/contributors).

MagicMirror² focuses on a modular plugin system and uses [Electron](http://electron.atom.io/) as an application wrapper. So no more web server or browser installs necessary!

# Why Docker?
In some cases, you want to start the application without an actual app window. In this case, you can start MagicMirror² in server only mode by manually running `node serveronly` or using Docker. This will start the server, after which you can open the application in your browser of choice.

# Supported tags and respective `Dockerfile` links

- `latest` - Latest MagicMirror² server ([Dockerfile](https://github.com/bastilimbach/docker-MagicMirror/blob/master/Dockerfile))
- `alpine` - Alpine version of the MagicMirror² server ([Dockerfile](https://github.com/bastilimbach/docker-MagicMirror/blob/master/alpine/Dockerfile))
- `raspberry` - ARM based version to work with a Raspberry Pi ([Dockerfile](https://github.com/bastilimbach/docker-MagicMirror/blob/master/raspberry/Dockerfile)) (Currently not working [#1](https://github.com/bastilimbach/docker-MagicMirror/issues/1))

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
| **Volumes** | **Description** |
| --- | --- |
| `/opt/magic_mirror/config` | Mount this volume to insert your own config into the docker container. |
| `/opt/magic_mirror/modules` | Mount this volume to add your own custom modules into the docker container. |

You may need to add your Docker Host IP to your `ipWhitelist` option. If you have some issues setting up this configuration, check [this forum post](https://forum.magicmirror.builders/topic/1326/ipwhitelist-howto).

```javascript
var config = {
	ipWhitelist: ["127.0.0.1", "::ffff:127.0.0.1", "::1", "::ffff:172.17.0.1"]
};

if (typeof module !== "undefined") { module.exports = config; }
```

> Disclaimer: The ARM and Alpine versions are overriding the `/modules` and `/config` folders on every container restart.
