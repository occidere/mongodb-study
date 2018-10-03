#/bin/bash

# docker image ls | grep none | awk -F' ' '{print $3}' | xargs docker image rm

# docker ps -aq |xargs docker stop

# docker ps -aq | xargs docker rm

docker build -t centos7:mongodb .

docker run --network bridge -it centos7:mongodb
