#!/bin/bash

shopt -s globstar

full_path=$(realpath $0)
dir_path=$(dirname $full_path)

# Temporary directory to mount filesystem
mount_point=`mktemp -d -p $dir_path`

for camera in ${dir_path}/cameras/*; do
    # Mount filesystem
    mkdir -p ${camera}/images
    cp output/images/* ${camera}/images
    mount ${camera}/images/rootfs.ext2 $mount_point

    # Move configuration
    cp ${camera}/onvif.config ${mount_point}/etc/generic-onvif-server/configs

    # Move images directory
    mkdir -p ${mount_point}/var/generic-onvif-server
    cp -r ${camera}/frames ${mount_point}/var/generic-onvif-server

    # Modify init.d script
    sed -i 's/ONVIF_ARGS="--xaddr $IP"/ONVIF_ARGS="--xaddr $IP --camdir \/var\/generic-onvif-server\/frames"/g' ${mount_point}/etc/init.d/S80onvif

    umount $mount_point
done

rmdir $mount_point
