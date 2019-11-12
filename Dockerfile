FROM jupyter/base-notebook

USER root

RUN wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
	&& dpkg -i packages-microsoft-prod.deb \
	&& rm packages-microsoft-prod.deb \
	&& apt-get update \
	&& apt-get install -y software-properties-common \
    && add-apt-repository universe \
	&& apt-get update \
	&& apt-get install -y apt-transport-https \
	&& apt-get update \
	&& apt-get install -y dotnet-sdk-3.0 \
    && apt-get install -y dotnet-sdk-2.1 \
    && dotnet tool install -g dotnet-try \
	&& /home/jovyan/.dotnet/tools/dotnet-try jupyter install \
	&& jupyter kernelspec list \
	&& fix-permissions /home/jovyan \
    && cp -r /home/jovyan/.dotnet/tools/* /usr/local/bin/ \
    && cp -r /home/jovyan/.dotnet/tools/.store /usr/local/bin/.store \
	&& rm -r /usr/share/dotnet/sdk/NuGetFallbackFolder
	
COPY cs_example.ipynb ./