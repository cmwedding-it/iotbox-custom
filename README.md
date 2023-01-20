# IoTBox-custom

This document shows how to modify the iotbox image.

Requirements:
- a linux box (e.g Ubuntu, WSL doesn't work)
- `kpartx` (`sudo apt install kpartx -y`)
- https://nightly.odoo.com/master/iotbox/iotbox-latest.zip

---

## Before starting

First, the image needs to be unpacked to the 2 partitions.
Unzip the `iotbox-latest.zip` and run
```sh
sudo kpartx -v -a iotbox.img
```
Sample output:
```
add map loop7p1 (254:2): 0 1048577 linear 7:7 8192
add map loop7p2 (254:3): 0 6799359 linear 7:7 1056769
```

Note down the loop's name. (In this case, its `loop7`)

## Chrooting into the image

The chroot-to-pi.sh allows us to chroot into the raspberry pi image.
It requires some packages. Install them by running:
```sh
sudo apt install qemu qemu-user-static binfmt-support -y
```

Now run the script like this:

```sh
chmod a+x chroot-to-pi.sh && \
sudo ./chroot-to-pi.sh /dev/mapper/<your loop name>
```

and replace `<your loop name>` with your loop name, e.g `loop7`


## Mounting the image

Mount the 2 new mappers (e.g loop7p1 + 2, see the output of the command above):
```sh
mkdir boot && mkdir rootfs && \
sudo mount /dev/mapper/loop7p1 ./boot && \
sudo mount /dev/mapper/loop7p2 ./rootfs
```
Make sure to replace `loop7` with your loop's name. 

## Special thanks

Special thanks to @htruong for writing the chroot-to-pi.sh gist.
Their gist can be found here: https://gist.github.com/htruong/7df502fb60268eeee5bca21ef3e436eb