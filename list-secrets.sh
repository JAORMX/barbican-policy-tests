#!/bin/bash
ROLE=$1
curl -X GET -H 'X-Project-Id: 1234' \
    -H "X-Roles: $ROLE" \
    http://localhost:9311/v1/secrets | python -m json.tool
