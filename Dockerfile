FROM monetas/golang-base:1

MAINTAINER Filip Gospodinov "filip@monetas.net"

RUN apt-get update && \
    apt-get install -y --no-install-recommends vim-gtk git tig && \
    apt-get autoremove

ADD bashrc /opt/
ENTRYPOINT ["bash", "--rcfile", "/opt/bashrc"]
