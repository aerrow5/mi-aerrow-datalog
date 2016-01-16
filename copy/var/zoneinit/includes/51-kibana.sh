#!/bin/bash

# This script was tested with 2.2-1 so get that by default
version='2.1.1'

pushd /tmp
wget --no-check-certificate https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/${version}/elasticsearch-${version}.tar.gz
popd
pushd /opt/local
tar xvf /tmp/elasticsearch-${version}.tar.gz
mv /opt/local/elasticsearch-${version} /opt/local/elasticsearch

test -d /var/tmp/elasticsearch || mkdir -p /var/tmp/elasticsearch && chown elastic /var/tmp/elasticsearch
test -d /opt/local/elasticsearch/logs || mkdir -p /opt/local/elasticsearch/logs && chown elastic /opt/local/elasticsearch/logs
test -d /opt/local/elasticsearch/plugins || mkdir -p /opt/local/elasticsearch/plugins && chown elastic /opt/local/elasticsearch/plugins
test -d /opt/local/elasticsearch/config/scripts || mkdir -p /opt/local/elasticsearch/config/scripts && chown elastic /opt/local/elasticsearch/config/scripts

test -d /data/elasticsearch || mkdir -p /data/elasticsearch && chown elastic /data/elasticsearch
test -a /opt/local/elasticsearch/data || ln -s /data/elasticsearch data

#mkdir /opt/local/UniFi/{logs,work} && chown unifi /opt/local/UniFi/{logs,work}

popd

# svccfg import not needed, as it is already done by mdata-init
svcadm enable srv:/pkgsrc/elasticsearch:default
