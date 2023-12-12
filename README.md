# Debootstrap on podman

Those scripts create a debian container by using Debootstrap and Podman.

# Dependencies

    sudo apt-get install git podman debootstrap slirp4netns fuse-overlayfs dirmngr

# Installation 

    git clone https://salsa.debian.org/bpasquier/testgitlabrunner

You need to execute the install script by using :

    sudo bash install.sh

# Usage 

Those scripts will create a perfectly usable debian machine running inside a container hosted
on your computer.

If you want to access your debian machine, you need to login as <u>dpm</u>, by using the command:

    sudo login dpm #the password should be created during the installation 

    podman attach CONTAINER_NAME or podman exec -ti CONTAINER_NAME bash

But if you want to run the container in your current user session, you need to comments those lines:

    #adduser $sudName <br> #usermod -aG sudo $sudName 

And change the $sudName variable by your own username ("whoami" to get it).


# Credits

- Original Idea from @kapouer
- <a href="https://sleeplessbeastie.eu/2018/04/11/how-to-create-base-docker-image/">Tutorial about the same project on docker</a>
