# Jupyter & .Net on Docker

https://devblogs.microsoft.com/dotnet/net-core-with-juypter-notebooks-is-here-preview-1/ and https://hub.docker.com/r/jupyter/base-notebook slapped together.

## Run without volume:
`docker run -it --rm -p 8888:8888 joshendriks/jupyterdotnet`

## Run with volume:
`docker run -it --rm -v %cd%:/home/jovyan/work -p 8888:8888 joshendriks/jupyterdotnet`