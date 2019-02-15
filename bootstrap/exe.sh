# package install
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y tmux git vim jq \
                    make build-essential libssl-dev zlib1g-dev libbz2-dev \
                    libreadline-dev libsqlite3-dev wget curl llvm \
                    libncurses5-dev libncursesw5-dev xz-utils \
                    python-opengl xvfb
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
conda install -y chainer tensorflow jupyter seaborn tqdm gensim flake8 keras # fastText, xgboost
conda update --all -y

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

# tmux setting
echo "bind c new-window -c '#{pane_current_path}'" >> ~/.tmux.conf
echo "bind '\"' split-window -c '#{pane_current_path}'" >> ~/.tmux.conf
echo "bind % split-window -h -c '#{pane_current_path}'" >> ~/.tmux.conf
tmux source ~/.tmux.conf

# mecab
mkdir ~/.mecab && cd ~/.mecab
wget -O mecab-0.996.tar.gz "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7cENtOXlicTFaRUE"
tar xvzf mecab-0.996.tar.gz
cd mecab-0.996 && ./configure --prefix=/opt/mecab --enable-utf8-only && make
echo 'export PATH=/opt/mecab/bin:$PATH' | sudo tee -a /etc/profile
echo 'export LD_LIBRARY_PATH=/opt/mecab/lib:$LD_LIBRARY_PATH' | sudo tee -a /etc/profile
source /etc/profile
sudo make install && cd ~/.mecab
sudo ldconfig

# ipadic
wget -O mecab-ipadic-2.7.0-20070801.tar.gz "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7MWVlSDBCSXZMTXM"
tar xvzf mecab-ipadic-2.7.0-20070801.tar.gz
cd ./mecab-ipadic-2.7.0-20070801 && ./configure --with-charset=utf8 --with-dicdir=/opt/mecab/lib/mecab/dic/ipadic && make
sudo make install && cd ~/.mecab
echo '/opt/mecab/lib' | sudo tee -a /etc/ld.so.conf
sudo ldconfig

# nelodg
git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git
cd mecab-ipadic-neologd
./bin/install-mecab-ipadic-neologd -n

cd ~/.mecab && rm -f mecab-0.996.tar.gz mecab-ipadic-2.7.0-20070801.tar.gz

# for NLP tool for python
pip install mecab-python3 mojimoji tensorflow_hub keras_rl JSAnimation gym

# my python utils
cp -r python/ ~

# update dotfiles
cat add_bashrc.txt >> ~/.bashrc
cp .gitconfig ~
cp .vimrc ~
