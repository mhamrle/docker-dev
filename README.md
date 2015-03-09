#Docker development environment#

This document describes how to create an development environment
inside a docker container with your `$HOME` folder mounted as the
`$HOME` folder inside the docker container.

##Usage##

1. fork this repo and clone your fork locally
2. edit the `Dockerfile`
  * for non-`bash` users: find out how to wrap your shell's init file
    and make sure that the mounted `notary` repo is symlinked into
    Docker's `$GOPATH` and that the $GOPATH is indeed `/opt/go/`.
1. create image with `docker build -t $SOME_TAGNAME .`
1. log into development environment with

    ```bash
        docker run -it -e TERM=$TERM -v $HOME:/root $SOME_TAGNAME
    ```
  * users that need X will do

    ```bash
        docker run -it -e TERM=$TERM -e DISPLAY=$DISPLAY -v $HOME:/root $SOME_TAGNAME
    ```
1. create an alias for the `docker run` command that suits your needs
1. commit changes and push to your fork on GitHub
  * this is useful to inspire other developers with your setup
  * and it's a free backup of your environment

##Note##

The user inside the docker container is `root`. This can easily be changed
by editing the `Dockerfile` if you prefer to work as an unprivileged user.
