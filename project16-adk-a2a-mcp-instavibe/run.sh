source env/bin/activate

#------ from the Document
gcloud auth list
git clone https://github.com/weimeilin79/instavibe-bootstrap.git
cd instavive-bootstrap
chmod +x init.sh
chmod +x set_env.sh
init.sh 
gcloud config set project $(cat project_id.txt) --quiet
export GOOGLE_CLOUD_PROJECT="work-mylab-machinelearning"
export GOOGLE_CLOUD_LOCATION="us-central1" 
export GOOGLE_GENAI_USE_VERTEXAI=TRUE

#------ from the Document
gcloud services enable  run.googleapis.com \
                        cloudfunctions.googleapis.com \
                        cloudbuild.googleapis.com \
                        artifactregistry.googleapis.com \
                        spanner.googleapis.com \
                        apikeys.googleapis.com \
                        iam.googleapis.com \
                        compute.googleapis.com \
                        aiplatform.googleapis.com \
                        cloudresourcemanager.googleapis.com \
                        maps-backend.googleapis.com

#------ from the Document
export PROJECT_ID=$(gcloud config get project)
export PROJECT_NUMBER=$(gcloud projects describe ${PROJECT_ID} --format="value(projectNumber)")
export SERVICE_ACCOUNT_NAME=$(gcloud compute project-info describe --format="value(defaultServiceAccount)")
export SPANNER_INSTANCE_ID="instavibe-graph-instance"
export SPANNER_DATABASE_ID="graphdb"
export GOOGLE_CLOUD_PROJECT=$(gcloud config get project)
export GOOGLE_GENAI_USE_VERTEXAI=TRUE
export GOOGLE_CLOUD_LOCATION="us-central1"

#------ from the Document
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME" \
  --role="roles/spanner.admin"

# Spanner Database User
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME" \
  --role="roles/spanner.databaseUser"

# Artifact Registry Admin
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME" \
  --role="roles/artifactregistry.admin"

# Cloud Build Editor
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME" \
  --role="roles/cloudbuild.builds.editor"

# Cloud Run Admin
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME" \
  --role="roles/run.admin"

# IAM Service Account User
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME" \
  --role="roles/iam.serviceAccountUser"

# Vertex AI User
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME" \
  --role="roles/aiplatform.user"

# Logging Writer (to allow writing logs)
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME" \
  --role="roles/logging.logWriter"


gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$SERVICE_ACCOUNT_NAME" \
  --role="roles/logging.viewer"


export REPO_NAME="introveally-repo"
gcloud artifacts repositories create $REPO_NAME \
  --repository-format=docker \
  --location=us-central1 \
  --description="Docker repository for InstaVibe workshop"


#------ from the Document
./set_env.sh 

#------ from the Document
gcloud spanner instances create $SPANNER_INSTANCE_ID \
  --config=regional-us-central1 \
  --description="GraphDB Instance InstaVibe" \
  --processing-units=100 \
  --edition=ENTERPRISE

gcloud spanner databases create $SPANNER_DATABASE_ID \
  --instance=$SPANNER_INSTANCE_ID \
  --database-dialect=GOOGLE_STANDARD_SQL

echo "Granting Spanner read/write access to ${SERVICE_ACCOUNT_NAME} for database ${SPANNER_DATABASE_ID}..."

gcloud spanner databases add-iam-policy-binding ${SPANNER_DATABASE_ID} \
  --instance=${SPANNER_INSTANCE_ID} \
  --member="serviceAccount:${SERVICE_ACCOUNT_NAME}" \
  --role="roles/spanner.databaseUser" \
  --project=${PROJECT_ID}

#------ from the Document
./set_env.sh
python -m venv env
source env/bin/activate
pip install -r requirements.txt
pip install --upgrade pip
cd instavibe
python setup.py

#------ from the Document
./set_env.sh
export KEY_DISPLAY_NAME="Maps Platform API Key"

GOOGLE_MAPS_KEY_ID=$(gcloud services api-keys list \
  --project="${PROJECT_ID}" \
  --filter="displayName='${KEY_DISPLAY_NAME}'" \
  --format="value(uid)" \
  --limit=1)

GOOGLE_MAPS_API_KEY=$(gcloud services api-keys get-key-string "${GOOGLE_MAPS_KEY_ID}" \
    --project="${PROJECT_ID}" \
    --format="value(keyString)")

echo "${GOOGLE_MAPS_API_KEY}" > mapkey.txt

echo "Retrieved GOOGLE_MAPS_API_KEY: ${GOOGLE_MAPS_API_KEY}"

#------ from the Document
./set_env.sh

cd instavibe/
export IMAGE_TAG="latest"
export APP_FOLDER_NAME="instavibe"
export IMAGE_NAME="instavibe-webapp"
export IMAGE_PATH="${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${IMAGE_NAME}:${IMAGE_TAG}"
export SERVICE_NAME="instavibe"

gcloud builds submit . \
  --tag=${IMAGE_PATH} \
  --project=${PROJECT_ID}

#------ from the Document
./set_env.sh
cd instavibe/
export IMAGE_TAG="latest"
export APP_FOLDER_NAME="instavibe"
export IMAGE_NAME="instavibe-webapp"
export IMAGE_PATH="${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${IMAGE_NAME}:${IMAGE_TAG}"
export SERVICE_NAME="instavibe"

gcloud run deploy ${SERVICE_NAME} \
  --image=${IMAGE_PATH} \
  --platform=managed \
  --region=${REGION} \
  --allow-unauthenticated \
  --set-env-vars="SPANNER_INSTANCE_ID=${SPANNER_INSTANCE_ID}" \
  --set-env-vars="SPANNER_DATABASE_ID=${SPANNER_DATABASE_ID}" \
  --set-env-vars="APP_HOST=0.0.0.0" \
  --set-env-vars="APP_PORT=8080" \
  --set-env-vars="GOOGLE_CLOUD_LOCATION=${REGION}" \
  --set-env-vars="GOOGLE_CLOUD_PROJECT=${PROJECT_ID}" \
  --set-env-vars="GOOGLE_MAPS_API_KEY=${GOOGLE_MAPS_API_KEY}" \
  --project=${PROJECT_ID} \
  --min-instances=1

#------ from the Document
Service URL: https://instavibe-388889235558.us-central1.run.app

#------ from the Document
./set_env.sh
source env/bin/activate
cd  agents
sed -i "s|^\(O\?GOOGLE_CLOUD_PROJECT\)=.*|GOOGLE_CLOUD_PROJECT=${PROJECT_ID}|" planner/.env
adk web

#------ from the Document
./set_env.sh
source env/bin/activate
cd agents
python -m planner.planner_client



#------ from the Document
./set_env.sh

cd tools/instavibe

export IMAGE_TAG="latest"
export MCP_IMAGE_NAME="mcp-tool-server"
export IMAGE_PATH="${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPO_NAME}/${MCP_IMAGE_NAME}:${IMAGE_TAG}"
export SERVICE_NAME="mcp-tool-server"
export INSTAVIBE_BASE_URL=$(gcloud run services list --platform=managed --region=us-central1 --format='value(URL)' | grep instavibe)/api

gcloud builds submit . \
  --tag=${IMAGE_PATH} \
  --project=${PROJECT_ID}

gcloud run deploy ${SERVICE_NAME} \
  --image=${IMAGE_PATH} \
  --platform=managed \
  --region=${REGION} \
  --allow-unauthenticated \
  --set-env-vars="INSTAVIBE_BASE_URL=${INSTAVIBE_BASE_URL}" \
  --set-env-vars="APP_HOST=0.0.0.0" \
  --set-env-vars="APP_PORT=8080" \
  --set-env-vars="GOOGLE_GENAI_USE_VERTEXAI=TRUE" \
  --set-env-vars="GOOGLE_CLOUD_LOCATION=${REGION}" \
  --set-env-vars="GOOGLE_CLOUD_PROJECT=${PROJECT_ID}" \
  --project=${PROJECT_ID} \
  --min-instances=1

#------ from the Document
Service URL: https://mcp-tool-server-388889235558.us-central1.run.app
export MCP_SERVER_URL=$(gcloud run services list --platform=managed --region=us-central1 --format='value(URL)' | grep mcp-tool-server)/sse
echo $MCP_SERVER_URL

#------ from the Document
/set_env.sh
export MCP_SERVER_URL=$(gcloud run services list --platform=managed --region=us-central1 --format='value(URL)' | grep mcp-tool-server)/sse

cd  agents
sed -i "s|^\(O\?GOOGLE_CLOUD_PROJECT\)=.*|GOOGLE_CLOUD_PROJECT=${PROJECT_ID}|" platform_mcp_client/.env
sed -i "s|^\(O\?MCP_SERVER_URL\)=.*|MCP_SERVER_URL=${MCP_SERVER_URL}|" platform_mcp_client/.env
adk web


#------- from Doddi Priyambodo (DONOTUSE)

python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

adk web

adk run iam_booksummary_agent
cd iam_booksummary_agent
python3 sh01_test_local.py 
python3 sh02_deploy_to_agentengine.py
python3 sh03_query_on_agentengine.py
python3 sh04_agentengine_utils.py list
python3 sh04_agentengine_utils.py delete RESOURCE_ID_FROM_PREVIOUS_OUTPUT

#Notes:
#AgentEngine created. Resource name: projects/388889235558/locations/us-central1/reasoningEngines/5174679952313810944
#To use this AgentEngine in another session:
#agent_engine = vertexai.agent_engines.get('projects/388889235558/locations/us-central1/reasoningEngines/5174679952313810944')

adk run iam_currency_agent
cd iam_currency_agent
python3 sh01_test_local.py 
python3 sh02_deploy_to_agentengine.py
python3 sh03_query_on_agentengine.py
python3 sh04_agentengine_utils.py list
python3 sh04_agentengine_utils.py delete RESOURCE_ID_FROM_PREVIOUS_OUTPUT
