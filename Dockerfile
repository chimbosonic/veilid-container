FROM registry.fedoraproject.org/fedora-minimal:latest

COPY config/default-veilid-server.conf default-veilid-server.conf
COPY config/veilid-rpm-repo.repo /etc/yum.repos.d/veilid-rpm-repo.repo
COPY entrypoint.sh /usr/bin/entrypoint.sh

RUN chmod +x /usr/bin/entrypoint.sh \
&& microdnf install -y veilid-server veilid-cli tini \
&& microdnf clean all \
&& rm -rf /etc/veilid-server/*

VOLUME /etc/veilid-server
VOLUME /var/db/veilid-server

EXPOSE 5150/tcp

EXPOSE 5150/udp

EXPOSE 5959/tcp

ENTRYPOINT ["/usr/bin/tini","--","/usr/bin/entrypoint.sh"]