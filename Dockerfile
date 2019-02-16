
FROM xianzixiang/xenial
MAINTAINER faith

RUN apt update
RUN apt upgrade
RUN apt-get install -y build-essential git curl zip libpcre3 libpcre3-dev libssl-dev zlib1g-dev

RUN curl http://nginx.org/download/nginx-1.15.2.tar.gz -o nginx.tar.gz
RUN tar xvf nginx.tar.gz

ARG STREAM_SERVER
ARG STREAM_KEY

RUN curl -L https://github.com/arut/nginx-rtmp-module/archive/master.zip -o nginx-rtmp-module.zip
RUN unzip nginx-rtmp-module.zip

WORKDIR nginx-1.15.2
RUN ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master
RUN make
RUN make install

RUN mkdir -p /var/www/html
RUN mkdir -p /var/www/live/hls
COPY ./nginx.conf /usr/local/nginx/conf/nginx.conf
COPY ./index.html /var/www/html/index.html
RUN sed -i -e "s/{STREAM_SERVER}/$STREAM_SERVER/g" /var/www/html/index.html
RUN sed -i -e "s/{STREAM_KEY}/$STREAM_KEY/g" /var/www/html/index.html

ENTRYPOINT /usr/local/nginx/sbin/nginx -g "daemon off;"
