#!/bin/bash

echo "=========================="
echo "stop and remove container"
docker stop swagger-datastore && docker rm swagger-datastore
docker stop swagger && docker rm swagger
echo "[done]"
echo "=========================="

echo "build images"
docker build --tag=swagger-datastore /var/lib/docker/dockerfiles/swagger-datastore
docker build --tag=swagger /var/lib/docker/dockerfiles/swagger
echo "[done]"
echo "=========================="

echo "run datastore container"
docker run -d -it -v /var/lib/docker/static-volume/swagger:/swagger --name swagger-datastore swagger-datastore
echo "{done]"
echo "=========================="

echo "run all app container"
docker run -d -p 8092:80 --volumes-from swagger-datastore --name swagger swagger
echo "[done]"
echo "=========================="
