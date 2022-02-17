FROM ubuntu:20.04

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get -y update && apt-get -y upgrade && \
        apt-get install -y software-properties-common && \
        add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable && \
        apt-get install -y python3 python3-pip python3-lxml aria2 \
        qbittorrent-nox tzdata p7zip-full p7zip-rar xz-utils wget curl pv jq \
        ffmpeg locales unzip neofetch mediainfo git make g++ gcc automake \
        autoconf libtool libcurl4-openssl-dev qt5-default \
        libsodium-dev libssl-dev libcrypto++-dev libc-ares-dev \
        libsqlite3-dev libfreeimage-dev swig libboost-all-dev \
        libpthread-stubs0-dev zlib1g-dev
        
# Installing Mega SDK Python Binding
RUN curl -fsSL https://github.com/viswanathbalusu/megasdkrest/releases/download/v0.1.17/megasdkrest-amd64 -o /usr/local/bin/megasdkrest \
    && chmod +x /usr/local/bin/megasdkrest
    
# Requirements Mirror Bot
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

RUN apt-get -y update && apt-get -y upgrade && apt-get -y autoremove && apt-get -y autoclean

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
