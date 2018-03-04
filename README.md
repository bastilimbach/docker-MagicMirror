[![MagicMirror²: The open source modular smart mirror platform. ](https://github.com/MichMich/MagicMirror/raw/master/.github/header.png)](https://github.com/MichMich/MagicMirror)

**MagicMirror²** is an open source modular smart mirror platform. With a growing list of installable modules, the **MagicMirror²** allows you to convert your hallway or bathroom mirror into your personal assistant.

# Why Docker?
In some cases, you want to start the application without an actual app window. In this case, you can start MagicMirror² in server only mode by manually running `node serveronly` or using Docker. This will start the server, after which you can open the application in your browser of choice.

# Supported tags and respective `Dockerfile` links

- `latest` - Latest MagicMirror² server ([Dockerfile](https://github.com/bastilimbach/docker-MagicMirror/blob/master/Dockerfile))
- `raspberry` - ARM based version to work with a Raspberry Pi ([Dockerfile](https://github.com/bastilimbach/docker-MagicMirror/blob/master/raspberry/Dockerfile))

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

You need to configure your MagicMirror² config to listen on any interface and allow every ip address.

```javascript
var config = {
    address: "",
    port: 8080,
    ipWhitelist: ["127.0.0.1", "::ffff:127.0.0.1", "::1", "::ffff:192.168.2.1/120", "192.168.2.110", "172.17.0.1"]
}

if (typeof module !== "undefined") { module.exports = config; }

```
