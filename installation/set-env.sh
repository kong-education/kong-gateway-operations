#!/bin/bash

source ~/.bashrc
export PUBLICIP=$(curl -s http://checkip.amazonaws.com)
export KONG_ADMIN_API_URI=http://$STRIGO_RESOURCE_DNS:8001
export KONG_ADMIN_GUI_URL=http://$STRIGO_RESOURCE_DNS:8002
export KONG_PORTAL_GUI_HOST=$STRIGO_RESOURCE_DNS:8003
export KONG_PORTAL_API_URL=http://$STRIGO_RESOURCE_DNS:8004
export KONG_LICENSE_DATA=$(cat /usr/local/kong/license.json)
export PROMETHEUS_URI=http://$STRIGO_RESOURCE_DNS:9090
export GRAFANA_URI=http://$STRIGO_RESOURCE_DNS:3000
export KONG_LICENSE_DATA=$(cat /usr/local/kong/license.json)
export KONG_PROXY_URI=http://$STRIGO_RESOURCE_DNS:8000