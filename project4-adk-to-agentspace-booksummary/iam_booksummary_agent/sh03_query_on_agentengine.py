import os
from dotenv import load_dotenv

import vertexai
from vertexai import agent_engines

load_dotenv()
vertexai.init(
    project=os.environ["GOOGLE_CLOUD_PROJECT"],
    location=os.environ["GOOGLE_CLOUD_LOCATION"],
    staging_bucket=f"gs://{os.getenv('GOOGLE_CLOUD_PROJECT')}-bucket",
)

ae_apps = agent_engines.list(filter=f'display_name="{os.getenv("APP_NAME")}"')
remote_app = next(ae_apps)
print(remote_app.display_name)

remote_session = remote_app.create_session(user_id="u_456")

user_prompt = """
Mind Map Mastery by Tony Buzan
"""

events = remote_app.stream_query(
    user_id="u_456",
    session_id=remote_session["id"],
    message=user_prompt,
)

for event in events:
    for part in event["content"]["parts"]:
        if 'text' in part:
            print(part['text'])