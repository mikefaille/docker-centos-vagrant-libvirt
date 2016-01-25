# Vagrant/libvirt/kvm over Docker

1- To build it :

```
docker build --pull=true  -t centos-vagrant .
```


2- To start it :

```
sudo docker  run -v $(pwd)/boxes:/root/.vagrant.d/  --privileged -v vagrant.d/ -e KVM_GROUP=$(getent group kvm |  cut -d ":" -f 3)   -ti centos-vagrant
```


3- (example) To launch projectatomic/centos image :

```
vagrant init centos/atomic-host; vagrant up --provider libvirt
```
