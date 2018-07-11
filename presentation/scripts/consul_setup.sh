#!/bin/bash

docker-compose -f install/consul/istio.yaml up -d
$GOPATH/bin/istioctl context-create --api-server http://localhost:8080
docker-compose -f samples/bookinfo/consul/bookinfo.yaml up -d
docker-compose -f samples/bookinfo/consul/bookinfo.sidecars.yaml up -d
