FROM ubuntu:12.04
MAINTAINER Jonathan Thorpe "jon.thorpe@gmail.com"

RUN apt-get -y update
RUN apt-get -y install rubygems
RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc
RUN gem install puppet
