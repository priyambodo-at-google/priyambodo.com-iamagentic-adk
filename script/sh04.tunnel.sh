#/!bin/bash
gcloud workstations start-tcp-tunnel \
  --project=work-mylab-machinelearning \
  --region=us-central1 \
  --cluster=cluster-priyambodo-workstation \
  --config=config-priyambodo-workstation \
  vscode-priyambodo-workstation 22