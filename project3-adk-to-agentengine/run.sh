python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

adk web

cd transcript_summarization_agent
python3 test_agent_app_locally.py
python3 deploy_to_agent_engine.py
python3 query_app_on_agent_engine.py
python3 agent_engine_utils.py list
python3 agent_engine_utils.py delete RESOURCE_ID_FROM_PREVIOUS_OUTPUT