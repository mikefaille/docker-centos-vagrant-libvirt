#!/usr/bin/bash
/usr/sbin/groupmod -g $KVM_GROUP kvm &&  mkdir -p /var/run/dbus/ && dbus-daemon --system &
libvirtd
