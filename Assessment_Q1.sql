-- Q1: High-Value Customers with Multiple Products

WITH savings_plans AS (
    SELECT 
        owner_id,
        COUNT(*) AS savings_count
    FROM plans_plan
    WHERE is_regular_savings = 1
    GROUP BY owner_id
),
investment_plans AS (
    SELECT 
        owner_id,
        COUNT(*) AS investment_count
    FROM plans_plan
    WHERE is_a_fund = 1
    GROUP BY owner_id
),
total_deposits AS (
    SELECT 
        owner_id,
        SUM(confirmed_amount) AS total_savings_deposit
    FROM savings_savingsaccount
    GROUP BY owner_id
)

SELECT 
    u.id AS owner_id,
    u.name,
    s.savings_count,
    i.investment_count,
    ROUND(COALESCE(td.total_savings_deposit, 0) / 100.0, 2) AS total_deposits
FROM users_customuser u
JOIN savings_plans s ON u.id = s.owner_id
JOIN investment_plans i ON u.id = i.owner_id
LEFT JOIN total_deposits td ON u.id = td.owner_id
ORDER BY total_deposits DESC;
