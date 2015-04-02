#!/bin/bash

echo "=========================="
echo "stop and remove container"
docker stop wiki-datastore && docker rm wiki-datastore
docker stop wiki && docker rm wiki
echo "[done]"
echo "=========================="

echo "build images"
docker build --tag=wiki-datastore /var/lib/docker/dockerfiles/dokuwiki-datastore
docker build --tag=wiki /var/lib/docker/dockerfiles/dokuwiki
echo "[done]"
echo "=========================="

echo "run datastore container"
docker run -it -d \
-v /var/lib/docker/static-volume/wiki-pages:/dokuwiki/data/pages \
-v /var/lib/docker/static-volume/wiki-meta:/dokuwiki/data/meta \
-v /var/lib/docker/static-volume/wiki-media:/dokuwiki/data/media \
-v /var/lib/docker/static-volume/wiki-media_attic:/dokuwiki/data/media_attic \
-v /var/lib/docker/static-volume/wiki-media_meta:/dokuwiki/data/media_meta \
-v /var/lib/docker/static-volume/wiki-attic:/dokuwiki/data/attic \
-v /var/lib/docker/static-volume/wiki-conf:/dokuwiki/conf \
-v /var/lib/docker/static-volume/wiki-log:/var/log \
--name wiki-datastore wiki-datastore
echo "{done]"
echo "=========================="

echo "run all app container"
docker run -d -p 8091:80 --volumes-from wiki-datastore --name wiki wiki
echo "[done]"
echo "=========================="
