#!/bin/sh -l

echo "image name"
echo "$IMAGENAME"
echo "container name"
echo "$CONTAINERNAME"
echo "restart policy"
echo "$RESTARTPOLICY"

printenv > .env
docker stop "$CONTAINERNAME" || echo "No container running with that name"
docker rm "$CONTAINERNAME" || echo "No container found to remove"
docker build --no-cache -t "$IMAGENAME" .
docker run -d --env-file .env --restart "$RESTARTPOLICY" --name "$CONTAINERNAME" "$IMAGENAME"
yes | docker system prune