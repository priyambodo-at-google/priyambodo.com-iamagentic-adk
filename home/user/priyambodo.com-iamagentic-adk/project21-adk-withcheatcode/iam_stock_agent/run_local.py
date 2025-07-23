from google.adk.runners import Runner
from agent import agent
import asyncio
from google.genai import types

async def main():
    runner = Runner(agent=agent, app_name="stock_app")
    while True:
        query = input("Enter a stock symbol (e.g., GOOGL) or type 'exit' to quit: ")
        if query.lower() == 'exit':
            break
        
        content = types.Content(role="user", parts=[types.Part(text=query)])
        async for event in runner.run_async(
            user_id="user_123", session_id="session_123", new_message=content
        ):
            if event.is_final_response():
                print(f"Agent: {event.content.parts[0].text}")

if __name__ == "__main__":
    asyncio.run(main())
