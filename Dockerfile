FROM phusion/baseimage:0.9.17
MAINTAINER Xena <xena@yolo-swag.com>

RUN apt-get update && \
    apt-get -y install libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl make curl git-core

# build/install OpenResty
ENV SRC_DIR /opt
ENV OPENRESTY_VERSION 1.9.3.1
ENV OPENRESTY_PREFIX /app/openresty
ENV LAPIS_VERSION 1.3.0

RUN cd $SRC_DIR && curl -LO http://openresty.org/download/ngx_openresty-$OPENRESTY_VERSION.tar.gz \
    && tar xzf ngx_openresty-$OPENRESTY_VERSION.tar.gz && cd ngx_openresty-$OPENRESTY_VERSION \
    && ./configure --prefix=$OPENRESTY_PREFIX \
    && make && make install && rm -rf ngx_openresty-$OPENRESTY_VERSION*

RUN apt-get -qqy install luarocks

RUN luarocks install lapis $LAPIS_VERSION && \
    luarocks install moonscript && \
    luarocks install lapis-console && \
    luarocks install yaml

ADD prepare.moon /app/prepare.moon
ADD lapis /etc/service/lapis/run
ENTRYPOINT /sbin/my_init

ENV PORT 8080
EXPOSE 8080
ENV LAPIS_ENVIRONMENT docker

ONBUILD ADD app.yaml /app/
ONBUILD RUN moon /app/prepare.moon /app/app.yaml
ONBUILD ADD . /app/src
ONBUILD RUN moonc /app/src
