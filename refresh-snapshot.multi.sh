#!/bin/bash
source .env
echo $SNAPSHOT_URL

echo " ->Creating a clean environment (delete/start/stop containers)"
docker-compose -f docker-compose.multi.yml down -v
docker-compose -f docker-compose.multi.yml up -d
docker-compose -f docker-compose.multi.yml stop

echo " ->Deleting snapshot data..."
rm -rf latest-snapshot/*

echo " ->Downloading latest snapshot"
curl -O $SNAPSHOT_URL

echo " ->Moving zip file"
mv 9c-main-snapshot.zip latest-snapshot/9c-main-snapshot.zip

echo " ->Unzipping snapshot and removing zip"
cd latest-snapshot
unzip 9c-main-snapshot.zip
rm 9c-main-snapshot.zip

echo " ->Copying snapshot data"

MOUNT_LOCATION=$(docker volume inspect --format '{{ .Mountpoint }}' c9dockercompose_9c-miner1)

echo " -> Copying to: $MOUNT_LOCATION"
sudo cp -r ./* $MOUNT_LOCATION

MOUNT_LOCATION=$(docker volume inspect --format '{{ .Mountpoint }}' c9dockercompose_9c-miner2)

echo " -> Copying to: $MOUNT_LOCATION"
sudo cp -r ./* $MOUNT_LOCATION

MOUNT_LOCATION=$(docker volume inspect --format '{{ .Mountpoint }}' c9dockercompose_9c-miner3)

echo " -> Copying to: $MOUNT_LOCATION"
sudo cp -r ./* $MOUNT_LOCATION

MOUNT_LOCATION=$(docker volume inspect --format '{{ .Mountpoint }}' c9dockercompose_9c-miner4)

echo " -> Copying to: $MOUNT_LOCATION"
sudo cp -r ./* $MOUNT_LOCATION

MOUNT_LOCATION=$(docker volume inspect --format '{{ .Mountpoint }}' c9dockercompose_9c-miner5)

echo " -> Copying to: $MOUNT_LOCATION"
sudo cp -r ./* $MOUNT_LOCATION

MOUNT_LOCATION=$(docker volume inspect --format '{{ .Mountpoint }}' c9dockercompose_9c-miner6)

echo " -> Copying to: $MOUNT_LOCATION"
sudo cp -r ./* $MOUNT_LOCATION

echo "->Refresh complete."

echo "====================================================="
echo "->To begin mining, run: docker-compose -f docker-compose.multi.yml up -d"
echo "->To monitor for mined blocks, run:"
echo "->docker-compose -f docker-compose.multi.yml logs --tail=1 -f | grep -A 10 --color -i 'Mined a block'"
echo " " 
echo "->To monitor ALL log messages:"
echo "->docker-compose -f docker-compose.multi.yml logs --tail=1 -f"
echo " "
echo "->To monitor a single miner:"
echo "->docker-compose -f docker-compose.multi.yml logs --tail=1 -f 9c-miner1"
echo "====================================================="
