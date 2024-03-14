FROM mcr.microsoft.com/dotnet/sdk:8.0.201-jammy

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Amsterdam

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install python3 python3-pip python3-dev ipython3 nano plantuml libfontconfig1\
	&& cp /usr/share/plantuml/plantuml.jar /usr/local/bin/plantuml.jar

RUN apt-get -y install nmap
RUN apt-get -y install bash

RUN pip3 install jupyterlab
RUN pip3 install iplantuml
RUN pip3 install graphviz
RUN pip3 install matplotlib
RUN pip install --upgrade ipykernel

RUN curl -sL https://deb.nodesource.com/setup_20.x | bash

RUN apt install nodejs \
    && pip3 install --upgrade jupyterlab-git \
    && jupyter lab build

ARG NB_USER="jupyter"
ARG NB_UID="1000"
ARG NB_GID="100"

RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER

USER $NB_USER

ENV HOME=/home/$NB_USER

WORKDIR $HOME

ENV PATH="${PATH}:$HOME/.dotnet/tools/"

RUN dotnet tool install --global Microsoft.dotnet-interactive

RUN dotnet-interactive jupyter install
RUN jupyter kernelspec list

COPY ./jupyter_notebook_config.py $HOME

RUN mkdir $HOME/work
RUN mkdir $HOME/work/examples
COPY csharp.ipynb $HOME/work/examples/csharp.ipynb
COPY plantuml.ipynb $HOME/work/examples/plantuml.ipynb
COPY graphviz.ipynb $HOME/work/examples/graphviz.ipynb
COPY mermaid.ipynb $HOME/work/examples/mermaid.ipynb

USER root

RUN chown -R jupyter $HOME/work/examples

RUN apt-get install sudo \
    && usermod -aG sudo $NB_USER

# prevent git init on this level
RUN mkdir $HOME/work/.git
COPY start.sh /start.sh
RUN chmod +x /start.sh

USER $NB_USER

CMD ["/start.sh"]
EXPOSE 8888