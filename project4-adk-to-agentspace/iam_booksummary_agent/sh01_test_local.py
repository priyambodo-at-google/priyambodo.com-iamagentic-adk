from vertexai.preview import reasoning_engines
from agent import root_agent

agent_app = reasoning_engines.AdkApp(
    agent=root_agent,
    enable_tracing=True,
)

session = agent_app.create_session(user_id="u_123")

for event in agent_app.stream_query(
    user_id="u_123",
    session_id=session.id,
    message="""
            The Psychology of Money.
        """,
):
    print(event["content"]["parts"][0]["text"])