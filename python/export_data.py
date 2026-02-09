#!/usr/bin/env python
# coding: utf-8


pip install pandas mysql-connector-python


import pandas as pd
print(pd.__file__)
print(pd.__version__)


# Import libraries
import pandas as pd
import mysql.connector
import pandas.io.sql as psql  # fallback for read_sql_query

# Connect to MySQL database
conn = mysql.connector.connect(
    host='localhost',       
    user='root',         
    password='$N@omi11',
    database='ecommerce_db' 
)

# SQL query to pull all data from the view
query = "SELECT * FROM sales_analysis_view;"

# Read SQL view into pandas DataFrame
df = psql.read_sql_query(query, conn)  # works even if pd.read_sql_query fails

# Convert order_date to datetime
df['order_date'] = pd.to_datetime(df['order_date'])

# Create Month column (YYYY-MM) for trends
df['month'] = df['order_date'].dt.to_period('M')

# Filter only Completed orders
df = df[df['order_status'] == 'Completed']

print(df.head())

# Export clean CSV for Tableau
df.to_csv('sales_analysis_clean.csv', index=False)
print("Clean CSV ready for Tableau: sales_analysis_clean.csv")

# Close the database connection
conn.close()



df.to_csv('sales_analysis_clean.csv', index=False)

