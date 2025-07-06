FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive
ENV JELLYFIN_VERSION=10.10.7
ENV GOCRYPTFS_VERSION=v2.5.1

# Install minimal required system packages
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

# Install gocryptfs from GitHub (extract from .tar.gz)
RUN curl -fSL https://github.com/rfjakob/gocryptfs/releases/download/${GOCRYPTFS_VERSION}/gocryptfs-${GOCRYPTFS_VERSION#v}-linux-amd64.tar.gz \
    -o /tmp/gocryptfs.tar.gz && \
    tar -xzf /tmp/gocryptfs.tar.gz -C /usr/local/bin && \
    chmod +x /usr/local/bin/gocryptfs && \
    rm -f /tmp/gocryptfs.tar.gz

# Download and extract Jellyfin server
RUN mkdir -p /opt/jellyfin && \
    curl -fSL "https://repo.jellyfin.org/files/server/linux/latest-stable/amd64/jellyfin_${JELLYFIN_VERSION}-amd64.tar.gz" \
    -o /tmp/jellyfin.tar.gz && \
    tar -xzf /tmp/jellyfin.tar.gz -C /opt/jellyfin --strip-components=1 && \
    ln -s /opt/jellyfin/jellyfin /usr/bin/jellyfin && \
    rm -rf /tmp/*

# Add run script
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Allow mounting USB and encrypted folders
VOLUME ["/media"]

CMD ["/run.sh"]
