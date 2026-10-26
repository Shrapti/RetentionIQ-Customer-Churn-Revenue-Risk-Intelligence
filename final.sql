CREATE DATABASE retentioniq;

USE retentioniq;

CREATE TABLE plans (
    plan_id INT PRIMARY KEY,
    plan_name VARCHAR(50) NOT NULL,
    monthly_price DECIMAL(10,2) NOT NULL,
    billing_cycle VARCHAR(20) NOT NULL
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(20),
    country VARCHAR(50),
    signup_date DATE
);

CREATE TABLE subscriptions (
    subscription_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    plan_id INT NOT NULL,
    start_date DATE,
    end_date DATE,
    status VARCHAR(20),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (plan_id)
        REFERENCES plans(plan_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    payment_date DATE,
    amount DECIMAL(10,2),
    payment_status VARCHAR(20),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

CREATE TABLE usage_activity (
    activity_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    activity_date DATE,
    login_count INT,
    usage_hours DECIMAL(10,2),
    sessions INT,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

CREATE TABLE cancellations (
    cancellation_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    cancellation_date DATE,
    cancellation_reason VARCHAR(100),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);
SELECT * FROM plans;
USE retentioniq;

SELECT COUNT(*) AS total_customers FROM customers;

SELECT * FROM customers LIMIT 10;

SELECT COUNT(*) AS total_subscriptions
FROM subscriptions;

SELECT 
    *
FROM
    subscriptions
LIMIT 10;

SELECT COUNT(*) AS total_usage_records
FROM usage_activity;

SELECT *
FROM usage_activity
LIMIT 10;

SELECT COUNT(*) AS total_cancellations
FROM cancellations;

SELECT *
FROM cancellations
LIMIT 10;

SELECT 'customers' AS table_name, COUNT(*) AS records FROM customers
UNION ALL
SELECT 'plans', COUNT(*) FROM plans
UNION ALL
SELECT 'subscriptions', COUNT(*) FROM subscriptions
UNION ALL
SELECT 'usage', COUNT(*) FROM usage_activity
UNION ALL
SELECT 'cancellations', COUNT(*) FROM cancellations
UNION ALL
SELECT 'payments', COUNT(*) FROM payments;

-- What percentage of customers have cancelled their subscription?
USE retentioniq;

SELECT
    COUNT(DISTINCT c.customer_id) AS total_customers,
    COUNT(DISTINCT ca.customer_id) AS cancelled_customers,
    ROUND(
        COUNT(DISTINCT ca.customer_id) * 100.0
        / COUNT(DISTINCT c.customer_id),
        2
    ) AS churn_rate_percentage
FROM customers c
LEFT JOIN cancellations ca
    ON c.customer_id = ca.customer_id;
    
 --   1. How many total customers do we have?
SELECT COUNT(*) AS total_customers
FROM customers;

-- Purpose: Know the total customer base.

-- 2. How many customers have cancelled?
SELECT COUNT(*) AS cancelled_customers
FROM cancellations;

-- Purpose: Measure total churned customers.

-- 3. What is the overall churn rate?
SELECT
    ROUND(
        (SELECT COUNT(*) FROM cancellations) * 100.0
        / (SELECT COUNT(*) FROM customers),
        2
    ) AS churn_rate;

-- Purpose: Find the percentage of customers who cancelled.

-- 4. How many subscriptions are there for each plan?
SELECT
    p.plan_name,
    COUNT(s.subscription_id) AS total_subscriptions
FROM plans p
JOIN subscriptions s
ON p.plan_id = s.plan_id
GROUP BY p.plan_name;

-- Purpose: Understand which plans have more customers.

-- 5. Which plan has the most cancellations?
SELECT
    p.plan_name,
    COUNT(c.customer_id) AS cancelled_customers
FROM plans p
JOIN subscriptions s
ON p.plan_id = s.plan_id
JOIN cancellations c
ON s.customer_id = c.customer_id
GROUP BY p.plan_name
ORDER BY cancelled_customers DESC;

-- Purpose: Compare cancellations across plans.

-- 6. What are the most common cancellation reasons?
SELECT
    cancellation_reason,
    COUNT(*) AS total_cancellations
FROM cancellations
GROUP BY cancellation_reason
ORDER BY total_cancellations DESC;

-- Purpose: Understand why customers leave.

-- 7. Which month has the most cancellations?
SELECT
    MONTH(cancellation_date) AS month,
    COUNT(*) AS total_cancellations
FROM cancellations
GROUP BY MONTH(cancellation_date)
ORDER BY total_cancellations DESC;

-- Purpose: Identify periods with higher churn.

-- 8. What is the average customer age?
SELECT
    ROUND(AVG(age), 2) AS average_age
FROM customers;

-- Purpose: Understand the customer demographic.

-- 9. Which cities have the most customers?
SELECT
    city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;

-- Purpose: Find the major customer locations.

-- 10. What is the average usage per customer?
SELECT
    customer_id,
    ROUND(AVG(usage_hours), 2) AS average_usage
FROM usage_activity
GROUP BY customer_id
ORDER BY average_usage DESC;

-- Purpose: Understand customer engagement.

-- 11. Which customers have very low usage?
SELECT
    customer_id,
    ROUND(SUM(usage_hours), 2) AS total_usage
FROM usage_activity
GROUP BY customer_id
HAVING SUM(usage_hours) < 5
ORDER BY total_usage;

-- Purpose: Find customers with low engagement who may need retention attention.

-- 12. Which customers have the highest number of sessions?
SELECT
    customer_id,
    SUM(sessions) AS total_sessions
FROM usage_activity
GROUP BY customer_id
ORDER BY total_sessions DESC
LIMIT 10;

-- Purpose: Identify highly engaged customers.

-- 13. How many customers are active vs cancelled?
SELECT
    CASE
        WHEN c.customer_id IS NOT NULL THEN 'Cancelled'
        ELSE 'Active'
    END AS customer_status,
    COUNT(*) AS total_customers
FROM customers cu
LEFT JOIN cancellations c
ON cu.customer_id = c.customer_id
GROUP BY customer_status;

-- Purpose: Compare retained and churned customers.

-- 14. Which customers have cancelled, and what was their reason?
SELECT
    cu.customer_id,
    cu.customer_name,
    c.cancellation_date,
    c.cancellation_reason
FROM customers cu
JOIN cancellations c
ON cu.customer_id = c.customer_id
ORDER BY c.cancellation_date;

-- Purpose: Get customer-level churn information.

-- 15. How long did customers stay before cancelling?
SELECT
    s.customer_id,
    s.start_date,
    c.cancellation_date,
    DATEDIFF(c.cancellation_date, s.start_date) AS days_as_customer
FROM subscriptions s
JOIN cancellations c
ON s.customer_id = c.customer_id
ORDER BY days_as_customer;

-- Purpose: Understand customer lifetime before cancellation.

-- 16. Which plan generates the highest revenue?

SELECT
    p.plan_name,
    SUM(p.monthly_price) AS total_revenue
FROM plans p
JOIN subscriptions s
ON p.plan_id = s.plan_id
GROUP BY p.plan_name
ORDER BY total_revenue DESC;

-- purpose: To compare the revenue associated with each subscription plan.

-- 17. What is the average customer lifetime before cancellation?

SELECT
    ROUND(
        AVG(DATEDIFF(c.cancellation_date, s.start_date)),
        0
    ) AS average_customer_lifetime_days
FROM subscriptions s
JOIN cancellations c
ON s.customer_id = c.customer_id;

--  Purpose: To understand how long customers stay before they cancel.

-- 18. Are low-usage customers more likely to cancel?
-- Find customers with low usage
SELECT
    customer_id,
    SUM(usage_hours) AS total_usage
FROM usage_activity
GROUP BY customer_id
HAVING SUM(usage_hours) < 5
ORDER BY total_usage;

-- Check how many of those low-usage customers cancelled
SELECT
    COUNT(*) AS low_usage_cancelled
FROM cancellations
WHERE customer_id IN
(
    SELECT customer_id
    FROM usage_activity
    GROUP BY customer_id
    HAVING SUM(usage_hours) < 5
);
-- purpose: We want to check whether customers who use the service less are also appearing among the cancelled customers.

-- 19. Which cancellation reasons are associated with the most cancelled customers?

SELECT
    cancellation_reason,
    COUNT(*) AS total_cancellations
FROM cancellations
GROUP BY cancellation_reason
ORDER BY total_cancellations DESC;

-- Purpose: To understand why customers are leaving.

-- 20. Which customers may be at risk of churn

SELECT
    c.customer_id,
    c.customer_name,
    SUM(u.usage_hours) AS total_usage,
    SUM(u.sessions) AS total_sessions
FROM customers c
JOIN usage_activity u
ON c.customer_id = u.customer_id
LEFT JOIN cancellations ca
ON c.customer_id = ca.customer_id
WHERE ca.customer_id IS NULL
GROUP BY
    c.customer_id,
    c.customer_name
HAVING SUM(u.usage_hours) < 5
   AND SUM(u.sessions) < 10
ORDER BY total_usage;

-- purposeFind customers who have:

-- Low usage
-- Few sessions
-- No cancellation yet

-- These customers can be considered potentially at risk, not guaranteed to churn.