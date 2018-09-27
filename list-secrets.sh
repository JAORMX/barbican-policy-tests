#!/bin/bash
ROLE=$1
PROJECT=${2:-'1234'}
curl -X GET -H "X-Project-Id: $PROJECT" \
    -H "X-Roles: $ROLE" \
    http://localhost:9311/v1/secrets | python -m json.tool
