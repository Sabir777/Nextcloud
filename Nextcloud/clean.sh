#!/bin/bash

docker volume ls -q | while read vol; do
  if ! docker ps -a --filter volume="$vol" --format '{{.ID}}' | grep -q .; then
    docker volume rm "$vol"
  fi
done
