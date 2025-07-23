python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
adk run app_agent
adk run llm_auditor
adk run my_google_search_agent
adk web