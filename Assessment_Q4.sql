WITH total_txns AS (
    SELECT 
        owner_id,
        COUNT(*) AS txn_count,
        SUM(confirmed_amount) AS total_amount  -- i still leave it in kobo
    FROM
		savings_savingsaccount
    WHERE
		confirmed_amount > 0
    GROUP BY
		owner_id
),
tenure AS (
    SELECT 
        id AS customer_id,
        first_name,
        last_name,
        TIMESTAMPDIFF(MONTH, date_joined, CURDATE()) AS tenure_months
    FROM
		users_customuser
),
clv_calc AS (
    SELECT
        t.owner_id AS customer_id,
        CONCAT(u.first_name, ' ', u.last_name) AS Full_Name,
        COALESCE(u.tenure_months, 1) AS tenure_months,  -- using coalesce to avoid zero division by replacing 0 with 1
        t.txn_count AS total_transactions,
        ROUND(
            (t.txn_count / NULLIF(u.tenure_months, 0)) * 12 * (t.total_amount / t.txn_count) * 0.001 / 100,
            2
        ) AS estimated_clv  -- Annualized profit-based Customer Lifetime Value in naira (0.1% profit assumption)
    FROM
		total_txns t
    JOIN
		tenure u
			ON u.customer_id = t.owner_id
)
SELECT * 
FROM
	clv_calc
ORDER BY
	estimated_clv DESC;