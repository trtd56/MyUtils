# package install
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y tmux git vim jq \
                    make build-essential libssl-dev zlib1g-dev libbz2-dev \
                    libreadline-dev libsqlite3-dev wget curl llvm \
                    libncurses5-dev libncursesw5-dev xz-utils
sudo apt autoremove -y

# pyenv
git clone https://github.com/yyuu/pyenv ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
source ~/.bashrc

# anaconda
anaconda_version=`pyenv install --list | grep anaconda | tail -n1`
pyenv install $anaconda_version  # 2018.09.14: anaconda3-5.2.0 
pyenv global $anaconda_version
pyenv rehash
conda install -y chainer tensorflow jupyter seaborn tqdm gensim flake8 # fastText, xgboost

# git setting
git config --global core.editor 'vim -c "set fenc=utf-8"'
git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto
git config --global core.precomposeunicode true
git config --global core.quotepath false

# neobundle
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
sh ./install.sh
rm -rf install.sh


# update dotfiles
cat add_bashrc.txt >> ~/.bashrc
cp .gitconfig ~
cp .vimrc ~
