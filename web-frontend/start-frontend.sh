#!/bin/bash

echo "=========================="
echo "stop and remove container"
docker stop brand-frontend-datastore && docker rm brand-frontend-datastore
docker stop brand-frontend && docker rm brand-frontend
echo "[done]"
echo "=========================="

echo "build images"
docker build --tag=brand-frontend-datastore /var/lib/docker/dockerfiles/web-frontend-datastore
docker build --tag=brand-frontend /var/lib/docker/dockerfiles/web-frontend
echo "[done]"
echo "=========================="

echo "run datastore container"
docker run -d -it -v /var/lib/docker/static-volume/brand-frontend:/var/www/ --name brand-frontend-datastore brand-frontend-datastore
echo "{done]"
echo "=========================="

echo "run all app container"
docker run -p 80:80 -d --volumes-from brand-frontend-datastore --name brand-frontend brand-frontend
echo "[done]"
echo "=========================="
