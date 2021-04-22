FROM debian:jessie

ENV PLEX_VERSION 1.22.3.4392-d7c624def

RUN apt-get update \
	&& apt-get install -y wget \
	&& wget -O /tmp/plexmediaserver.deb \
		"https://downloads.plex.tv/plex-media-server-new/${PLEX_VERSION}/debian/plexmediaserver_${PLEX_VERSION}_amd64.deb" \
	&& dpkg -i /tmp/plexmediaserver.deb \
	&& rm -f /tmp/plexmediaserver.deb \
	&& rm -rf /var/lib/apt/lists/*

RUN useradd -U -d /config -s /bin/false plex && \
    usermod -G users plex

COPY docker-entrypoint.sh /entrypoint.sh
COPY plex /usr/local/bin/

EXPOSE 32400/tcp 3005/tcp 8324/tcp 32469/tcp 1900/udp 32410/udp 32412/udp 32413/udp 32414/udp
VOLUME /plex

ENTRYPOINT ["/entrypoint.sh"]
CMD ["plex"]
