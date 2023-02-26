#!/usr/bin/env bash


yq -i '.services.kong-cp.environment.KONG_VITALS_STRATEGY = "prometheus"' docker-compose.yaml
yq -i '.services.kong-cp.environment.KONG_VITALS_STATSD_ADDRESS = "statsd:9125"' docker-compose.yaml
yq -i '.services.kong-cp.environment.KONG_VITALS_TSDB_ADDRESS = "prometheus:9090"' docker-compose.yaml

yq -i '.services.kong-dp.environment.KONG_VITALS_STRATEGY = "prometheus"' docker-compose.yaml
yq -i '.services.kong-dp.environment.KONG_VITALS_STATSD_ADDRESS = "statsd:9125"' docker-compose.yaml
yq -i '.services.kong-dp.environment.KONG_VITALS_TSDB_ADDRESS = "prometheus:9090"' docker-compose.yaml