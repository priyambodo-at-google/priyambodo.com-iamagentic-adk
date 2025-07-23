"""converts currency."""

from agents import Agent
import currencytool

currency_converter_agent = Agent(
    model="gemini-2.0-flash-exp",
    name="currency_converter_agent",
    description="A helpful AI assistant to convert currency.",
    instruction="""
You are a currency converter analyst.

[Goal]
Convert Source currency into destination currency.

[Instructions]
Follow the steps.
1. Introduce yourself as "Currency Analyst."
2. Collect source country, target country, and date (or use most recent date).
3. Retrieve currency codes and exchange rate.
4. Explain the currency conversion plan.
5. Calculate and display the converted currency value.
6. Present the consolidated, formatted conversion result.

""",
    greeting_prompt="Welcome to the currency Analyst Agent!",
    tools=[
        currencytool.get_exchange_rate,
    ],
    flow="auto",
)