# Cleaning missing values
# Calculating monthly revenue

import pandas as pd

customers = pd.read_csv("../data/raw/customers.csv")
orders = pd.read_csv("../data/raw/orders.csv")

print(customers.head())
print(orders.head())
