!/bin/bash
ETCD_VER=$1
if [ ${ETCD_VER} eq "" ]; then
    ETCD_VER=v3.5.0
fi

# choose either URL
GOOGLE_URL=https://storage.googleapis.com/etcd
GITHUB_URL=https://github.com/etcd-io/etcd/releases/download
DOWNLOAD_URL=${GOOGLE_URL}

if [ ! -f "/tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz" ]; then
    rm -f /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz
fi

if [ ! -d "/tmp/etcd-download-test" ];then
    rm -rf /tmp/etcd-download-test && mkdir -p /tmp/etcd-download-test
fi


curl -L ${DOWNLOAD_URL}/${ETCD_VER}/etcd-${ETCD_VER}-linux-amd64.tar.gz -o /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz

tar xzvf /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz -C /tmp/etcd-download-test --strip-components=1

mv /tmp/etcd-download-test /usr/local/etcd

rm -f /tmp/etcd-${ETCD_VER}-linux-amd64.tar.gz

/usr/local/etcd/etcd --version
/usr/local/etcd/etcdctl version
/usr/local/etcd/etcdutl version