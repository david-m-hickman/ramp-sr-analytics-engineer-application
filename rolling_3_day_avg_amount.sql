/* Using this dataset, show the SQL query to find the rolling 3 day average transaction amount for each day in January 2021.  PostgreSQL v9.6 */
SELECT transaction_date,
  total_transaction_amount,
  round(avg(total_transaction_amount) OVER (ORDER BY transaction_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)::numeric,2) AS rolling_3_day_avg_amount
FROM
  (SELECT date(transaction_time) as transaction_date,
    sum(transaction_amount) as total_transaction_amount
  FROM transactions
  GROUP BY date(transaction_time)) base
