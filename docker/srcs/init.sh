#!/bin/sh

## Start building docker image
echo "Start building docker image"
docker build -t vault_server:0.0.1 .

echo "Running docker image"
docker run -it -p 8200:8080 -p 8201:8081 vault_server:0.0.1
