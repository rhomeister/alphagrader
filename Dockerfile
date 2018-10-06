FROM debian:stretch-slim
MAINTAINER Ruben Stranders

RUN mkdir -p /usr/share/man/man1 && mkdir /submission

RUN apt-get update && \
    apt-get install -y curl gnupg && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash -

#Install all the languages/compilers we are supporting.
RUN apt-get install -y --no-install-recommends \
          gcc \
          g++ \
          ruby \
          python python3 \
          mono-xsp mono-xsp4-base mono-vbnc \
          nodejs \
          default-jre \
          golang

RUN useradd -r default -u 1000
