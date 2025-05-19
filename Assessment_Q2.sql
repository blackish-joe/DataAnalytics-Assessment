WITH transaction_counts AS (
    SELECT
        owner_id,
        DATE_FORMAT(transaction_date, '%Y-%m') AS month, -- using the function to extract year-month for monthly aggregation
        COUNT(*) AS monthly_txn_count
    FROM
		savings_savingsaccount
    WHERE
		transaction_status IN ('success', 'successful', 'monnify_success', 'support credit', 'supportcredit', 'earnings')
      AND transaction_date IS NOT NULL
    GROUP BY
		owner_id, DATE_FORMAT(transaction_date, '%Y-%m')
),
monthly_avg AS (
    SELECT
        owner_id,
        AVG(monthly_txn_count) AS avg_txn_per_month
    FROM
		transaction_counts
    GROUP BY
		owner_id
),
categorized AS (
    SELECT
        owner_id,
        avg_txn_per_month,
        CASE
            WHEN avg_txn_per_month >= 10 THEN 'High Frequency'
            WHEN avg_txn_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM
		monthly_avg
)
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_txn_per_month), 1) AS avg_transactions_per_month
FROM 
	categorized
GROUP BY
	frequency_category
ORDER BY
	customer_count DESC;