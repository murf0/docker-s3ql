FROM		phusion/baseimage
MAINTAINER	Mikael Mellgren <mikael@murf.se>

# Dependencies
RUN export DEBIAN_FRONTEND=noninteractive && \
    add-apt-repository -y ppa:nikratio/s3ql && \
	apt-get update && \
	apt-get install --no-install-recommends -y software-properties-common s3ql ca-certificates python-swiftclient && \
	apt-get upgrade --no-install-recommends -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	ulimit -n 30000 && \
	mkdir -p /etc/my_init.d

# End S3QL FS


# Config env variables
ENV 	 S3QL_TYPE=swift \
	 S3QL_STORAGE=<server>:<port> \
	 S3QL_STORAGE_CONTAINER=<storage_container> \
	 S3QL_STORAGE_FS=<Filesystem_Name> \
	 S3QL_COMPRESS=zlib \
	 S3QL_MOUNT_POINT=/mnt/data\
	 S3QL_LOGIN=<username> \
	 S3QL_PASSWD=<password> \
	 S3QL_FSPASSWD=<FS password> \
	 SWIFT_AUTH_ENDPOINT=<HTTP AUTH API endpoint (skip if container is already created)>

#Adding all our scripts
COPY scripts/create_s3ql_fs /etc/my_init.d/01_create_s3ql_fs
COPY scripts/rc.local_shutdown /etc/rc.local_shutdown

# Baseimage init process
ENTRYPOINT ["/sbin/my_init"]