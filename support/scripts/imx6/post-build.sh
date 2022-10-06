#!/bin/sh

# genimage will need to find the extlinux.conf
# in the binaries directory

BOARD_DIR="$(dirname $0)"

install -m 0644 -D $BOARD_DIR/extlinux.conf $BINARIES_DIR/extlinux.conf

################################################
### create mnt directories for the partitions ##
################################################
mkdir -p $TARGET_DIR/mnt/app $TARGET_DIR/mnt/appdata $TARGET_DIR/mnt/userdata
