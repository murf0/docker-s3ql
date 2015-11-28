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
SWIFT_AUTH_ENDPOINT=<HTTP AUTH API endpoint (skip if container is already created)>
```


## Hubic
Im using hubic 10tb for €5 per month. It's an OVH company, so it's running in France. 

[hubic.com](https://hubic.com)
Of if you want to use my affiliate link (I'll get an extra 500gb when you sign up)
[hubic.com/en/offers?referral=KRMTJR](https://hubic.com/en/offers?referral=KRMTJR)