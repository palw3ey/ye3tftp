FROM alpine:latest

MAINTAINER palw3ey <palw3ey@gmail.com>
LABEL name="ye3tftp" version="1.0.0" author="palw3ey" maintainer="palw3ey" email="palw3ey@gmail.com" website="https://github.com/palw3ey/ye3tftp" license="MIT" create="20231202" update="20231202" description="A docker TFTP server based on tftp-hpa and Alpine. Light, below 10 Mb. GNS3 ready." usage="docker run -dt --name mytftp palw3ey/ye3tftp" tip="The folder /data is persistent"
LABEL org.opencontainers.image.source=https://github.com/palw3ey/ye3tftp

ENV Y_LANGUAGE=fr_FR \
	Y_DEBUG=no \
	Y_IP=0.0.0.0 \
	Y_PORT=69 \
	Y_CREATE=no \
	Y_CHMOD= \
	Y_CHMOD_RECURSIVE=no

ADD entrypoint.sh /
ADD i18n/ /i18n/
ADD bypass_docker_env.sh.dis /etc/profile.d/

RUN apk add --update --no-cache tftp-hpa ; \
	chmod +x /entrypoint.sh ; \
	mkdir /data ; \
	chmod 777 /data ;

EXPOSE $Y_PORT/udp

VOLUME /data

ENTRYPOINT sh --login -c "/entrypoint.sh"
