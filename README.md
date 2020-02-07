# Jupyter & .Net on Docker

https://devblogs.microsoft.com/dotnet/net-interactive-is-here-net-notebooks-preview-2/ and https://hub.docker.com/_/microsoft-dotnet-core-sdk/ slapped together.

## Run options

### Without parameters

`docker run -it --rm -p 8888:8888 joshendriks/jupyter-dotnet`

Default password 'trydotnet'

## Run with a volume

Windows:
`docker run -it --rm -v %cd%:/home/jupyter/work -p 8888:8888 joshendriks/jupyter-dotnet`

Linux or MacOs:
`docker run -it --rm -v $PWD:/home/jupyter/work -p 8888:8888 joshendriks/jupyter-dotnet`

## Authentication

### Different password
`docker run -it --env JUPYTER_PASSWORD_HASH=<somehash> -p 8888:8888 joshendriks/jupyter-dotnet`

### Without password without token
`docker run -it --env JUPYTER_NO_PASSWORD=true -p 8888:8888 joshendriks/jupyter-dotnet`
