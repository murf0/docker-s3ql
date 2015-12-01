#!/bin/sh
export DEBIAN_FRONTEND=noninteractive
add-apt-repository -y ppa:nikratio/s3ql
apt-get update
apt-get install --no-install-recommends -y software-properties-common s3ql ca-certificates python-swiftclient nfs-kernel-server
apt-get upgrade --no-install-recommends -y
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#S3QL
ulimit -n 30000

#NFS
mkdir -p /run/rpc_pipefs/nfs
sed -i 's#KILL_PROCESS_TIMEOUT = 5#KILL_PROCESS_TIMEOUT = 120#g' /sbin/my_init
sed -i 's#KILL_ALL_PROCESSES_TIMEOUT = 5#KILL_ALL_PROCESSES_TIMEOUT = 120#g' /sbin/my_init
mkdir -p /etc/my_init.d

sed -i 's#NEED_SVCGSSD=""#NEED_SVCGSSD=no#g' /etc/default/nfs-kernel-server
echo "[Mapping]
Nobody-User = nobody
Nobody-Group = nogroup"  > /etc/idmapd.conf
service rpcbind restart
service nfs-kernel-server restart