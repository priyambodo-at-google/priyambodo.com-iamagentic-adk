#!/bin/bash

export GCP_REGION='us-central1'
export GCP_PROJECT='work-mylab-machinelearning'
export AR_REPO='arrakis-artifactregistry'  
export SERVICE_NAME='arrakis'

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

#gcloud auth configure-docker "$GCP_REGION-docker.pkg.dev"
#gcloud artifacts repositories create "$AR_REPO" --location="$GCP_REGION" --repository-format=Docker

gcloud builds submit --tag "$GCP_REGION-docker.pkg.dev/$GCP_PROJECT/$AR_REPO/$SERVICE_NAME"
gcloud run deploy "$SERVICE_NAME" \
   --image="$GCP_REGION-docker.pkg.dev/$GCP_PROJECT/$AR_REPO/$SERVICE_NAME" \
   --region=$GCP_REGION \
   --project=$GCP_PROJECT \
   --platform=managed  \
   --allow-unauthenticated \
   --set-env-vars=GCP_PROJECT=$GCP_PROJECT,GCP_REGION=$GCP_REGION