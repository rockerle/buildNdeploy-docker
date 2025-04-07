#!/bin/sh -l

printenv > .env

docker stop "$containername"
docker rm "$containername"

docker build --no-cache -t "$imagename" .
docker run -d --env-file .env --restart "$restartpolicy" --name "$containername"

yes | docker system prune