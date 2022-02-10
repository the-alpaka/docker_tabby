FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.14
ARG TAG=latest
RUN \
    echo 'Install Dependencies' && \
    apk add --no-cache --upgrade \ 
    git && \
    echo 'Install Tabby' && \
    mkdir -p /app && \
    cd /app && git clone -b v${TAG} https://github.com/bertvandepoel/tabby.git && \
    echo 'Remove Dependencies' && \
    apk del --purge git
COPY default.conf /config/nginx/site-confs/default
EXPOSE 80