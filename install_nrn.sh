cd $INSTALL_DIR
touch nrnenv

cd $NRN_DIR
wget https://neuron.yale.edu/ftp/neuron/versions/v7.5/nrn-7.5.tar.gz
wget https://neuron.yale.edu/ftp/neuron/versions/v7.5/iv-19.tar.gz
tar xzf iv-19.tar.gz
tar xzf nrn-7.5.tar.gz
# renaming the new directories iv and nrn makes life simpler later on
mv iv-19 iv
mv nrn-7.5 nrn

#Install IV

cd iv
./configure --prefix=`pwd`
make
make install

#Install neuron

cd ..
cd nrn
./configure --prefix=`pwd` --with-iv=$NRN_DIR/iv --with-nrnpython
make
make install

cd src/nrnpython
python3 setup.py install