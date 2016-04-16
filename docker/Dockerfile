FROM ubuntu:14.04

RUN apt-get update && apt-get upgrade -y

RUN echo "Asia/Tokyo" > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata
RUN apt-get install language-pack-ja locales
RUN locale-gen ja_JP.UTF-8  
ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8


RUN apt-get install -y git vim tmux
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
RUN pip install chainer
RUN pip install scikit-learn
RUN pip install notebook
RUN pip freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs pip install -U

RUN apt-get clean

####################
### User Setting ###
####################

# Create user
RUN adduser trtd56
RUN echo "trtd56:trtd56" | chpasswd
RUN gpasswd -a trtd56 sudo

# Change user
USER trtd56
WORKDIR /home/trtd56
ENV HOME /home/trtd56

# vim
RUN curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh

# git
RUN git config --global core.editor 'vim -c "set fenc=utf-8"'
RUN git config --global color.diff auto
RUN git config --global color.status auto
RUN git config --global color.branch auto
RUN git config --global core.precomposeunicode true
RUN git config --global core.quotepath false

# my comfig
RUN git clone https://github.com/trtd56/MyConfig.git
RUN cp MyConfig/dotfiles/.bash_profile ~
RUN cp MyConfig/dotfiles/.bashrc ~
RUN cp MyConfig/dotfiles/.vimrc ~
RUN cp MyConfig/dotfiles/.gitconfig ~

