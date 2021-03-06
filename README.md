![GitHub](https://img.shields.io/github/license/ksator/arista_eos_automation_tools_dockerized) ![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/ksator/arista_eos_automation_tools_dockerized) ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/ksator/arista_eos_automation_tools_dockerized)  

# About this repository 

Various tools for Arista EOS automation (Python libraries, Ansible ...) packaged in a [Dockerfile](Dockerfile) at the root of this repository.

# Requirements 

install Docker on your laptop.  

# Docker image

In order to get a Docker image: 
- either you pull the docker image that is already built and available on Docker Hub
- or you create a Docker image yourself from the Dockerfile. 

## Pull the docker image from Docker Hub

```
docker pull ksator/arista_eos_automation_tools_dockerized:latest
```
```
docker images | grep arista
ksator/arista_eos_automation_tools_dockerized   latest              177c59b2bc31        9 minutes ago       685MB
```

## Create a Docker image from the Dockerfile

Move to the local directory which contains the [Dockerfile](Dockerfile) and run this command. 
```
docker build --tag eos_automation:1.0 .
```
```
docker images | grep eos_automation
eos_automation                  1.0                 65dec9ed3519        19 minutes ago      685MB
```

# Instanciate a Docker container 

Move to the local directory which contains your scripts and run this command to instanciate and start a container.
```
docker run -it -v $PWD:/projects --name eos_automation_container eos_automation:1.0       
```
Your local scripts will be mounted to `/projects` in the container.
```
root@7d4eb0a7fb0a:/projects# ls
```

# About the container 

Ubuntu version: 
```
root@7d4eb0a7fb0a:/projects# uname -a
Linux 7d4eb0a7fb0a 4.19.76-linuxkit #1 SMP Tue May 26 11:42:35 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
```
```
root@7d4eb0a7fb0a:/projects# lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu Groovy Gorilla (development branch)
Release:        20.10
Codename:       groovy
```

Python version:
```
root@7d4eb0a7fb0a:/projects# python3 -V
Python 3.8.3
```

Verify some packages: 
```
root@7d4eb0a7fb0a:/projects# pip3 list | grep 'ansible\|pyang'
ansible          2.9.7
pyang            2.2.1
pyangbind        0.8.1
root@7d4eb0a7fb0a:/projects# 
```

Ansible version: 
```
root@7d4eb0a7fb0a:/projects# ansible --version
ansible 2.9.11
  config file = /projects/ansible.cfg
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python3.8/dist-packages/ansible
  executable location = /usr/local/bin/ansible
  python version = 3.8.4 (default, Jul 13 2020, 21:16:07) [GCC 9.3.0]
```

Verify Ansible collection: 
```
ls -l ~/.ansible/collections/ansible_collections/arista/eos/
```


## Test the container 

Device configuration:
```
s7152#show running-config section management api
management api http-commands
   protocol http
   no shutdown
s7152#
```

Run an eAPI test (python) from the container:  

```
from jsonrpclib import Server
from pprint import pprint as pp
username = "arista"
password = "arista"
ip = "10.83.28.218"
url = "http://" + username + ":" + password + "@" + ip + "/command-api"
switch = Server(url)
result=switch.runCmds(version=1,cmds=["show version"])
pp(result) 
result[0]['version']
```
