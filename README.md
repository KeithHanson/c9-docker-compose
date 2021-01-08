# Docker Composerized Headless Miner for Nine Chronicles

Nine Chronicles is an idle game created that runs on a blockchain based platform for multiplayer activities like PvP and Market activity.

It uses the in-game currency as a way to incentivize miners. 

This repository is an attempt to make it simpler for miners to run multiple containers, tweak options, and pull logs.

## This is for Linux currently.

This is currently built for folks running Linux. 

If someone would like to help me in maintaining a Windows version, I would appreciate the support.

# Setup

1. Install Docker.
1. Install Docker Compose.
1. Git clone this repository
1. Copy the .env.example to .env and fill in your details
1. Open a terminal to where you cloned this repository
1. Run: `./refresh-snapshot.sh`
1. Run: `docker-compose up -d`

# Monitoring

- See the full log: `docker-compose logs --tail=100 -f`
- Watch for mined blocks: `docker-compose logs --tail=100 -f | grep -A 10 --color -i 'Mined a block'` 
