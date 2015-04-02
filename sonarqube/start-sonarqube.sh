#!/bin/bash

echo "=========================="
echo "stop and remove container"
docker stop sonarqube-datastore && docker rm sonarqube-datastore
docker stop sonarqube && docker rm sonarqube
echo "[done]"
echo "=========================="

echo "build images"
docker build --tag=sonarqube-datastore /var/lib/docker/dockerfiles/sonarqube-datastore
docker build --tag=sonarqube /var/lib/docker/dockerfiles/sonarqube
echo "[done]"
echo "=========================="

echo "run datastore container"
docker run -d -it \
-v /var/lib/docker/static-volume/sonarqube-mysql-config:/etc/mysql \
-v /var/lib/docker/static-volume/sonarqube-mysql-data:/var/lib/mysql \
-v /var/lib/docker/static-volume/sonarqube-extensions:/opt/sonar/extensions \
--name sonarqube-datastore sonarqube-datastore
echo "{done]"
echo "=========================="

echo "run all app container"
docker run -d -it -p 8093:9000 -p 3306:3306 --volumes-from sonarqube-datastore --name sonarqube sonarqube
echo "[done]"
echo "=========================="
