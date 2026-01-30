"""
Project: E-Commerce Sales & Customer Analytics
Purpose: Clean and prepare e-commerce data for analysis
Author: Riya Makhani
"""

import pandas as pd

# Load dataset
orders = pd.read_csv("orders.csv")

# Handle missing values
orders.dropna(inplace=True)

# Convert date columns
orders['order_date'] = pd.to_datetime(orders['order_date'])

# Save cleaned data
orders.to_csv("cleaned_orders.csv", index=False)

