#!/bin/bash

# This script was tested with 4.3-1 so get that by default
version='4.3.1'

pushd /tmp
wget --no-check-certificate https://download.elastic.co/kibana/kibana/kibana-${version}-linux-x64.tar.gz
popd
pushd /opt/local
tar xvf /tmp/kibana-${version}-linux-x64.tar.gz
mv /opt/local/kibana-${version}-linux-x64 /opt/local/kibana

# hardcode node exec in kibana script:
sed -i 's/\(test -x\)/NODE="\/opt\/local\/bin\/node" #hardcode solaris node in script \r\n\1/' /opt/local/kibana/bin/kibana
chown -R elastic:elastic /opt/local/kibana

test -d /var/tmp/kibana || mkdir -p /var/tmp/kibana && chown elastic:elastic /var/tmp/kibana

#mkdir /opt/local/UniFi/{logs,work} && chown unifi /opt/local/UniFi/{logs,work}

popd

# svccfg import not needed, as it is already done by mdata-init
svcadm enable svc:/pkgsrc/kibana:default
