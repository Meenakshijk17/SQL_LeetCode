-- Table: Accounts

-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | account_id  | int  |
-- | income      | int  |
-- +-------------+------+
-- account_id is the primary key (column with unique values) for this table.
-- Each row contains information about the monthly income for one bank account.
 

-- Write a solution to calculate the number of bank accounts for each salary category. The salary categories are:

-- "Low Salary": All the salaries strictly less than $20000.
-- "Average Salary": All the salaries in the inclusive range [$20000, $50000].
-- "High Salary": All the salaries strictly greater than $50000.
-- The result table must contain all three categories. If there are no accounts in a category, return 0.

-- Return the result table in any order.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Accounts table:
-- +------------+--------+
-- | account_id | income |
-- +------------+--------+
-- | 3          | 108939 |
-- | 2          | 12747  |
-- | 8          | 87709  |
-- | 6          | 91796  |
-- +------------+--------+
-- Output: 
-- +----------------+----------------+
-- | category       | accounts_count |
-- +----------------+----------------+
-- | Low Salary     | 1              |
-- | Average Salary | 0              |
-- | High Salary    | 3              |
-- +----------------+----------------+
-- Explanation: 
-- Low Salary: Account 2.
-- Average Salary: No accounts.
-- High Salary: Accounts 3, 6, and 8.

with main as (
    select
        cat.category,
        count(cat.category) as accounts_count
    from
        Accounts A
    left join
    (
        select
            *, 
            case
                when income < 20000 then 'Low Salary'
                when (20000 <= income) and (income <= 50000) then 'Average Salary'
                when 50000 < income then 'High Salary'
            end as category
        from
            Accounts
    ) as cat
    on 
        A.account_id = cat.account_id
    group by 
        cat.category
)
select * from main
union
(
    select 'Low Salary' as category, 0 as accounts_count from Accounts
    where 'Low Salary' not in (select category from main)
)
union
(
    select 'Average Salary' as category, 0 as accounts_count from Accounts
    where 'Average Salary' not in (select category from main)
)
union
(
    select 'High Salary' as category, 0 as accounts_count from Accounts
    where 'High Salary' not in (select category from main)
)

;
