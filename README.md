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
- Normalizing amount fields (stored in kobo) required consistent conversion.
- Mixed plan types had overlapping identifiers requiring type-specific filtering.
- Null-safe calculations (e.g., avoiding division by zero on tenure).
