#!/bin/bash

export DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)
docker compose up -d
