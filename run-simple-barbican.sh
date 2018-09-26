#!/bin/bash

# This runs a simple barbican container with host networking and as a daemon,
# it doesn't attach any volumes to it.

docker run -d --network=host barbican-minimal:latest httpd -DFOREGROUND
