# JellyCrypt Add-on for Home Assistant

This add-on runs **Jellyfin** from an **encrypted folder** mounted with `gocryptfs` on an attached USB drive.

## 🔐 Features

- Auto-detects the first USB drive mounted under `/media`
- Mounts an encrypted folder using `gocryptfs` (`/media/usb/encrypted`)
- Starts Jellyfin from the mounted cleartext directory
- Designed for secure offline or local-only media playback

## 📂 Folder Structure on USB

To use this add-on:

1. Insert a USB drive that mounts under `/media`
2. Create the following directory structure on the drive:
