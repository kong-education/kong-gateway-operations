#!/bin/bash

export PUBLICIP=$(curl -s http://checkip.amazonaws.com)
export KONG_ADMIN_API_URI=http://$PUBLICIP:8001
export KONG_ADMIN_GUI_URL=http://$PUBLICIP:8002

# echo "$(curl -s http://checkip.amazonaws.com)  kongcluster" >> /etc/hosts
