"""
Customer cohort analysis to measure retention
"""

import pandas as pd

orders = pd.read_csv("cleaned_orders.csv")
orders['order_date'] = pd.to_datetime(orders['order_date'])

orders['cohort_month'] = orders.groupby('customer_id')['order_date'].transform('min').dt.to_period('M')
orders['order_month'] = orders['order_date'].dt.to_period('M')

cohort_data = orders.groupby(['cohort_month', 'order_month'])['customer_id'].nunique().reset_index()

cohort_data.to_csv("cohort_analysis.csv", index=False)
