#!/bin/bash

docker-compose -f install/eureka/istio.yaml up -d
./bin/istioctl context-create --api-server http://localhost:8080
docker-compose -f samples/bookinfo/eureka/bookinfo.yaml up -d
docker-compose -f samples/bookinfo/eureka/bookinfo.sidecars.yaml up -d
