#!/bin/sh -l

printenv > .env
echo "checking Java version"
java -version
docker stop "$INPUT_CONTAINERNAME" || echo "No container running with that name"
docker rm "$INPUT_CONTAINERNAME" || echo "No container found to remove"

docker build --no-cache -t "$INPUT_IMAGENAME" .

env_args=""
if [ -n "$INPUT_ENV" ]; then
    echo "Processing environment variables..."
    while IFS= read -r line; do
        trimmed_line=$(echo "$line" | xargs)
        if [ -n "$trimmed_line" ]; then
            env_args="$env_args -e $trimmed_line "
        fi
    done <<EOF
$INPUT_ENV
EOF
    echo "Environment arguments: $env_args"
fi

label_args=""
if [ -n "$INPUT_LABEL" ]; then
	while IFS= read -r line; do
		trimmed_line=$(echo "$line" | xargs)
		if [ -n "$trimmed_line" ]; then
			label_args="$label_args --label $trimmed_line"
		fi
	done <<EOF
	$INPUT_LABEL
EOF
fi
echo "$label_args"

network_args=""
if [ -n "$INPUT_DNETWORK" ]; then
	network_args=" --network=$INPUT_DNETWORK"
fi
docker run -d $env_args --restart "$INPUT_RESTARTPOLICY" $network_args $label_args --name "$INPUT_CONTAINERNAME" "$INPUT_IMAGENAME"
yes | docker system prune