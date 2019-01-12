cd $INSTALL_DIR
touch nrnenv

cd $NRN_DIR
wget https://neuron.yale.edu/ftp/neuron/versions/v7.5/nrn-7.5.tar.gz
tar xzf nrn-7.5.tar.gz
# renaming the new directories iv and nrn makes life simpler later on
mv nrn-7.5 nrn

#Install neuron
cd nrn
./configure --prefix=`pwd` --with-nrnpython
make
make install

python3 $NRN_DIR/nrn/src/nrnpython/setup.py install