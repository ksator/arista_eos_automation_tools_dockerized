FROM ubuntu:20.10
MAINTAINER Khelil Sator <ksator@arista.com>
RUN apt update && apt-get -y upgrade
RUN apt install -y python3-pip git vim
RUN pip3 install ansible==2.9.11 paramiko==2.7.1 jsonrpclib-pelix==0.4.1 ncclient==0.6.7 pyang==2.2.1 pyangbind==0.8.1 wget==3.2 curl==0.0.1 netaddr==0.8.0
RUN ansible-galaxy collection install arista.eos
WORKDIR /projects
