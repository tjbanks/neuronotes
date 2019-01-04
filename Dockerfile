FROM ubuntu:18.04
RUN \
  apt-get update && \
  apt-get install -y python python-dev python-pip python-virtualenv

RUN pip install --no-cache-dir notebook==5.*
RUN apt install -y libreadline-dev libncurses-dev libtool make git neuron python3-neuron

ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
    
# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
RUN setfacl -m u:${NB_USER}:rwx /usr
USER ${NB_USER}

RUN pip install requirements.txt