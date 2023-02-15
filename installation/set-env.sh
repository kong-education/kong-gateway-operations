#!/bin/bash

export PUBLICIP=$(curl -s http://checkip.amazonaws.com)

export DYNAMIC_FQDN=$(echo $STRIGO_RESOURCE_DNS)
export KONG_ADMIN_API_URI=http://$DYNAMIC_FQDN:8001
export KONG_ADMIN_GUI_URL=http://$DYNAMIC_FQDN:8002
export KONG_PORTAL_GUI_HOST=http://$DYNAMIC_FQDN:8003
export KONG_PORTAL_API_URL=http://$DYNAMIC_FQDN:8004

# export KONG_ADMIN_API_URI=http://$PUBLICIP:8001
# export KONG_ADMIN_GUI_URL=http://$PUBLICIP:8002
# export KONG_PORTAL_GUI_HOST=http://$PUBLICIP:8003
# export KONG_PORTAL_API_URL=http://$PUBLICIP:8004




# export KONG_LICENSE_DATA=$(cat /usr/local/kong/license.json)