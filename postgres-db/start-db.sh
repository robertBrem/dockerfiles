#!/bin/bash

echo "=========================="
echo "stop and remove container"
docker stop pictureservice-datastore && docker rm pictureservice-datastore
docker stop pictureservice-db-datastore && docker rm pictureservice-db-datastore
docker stop pictureservice-db && docker rm pictureservice-db
docker stop pictureservice && docker rm pictureservice
echo "[done]"
echo "=========================="

echo "build images"
docker build --tag=pictureservice-db-datastore /var/lib/docker/dockerfiles/postgres-db-datastore
docker build --tag=pictureservice-db /var/lib/docker/dockerfiles/postgres-db
echo "[done]"
echo "=========================="

echo "run datastore container"
docker run -d -it -v /var/lib/docker/static-volume/pictureservice-db:/var/lib/postgresql/data --name pictureservice-db-datastore pictureservice-db-datastore
echo "{done]"
echo "=========================="

echo "run all app container"
docker run -it -d -e POSTGRES_PASSWORD=postgres -p 5433:5432 --volumes-from pictureservice-db-datastore --name pictureservice-db pictureservice-db
echo "[done]"
echo "=========================="

echo "link container"

echo "[done]"
echo "=========================="

