python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

export GOOGLE_CLOUD_PROJECT="work-mylab-machinelearning"
export GOOGLE_CLOUD_LOCATION="us-central1" 
export GOOGLE_GENAI_USE_VERTEXAI=TRUE

adk run helloworldadk
adk web