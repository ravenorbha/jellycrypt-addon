#!/bin/bash
set -e

log() {
  echo "[JellyCrypt] $1"
}

USB_BASE="/media"
FIRST_USB=$(find "$USB_BASE" -mindepth 1 -maxdepth 1 -type d | head -n 1)

if [ -z "$FIRST_USB" ]; then
  log "ERROR: No USB device detected under /media"
  exit 1
fi

ENCRYPTED="${FIRST_USB}/encrypted_media"
DECRYPTED="/media/decrypted_mount"
DISGUISE="${disguise_extension:-.wav}"
CONF_PATH="/config/gocryptfs"

log "Detected USB storage at: $FIRST_USB"
log "Encrypted path: $ENCRYPTED"
log "Decrypted mount: $DECRYPTED"

mkdir -p "$ENCRYPTED" "$DECRYPTED" "$CONF_PATH"

if [ ! -f "$CONF_PATH/gocryptfs.conf" ]; then
    echo "$password" | gocryptfs -init -plaintextnames "$ENCRYPTED"
    log "Initialized encrypted directory."
fi

echo "$password" | gocryptfs -extpass "cat" -plaintextnames "$ENCRYPTED" "$DECRYPTED"
log "Mounted encrypted volume."

find "$ENCRYPTED" -type f ! -name "*$DISGUISE" -exec bash -c 'mv "$0" "$0'$DISGUISE'"' {} \;
log "Applied disguise extension to encrypted files."

log "Starting Jellyfin..."
jellyfin --datadir /config/jellyfin --cachedir /config/jellyfin-cache --ffmpeg /usr/bin/ffmpeg --mediafolders "$DECRYPTED"
