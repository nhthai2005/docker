#Error with pre-create check: “This computer doesn't have VT-X/AMD-v enabled. Enabling it in the BIOS is mandatory” even though it's enabled
#docker-machine create -d virtualbox --virtualbox-memory=4096 --virtualbox-cpu-count=4 --virtualbox-disk-size=40960 --virtualbox-no-vtx-check play-with-docker

docker-machine create -d virtualbox --virtualbox-memory=2048 --virtualbox-cpu-count=2   play-with-docker