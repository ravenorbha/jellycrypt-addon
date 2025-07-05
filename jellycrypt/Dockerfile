FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    gocryptfs \
    fuse \
    curl \
    ffmpeg \
    gnupg2 \
    ca-certificates \
    jq && \
    curl -fsSL https://repo.jellyfin.org/jellyfin_team.gpg.key | gpg --dearmor -o /usr/share/keyrings/jellyfin.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/jellyfin.gpg] https://repo.jellyfin.org/debian bullseye main" > /etc/apt/sources.list.d/jellyfin.list && \
    apt-get update && \
    apt-get install -y \
    jellyfin \
    jellyfin-web \
    jellyfin-server \
    jellyfin-ffmpeg5 && \
    apt-get clean

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD [ "/run.sh" ]
