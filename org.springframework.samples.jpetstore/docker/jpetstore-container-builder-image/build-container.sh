#/bin/bash
HOSTIP=$(ip addr show docker0 | grep -Po 'inet \K[\d.]+')
docker build --rm=true -t=jpetstore-builder .
docker stop jpetstore-builder-running
docker rm -f jpetstore-builder-running
docker run -e FACTER_dockerhostip=$HOSTIP --name jpetstore-builder-running jpetstore-builder
docker commit jpetstore-builder-running jetty-with-jpetstore

