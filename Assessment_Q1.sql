SELECT
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS Full_Name,
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN p.id END) AS savings_count,
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) AS investment_count,
    ROUND(SUM(s.confirmed_amount) / 100, 2) AS total_deposits  -- i convert from kobo to Naira
FROM
	users_customuser u
JOIN
	plans_plan p
		ON u.id = p.owner_id
JOIN
	savings_savingsaccount s
		ON p.id = s.plan_id
WHERE
	s.confirmed_amount > 0
GROUP BY
	u.id, Full_Name
HAVING 
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN p.id END) >= 1
    AND COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) >= 1
ORDER BY
	total_deposits DESC