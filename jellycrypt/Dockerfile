FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive
ENV JELLYFIN_VERSION=10.10.7

# Install system packages and Jellyfin server
RUN apt-get update && \
    apt-get install -y \
        gocryptfs \
        fuse \
        curl \
        ffmpeg \
        gnupg2 \
        ca-certificates \
        jq \
        unzip \
        tar && \
    mkdir -p /opt/jellyfin && \
    curl -fSL "https://repo.jellyfin.org/files/server/linux/latest-stable/amd64/jellyfin_${JELLYFIN_VERSION}-amd64.tar.gz" \
        -o /tmp/jellyfin.tar.gz && \
    file /tmp/jellyfin.tar.gz && \
    tar -xzf /tmp/jellyfin.tar.gz -C /opt/jellyfin --strip-components=1 && \
    ln -s /opt/jellyfin/jellyfin /usr/bin/jellyfin && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# Copy startup script
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Default entrypoint
CMD ["/run.sh"]
