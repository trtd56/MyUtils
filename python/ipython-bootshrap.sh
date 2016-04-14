PASSWD=`python generate_ipython_passwd.py`

yes | jupyter notebook --generate-config

echo "" >> ~/.jupyter/jupyter_notebook_config.py
echo "### setting jupyter ###" >> ~/.jupyter/jupyter_notebook_config.py
echo "c = get_config()" >> ~/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.ip = '*'" >> ~/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.password = u'$PASSWD'" >> ~/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.port = 8888" >> ~/.jupyter/jupyter_notebook_config.py
