#/!bin/bash

python3 -m pip install google-adk==0.3.0

export PATH=$PATH:"/home/${USER}/.local/bin"
gcloud storage cp gs://YOUR_GCP_PROJECT_ID-bucket/adk_project.zip ./adk_project.zip
unzip adk_project.zip

