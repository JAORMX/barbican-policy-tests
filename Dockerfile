FROM kolla/centos-binary-barbican-api:master

USER barbican

COPY conf/barbican.conf /etc/barbican/barbican.conf
COPY conf/barbican-api-paste.ini /etc/barbican/barbican-api-paste.ini

USER root

COPY conf/wsgi-barbican.conf /etc/httpd/conf.d/wsgi-barbican.conf
RUN sed -i 's/#Listen 80/Listen localhost:9311/' /etc/httpd/conf/httpd.conf
