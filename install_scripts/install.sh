#!bin/sh

# Variables
tarName="Debian.tar.gz"
installlib=("debootstrap" "dirmngr" "podman" "slirp4netns" "fuse-overlayfs")

if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as sudo."
    exit 1
fi


#Functions
run_install()
{
    read -p "Do you want to install missing libraries? [Y/n]: " answer
    answer=${answer:Y}
    [[ $answer =~ [Yy] ]] && apt-get install ${installlib[@]}
}


add_user()
{
    read -p "Do you want to add a new user? [Y/n]: " answer
    answer=${answer:Y}
    [[ $answer =~ [Yy] ]] && read -p "Name of the user : " sudName && adduser $sudName && usermod -aG sudo $sudName
    [[ $answer =~ [Nn] ]] && read -p "Then what's your username ? " sudName
    echo "user.max_user_namespaces=28633" > /etc/sysctl.d/userns.conf
    sysctl -p /etc/sysctl.d/userns.conf
    usermod --add-subuids 100000-165535 --add-subgids 100000-165535 $sudName
}

add_user
# Dependecies install / Debootstrap tarball
dpkg -s "${installlib[@]}" >/dev/null 2>&1 || run_install
if [ -f "$tarName" ]; then
    echo "$tarName exists."
    read -p "Do you want to remove the files? [Y/n]: " answer
    answer=${answer:Y}
    [[ $answer =~ [Yy] ]] && rm -rf $tarName && exit
    #[[ $answer =~ [Nn] ]] && exit
else
    touch dpm
    read -p $'\e[33mWhich version of Debian you want to install ? (bookworm,buster,bullseye,buster) :\e[0m ' codeName
    debootstrap --variant=minbase --components=main,contrib,non-free-firmware --include=sudo,git,dirmngr,apt-transport-https $codeName "debian-$codeName" http://deb.debian.org/debian/
    tar --verbose --create --file $tarName --directory "debian-$codeName" .
    sudo echo $codeName > dpm;
fi
# launch podman import and run script as $sudName
sudo -u  $sudName bash import.sh




