#!/bin/bash

kubectl apply -f ../scripts/samples/bookinfo/consul/route-rule-all-v1.yaml
echo "Ready to create and view routerulev2"
read -n 1 -s -r -p "Press any key to continue"
kubectl apply -f ../scripts/samples/bookinfo/consul/route-rule-reviews-test-v2.yaml 
echo "RouteRulev2 ###########################
#############################################
#############################################"
cat ../scripts/samples/bookinfo/consul/route-rule-reviews-test-v2.yaml 

echo "Ready to create and view 2 second latency"
read -n 1 -s -r -p "Press any key to continue"
kubectl apply -f ../scripts/samples/bookinfo/consul/route-rule-ratings-test-2sec-delay.yaml
echo "Ratings httpFault #####################
#############################################
#############################################"
cat ../scripts/samples/bookinfo/consul/route-rule-ratings-test-2sec-delay.yaml

echo "Ready to create and view 7sec latency to ratings backend"
read -n 1 -s -r -p "Press any key to continue"
kubectl apply -f ../scripts/samples/bookinfo/consul/route-rule-ratings-test-delay.yaml 
echo "Ratings httpFault #####################
#############################################
#############################################"
cat ../scripts/samples/bookinfo/consul/route-rule-ratings-test-delay.yaml 

echo "Ready to cleanup"
read -n 1 -s -r -p "Press any key to continue"
kubectl delete -f ../scripts/samples/bookinfo/consul/route-rule-reviews-test-v2.yaml
kubectl delete -f ../scripts/samples/bookinfo/consul/route-rule-all-v1.yaml
kubectl delete -f ../scripts/samples/bookinfo/consul/route-rule-ratings-test-delay.yaml 
kubectl delete -f ./consul_1secreviews.yaml
