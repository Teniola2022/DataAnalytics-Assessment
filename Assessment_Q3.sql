-- Savings accounts with no inflow in the past 365 days
SELECT 
    s.id AS plan_id,
    s.owner_id,
    'Savings' AS type,
    MAX(s.transaction_date) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(s.transaction_date)) AS inactivity_days
FROM savings_savingsaccount s
WHERE s.confirmed_amount > 0
GROUP BY s.id, s.owner_id
HAVING DATEDIFF(CURDATE(), MAX(s.transaction_date)) > 365

UNION ALL

-- Investment plans with no activity in the past 365 days
SELECT 
    p.id AS plan_id,
    p.owner_id,
    'Investment' AS type,
    MAX(p.created_on) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(p.created_on)) AS inactivity_days
FROM plans_plan p
WHERE p.is_a_fund = 1
GROUP BY p.id, p.owner_id
HAVING DATEDIFF(CURDATE(), MAX(p.created_on)) > 365;
