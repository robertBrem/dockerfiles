#!/bin/bash

echo "=========================="
echo "stop and remove container"
docker stop keycloak && docker rm keycloak
docker stop keycloak-datastore && docker rm keycloak-datastore
echo "[done]"
echo "=========================="

echo "build images"
docker build --tag=keycloak /var/lib/docker/dockerfiles/keycloak
docker build --tag=keycloak-datastore /var/lib/docker/dockerfiles/keycloak-datastore
echo "[done]"
echo "=========================="

echo "run datastore container"
docker run -d -it -v /var/lib/docker/static-volume/keycloak-data:/opt/jboss/wildfly/standalone/data -v /var/lib/docker/static-volume/keycloak-configuration:/opt/jboss/wildfly/standalone/configuration -v /var/lib/docker/static-volume/keycloak-deployment:/opt/jboss/wildfly/standalone/deployments --name keycloak-datastore keycloak-datastore 
echo "{done]"
echo "=========================="

echo "run all app container"
docker run -it -p 8090:8080 -p 9980:9990 -p 8443:8443 -d --volumes-from keycloak-datastore --name keycloak keycloak
echo "[done]"
echo "=========================="

