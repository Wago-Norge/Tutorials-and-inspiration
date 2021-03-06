# Tips and tricks for Linux and Docker with PFC200
This chapter will contain useful tips to help you with Wago, Linux and Docker.

### Installing Docker on an SD card
It is possible to move Docker's location to an external SD-card. This is helpful if you want many applications installed on your PFC200, that require more than 1-1.5GB of storage.

* Prerequisites: 
- Wago PFC200 G2 with new/fresh Docker installed
- Wago SD card

#### Steps:
- Go to the PLC's Web Based Management (WBM).
- Under `Mass Storage`, format the SD card with `ext4`. Give the partition a suitable name.

- Log in to the PLC via SSH as root.
- Type `df -h` to get a quick overview of the file system. You can from here se the address of your SD card. This should be under: `/media`.
- Go to `/media/"partition"` and create a folder for Docker:
```
cd /media/{partition}
mkdir docker
```
- Run the following command: `nano /etc/docker/daemon.json`
- Change the address to the address on your SD card: `/media/{partition}/docker`

- Restart Docker: `/etc/init.d/dockerd restart`

After doing this, a reboot may be required. Docker should from now on install new images, containers and volumes on the SD card.


### Disable timeout for the SSH terminal
When working with the PLC via SSH, one will be thrown out rather quickly, if absent. Follow these small steps, to expand your coffee break. ;)
- Log on to the PLC via SSH as root.
- Run the following command: `nano /etc/profile`
- The value `TMOUT` is the timeout in seconds. Change this (or remove) to alter the timeout. 20 minutes = 1200, for instance.
