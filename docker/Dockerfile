FROM ubuntu:14.04

# update & upgrade
RUN apt-get update && apt-get upgrade -y

# git
RUN apt-get install -y git

# build tool
RUN apt-get install -y build-essential gfortran

# python
RUN apt-get install -y python-setuptools
RUN apt-get install -y python-pip
RUN apt-get install -y python-dev
RUN apt-get install -y python-numpy
RUN apt-get install -y python-scipy
RUN apt-get install -y python-matplotlib
RUN apt-get install -y python-pandas 
RUN apt-get install -y python-sympy 
RUN apt-get install -y ipython
RUN apt-get install -y ipython-notebook
# chainer
RUN pip install chainer
# scikit-learn
RUN pip install scikit-learn

# pip update all
RUN pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip install -U

# clean
RUN apt-get clean
