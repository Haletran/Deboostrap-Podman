# Debootstrap on Podman

These scripts facilitate the creation of a Debian container using Debootstrap and Podman.

## Dependencies

Ensure you have the following dependencies installed before using the scripts
(it will dl them if you don't have them):

```bash
sudo apt-get install git podman debootstrap slirp4netns fuse-overlayfs dirmngr
```

## Installation 

Clone the repository :

    git clone https://salsa.debian.org/bpasquier/testgitlabrunner

Execute the install script with elevated privileges:

    sudo bash install.sh

## Credits

- Original Idea from @kapouer
- <a href="https://sleeplessbeastie.eu/2018/04/11/how-to-create-base-docker-image/">Tutorial about the same project on docker</a>

Feel free to explore and adapt these scripts to suit your containerization needs. If you encounter any issues or have suggestions for improvement, please contribute to the project.


