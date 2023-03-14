#!/bin/bash

# Copy Elk Config into shared volume with DinD
# cp -R elk /srv/shared

# Put license into a envionment variable so it is loaded by the docker compose
export KONG_LICENSE=$(cat /usr/local/kong/license.json)


echo "Preloading images into docker, this will take aproximatly three minutes"

# Load Images into docker
docker load -qi docker_images.tar

echo "Image load complete"

# Launch docker compose cluster in background
docker-compose -f docker-compose.yaml up -d 

