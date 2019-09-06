#!/bin/bash -ex
{

set -x
system_data="$UBUNTU_IMAGE_HOOK_ROOTFS"/system-data
# Insert our system user
cp data/auto-import.assert "$system_data"/var/lib/snapd/seed/assertions/

# Create systemd job to create user
systemd_dir="$system_data"/etc/systemd/system
service_dir="$system_data"/var/lib/configure-device

mkdir -p "$systemd_dir"
mkdir -p "$service_dir"
cp -f data/configure-device.service "$systemd_dir"
cp -f data/run.sh "$service_dir"

mkdir -p "$systemd_dir"/multi-user.target.wants
ln -sf /etc/systemd/system/configure-device.service \
   "$systemd_dir"/multi-user.target.wants/configure-device.service

# Disable console-conf
console_conf_dir="$system_data"/var/lib/console-conf
mkdir -p "$console_conf_dir"
touch "$console_conf_dir"/complete

find "$UBUNTU_IMAGE_HOOK_ROOTFS"
} #> /tmp/log.txt
