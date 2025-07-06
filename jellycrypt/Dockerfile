FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive
ENV JELLYFIN_VERSION=10.10.7

# Install safe core tools only
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        fuse3 \
        curl \
        gnupg2 \
        ca-certificates \
        jq \
        unzip \
        tar \
        udev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install gocryptfs manually (latest working release)
RUN curl -fSL https://github.com/rfjakob/gocryptfs/releases/download/v2.5.1/gocryptfs-v2.5.1-linux-amd64 \
    -o /usr/local/bin/gocryptfs && \
    chmod +x /usr/local/bin/gocryptfs

# Install Jellyfin
RUN mkdir -p /opt/jellyfin && \
    curl -fSL "https://repo.jellyfin.org/files/server/linux/latest-stable/amd64/jellyfin_${JELLYFIN_VERSION}-amd64.tar.gz" \
    -o /tmp/jellyfin.tar.gz && \
    tar -xzf /tmp/jellyfin.tar.gz -C /opt/jellyfin --strip-components=1 && \
    ln -s /opt/jellyfin/jellyfin /usr/bin/jellyfin && \
    rm -rf /tmp/*

# Add and prepare the startup script
COPY run.sh /run.sh
RUN chmod +x /run.sh

VOLUME ["/media"]

CMD ["/run.sh"]
