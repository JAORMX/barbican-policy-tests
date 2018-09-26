#!/bin/bash
ROLE=$1
curl -X POST -H 'X-Project-Id: 1234' -H 'Content-Type: application/json' \
    -H "X-Roles: $ROLE" \
    -d '{"name": "mySecrete", "payload": "mySecretPayload", "payload_content_type": "text/plain"}' \
    http://localhost:9311/v1/secrets | python -m json.tool
