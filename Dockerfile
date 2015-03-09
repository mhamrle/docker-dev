FROM monetas/golang-base:1

MAINTAINER Filip Gospodinov "filip@monetas.net"

RUN apt-get update && \
    apt-get install -y --no-install-recommends vim-gtk git tig && \
    apt-get autoremove

CMD uid=$(ls -ldn $GOPATH/src/github.com/monetas/ | awk '{print $3}') && \
    useradd -d /home/dev -M -u $uid -s /bin/bash dev && \
    install /home/dev/.bashrc /opt/bashrc && \
    echo "export GOPATH=$GOPATH GOROOT=$GOROOT PATH=$PATH PS1='\[\033[00m\]\[\033[01;34m\]\w \[\033[01;31m\]DOCKER\[\033[00m\] '" >> /opt/bashrc && \
    sudo -i -u dev bash --rcfile /opt/bashrc
