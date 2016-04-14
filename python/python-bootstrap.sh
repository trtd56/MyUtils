#!/bin/bash

sudo apt-get -y update 
sudo apt-get -y upgrade 
sudo apt-get install -y build-essential

sudo apt-get -y install python-setuptools python-pip python-dev

sudo pip install --upgrade pip

sudo apt-get install -y python-setuptools \
python-pip \
python-dev \
python-numpy \
python-scipy \
python-matplotlib \
python-pandas \
python-sympy \
ipython \
ipython-notebook \

sudo pip install virtualenv
sudo pip install scikit-learn 
sudo pip install chainer 
sudo pip install notebook

mkdir ~/venv
cd ~/venv
virtualenv --system-site-packages env27
