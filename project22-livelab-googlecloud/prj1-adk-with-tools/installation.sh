#!/bin/bash
python -m venv .venv
source .venv/bin/activate
#create requirements.txt
pip install -r requirements.txt

pip install google-adk
pip show google-adk

export GCP_REGION='us-central1'
export GCP_PROJECT='work-mylab-machinelearning'
export AR_REPO='repo-work-mylab-machinelearning-artifactregistry'  
export SERVICE_NAME='adk'

gcloud init
gcloud auth login
gcloud auth application-default login
