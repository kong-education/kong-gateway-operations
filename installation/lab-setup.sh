#!/usr/bin/env bash

sudo setfacl -m user:ubuntu:rw /var/run/docker.sock

red=$(tput setaf 1)
normal=$(tput sgr0)

source /home/ubuntu/.bashrc
export DYNAMIC_FQDN=$(echo $STRIGO_RESOURCE_DNS)
export KONG_ADMIN_API_URI=http://$DYNAMIC_FQDN:8001
export KONG_ADMIN_GUI_URL=http://$DYNAMIC_FQDN:8002
export KONG_PORTAL_GUI_HOST=$DYNAMIC_FQDN:8003
export KONG_PORTAL_API_URL=http://$DYNAMIC_FQDN:8004
export KONG_LICENSE_DATA=$(cat /usr/local/kong/license.json)

printf "\n${red}Bringing up Kong Gateway.${normal}\n"

cd ~/kong-gateway-operations/installation
docker-compose up -d

printf "\n${red}Waiting for Gateway startup to finish.${normal}"

until curl --head localhost:8001 > /dev/null 2>&1; do sleep 1; done

printf "\n${red}Applying Enterprise License.${normal}\n"
http --headers POST "localhost:8001/licenses" payload=@/usr/local/kong/license.json | grep HTTP

printf "\n${red}Recreating Contral Plane.${normal}\n"
docker-compose stop kong-cp; docker-compose rm -f kong-cp; docker-compose up -d kong-cp
# sleep 8
until curl --head localhost:8001 > /dev/null 2>&1; do sleep 1; done

printf "\n${red}Checking Admin API.${normal}\n"
curl -IsX GET localhost:8001 | grep Server

# printf "\n${red}Enabling the Developer Portal.${normal}\n"
# curl -siX PATCH localhost:8001/workspaces/default -d "config.portal=true" | grep HTTP

printf "\n${red}Configuring decK.${normal}\n"
sed -i "s|KONG_ADMIN_API_URI|$KONG_ADMIN_API_URI|g" ~/kong-gateway-operations/installation/deck/deck.yaml
cp ~/kong-gateway-operations/installation/deck/deck.yaml ~/.deck.yaml
deck ping

# printf "\n${red}Copying the script to user path.${normal}\n"
# if [ ! -f "~/.local/bin/scram.sh" ]
# then
#   mkdir -p ~/.local/bin
#   cp ~/kong-gateway-operations/installation/reset-lab.sh ~/.local/bin/
#   source ~/.profile
# fi

# printf "\n${red}Displaying Gateway URIs${normal}\n"
# env | grep KONG | sort
printf "\n${red}Completed Setting up Kong Gateway Operations Lab Envrinment.${normal}\n\n"

echo "Kong Manager can be access on $KONG_ADMIN_GUI_URL"
