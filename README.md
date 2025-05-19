This repository contains SQL solutions for the Data Analyst SQL Proficiency Assessment. Each SQL file corresponds to one question, solving real business problems involving customer transactions, account activity, and customer value.

Question 1
Task: Identify customers who have at least one funded savings plan and one funded investment plan, and sort them by their total deposits.

Approach:

Joined users_customuser, savings_savingsaccount, and plans_plan tables.

Used flags is_regular_savings = 1 for savings plans and is_a_fund = 1 for investment plans.

Counted the number of savings and investment plans per customer.

Summed total deposits from confirmed_amount (converted from kobo).

Filtered customers who have both types of plans funded.

Sorted customers by total deposits descending.

Challenges:

Ensuring correct joins to avoid double counting.

Filtering based on flags for plan types.

Question 2
Task: Calculate the average number of transactions per customer per month and categorize customers into "High Frequency," "Medium Frequency," or "Low Frequency" segments.

Approach:

Calculated tenure in months using date_joined from users_customuser.

Counted total transactions per customer from savings_savingsaccount.

Computed average monthly transactions by dividing total transactions by tenure.

Categorized customers using CASE statements based on average transactions thresholds.

Aggregated counts and average transactions per category.

Challenges:

Handling customers with zero tenure to avoid division errors.

Categorizing transaction frequencies correctly using CASE.

Question 
Task: Find active savings or investment accounts with no inflow transactions for over 365 days.

Approach:

For savings accounts: used savings_savingsaccount table and filtered for inflow transactions (confirmed_amount > 0).

For investment plans: used plans_plan table where is_a_fund = 1.

Used transaction_date (savings) and created_on (investment) as last transaction dates.

Calculated inactivity days using DATEDIFF from current date.

Filtered accounts with inactivity > 365 days.

Combined savings and investment results using UNION ALL.

Challenges:

Understanding which date columns to use for each table.

Handling missing inflow amount columns in plans_plan.

Question 4: Customer Lifetime Value (CLV) Estimation
Task: Calculate customer tenure, total transactions, and estimate CLV assuming a profit per transaction of 0.1%.

Approach:

Calculated tenure in months from date_joined to current date.

Counted transactions from savings_savingsaccount.

Applied the CLV formula: CLV = (Total Transactions / Tenure) × 12 × 0.001

Used NULLIF to avoid division by zero for new customers.

Sorted results by estimated CLV descending.

Challenges:

Avoiding division by zero errors for customers with zero tenure.

Joining tables correctly to count transactions accurately.
