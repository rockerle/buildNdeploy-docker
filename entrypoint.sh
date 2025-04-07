#!/bin/sh -l

printenv > .env

docker stop "$CONTAINERNAME"
docker rm "$CONTAINERNAME"

docker build --no-cache -t "$IMAGENAME" .
docker run -d --env-file .env --restart "$RESTARTPOLICY" --name "$CONTAINERNAME"

yes | docker system prune