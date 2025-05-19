# DataAnalytics-Assessment

# Overview
This assessment leverage on SQL skills across four real-world business scenarios involving transaction data, customer segmentation, and financial planning.
Using MySQL, the goal is to extract insights related to:
Customers with both savings and investment accounts.
Transaction frequency patterns.
Inactive financial plans.
Estimating Customer Lifetime Value (CLV).

The data was sourced from four key tables:
users_customuser
plans_plan
savings_savingsaccount
withdrawals_withdrawal (not used in final queries)

# Assessment_Q1.sql – High-Value Customers
**Approach**: 
- Joined users, plans, and savings tables.
- Used conditional aggregation to identify customers with both savings and investment plans.
- Aggregated total deposits.


# Assessment_Q2.sql – Transaction Frequency
**Approach**:
- Used CTEs to compute monthly transaction count.
- Averaged them per customer.
- Applied CASE logic to categorize into frequency tiers.

# Assessment_Q3.sql – Inactivity Alert
**Approach**:
- Fetched last transaction dates per plan.
- Filtered plans inactive for over 365 days using interval comparison.
- Covered both savings and investment plans.

# Assessment_Q4.sql – Customer Livetime Value Estimation
**Approach**:
- Calculated transaction volume and average.
- Computed tenure from signup.
- Estimated CLV using the provided formula.

# Challenges
- Inconsistent Transaction Status: The transaction_status field contained unstructured text and irrelevant values (e.g., future timestamps, error messages). Manual filtering was done to isolate valid statuses such as: success, successful, monnify_success, support credit, supportcredit, earnings.
- Currency Format: Deposits were stored in kobo, requiring conversion to naira for meaningful financial summaries.
- Missing/Null Dates: Some plans had null transaction dates. These were excluded where necessary to avoid misinterpretation in calculations.
- Avoiding Division by Zero: In CLV calculation, COALESCE and NULLIF were used to ensure no divide-by-zero errors.
