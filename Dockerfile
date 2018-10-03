FROM centos:7
MAINTAINER occidere@naver.com

USER root
WORKDIR /root

RUN yum update -y -q && yum upgrade -y -q
RUN yum install -y -q vim wget net-tools

RUN mkdir apps deploy script logs

RUN wget -q --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.tar.gz
RUN tar -zxf jdk-8* && rm -rf jdk-8*.tar.gz && mv jdk1.8.0_181 apps/

RUN wget -q https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-rhel70-3.6.8.tgz
RUN tar -zxf mongodb-linux-*.tgz && rm -rf *tgz && mv mongodb-* mongodb && mv mongodb apps/

EXPOSE 27017

ENV JAVA_HOME /root/apps/jdk1.8.0_181
ENV LANG ko_KR.UTF-8
RUN echo 'set encoding=utf-8' >> /etc/vimrc
ENV PROFILE /root/.bashrc
RUN echo 'alias ll="ls -Fhal --color=auto"' >> $PROFILE
RUN echo 'alias l="ls -Fha --color=auto"' >> $PROFILE
RUN echo 'cl() { clear; ls -Fhal --color=auto; }' >> $PROFILE
RUN echo 'cdl() { clear; cd "$@" && ls -Fhal --color=auto; }' >> $PROFILE
RUN echo 'export PS1="\[\e[1;34m\]DOCKER\[\e[m\]\[\e[1;34m\]-\[\e[m\][\h:\w] "' >> $PROFILE
RUN echo 'export PATH=$PATH:$JAVA_HOME/bin:/root/apps/mongodb/bin' >> $PROFILE

ENV MONGO_SCRIPT /root/script/run_with_mongo.sh
RUN touch $MONGO_SCRIPT
RUN echo '#!/bin/sh' >> $MONGO_SCRIPT
RUN echo 'mkdir -p /data/db' >> $MONGO_SCRIPT
RUN echo '/root/apps/mongodb/bin/mongod --bind_ip 0.0.0.0 >> /root/logs/mongodb.log &' >> $MONGO_SCRIPT
RUN echo '/bin/bash' >> $MONGO_SCRIPT
RUN chmod 777 $MONGO_SCRIPT && sh $MONGO_SCRIPT

CMD $MONGO_SCRIPT
