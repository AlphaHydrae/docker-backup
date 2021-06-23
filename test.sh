#!/usr/bin/env bash
set -e

for dockerfile in Dockerfile*; do
  docker_tag="alphahydrae/backup$(echo $dockerfile|sed 's/^Dockerfile//'|sed 's/^\./:/')-test"
  printf "\nBuilding ${docker_tag}...\n"
  docker build -f $dockerfile -t "$docker_tag" .
done

echo
