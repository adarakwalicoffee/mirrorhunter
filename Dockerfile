FROM ubuntu:20.04

RUN set -ex \
    # Setup environment
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -qq update \
    && apt-get -qq -y dist-upgrade \
    && apt-get -qq -y install --no-install-recommends \
        locales python3 python3-lxml python3-pip python3-dev \
        # MegaSDK-REST dependencies
        libc-ares-dev libcrypto++-dev libcurl4-openssl-dev \
        libmagic-dev libsodium-dev libsqlite3-dev libssl-dev \
        # MirrorBot dependencies
        aria2 curl ffmpeg jq p7zip-full p7zip-rar pv gcc libpq-dev unzip \
    #qbit
    && apt install -y software-properties-common && add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable \
    && apt install -y qbittorrent-nox \
    && sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen \
    && locale-gen \
    # Setup MirrorBot dependencies
    && curl -fsSL https://github.com/jaskaranSM/megasdkrest/releases/download/v0.1/megasdkrest -o /usr/local/bin/megasdkrest \
    && chmod +x /usr/local/bin/megasdkrest \
    && curl -fsSLO https://gist.githubusercontent.com/harshpreets63/bf994ec106cb439a45dc5c362fd76dbf/raw/requirements.txt \
    && pip3 install --no-cache-dir --upgrade -r requirements.txt \
    && rm requirements.txt \
    # Cleanup environment
    && apt-get -qq -y autoremove --purge \
    && apt-get -qq -y clean \
    && rm -rf -- /var/lib/apt/lists/* /var/cache/apt/archives/* /etc/apt/sources.list.d/*

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

CMD ["bash", "start.sh"]

# vim: ft=dockerfile
