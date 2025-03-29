#!/usr/bin/env bash

set -e

echo "Pruning docker..."
docker system prune --all --volumes --force

services=(
    miniflux
    hedgedoc
    paperless-ngx
)

for service in "${services[@]}"; do
    echo ""
    echo "Entering $service"
    (
        cd docker/$service
        echo "Creating backup..."
        ./backup.sh
        echo "Pulling images..."
        docker compose pull
        echo "Updating service..."
        docker compose up -d
    )
    echo "done"
done