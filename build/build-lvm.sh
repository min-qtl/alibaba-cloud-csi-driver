#!/usr/bin/env bash
set -e

cd ${GOPATH}/src/quantil.com/qcc/lvm-csi-driver/
GIT_SHA=`git rev-parse --short HEAD || echo "HEAD"`

export GOARCH="amd64"
export GOOS="linux"

branch="v1.0.0"
version="v1.14.5"
commitId=$GIT_SHA
buildTime=`date "+%Y-%m-%d-%H:%M:%S"`

CGO_ENABLED=0 go build -ldflags "-X main._BRANCH_='$branch' -X main._VERSION_='$version-$commitId' -X main._BUILDTIME_='$buildTime'" -o lvm.csi.quantil.com

if [ "$1" == "" ]; then
  version="v1.14"
  cd ${GOPATH}/src/quantil.com/qcc/lvm-csi-driver/build/lvm/
  mv ${GOPATH}/src/quantil.com/qcc/lvm-csi-driver/lvm.csi.quantil.com ./
  docker build -t=registry-qcc.quantil.com/qcc/csi-lvmplugin:$version ./
  docker push registry-qcc.quantil.com/qcc/csi-lvmplugin:$version
fi

rm -rf lvm.csi.quantil.com
