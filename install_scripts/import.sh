#!bin/sh

#Variables
tarName="Debian.tar.gz"
Remove=1

#Function to check if install script has been before
if [ ! -f dpm ]; then
	echo "You need to run ./install.sh first"
	exit 1
else
    name=$(cat dpm)
fi

#Function to Remove file if var is set to 1
remove_files()
{
    if [ $Remove -eq 1 ]; then
        rm -rf $tarName
        rm -rf "debian-$name"
        rm -rf dpm
    fi
}

#Function to ask the user if they want to access the container directly
access_container()
{
    remove_files
    read -p "Do you want to access the container now [Y/n]:  " answer
    answer=${answer:Y}
    [[ $answer =~ [Yy] ]] && podman exec -ti "debian-$name" bash
}

# set podman debian container
podman ps | grep -q "debian-$name"
if [ $? -eq 0 ]; then 
    echo "Container "debian-$name" already exist"
    echo "You need to give another name to the container"
    read -p $'What name do you want to give ? (debian-$NAME)' name;
fi
cat Debian.tar.gz | podman import - "debian-$name"
podman run --name "debian-$name" -dt "debian-$name" bash
if [ $? -eq 0 ]; then remove_files && access_container; else remove_files && exit; fi


# Sets of commands if something bad happens
# cgroupv2 manager systemd enable
#sudo loginctl enable-linger 1001
#sudo rm -rf mounts/ debian-test/ Debian.tar.gz defaultNetworkBackend overlay overlay-images overlay-layers/ overlay-locks/ storage.lock tmp/ userns.lock overlay-containers

