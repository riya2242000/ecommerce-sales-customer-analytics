"""
Customer Segmentation based on purchase behavior
"""

import pandas as pd

# Load data
orders = pd.read_csv("cleaned_orders.csv")
payments = pd.read_csv("payments.csv")

# Merge datasets
data = orders.merge(payments, on="order_id")

# Aggregate customer metrics
customer_metrics = data.groupby("customer_id").agg({
    "payment_value": ["sum", "count"]
})

customer_metrics.columns = ["total_spent", "order_count"]

# Segment customers
customer_metrics["segment"] = pd.cut(
    customer_metrics["total_spent"],
    bins=[0, 100, 500, 1000, 10000],
    labels=["Low", "Medium", "High", "VIP"]
)

customer_metrics.to_csv("customer_segments.csv")
