/* Using this dataset, show the SQL query to find the rolling 3 day average transaction amount for each day in January 2021.  PostgreSQL v9.6 */
SELECT rolling_3_day_avg_amount
FROM
  (SELECT transaction_date,
    total_transaction_amount,
    ROUND(AVG(total_transaction_amount) OVER (ORDER BY transaction_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)::numeric, 2) AS rolling_3_day_avg_amount
    FROM
      (SELECT DATE(transaction_time) AS transaction_date,
        SUM(transaction_amount) AS total_transaction_amount
      FROM transactions
      GROUP BY DATE(transaction_time)) AS tbd
   ) AS tbd_agg
WHERE transaction_date = '2021-01-31';
