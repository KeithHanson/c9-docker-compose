#!/bin/bash
source .env
echo $SNAPSHOT_URL

echo " ->Creating a clean environment (delete/start/stop containers)"
docker-compose down -v
docker-compose up -d
docker-compose stop

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

# It would be much better to look for the proper volumes and grab the path with inspect
echo " ->Copying snapshot data"
MOUNT_LOCATION=$(docker volume inspect --format '{{ .Mountpoint }}' c9dockercompose_9c-miner1)
sudo cp -r ./* $MOUNT_LOCATION

echo "->Refresh complete."

echo "====================================================="
echo "->To begin mining, run: docker-compose up -d"
echo "->To monitor for mined blocks, run:"
echo "->docker-compose logs --tail=1 -f | grep -A 10 --color -i 'Mined a block'"
echo " " 
echo "->To monitor ALL log messages:"
echo "->docker-compose logs --tail=1 -f"
echo "====================================================="
