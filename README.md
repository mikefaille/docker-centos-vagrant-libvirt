# Vagrant/libvirt/kvm over Docker

To build it :

docker build --pull=true  -t centos-vagrant .


To start it :

sudo docker  run -v vagrant.d:/.vagrant  --privileged -v vagrant.d/ -e KVM_GROUP=$(getent group kvm |  cut -d ":" -f 3)   -ti centos-vagrant
