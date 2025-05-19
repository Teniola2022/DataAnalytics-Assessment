WITH customer_txns AS (
    SELECT
        s.owner_id,
        COUNT(*) AS total_transactions,
        MIN(u.date_joined) AS signup_date,
        TIMESTAMPDIFF(MONTH, MIN(u.date_joined), CURDATE()) AS tenure_months
    FROM savings_savingsaccount s
    JOIN users_customuser u ON u.id = s.owner_id
    GROUP BY s.owner_id
),
txn_frequency AS (
    SELECT
        owner_id,
        total_transactions,
        tenure_months,
        CASE
            WHEN tenure_months = 0 THEN total_transactions
            ELSE ROUND(total_transactions / tenure_months, 2)
        END AS avg_txns_per_month
    FROM customer_txns
),
categorized AS (
    SELECT
        CASE
            WHEN avg_txns_per_month >= 10 THEN 'High Frequency'
            WHEN avg_txns_per_month BETWEEN 3 AND 9.99 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        avg_txns_per_month
    FROM txn_frequency
)
SELECT
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_txns_per_month), 2) AS avg_transactions_per_month
FROM categorized
GROUP BY frequency_category
ORDER BY customer_count DESC;
