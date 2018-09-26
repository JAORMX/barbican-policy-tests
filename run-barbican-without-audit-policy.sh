#!/bin/bash

# This runs a simple barbican container with host networking and as a daemon.
# It takes into use policy-reader.json, which is a policy file that replaces
# the "observer" role, for the "reader". This way, the operations that an
# observer could usually do, are now doable by a reader. And using the observer
# role should now give a 403.

docker run -d --network=host \
    -v $PWD/policy-remove-audit.json:/etc/barbican/policy.json \
    barbican-minimal:latest httpd -DFOREGROUND
