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

## License
MIT For original code in this repository see LICENSE text
GPL for the code originating from raghon1 repository.