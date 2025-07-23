from google.adk.tools import tool
import yfinance as yf

@tool
def get_stock_price(symbol: str) -> str:
    """Gets the current stock price for a given symbol."""
    stock = yf.Ticker(symbol)
    todays_data = stock.history(period='1d')
    if todays_data.empty:
        return f"Could not find stock price for {symbol}"
    return str(todays_data['Close'][0])
