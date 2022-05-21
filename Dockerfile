FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /root/

ENV NGINX_VERSION 1.21.6

RUN \
      apt-get update && \
      apt-get install -y build-essential libpcre3 libpcre3-dev unzip libssl-dev aptitude dkms git yasm wget sysstat cifs-utils zlib1g-dev cmake libtool libc6 libc6-dev libnuma1 libnuma-dev nano wget


RUN \
      apt-get install -y ffmpeg 


RUN \
	    wget https://github.com/arut/nginx-rtmp-module/archive/master.zip && \
      unzip master.zip && \
      wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
	    tar -xf nginx-${NGINX_VERSION}.tar.gz

RUN \
      cd nginx-${NGINX_VERSION} && \
      ./configure --with-debug --with-file-aio --with-http_ssl_module --add-module=../nginx-rtmp-module-master && \
	    make -j 12 && \
	    make install


RUN   mkdir -p /usr/local/nginx/scripts/
COPY  scripts/ /usr/local/nginx/scripts/
COPY  *.conf /usr/local/nginx/conf/


CMD ["/bin/sh" , "-c" , "echo $NAME > /usr/local/nginx/scripts/name.param && echo $DEST > /usr/local/nginx/scripts/dest.param && echo $TIMEOUT > /usr/local/nginx/scripts/timeout.param && exec /usr/local/nginx/sbin/nginx -g 'daemon off;'"]