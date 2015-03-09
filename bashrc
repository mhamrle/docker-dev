DOCKER_GOPATH=$GOPATH
# sourcing the bashrc will override GOPATH
. $HOME/.bashrc
ln -s $GOPATH/src/github.com/monetas $DOCKER_GOPATH/src/github.com/
export GOPATH=$DOCKER_GOPATH
export PS1='\[\033[00m\]\[\033[01;34m\]\w \[\033[01;31m\]DOCKER\[\033[00m\] '
unset DOCKER_GOPATH
