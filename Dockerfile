FROM monetas/golang-base:latest

MAINTAINER Filip Gospodinov "filip@monetas.net"

RUN apt-get update && \
    apt-get install -y --no-install-recommends openssh-server git tig && \
    apt-get autoremove && \
    go get -u github.com/davecgh/go-spew/spew
ENV GOPATH_MOUNTED /opt/go_mounted
CMD service ssh start && \
    sh /opt/run_services.sh && \
    cd $GOPATH_MOUNTED/src/github.com/monetas/gotary/Dockerfiles/ && sh install.sh && \
    locale-gen de_CH.UTF-8 && \
    mkdir $HOME/.ssh && \
    cp /home/dev/.ssh/id_rsa.pub $HOME/.ssh/authorized_keys && \
    uid=$(ls -ldn $GOPATH_MOUNTED/src/github.com/monetas/ | awk '{print $3}') && \
    useradd -d /home/dev -M -u $uid -s /bin/bash dev && \
    install /home/dev/.bashrc /opt/bashrc && \
    echo "export GOPATH=$GOPATH_MOUNTED:$GOPATH GOROOT=$GOROOT PATH=$PATH PS1='\[\033[00m\]\[\033[01;34m\]\w \[\033[01;31m\]DOCKER\[\033[00m\] '" >> /opt/bashrc && \
    echo "cd $GOPATH_MOUNTED/src/github.com/monetas/gotary" >> /opt/bashrc && \
    sudo -i -u dev bash --rcfile /opt/bashrc
