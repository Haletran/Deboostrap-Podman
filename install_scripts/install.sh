#!bin/sh

# Variables
tarName="Debian.tar.gz"
sudName="dpm"

# add user and rootless podman
echo "user.max_user_namespaces=28633" > /etc/sysctl.d/userns.conf
sysctl -p /etc/sysctl.d/userns.conf
adduser $sudName
usermod -aG sudo $sudName
usermod --add-subuids 100000-165535 --add-subgids 100000-165535 $sudName

# Dependecies install / Debootstrap tarball
apt-get install debootstrap dirmngr podman slirp4netns fuse-overlayfs
read -p $'\e[33mWhich version of Debian you want to install ? (bookworm,buster,bullseye,buster,stretch) :\e[0m ' codeName
debootstrap --variant=minbase --components=main,contrib,non-free --include=sudo,git,dirmngr,apt-transport-https $codeName "debian-$codeName" http://deb.debian.org/debian/ 
tar --verbose --create --file $tarName --directory "debian-$codeName" .

echo $codeName > /tmp/dpm
# launch podman import and run script as $sudName
sudo -u  $sudName bash import.sh




