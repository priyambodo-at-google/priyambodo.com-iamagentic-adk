#web: https://vertexaisearch.cloud.google.com/home/cid/2d2005fe-de82-4765-b62e-416d4604a747

export PROJECT_NUMBER="388889235558"
export PROJECT_ID="work-mylab-machinelearning"

export AS_APP="enterprise-search-17423578_1742357955434"
export REASONING_ENGINE="projects/${PROJECT_ID}/locations/us-central1/reasoningEngines/8311683383381983232" #new name. We should do a list query to make sure it exists
export AGENT_DISPLAY_NAME="currencty converter"
export AGENT_DESCRIPTION="The agent can convert currency"
export AGENT_ID="currency_convert_agent"

echo "REASONING_ENGINE: $REASONING_ENGINE"
echo "PROJECT_NUMBER: $PROJECT_NUMBER"
echo "PROJECT_ID: $PROJECT_ID"

curl -X PATCH -H "Authorization: Bearer $(gcloud auth print-access-token)" \
-H "Content-Type: application/json" \
-H "x-goog-user-project: ${PROJECT_ID}" \
https://discoveryengine.googleapis.com/v1alpha/projects/${PROJECT_NUMBER}/locations/global/collections/default_collection/engines/${AS_APP}/assistants/default_assistant?updateMask=agent_configs -d '{
    "name": "projects/${PROJECT_NUMBER}/locations/global/collections/default_collection/engines/${AS_APP}/assistants/default_assistant",
    "displayName": "Default Assistant",
    "agentConfigs": [{
      "displayName": "'"${AGENT_DISPLAY_NAME}"'",
      "vertexAiSdkAgentConnectionInfo": {
        "reasoningEngine": "'"${REASONING_ENGINE}"'"
      },
      "toolDescription": "'"${AGENT_DESCRIPTION}"'",
      "icon": {
        "uri": "https://fonts.gstatic.com/s/i/short-term/release/googlesymbols/corporate_fare/default/24px.svg"
      },
      "id": "'"${AGENT_ID}"'"
    }]
  }'