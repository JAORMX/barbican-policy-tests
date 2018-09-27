#!/bin/bash
ROLE=$1
PROJECT=${2:-'1234'}
curl -X POST -H "X-Project-Id: $PROJECT" -H 'Content-Type: application/json' \
    -H "X-Roles: $ROLE" \
    -d '{"name": "mySecrete", "payload": "mySecretPayload", "payload_content_type": "text/plain"}' \
    http://localhost:9311/v1/secrets | python -m json.tool
