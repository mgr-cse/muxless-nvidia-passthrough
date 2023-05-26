#!/bin/bash

set -x

# unbind the vtconsoles (you might have more vtconsoles than me, you can check by running: dir /sys/class/vtconsole
echo 0 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind

# unbind the efi framebruffer
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

# avoid race condition (I'd start with 5, and if the gpu passes inconsistently, change this value to be higher)
sleep 4

# detach the gpu
virsh nodedev-detach pci_0000_01_00_0

# load vfio
modprobe vfio-pci