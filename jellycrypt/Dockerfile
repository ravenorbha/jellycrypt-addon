FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

# Add Jellyfin repository and install dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    gnupg2 \
    ffmpeg \
    fuse \
    gocryptfs \
    ca-certificates && \
    curl -fsSL https://repo.jellyfin.org/debian/jellyfin_team.gpg.key | gpg --dearmor -o /usr/share/keyrings/jellyfin-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/jellyfin-archive-keyring.gpg] https://repo.jellyfin.org/debian bullseye main" > /etc/apt/sources.list.d/jellyfin.list && \
    apt-get update && \
    apt-get install -y jellyfin && \
    apt-get clean

# Add and allow run script
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Start entrypoint
CMD [ "/run.sh" ]
