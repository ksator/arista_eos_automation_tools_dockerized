#  About this repository 

Various tools for Arista EOS automation (Python libraries, Ansible ...) packaged in a [Dockerfile](Dockerfile) at the root of this repository.

# Requirements 

install Docker on your laptop.  

# Create a Docker image

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
ansible 2.9.7
  config file = None
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python3.8/dist-packages/ansible
  executable location = /usr/local/bin/ansible
  python version = 3.8.3 (default, May 14 2020, 11:03:12) [GCC 9.3.0]
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

## EOS automation examples 

## eAPI 

There are examples in this repository https://github.com/ksator/arista_eos_automation_with_eAPI 

## Ansible 

There are examples in this repository https://github.com/ksator/arista_eos_automation_with_ansible

## Pyang and Pyangbind 

There are examples in this repository https://github.com/ksator/gnmi_demo_with_arista_eos

## Netconf 

There are examples in this repository https://github.com/ksator/arista_eos_automation_with_ncclient
