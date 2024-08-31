#!/usr/bin/env bash

SYS_INSTALL_ERROR_HEADER="\033[1;31mERROR! Failed to install system.\n\e[0m"

SYS_INSTALL_LUKS_KEY=/tmp/luks.key

set -e

export SOPS_AGE_KEY_FILE=secrets/key.txt

if [ ! -f $SOPS_AGE_KEY_FILE ]; then
    printf "$SYS_INSTALL_ERROR_HEADER"
    echo "SOPS Age Key does not exist at secrets/key.txt."
    echo "Supply the key and try the installer again."
    exit 1
fi

# Start tracing
set -x

# sops-nix won't be available when setting up the disks
# so just decrypt the LUKS passphrase to a temporary location
# exclusively for the install process.
sops decrypt --extract '["luks"]["passphrase"]' secrets/secrets.yaml > $SYS_INSTALL_LUKS_KEY

# Stopgap to check if the key file exists
ls $SYS_INSTALL_LUKS_KEY

