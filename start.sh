#!/bin/bash

if [[ ! -z "${JUPYTER_PASSWORD_HASH}" ]]; then
  jupyter lab --NotebookApp.token='' --NotebookApp.password=${JUPYTER_PASSWORD_HASH} --ip=0.0.0.0
elif [[ "${JUPYTER_NO_PASSWORD}" == "true" ]]; then
  jupyter lab --NotebookApp.token='' --NotebookApp.password='' --ip=0.0.0.0
else
  jupyter lab --NotebookApp.token='' --ip=0.0.0.0
fi