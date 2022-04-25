FROM linuxserver/nginx:latest
ENV TABBY_VERSION=latest
COPY root/ /
RUN \
    apk add --no-cache --upgrade git && \ 
    chmod +x /etc/cont-init.d/20-config /periodic/daily/tabby-cron
EXPOSE 80
VOLUME /config