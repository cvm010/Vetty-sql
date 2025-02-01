# Vetty-sql

The first query counts the number of purchases per month, excluding refunded transactions. It groups transactions by month and only includes purchases where no refund occurred. The second query identifies stores that received at least 5 orders in October 2020. It filters transactions for that month, counts orders per store, and keeps only those with 5 or more orders.

The third query calculates the shortest time (in minutes) between a purchase and its refund for each store. It computes the time difference between purchase and refund times and finds the smallest interval for each store.

The fourth query finds the gross transaction value of the first order for each store. It ranks transactions by purchase time for each store and selects the first transaction.

The sixth query adds a flag to indicate whether a refund can be processed within 72 hours of purchase. It calculates the time difference between purchase and refund times and adds a "Yes" or "No" flag based on the 72-hour rule.

The seventh query finds the second purchase for each buyer, ignoring refunded transactions. It ranks transactions by purchase time for each buyer and selects the second transaction. The eighth query identifies the exact time of the second transaction for each buyer. It ranks transactions by purchase time and selects the second one for each buyer.

To use these queries, open MySQL Workbench or any SQL tool, connect to your database, and copy-paste each query into the editor.

