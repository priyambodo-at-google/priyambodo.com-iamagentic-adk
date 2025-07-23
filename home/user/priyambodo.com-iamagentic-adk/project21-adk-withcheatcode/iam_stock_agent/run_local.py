import asyncio
from google.adk.runners import Runner
from google.adk.sessions import InMemorySessionService
from google.genai import types
from iam_stock_agent.agent import stock_price_agent

async def main():
    """Runs the stock price agent."""
    session_service = InMemorySessionService()
    runner = Runner(
        agent=stock_price_agent,
        app_name="stock_app",
        session_service=session_service
    )
    session = await session_service.create_session(
        app_name="stock_app",
        user_id="test_user",
        session_id="test_session"
    )

    while True:
        try:
            user_input = input("Enter a stock symbol (or 'quit' to exit): ")
            if user_input.lower() == 'quit':
                break

            content = types.Content(role='user', parts=[types.Part(text=user_input)])
            async for event in runner.run_async(
                user_id="test_user",
                session_id="test_session",
                new_message=content
            ):
                if event.is_final_response():
                    print("Agent:", event.content.parts[0].text.strip())
        except (KeyboardInterrupt, EOFError):
            break

if __name__ == "__main__":
    asyncio.run(main())
