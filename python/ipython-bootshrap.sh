PASSWD=`python generate_ipython_passwd.py`

yes | jupyter notebook --generate-config

echo "" >> ~/.jupyter/jupyter_notebook_config.py
echo "### setting jupyter ###" >> ~/.jupyter/jupyter_notebook_config.py
echo "c = get_config()" >> ~/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.ip = '*'" >> ~/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.password = u'$PASSWD'" >> ~/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.port = 8888" >> ~/.jupyter/jupyter_notebook_config.py

echo "/usr/local/bin/jupyter notebook --notebook-dir=~/share" > ~/start_jupyter.sh
chmod 777 ~/start_jupyter.sh

# Please edit
#   /etc/rc.local
# add
#   su - vagrant /home/vagrant/start_jupyter.sh &
# before
#   exit 0
