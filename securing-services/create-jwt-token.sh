#!/usr/bin/env bash
# 
# usage: JWT_SECRET="silly" mk-jwt-token 
# @WARN: modify the payload and header to your needs.
#  See https://gist.github.com/briceburg/0d6589714862004609daf77f4fc4aac9

main(){
  set -eo pipefail

  [ -n "$JWT_SECRET" ] || die "JWT_SECRET environment variable is not set."

  # number of seconds to expire token. default 1h
  expire_seconds="${JWT_EXPIRATION_IN_SECONDS:-3600}"

  # pass JWT_SECRET_BASE64_ENCODED as true if secret is base64 encoded
  ${JWT_SECRET_BASE64_ENCODED:-false} && \
    JWT_SECRET=$(printf %s "$JWT_SECRET" | base64 --decode)

  header='{
    "alg": "HS256",
  	"typ": "JWT"
  }'

  payload="{
    \"iss\": \"$KEY\",
    \"iat\": $(date +%s),
    \"exp\": $(($(date +%s)+expire_seconds)),
    \"nbf\": $(($(date +%s)-1))
  }"

  header_base64=$(printf %s "$header" | base64_urlencode)
  payload_base64=$(printf %s "$payload" | base64_urlencode)
  signed_content="${header_base64}.${payload_base64}"
  signature=$(printf %s "$signed_content" | openssl dgst -binary -sha256 -hmac "$JWT_SECRET" | base64_urlencode)

  log "generated JWT token. expires in $expire_seconds seconds -->\\n\\n"
  printf '%s' "${signed_content}.${signature}"
  echo ""
  export TOKEN="${signed_content}.${signature}"
}

base64_urlencode() { openssl enc -base64 -A | tr '+/' '-_' | tr -d '='; }
readonly __entry=$(basename "$0")
log(){ echo -e "$__entry: $*" >&2; }
die(){ log "$*"; exit 1; }
main "$@"


# name=$1
# CONSUMER=${name:-Jane}

# HEADER=$(echo -n '{"alg":"RS256","typ":"JWT"}' | openssl base64 | tr -d '=' | tr '/+' '_-' | tr -d '\n')
# PAYLOAD=$(echo -n '{"iss":"'$CONSUMER-issuer'"}' | openssl base64 | tr -d '=' | tr '/+' '_-' | tr -d '\n')
# HEADER_PAYLOAD=$HEADER.$PAYLOAD
# PEM=$(cat ./$CONSUMER.pem)
# SIG=$(openssl dgst -sha256 -sign <(echo -n "${PEM}") <(echo -n "${HEADER_PAYLOAD}") | openssl base64 | tr -d '=' | tr '/+' '_-' | tr -d '\n')
# TOKEN=$HEADER.$PAYLOAD.$SIG
# echo $TOKEN



