#!/bin/bash
#docker run --network=host -v /home/josorior/barbican-container-test/barbican.conf:/etc/barbican/barbican.conf -v /home/josorior/barbican-container-test/barbican-api-paste.ini:/etc/barbican/barbican-api-paste.ini  kolla/centos-binary-barbican-api:7.0.0 barbican-wsgi-api --port 9311 --host localhost
docker run -d --network=host barbican-minimal:latest httpd -DFOREGROUND
