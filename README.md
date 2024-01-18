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


# Credits

- Original Idea from @kapouer
- <a href="https://sleeplessbeastie.eu/2018/04/11/how-to-create-base-docker-image/">Tutorial about the same project on docker</a>
