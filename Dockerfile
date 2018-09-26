FROM kolla/centos-binary-barbican-api:master

USER barbican

COPY barbican.conf /etc/barbican/barbican.conf
COPY barbican-api-paste.ini /etc/barbican/barbican-api-paste.ini

USER root

COPY wsgi-barbican.conf /etc/httpd/conf.d/wsgi-barbican.conf
RUN sed -i 's/#Listen 80/Listen 0.0.0.0:9311/' /etc/httpd/conf/httpd.conf
