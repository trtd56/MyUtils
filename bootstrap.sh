# oackage install
sudo apt update
sudo apt upgrade
sudo apt install -y tmux git vim jq \
                    make build-essential libssl-dev zlib1g-dev libbz2-dev \
                    libreadline-dev libsqlite3-dev wget curl llvm \
                    libncurses5-dev libncursesw5-dev xz-utils
sudo apt autoremove

# move dotfiles


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

# pyenv
git clone https://github.com/yyuu/pyenv.git ~/.pyenv
echo "export PYENV_ROOT=$HOME/.pyenv" >> .~/.bash_profile
echo "export PATH=$PYENV_ROOT/bin:$PATH" >> ~/.bash_profile
echo 'eval "$(pyenv init -)"' >> ~/.bash_profile
echo "pyenv install 3.6.5" >> ~/.bash_profile
source ~/.bash_profile

# pip install
pip install jedi
pip install chainer ipython xonsh kaggle jupyter
