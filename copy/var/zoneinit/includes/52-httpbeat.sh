#!/bin/bash

beatprog='httpbeat'
gh_user='christiangalsterer'
gh_dir=github.com/${gh_user}/${beatprog}

test -d /root/go || mkdir -p /root/go
export GOPATH=${HOME}/go

pushd /${GOPATH}
go get -u ${gh_dir}
curl -XPUT http://localhost:9200/_template/${beatprog} -d @${GOPATH}/src/${gh_dir}/etc/${beatprog}-template.json

test -d /etc/${beatprog} || mkdir -p /etc/${beatprog} && chown elastic:elastic /etc/${beatprog}
cp ${GOPATH}/src/${gh_dir}/etc/pingbeat-example.yml /etc/pingbeat/pingbeat.yml
ln -s ${GOPATH}/bin/pingbeat /etc/pingbeat/pingbeat

popd

# svccfg import not needed, as it is already done by mdata-init
# svcadm enable svc:/pkgsrc/kibana:default
