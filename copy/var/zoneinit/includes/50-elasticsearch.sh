#!/bin/bash

# This script was tested with 2.2-1 so get that by default
version='2.1.1'

pushd /tmp
wget --no-check-certificate https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/${version}/elasticsearch-${version}.tar.gz
popd
pushd /opt/local
tar xvf /tmp/elasticsearch-${version}.tar.gz

#test -d /srv/unifi/data || mkdir -p /srv/unifi/data && chown unifi /srv/unifi/data
#test -d /srv/unifi/run || mkdir -p /srv/unifi/run && chown unifi /srv/unifi/run

#mkdir /opt/local/UniFi/{logs,work} && chown unifi /opt/local/UniFi/{logs,work}

popd

# svccfg import not needed, as it is already done by mdata-init
# svcadm enable svc:/network/unifi:default
