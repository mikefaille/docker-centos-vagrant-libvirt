FROM centos:7
MAINTAINER michael@faille.io <michael@faille.io>

ENV VAGRANT_DEFAULT_PROVIDER=libvirt

RUN  rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && yum upgrade -y && yum -y install gcc libxslt-devel libxml2-devel libvirt-devel libguestfs-tools-c   libvirt-daemon-kvm libvirt  qemu-kvm  bridge-utils https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.rpm

RUN yum install rubygems ruby-devel -y && gem install bundler  && bundle config disable_multisource true # &&gem list --clear-sources --source http://gems.hashicorp.com -r
RUN  vagrant plugin install vagrant-libvirt
RUN vagrant plugin install vagrant-cachier

RUN yum install dbus openssh-clients rsync -y

# RUN yum -y swap -- remove systemd-container systemd-container-libs -- install systemd systemd-libs




# RUN systemctl mask dev-mqueue.mount dev-hugepages.mount \
#     systemd-remount-fs.service sys-kernel-config.mount \
#     sys-kernel-debug.mount sys-fs-fuse-connections.mount \
#     display-manager.service graphical.target systemd-logind.service


# # Environment for systemd
# ENV container=docker


# RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
#     rm -f /lib/systemd/system/multi-user.target.wants/*;\
#     rm -f /etc/systemd/system/*.wants/*;\
#     rm -f /lib/systemd/system/local-fs.target.wants/*; \
#     rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
#     rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
#     rm -f /lib/systemd/system/basic.target.wants/*;\
#     rm -f /lib/systemd/system/anaconda.target.wants/*;


# # # Volumes for systemd
# VOLUME ["/run", "/tmp"]



# # VOLUME ["/run"]
# VOLUME [ "/sys/fs/cgroup" ]

# RUN systemctl enable libvirtd && systemctl disable network
# ADD changekvmgroup.service /usr/lib/systemd/system/changekvmgroup.service
# RUN systemctl enable changekvmgroup.service
ADD run.sh run.sh

RUN yum install -y dbus \
  && sed -i -e "s/OOMScoreAdjust/# OOMScoreAdjust/" /usr/lib/systemd/system/dbus.service

ENTRYPOINT ["./run.sh"]
