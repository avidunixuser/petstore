FROM jlthorpe73/puppet-base
MAINTAINER Jonathan Thorpe "jon.thorpe@gmail.com"
ADD config-jetty.pp /tmp/puppetfile.pp

#RUN apt-get -y update
#RUN apt-get -y install openjdk-7-jdk
RUN puppet module install maestrodev-jetty
RUN puppet apply --verbose --debug /tmp/puppetfile.pp

