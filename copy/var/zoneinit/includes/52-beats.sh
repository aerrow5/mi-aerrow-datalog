#!/bin/bash

# This script was tested with 4.3-1 so get that by default
version='4.3.1'

test -d /root/go || mkdir -p /root/go
export GOPATH=${HOME}/go

pushd /${GOPATH}
go get -u github.com/joshuar/pingbeat

curl -XPUT http://localhost:9200/_template/pingbeat -d @${GOPATH}/src/github.com/joshuar/pingbeat/etc/pingbeat-template.json

test -d /etc/pingbeat || mkdir -p /etc/pingbeat && chown elastic:elastic /etc/pingbeat
cp ${GOPATH}/src/github.com/joshuar/pingbeat/etc/pingbeat-example.yml /etc/pingbeat/pingbeat.yml
ln -s ${GOPATH}/bin/pingbeat /etc/pingbeat/pingbeat

popd

# svccfg import not needed, as it is already done by mdata-init
# svcadm enable svc:/pkgsrc/kibana:default
