#Docker build and test environment#

This document describes how to create a development environment
**outside** a docker container with your `$HOME` and `src/github.com/monetas`
folder mounted inside the docker container. Also, the Go dependencies
from the container will be put into your host's `$GOPATH` using `sshfs`.
The benefit is that when using `tmux` one can use the host's editor
natively in one tab while having a docker container running in the
second tab that allows to run `go test` and friends with the
correct dependencies.

##Usage##

1. fork this repo and clone your fork locally
2. edit the `Dockerfile`
  * for non-`bash` users: find out how to wrap your shell's init file
    and make sure that the $GOPATH is indeed `/opt/go/`.
1. create an image with `docker build -t $SOME_TAGNAME .`
1. log into build and test environment with

    ```bash
        docker run -it -p 2222:22 -e TERM=$TERM -v $GOPATH/src/github.com/monetas:/opt/go/src/github.com/monetas -v $HOME:/home/dev $SOME_TAGNAME
    ```
  * users that need X will do

    ```bash
        docker run -it -p 2222:22 -e TERM=$TERM -e DISPLAY=$DISPLAY -v $GOPATH/src/github.com/monetas:/opt/go/src/github.com/monetas -v $HOME:/home/dev $SOME_TAGNAME
    ```
1. mount dependecies and include them into your `$GOPATH`
```bash
    sshfs -o cache=no -p 2222 root@localhost:/opt/go $HOME/go_sshfs
    export GOPATH=$HOME/go_sshfs:$GOPATH
```
1. create an alias for the `docker run` command that suits your needs
1. commit changes and push to your fork on GitHub
  * this is useful to inspire other developers with your setup
  * and it's a free backup of your environment
