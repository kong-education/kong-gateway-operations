#!/usr/bin/env bash

red=$(tput setaf 1)
normal=$(tput sgr0)

printf "\n${red}Setting up CA, certificate and key for Docker.${normal}"
mkdir -p ~/.docker
cp misc/docker-config.json ~/.docker/config.json
curl -so ~/.docker/ca.pem http://docker:9000/ca.pem
curl -so ~/.docker/cert.pem http://docker:9000/cert.pem
curl -so ~/.docker/key.pem http://docker:9000/key.pem
docker-compose pull &>/dev/null &
printf "\n${red}Docker Setup complete.${normal}\n\n"