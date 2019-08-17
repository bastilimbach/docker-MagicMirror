rm -rf ./config
rm -rf ./modules
mkdir config
mkdir modules

docker rm -f magic_mirror
docker build -t mm:latest .
docker run  -d \
	--publish 80:8080 \
	--restart always \
	--volume $PWD/config:/opt/magic_mirror/config \
	--volume $PWD/modules:/opt/magic_mirror/modules \
	--name magic_mirror \
	mm:latest
