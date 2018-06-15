#!/bin/bash

docker-compose -f samples/bookinfo/consul/bookinfo.sidecars.yaml  down
docker-compose -f samples/bookinfo/consul/bookinfo.yaml  down
docker-compose -f install/consul/istio.yaml down
