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
    jellyfin \
    && apt-get clean

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD [ "/run.sh" ]
