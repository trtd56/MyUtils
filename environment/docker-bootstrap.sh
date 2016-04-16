#!/bin/bash

sudo apt-get install -y docker.io vim-syntax-docker
source /etc/bash_completion.d/docker

sudo gpasswd -a $USER docker
