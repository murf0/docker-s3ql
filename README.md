## s3ql docker image
Based on: https://github.com/raghon1/seafile/tree/master/docker-s3ql

Using it with [docker-hubic-swiftauth-proxy](https://github.com/murf0/docker-hubic-swiftauth-proxy) to enable hubic compability

Set environment variables to suite your needs.

```
S3QL_TYPE=swift \
S3QL_STORAGE=<server>:<port> \
S3QL_STORAGE_CONTAINER=<storage_container> \
S3QL_STORAGE_FS=<Filesystem_Name> \
S3QL_COMPRESS=zlib \
S3QL_MOUNT_POINT=/mnt/data\
S3QL_LOGIN=<username> \
S3QL_PASSWD=<password> \
S3QL_FSPASSWD=<FS password> \
S3QL_CACHESIZE=<In KB or empty if you wish to use auto, auto will use up all of the space on your _host_> \
S3QL_SUBNET=<subnet ex 172.17.0./16> \
SWIFT_AUTH_ENDPOINT=<HTTP AUTH API endpoint (skip if container is already created)>

```

### Run it
To run you must use "--privileged" or "--cap-add mknod --cap-add sys_admin --device=/dev/fuse" Since it uses fuse to mount the volume.

### Shutdown
Changed timeout in my_init from 5sec to 120 sec to allow for syncing of metadata and data to cloud.


## Hubic
Im using hubic 10tb for €5 per month. It's an OVH company, so it's running in France. 

[hubic.com](https://hubic.com)
Of if you want to use my affiliate link (I'll get an extra 500gb when you sign up)
[hubic.com/en/offers?referral=KRMTJR](https://hubic.com/en/offers?referral=KRMTJR)

#Usage in other containers.
Since this mount is only container local (not mounted in the host file system.) No other containers can use the filesystem directly (eg via --volumes-from) 
Instead you can use NFS
```
mount <s3ql ip>:/folder/already/setup/to/be/shared /mountpoint
```
Remember the host server must have the nfs-kernel module installed also.
And of course the server mounting needs to run in "--privileged" mode also.
This is a _security_ issue. A compromised container running in privileged mode means a compromised host. (Running the s3ql in privileged mode is "ok-ish" since it is not exposing any services to the world)


##NFS mount in host instead.
Basically query docker for the ip of the s3ql container (On name..) then mount on that ip.  Remember to set S3QL_SUBNET accordingly on the container. 
```
mount -t nfs $(docker inspect $(docker ps -a | grep s3ql | awk '{print $1}') | grep IPAddress\" | awk -F\" '{print $4}'):/ <mount_point>
```


##Docker volumes plugins
Instead there is a couple of docker-volume plugins you can use: 
https://github.com/SvenDowideit/docker-volumes-nfs
https://github.com/gondor/docker-volume-netsh

But that forces you to expose the Ports for NFSv4 111 and 2049

#License
MIT For original code in this repository, see LICENSE text