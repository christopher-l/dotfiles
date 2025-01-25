#!/usr/bin/env fish

echo "Pruning docker..."
ssh vortex docker system prune --all --volumes --force; or return

set services miniflux hedgedoc paperless-ngx nocodb

for service in $services
    echo ""
    echo "Entering $service"
    echo "Creating backup..."
    ssh vortex "cd docker/$service; ./backup.sh"; or return
    echo "Pulling images..."
    ssh vortex "cd docker/$service; docker compose pull"; or return
    echo "Updating service..."
    ssh vortex "cd docker/$service; docker compose up -d"; or return
    echo "done"
end