#!/bin/bash

echo " ->Creating a clean environment (delete/start/stop containers)"
docker-compose down -v
docker-compose up -d
docker-compose stop

echo " ->Deleting snapshot data..."
rm -rf latest-snapshot/*

echo " ->Downloading latest snapshot"
curl -O https://download.nine-chronicles.com/latest/9c-main-snapshot.zip

echo " ->Moving zip file"
mv 9c-main-snapshot.zip latest-snapshot/9c-main-snapshot.zip

echo " ->Unzipping snapshot and removing zip"
cd latest-snapshot
unzip 9c-main-snapshot.zip
rm 9c-main-snapshot.zip

echo " ->Copying snapshot data"
sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner1-volume/_data/

sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner2-volume/_data/

sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner3-volume/_data/

sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner4-volume/_data/

sudo cp -r ./* /var/lib/docker/volumes/c9-docker-compose_9c-miner5-volume/_data/

echo "->Refresh complete."

echo "->To begin mining, run: docker-compose up -d"
echo "->To monitor for mined blocks, run:"
echo "->docker-compose logs --tail=1 -f | grep -A 10 --color -i 'Mined a block'"
