#!/bin/sh

docker build --no-cache -t abhitom17/docker-fib-client t abhitom17/docker-fib-client:$GIT_SHA ./client
docker build --no-cache -t abhitom17/docker-fib-server t abhitom17/docker-fib-server:$GIT_SHA ./server
docker build --no-cache -t abhitom17/docker-fib-worker t abhitom17/docker-fib-worker:$GIT_SHA ./worker

docker push abhitom17/docker-fib-client
docker push abhitom17/docker-fib-client:$GIT_SHA
docker push abhitom17/docker-fib-server
docker push abhitom17/docker-fib-server:$GIT_SHA
docker push abhitom17/docker-fib-worker
docker push abhitom17/docker-fib-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set images deployments/client-deployment client=abhitom17/docker-fib-client:$GIT_SHA
kubectl set images deployments/server-deployment server=abhitom17/docker-fib-server:$GIT_SHA
kubectl set images deployments/worker-deployment worker=abhitom17/docker-fib-worker:$GIT_SHA