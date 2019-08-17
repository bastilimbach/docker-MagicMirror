[![MagicMirror²: The open source modular smart mirror platform. ](https://github.com/MichMich/MagicMirror/raw/master/.github/header.png)](https://github.com/MichMich/MagicMirror)

**MagicMirror²** is an open source modular smart mirror platform. With a growing list of installable modules, the **MagicMirror²** allows you to convert your hallway or bathroom mirror into your personal assistant.

[![DockerHub Badge](https://dockeri.co/image/bastilimbach/docker-magicmirror)](https://hub.docker.com/r/bastilimbach/docker-magicmirror/)

# Why Docker?
In some cases, you want to start the application without an actual app window. In this case, you can start MagicMirror² in server only mode by manually running `node serveronly` or using Docker. This will start the server, after which you can open the application in your browser of choice.

# Supported architectures

- `amd64` - 64 Bit based architectures (e.g: macOS, Linux, etc.)
- `arm` - Raspberry Pi and any other arm based architectures

> The respective docker images are getting updated daily by a cron job from Travis CI.

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
| `/opt/magic_mirror/config` | Mount this folder to insert your own config into the docker container. If the folder is empty the container will create a default configuration which can be adapted to you likings. |
| `/opt/magic_mirror/modules` | Mount this folder to add your own custom modules into the docker container. If the folder is empty the container will copy the [default modules](https://github.com/MichMich/MagicMirror/tree/master/modules/default) from the MagicMirror² repository into the volume. |
| `/opt/magic_mirror/css/custom.css` | Mount this file to add your own custom css into the docker container. <br><br> **Important:** You need to create the file before you run the container. Otherwise Docker will create a `custom.css` folder. |

# Config
If you start the container without providing a custom configuration it will create a default config inside the `config` volume if it is empty.
This config can then be adapted to your likings.

If you want to build the configuration by yourself be sure to set the following configuration properties accordingly:
```javascript
var config = {
	address: "", // Needs to be either "", "0.0.0.0" or "::" to make MagicMirror listen on any interface.
	port: 8080, // If you change the port, be sure to also adapt the "--publish" flag in your docker run command. e.g: --publish 80:3000
	ipWhitelist: [] // This is required to allow all IP addresses to access MagicMirror. Can also be set to the docker subnet.
}
```

# Contribution
I'm happy to accept Pull Requests! Please note that this project is released with a [Contributor Code of Conduct](https://github.com/bastilimbach/docker-MagicMirror/blob/master/CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

# License
[MIT](https://github.com/bastilimbach/docker-MagicMirror/blob/master/LICENSE) ❤️
