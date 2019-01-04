FROM continuumio/anaconda3:5.0.0

RUN apt-get update && apt-get install -y automake \
                                         libtool \
                                         build-essential \
                                         libncurses5-dev

ENV BUILD_DIR=/home/build
ENV HOME_DIR=/home/shared
ENV WORK_DIR=${HOME_DIR}/workspace

RUN mkdir -p ${BUILD_DIR}
RUN mkdir -p ${HOME_DIR}
RUN mkdir -p ${WORK_DIR}

RUN conda install -y numpy h5py lxml pandas matplotlib jsonschema scipy

# Install NEURON for BioNet
RUN conda install -y -c kaeldai neuron

### Install AllenSDK (Not used by bmtk, but used by some notebooks to fetch cell-types files)
RUN pip install allensdk


### Install the bmtk
RUN cd ${BUILD_DIR}; \
    git clone https://github.com/AllenInstitute/bmtk.git; \
    cd bmtk; \
    python setup.py install

# Pre-compile mechanisms for BioNet examples
RUN cd ${HOME_DIR}/examples/biophys_components/mechanisms; \
    nrnivmodl modfiles/

    
RUN pip install --no-cache-dir notebook==5.*

ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
    
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}