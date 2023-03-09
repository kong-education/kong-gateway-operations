#!/usr/bin/env bash

DOCKERCOMPOSEFILE="/home/ubuntu/kong-gateway-operations/installation/docker-compose.yaml"

yq -i '.services.kong-cp.environment.KONG_VITALS_STRATEGY = "prometheus"' $DOCKERCOMPOSEFILE
yq -i '.services.kong-cp.environment.KONG_VITALS_STATSD_ADDRESS = "statsd:9125"' $DOCKERCOMPOSEFILE
yq -i '.services.kong-cp.environment.KONG_VITALS_TSDB_ADDRESS = "prometheus:9090"' $DOCKERCOMPOSEFILE

yq -i '.services.kong-dp.environment.KONG_VITALS_STRATEGY = "prometheus"' $DOCKERCOMPOSEFILE
yq -i '.services.kong-dp.environment.KONG_VITALS_STATSD_ADDRESS = "statsd:9125"' $DOCKERCOMPOSEFILE
yq -i '.services.kong-dp.environment.KONG_VITALS_TSDB_ADDRESS = "prometheus:9090"' $DOCKERCOMPOSEFILE
