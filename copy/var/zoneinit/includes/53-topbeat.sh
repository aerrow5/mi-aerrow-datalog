#!/bin/bash


pushd /tmp
wget --no-check-certificate https://download.elastic.co/beats/topbeat/topbeat-1.0.1-x86_64.tar.gz
popd
pushd /opt/local
tar xvf /tmp/topbeat-1.0.1-x86_64.tar.gz
mv topbeat-1.0.1-x86_64/ topbeat/

curl -XPUT 'http://localhost:9200/_template/topbeat' -d@/opt/local/topbeat/topbeat.template.json


# hardcode node exec in kibana script:
sed -i 's/\(test -x\)/NODE="\/opt\/local\/bin\/node" #hardcode solaris node in script \r\n\1/' kibana
chown -R elastic:elastic /opt/local/kibana

test -d /var/tmp/kibana || mkdir -p /var/tmp/kibana && chown elastic:elastic /var/tmp/kibana

#mkdir /opt/local/UniFi/{logs,work} && chown unifi /opt/local/UniFi/{logs,work}

popd

# svccfg import not needed, as it is already done by mdata-init
svcadm enable svc:/pkgsrc/kibana:default
