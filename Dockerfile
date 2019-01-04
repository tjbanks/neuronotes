FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install dialog apt-utils -y
RUN apt-get install -y python python-dev python-pip python-virtualenv

RUN pip install --no-cache-dir notebook==5.*
RUN apt install -y libreadline-dev libncurses-dev libtool make git neuron python3-neuron

ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
RUN apt install -y sudo
# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN pip install -r requirements.txt
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

