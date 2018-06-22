#!/bin/bash

docker-compose -f samples/bookinfo/eureka/bookinfo.sidecars.yaml  down
docker-compose -f samples/bookinfo/eureka/bookinfo.yaml  down
docker-compose -f install/eureka/istio.yaml down
