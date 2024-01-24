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
docker-compose -f docker-compose.yml up -d

echo "Done."