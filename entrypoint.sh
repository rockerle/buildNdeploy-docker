#!/bin/sh -l

printenv > .env

docker stop $(container-name)
docker rm $(container-name)

docker build --no-cache -t $(image-name) .
docker run -d --env-file .env --restart $(restart-policy) --name $(container-name)

yes | docker system prune