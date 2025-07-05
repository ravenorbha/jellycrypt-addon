FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive
ENV JELLYFIN_VERSION=10.10.7

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gocryptfs \
        fuse3 \
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
    tar -xzf /tmp/jellyfin.tar.gz -C /opt/jellyfin --strip-components=1 && \
    ln -s /opt/jellyfin/jellyfin /usr/bin/jellyfin && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
