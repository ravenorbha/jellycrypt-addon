FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive
ENV JELLYFIN_VERSION=10.8.13

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
    curl -L "https://repo.jellyfin.org/releases/server/debian/versions/stable/server/jellyfin_${JELLYFIN_VERSION}_amd64.tar.gz" -o /tmp/jellyfin.tar.gz && \
    tar -xzf /tmp/jellyfin.tar.gz -C /opt/jellyfin --strip-components=1 && \
    ln -s /opt/jellyfin/jellyfin /usr/bin/jellyfin && \
    rm -rf /var/lib/apt/lists/* /tmp/*

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
