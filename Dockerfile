FROM mcr.microsoft.com/dotnet/core/sdk:3.1-bionic

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install python3 python3-pip python3-dev ipython3
	
RUN pip3 install jupyterlab

ARG NB_USER="jupyter"
ARG NB_UID="1000"
ARG NB_GID="100"

RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER

USER $NB_UID

ENV HOME=/home/$NB_USER

WORKDIR $HOME

ENV PATH="${PATH}:$HOME/.dotnet/tools/"
	
RUN dotnet tool install -g --add-source "https://dotnet.myget.org/F/dotnet-try/api/v3/index.json" dotnet-interactive

RUN dotnet-interactive jupyter install \ 
	&& jupyter kernelspec list
	
RUN mkdir $HOME/.jupyter
COPY ./jupyter_notebook_config.py $HOME/.jupyter/jupyter_notebook_config.py

RUN mkdir $HOME/work
COPY example.ipynb $HOME/work/example.ipynb

# with default 'trydotnet' password
# docker run -it -p 8888:8888 jc
#
# with token without password
# docker run -it --env JUPYTER_PASSWORD_HASH=<somehash> -p 8888:8888 jc
#
# without password without token
# docker run -it --env JUPYTER_NO_PASSWORD=true -p 8888:8888 jc

USER root
COPY start.sh /start.sh
USER $NB_UID

CMD ["/start.sh"]