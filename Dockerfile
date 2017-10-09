FROM chug/ubuntu14.04x64
MAINTAINER Ruben Stranders

# Update the repository sources list
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN apt-get update
#RUN apt-get upgrade
#Install all the languages/compilers we are supporting.
RUN apt-get install -y gcc
RUN apt-get install -y g++
RUN apt-get install -y php5-cli
RUN apt-get install -y ruby
RUN apt-get install -y python
RUN apt-get install -y mono-xsp2 mono-xsp2-base

RUN apt-get install -y mono-vbnc
RUN apt-get install -y npm
# RUN apt-get install -y golang-golang
RUN apt-get install -y nodejs

#prepare for Java download
RUN apt-get install -y python-software-properties
RUN apt-get install -y software-properties-common

#grab oracle java (auto accept licence)
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java9-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java9-installer

RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs

RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update
RUN apt-get install -y python3.6

RUN useradd -r default -u 1000
