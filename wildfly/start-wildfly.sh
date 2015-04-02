#!/bin/bash

echo "=========================="
echo "stop and remove container"
docker stop brandservice-datastore && docker rm brandservice-datastore
docker stop brandservice-db-datastore && docker rm brandservice-db-datastore
docker stop brandservice-db && docker rm brandservice-db
docker stop brandservice && docker rm brandservice
echo "[done]"
echo "=========================="

echo "build images"
docker build --tag=brandservice-datastore /var/lib/docker/dockerfiles/wildfly-datastore
docker build --tag=brandservice-db-datastore /var/lib/docker/dockerfiles/postgres-db-datastore
docker build --tag=brandservice-db /var/lib/docker/dockerfiles/postgres-db
docker build --tag=brandservice /var/lib/docker/dockerfiles/wildfly
echo "[done]"
echo "=========================="

echo "run datastore container"
docker run -d -it -v /var/lib/docker/static-volume/brandservice-configuration:/opt/jboss/wildfly/standalone/configuration -v /var/lib/docker/static-volume/brandservice-deployment:/opt/jboss/wildfly/standalone/deployments -v /var/lib/docker/static-volume/brandservice-modules:/opt/jboss/wildfly/modules --name brandservice-datastore brandservice-datastore
docker run -d -it -v /var/lib/docker/static-volume/brandservice-db:/var/lib/postgresql/data --name brandservice-db-datastore brandservice-db-datastore
echo "{done]"
echo "=========================="

echo "run all app container"
docker run -it -d -e POSTGRES_PASSWORD=postgres --volumes-from brandservice-db-datastore --name brandservice-db brandservice-db
echo "[done]"
echo "=========================="

echo "link container"
docker run -p 8080:8080 -p 9990:9990 -d --volumes-from brandservice-datastore --name brandservice --link brandservice-db:brandservice-db brandservice
echo "[done]"
echo "=========================="

