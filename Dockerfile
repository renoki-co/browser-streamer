FROM ubuntu:20.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV DEBIAN_FRONTEND noninteractive

RUN groupadd --gid 1000 streamer && \
	useradd --uid 1000 --gid streamer --shell /bin/bash --create-home streamer

WORKDIR /tmp

ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini /tini

RUN chmod +x /tini

ENTRYPOINT ["/tini", "--"]

RUN apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y \
		curl \
		sudo \
		pulseaudio \
		xvfb \
		firefox \
		libnss3-tools \
		ffmpeg \
		xdotool \
		unzip \
		x11vnc \
		libfontconfig \
		libfreetype6 \
		xfonts-cyrillic \
		xfonts-scalable \
		fonts-liberation \
		fonts-ipafont-gothic \
		fonts-wqy-zenhei && \
	echo 'streamer ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers && \
	# Bundle Firefox plugin to enable H264 codec support for WebRTC
	curl -s http://ciscobinary.openh264.org/libopenh264-2.1.1-linux64.6.so.bz2 -o /tmp/libopenh264-2.1.1-linux64.6.so.bz2 && \
    chmod a+r /tmp/libopenh264-2.1.1-linux64.6.so.bz2 && \
	# Clean
	apt-get clean autoclean && \
	apt-get autoremove -y && \
	rm -rf /var/lib/{apt,dpkg,cache,log}/

USER streamer

WORKDIR /home/user/streamer

COPY . .

CMD ["./entrypoint.sh"]

EXPOSE 5900
