#!/bin/bash

sudo apt-get -y update 
sudo apt-get -y upgrade 
sudo apt-get install -y build-essential \
gfortran \
libsqlite3-dev \
libreadline6-dev \
libgdbm-dev \
zlib1g-dev \
libbz2-dev \
sqlite3 \
tk-dev \
zip \
libssl-dev

sudo apt-get -y install python-setuptools python-pip python-dev

pip install virtualenv

mkdir ~/venv
cd ~/venv

virtualenv env27
source ~/venv/env27/bin/activate 

pip install numpy
pip install scipy
pip install matplotlib
pip install pandas 
pip install sympy
pip install python 
pip install ipython-notebook
pip install scikit-learn 
pip install chainer 

deactivate
