#!/bin/sh

set -ex

# Print to kmsg and console
# $1: string to print
print_system()
{
    printf "%s configure-device: %s\n" "$(date -Iseconds --utc)" "$1" |
        tee /dev/kmsg /dev/console || true
}

service_dir=/writable/system-data/var/lib/configure-device

# Don't start again if we're already done
if [ -e "$service_dir"/complete ]; then
    exit 0
fi

print_system "start"

# no changes at all
until snap changes; do
    print_system "no changes yet, waiting"
    sleep 5
done

# If we have the assertion, create the user
if [ "$(snap managed)" != "true" ] && [ -n "$(snap known system-user)" ]; then
    snap create-user --known --sudoer
    print_system "system user created"
fi

# Wait for all snaps to be available
#snap wait system seed.loaded

# Apply network configuration
#netplan generate
#systemctl restart systemd-networkd.service
# Remove old addresses - otherwise we might have problems if the dhcp server
# gives different addresses to NM than those given to networkd.
#ip address flush dev eth0
#systemctl restart snap.network-manager.networkmanager.service

#print_system "network configuration applied"

# Mark us done
touch "$service_dir"/complete
