#!/bin/bash
set -e

DEVICE="/dev/vdc1"
MOUNTPOINT="/tmp"

# Ellenőrizzük, hogy már mountolva van-e
if ! mountpoint -q "$MOUNTPOINT"; then
    echo "Mounting $DEVICE to $MOUNTPOINT..."
    mount "$DEVICE" "$MOUNTPOINT"
else
    echo "$MOUNTPOINT is already mounted."
fi

# UUID lekérése
UUID=$(blkid -s UUID -o value "$DEVICE")

# Ellenőrizzük, hogy van-e már fstab bejegyzés
if ! grep -q "$UUID" /etc/fstab; then
    echo "Adding $DEVICE to /etc/fstab..."
    echo "UUID=$UUID  /tmp  ext4  defaults,nosuid,nodev,noexec  0  2" >> /etc/fstab
else
    echo "$DEVICE already exists in /etc/fstab."
fi

echo "Done."
