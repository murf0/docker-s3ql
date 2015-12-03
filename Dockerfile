FROM		phusion/baseimage
MAINTAINER	Mikael Mellgren <mikael@murf.se>

# Environment Configuration variables Needed to function properly.
ENV  S3QL_TYPE=swift \
	 S3QL_STORAGE=server:port \
	 S3QL_STORAGE_CONTAINER=storage_container \
	 S3QL_STORAGE_FS=Filesystem_Name \
	 S3QL_COMPRESS=zlib \
	 S3QL_MOUNT_POINT=/mnt/data\
	 S3QL_LOGIN=username \
	 S3QL_PASSWD=password \
	 S3QL_FSPASSWD=FS_password \
	 S3QL_CACHESIZE= \
	 S3QL_SUBNET=10.7.0.0/16 \
	 SWIFT_AUTH_ENDPOINT="HTTP AUTH API endpoint (skip if container is already created)"

# Dependencies
COPY build.sh /build.sh
RUN chmod 755 /build.sh
RUN /build.sh

#Adding Startup, shutdown
COPY create_s3ql_fs /etc/service/s3ql/run
RUN chmod 755 /etc/service/s3ql/run

EXPOSE 111/udp 2049/tcp

# Baseimage init process
ENTRYPOINT ["/sbin/my_init"]
