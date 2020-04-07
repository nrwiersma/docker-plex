FROM debian:jessie

ENV PLEX_VERSION 1.18.9.2578-513b381af

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

EXPOSE 32400
VOLUME /plex

ENTRYPOINT ["/entrypoint.sh"]
CMD ["plex"]
