#!/bin/bash

echo "[JellyCrypt] Starting encrypted media mount..."

# Read password from config
PASSWORD=$(jq -r '.password' /data/options.json)
DISGUISE_EXT=$(jq -r '.disguise_extension' /data/options.json)

ENCRYPTED_PATH="/media/.New folder/encrypted_media"
MOUNT_PATH="/media/decrypted_mount"

mkdir -p "$ENCRYPTED_PATH"
mkdir -p "$MOUNT_PATH"

# Initialize if not yet encrypted
if [ ! -f "$ENCRYPTED_PATH/gocryptfs.conf" ]; then
    echo "[JellyCrypt] Initializing encrypted folder..."
    echo "$PASSWORD" | gocryptfs -init "$ENCRYPTED_PATH"
fi

# Mount the encrypted volume
echo "[JellyCrypt] Mounting encrypted media..."
echo "$PASSWORD" | gocryptfs "$ENCRYPTED_PATH" "$MOUNT_PATH"

# Optional: disguise extensions (basic rename)
if [ "$DISGUISE_EXT" != "none" ]; then
    echo "[JellyCrypt] Disguising media extensions as $DISGUISE_EXT"
    find "$MOUNT_PATH" -type f | while read f; do
        ext="${f##*.}"
        [ "$ext" != "$DISGUISE_EXT" ] && mv "$f" "$f.$DISGUISE_EXT"
    done
fi

# Start Jellyfin
echo "[JellyCrypt] Starting Jellyfin..."
exec /usr/bin/jellyfin
