#!/bin/bash

# This script was tested with 4.3-1 so get that by default
version='4.3.1'

pushd /tmp
wget --no-check-certificate https://download.elastic.co/kibana/kibana/kibana-${version}-linux-x64.tar.gz
popd
pushd /opt/local
tar xvf /tmp/kibana-${version}-linux-x64.tar.gz
mv /opt/local/kibana-${version}-linux-x64 /opt/local/kibana

# hardcode directory in kibana script:
sed -i 's/\(NODE="${DIR}\)/DIR="\/usr" #hardcode in script\r\n\1/' kibana

#test -d /var/tmp/elasticsearch || mkdir -p /var/tmp/elasticsearch && chown elastic /var/tmp/elasticsearch

#mkdir /opt/local/UniFi/{logs,work} && chown unifi /opt/local/UniFi/{logs,work}

popd

# svccfg import not needed, as it is already done by mdata-init
svcadm enable srv:/pkgsrc/elasticsearch:default
