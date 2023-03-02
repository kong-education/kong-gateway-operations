#!/bin/bash

name=$1
CONSUMER=${name:-Jane}

HEADER=$(echo -n '{"alg":"RS256","typ":"JWT"}' | openssl base64 | tr -d '=' | tr '/+' '_-' | tr -d '\n')
PAYLOAD=$(echo -n '{"iss":"'$CONSUMER-issuer'"}' | openssl base64 | tr -d '=' | tr '/+' '_-' | tr -d '\n')
HEADER_PAYLOAD=$HEADER.$PAYLOAD
PEM=$(cat ./$CONSUMER.pem)
SIG=$(openssl dgst -sha256 -sign <(echo -n "${PEM}") <(echo -n "${HEADER_PAYLOAD}") | openssl base64 | tr -d '=' | tr '/+' '_-' | tr -d '\n')
TOKEN=$HEADER.$PAYLOAD.$SIG
echo $TOKEN

