#/bin/bash
ip addr show docker0 | grep -Po 'inet \K[\d.]+' > dockerhostip
cat dockerhostip | while read line; do echo "export HOSTIP=$line" > setip.sh; echo "export FACTER_docker_host_ip=$line" >> setip.sh; 
done 

