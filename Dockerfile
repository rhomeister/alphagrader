FROM debian:stable-slim
MAINTAINER Ruben Stranders

RUN mkdir -p /usr/share/man/man1 && mkdir /submission

RUN echo "deb http://ftp.us.debian.org/debian sid main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y curl gnupg --no-install-recommends && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash -

#Install all the languages/compilers we support
RUN apt-get install -y --no-install-recommends \
          gcc \
          g++ \
          ruby \
          python python3 \
          mono-xsp \
          nodejs \
          openjdk-13-jdk \
          golang \
          clisp \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -r default -u 1000
