#!/bin/bash

echo "Stopping and removing containers, networks, and volumes..."
docker-compose down -v

# List all volumes for the current project
echo "Listing all volumes..."
volumes=$(docker volume ls -q -f "name=$(basename "$(pwd)")")

if [ -n "$volumes" ]; then
    echo "Removing the following volumes:"
    echo "$volumes"
    # Remove the listed volumes
    echo "$volumes" | xargs -r docker volume rm
else
    echo "No volumes to remove."
fi

echo "Rebuilding the containers without using the cache..."
docker-compose build --no-cache

echo "Starting the containers in detached mode..."
docker-compose up -d

# Wait for the Kong container to be healthy
echo "Waiting for the Kong container to be healthy..."
until [ "$(docker inspect -f {{.State.Health.Status}} $(docker-compose ps -q kong))" == "healthy" ]; do
    sleep 1;
    echo "Waiting for Kong to be healthy..."
done

# Replace 'notice' with 'debug' in nginx-kong.conf
echo "Modifying nginx-kong.conf in the Kong container..."
container_id=$(docker-compose ps -q kong)
echo "Container ID: $container_id"
docker exec --user root $container_id sed -i 's/notice/debug/g' /usr/local/kong/nginx-kong.conf

# Optionally, you might need to reload or restart Kong to apply the changes
docker exec $container_id kong reload

echo "Done."