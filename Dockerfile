FROM ubuntu:23.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV DEBIAN_FRONTEND noninteractive

RUN groupadd --gid 1000 streamer && \
	useradd --uid 1000 --gid streamer --shell /bin/bash --create-home streamer

WORKDIR /tmp

ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini /tini

RUN chmod +x /tini

ENTRYPOINT ["/tini", "--"]

WORKDIR /home/user/streamer

COPY . .

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
	curl -s http://ciscobinary.openh264.org/openh264-linux64-2e1774ab6dc6c43debb0b5b628bdf122a391d521.zip -o /tmp/openh264-1.8.1.1.zip && \
    chmod a+r /tmp/openh264-1.8.1.1.zip && \
	# Clean
	apt-get clean autoclean && \
	apt-get autoremove -y && \
	rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
    # Permissions
    chmod +x entrypoint.sh && \
    chmod +x ffmpeg.sh && \
    chmod +x firefox.sh

USER streamer

CMD ["./entrypoint.sh"]

EXPOSE 5900
