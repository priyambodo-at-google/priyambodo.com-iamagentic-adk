from google.adk.agents import Agent
from stock_tool import get_stock_price

agent = Agent(
    name="stock_agent",
    model="gemini-1.5-flash",
    instruction="You are a helpful assistant that can provide stock prices.",
    tools=[get_stock_price],
)
