#!/bin/bash
set -e

ENCRYPTED="${encrypted_path:-/media/encrypted_media}"
DECRYPTED="${decrypted_path:-/media/decrypted_mount}"
DISGUISE="${disguise_extension:-.wav}"
CONF_PATH="/config/gocryptfs"

mkdir -p "$ENCRYPTED" "$DECRYPTED" "$CONF_PATH"

/bin/bash -c "echo '[INFO] JellyCrypt started... Using disguise $DISGUISE'"

if [ ! -f "$CONF_PATH/gocryptfs.conf" ]; then
    echo "$password" | gocryptfs -init -plaintextnames "$ENCRYPTED"
fi

echo "$password" | gocryptfs -extpass "cat" -plaintextnames "$ENCRYPTED" "$DECRYPTED"

find "$ENCRYPTED" -type f ! -name "*$DISGUISE" -exec bash -c 'mv "$0" "$0'$DISGUISE'"' {} \;

jellyfin \
    --datadir /config/jellyfin \
    --cachedir /config/jellyfin-cache \
    --ffmpeg /usr/bin/ffmpeg \
    --mediafolders "$DECRYPTED"
