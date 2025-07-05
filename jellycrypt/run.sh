#!/bin/bash

echo "[JellyCrypt] Starting encrypted media mount..."

# Read password and disguise option from config
PASSWORD=$(jq -r '.password' /data/options.json)
DISGUISE_EXT=$(jq -r '.disguise_extension' /data/options.json)

# Validate password
if [ -z "$PASSWORD" ] || [ "$PASSWORD" == "null" ]; then
    echo "[JellyCrypt] ERROR: No password set in options.json"
    exit 1
fi

ENCRYPTED_PATH="/media/.New folder/encrypted_media"
MOUNT_PATH="/media/decrypted_mount"

mkdir -p "$ENCRYPTED_PATH"
mkdir -p "$MOUNT_PATH"

# Initialize encrypted folder if not already set up
if [ ! -f "$ENCRYPTED_PATH/gocryptfs.conf" ]; then
    echo "[JellyCrypt] Initializing encrypted folder..."
    echo "$PASSWORD" | gocryptfs -quiet -init "$ENCRYPTED_PATH"
fi

# Mount the encrypted volume
echo "[JellyCrypt] Mounting encrypted media..."
echo "$PASSWORD" | gocryptfs "$ENCRYPTED_PATH" "$MOUNT_PATH"

# Disguise file extensions (optional)
if [ -n "$DISGUISE_EXT" ] && [ "$DISGUISE_EXT" != "none" ]; then
    echo "[JellyCrypt] Disguising media extensions as $DISGUISE_EXT"
    find "$MOUNT_PATH" -type f ! -name "*.$DISGUISE_EXT" | while read -r f; do
        mv "$f" "$f.$DISGUISE_EXT"
    done
fi

# Start Jellyfin
echo "[JellyCrypt] Starting Jellyfin..."
exec /usr/bin/jellyfin
