#!bin/sh

# set podman debian container
name=$(cat /tmp/dpm)
cat Debian.tar.gz | podman import - "debian-$name"
podman run -dt  "debian-$name" bash

# cgroupv2 manager systemd enable
#sudo loginctl enable-linger 1001

#sudo rm -rf mounts/ debian-test/ Debian.tar.gz defaultNetworkBackend overlay overlay-images overlay-layers/ overlay-locks/ storage.lock tmp/ userns.lock overlay-containers
