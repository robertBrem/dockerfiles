#!/bin/bash

echo "=========================="
echo "stop and remove container"
docker stop jenkins-datastore && docker rm jenkins-datastore
docker stop jenkins && docker rm jenkins
echo "[done]"
echo "=========================="

echo "build images"
docker build --tag=jenkins-datastore /var/lib/docker/dockerfiles/jenkins-datastore
docker build --tag=jenkins /var/lib/docker/dockerfiles/jenkins
echo "[done]"
echo "=========================="

echo "run datastore container"
docker run -d -v /var/lib/docker/static-volume/jenkins:/var/jenkins_home --name jenkins-datastore jenkins-datastore
echo "{done]"
echo "=========================="

echo "run all app container"
docker run -d -p 8089:8080 --volumes-from jenkins-datastore --name jenkins jenkins
echo "[done]"
echo "=========================="
