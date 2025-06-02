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
