WITH last_transactions AS (
    SELECT
        p.id AS plan_id,
        p.owner_id,
        CASE 
            WHEN p.is_regular_savings = 1 THEN 'Savings'
            WHEN p.is_a_fund = 1 THEN 'Investment'
            ELSE 'Other'
        END AS type,
        MAX(s.transaction_date) AS last_transaction_date
    FROM
		plans_plan p
    LEFT JOIN
		savings_savingsaccount s 
			ON p.id = s.plan_id
    WHERE
		p.is_deleted = 0 AND p.is_archived = 0
    GROUP BY
		p.id, p.owner_id, p.is_regular_savings, p.is_a_fund
)
SELECT 
    plan_id,
    owner_id,
    type,
    DATE(last_transaction_date) AS last_transaction_date,
    DATEDIFF(CURDATE(), last_transaction_date) AS inactivity_days  -- Calculate days since last deposit
FROM
	last_transactions
WHERE last_transaction_date IS NOT NULL 
   OR last_transaction_date < CURDATE() - INTERVAL 365 DAY
ORDER BY
	inactivity_days DESC