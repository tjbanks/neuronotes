FROM continuumio/anaconda3:5.0.0

RUN apt-get update
#RUN apt-get install dialog apt-utils -y
# RUN apt-get install -y python3 python3-dev python3-pip python3-virtualenv

RUN pip install --no-cache-dir notebook==5.*
# RUN apt install -y libreadline-dev libncurses-dev libtool make git

ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}
ENV APP /app
ENV INSTALL_DIR ${APP}
ENV NRN_DIR ${INSTALL_DIR}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
RUN apt install -y wget gcc
# RUN apt-get install -y python python-dev python-pip python-virtualenv
# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN mkdir -p ${APP}
COPY install_nrn.sh ${APP}
COPY requirements.txt ${APP}
WORKDIR ${APP}

RUN chmod +x install_nrn.sh && ${APP}/install_nrn.sh
RUN pip3 install --no-cache-dir -r ${APP}/requirements.txt

RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

ENV PATH ${NRN_DIR}/nrn-7.5/x86_64/bin:${PATH}
ENV PYTHONPATH ${PYTHONPATH}:~/lib/python/site-packages