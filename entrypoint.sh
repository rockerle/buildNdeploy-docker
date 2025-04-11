#!/bin/sh -l

echo "image name"
echo "${{INPUTS.IMAGENAME}}"
echo "container name"
echo "${{INPUTS.CONTAINERNAME}}"
echo "restart policy"
echo "${{INPUTS.RESTARTPOLICY}}"

printenv > .env
docker stop "$INPUT_CONTAINERNAME" || echo "No container running with that name"
docker rm "$INPUT_CONTAINERNAME" || echo "No container found to remove"
docker build --no-cache -t "$INPUT_IMAGENAME" .
docker run -d --env-file .env --restart "$INPUT_RESTARTPOLICY" --name "$INPUT_CONTAINERNAME" "$INPUT_IMAGENAME"
yes | docker system prune