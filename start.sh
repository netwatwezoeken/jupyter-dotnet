#!/bin/bash

if [[ ! -z "${JUPYTER_PASSWORD_HASH}" ]]; then
  jupyter lab --NotebookApp.token='' --NotebookApp.password='${JUPYTER_PASSWORD_HASH}'
elif [[ "${JUPYTER_NO_PASSWORD}" == "true" ]]; then
  jupyter lab --NotebookApp.token='' --NotebookApp.password=''
else
  jupyter lab --NotebookApp.token=''
fi