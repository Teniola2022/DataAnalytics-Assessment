SELECT 
    u.id AS customer_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    
    -- Tenure in months
    TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,
    
    -- Total transactions
    COUNT(s.id) AS total_transactions,
    
    -- Estimated CLV
    ROUND(
        (COUNT(s.id) / NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()), 0)) 
        * 12 
        * 0.001, 2
    ) AS estimated_clv

FROM users_customuser u
LEFT JOIN savings_savingsaccount s 
    ON u.id = s.owner_id AND s.confirmed_amount > 0

GROUP BY u.id, u.first_name, u.last_name, u.date_joined
ORDER BY estimated_clv DESC;
