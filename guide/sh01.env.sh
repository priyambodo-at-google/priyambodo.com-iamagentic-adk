#!/bin/bash

export GCP_REGION='us-central1'
export GCP_PROJECT='work-mylab-machinelearning'
export AR_REPO='work-mylab-machinelearning-artifactregistry'  
export SERVICE_NAME='adk'

echo $GCP_REGION
echo $GCP_PROJECT
echo $AR_REPO
echo $SERVICE_NAME

#gcloud init
#gcloud auth application-default login

gcloud config set project $GCP_PROJECT
gcloud auth application-default set-quota-project $GCP_PROJECT
gcloud config set billing/quota_project $GCP_PROJECT

gcloud config list
gcloud auth list