#!/bin/bash

echo "=========================="
echo "stop and remove container"
docker stop openpixxfrontend-datastore && docker rm openpixxfrontend-datastore
docker stop openpixxfrontend && docker rm openpixxfrontend
echo "[done]"
echo "=========================="

echo "build images"
docker build --tag=openpixxfrontend-datastore /var/lib/docker/dockerfiles/node-datastore
docker build --tag=openpixxfrontend /var/lib/docker/dockerfiles/node
echo "[done]"
echo "=========================="

echo "run datastore container"
docker run -d -it -v /var/lib/docker/static-volume/openpixxfrontend:/usr/src/app --name openpixxfrontend-datastore openpixxfrontend-datastore
echo "{done]"
echo "=========================="

echo "run all app container"
docker run -p 8001:8000 -id --volumes-from openpixxfrontend-datastore --name openpixxfrontend openpixxfrontend
echo "[done]"
echo "=========================="
