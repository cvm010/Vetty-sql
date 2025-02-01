CREATE TABLE transactions (
    buyer_id INT,
    purchase_time TIMESTAMP,
    refund_item TIMESTAMP NULL DEFAULT NULL,
    store_id CHAR(1),
    item_id VARCHAR(10),
    gross_transaction_value DECIMAL(10,2)
);

INSERT INTO transactions (buyer_id, purchase_time, refund_item, store_id, item_id, gross_transaction_value) VALUES
(3, '2019-09-19 21:19:06.544', NULL, 'a', 'a1', 58),
(12, '2019-12-10 20:10:14.324', '2019-12-15 23:19:06.544', 'b', 'b2', 475),
(3, '2020-09-01 23:59:46.561', '2020-09-02 21:22:06.331', 'f', 'f9', 33),
(2, '2020-04-30 21:19:06.544', NULL, 'd', 'd3', 250),
(1, '2020-10-22 22:20:06.531', NULL, 'f', 'f2', 91),
(8, '2020-04-16 21:00:22.214', NULL, 'e', 'e7', 24),
(5, '2019-09-23 12:09:35.542', '2019-09-27 02:55:02.114', 'g', 'g6', 61);

select * from transactions;

CREATE TABLE items (
    store_id CHAR(1),
    item_id VARCHAR(10),
    item_category VARCHAR(50),
    item_name VARCHAR(50)
);

INSERT INTO items (store_id, item_id, item_category, item_name) VALUES
('a', 'a1', 'pants', 'denim pants'),
('a', 'a2', 'tops', 'blouse'),
('f', 'f1', 'table', 'coffee table'),
('f', 'f5', 'chair', 'lounge chair'),
('f', 'f6', 'chair', 'armchair'),
('d', 'd2', 'jewelry', 'bracelet'),
('b', 'b4', 'earphone', 'airpods');


-- 1> Count of Purchases per Month (Excluding Refunded Purchases)-- 
SELECT 
    DATE_FORMAT(purchase_time, '%Y-%m') AS month,
    COUNT(*) AS purchase_count
FROM 
    transactions
WHERE 
    refund_item IS NULL
GROUP BY 
    DATE_FORMAT(purchase_time, '%Y-%m')
ORDER BY 
    month;
    
    
    
    
    
    
    -- 2> Stores with at Least 5 Orders/Transactions in October 2020
    
    SELECT 
    store_id,
    COUNT(*) AS order_count
FROM 
    transactions
WHERE 
    DATE_FORMAT(purchase_time, '%Y-%m') = '2020-10'
GROUP BY 
    store_id
HAVING 
    COUNT(*) >= 5;
    
    
    
    
    
    
    
    
--     3) Shortest Interval (in Minutes) from Purchase to Refund Time for Each Store

SELECT 
    store_id,
    MIN(TIMESTAMPDIFF(MINUTE, purchase_time, refund_item)) AS shortest_interval_minutes
FROM 
    transactions
WHERE 
    refund_item IS NOT NULL
GROUP BY 
    store_id;
    
    
    
    
    
    
  --   4) Gross Transaction Value of Every Store’s First Order
  
  SELECT 
    store_id,
    gross_transaction_value
FROM (
    SELECT 
        store_id,
        gross_transaction_value,
        ROW_NUMBER() OVER (PARTITION BY store_id ORDER BY purchase_time) AS rn
    FROM 
        transactions
) AS subquery
WHERE 
    rn = 1;
    
   
   
   
   
   
   -- --6) Flag for Refund Eligibility (Within 72 Hours of Purchase)

SELECT 
    *,
    CASE 
        WHEN TIMESTAMPDIFF(HOUR, purchase_time, refund_item) <= 72 THEN 'Yes'
        ELSE 'No'
    END AS refund_eligible
FROM 
    transactions
WHERE 
    refund_item IS NOT NULL;
  
  
  
  
  
  
--  7) Rank by Buyer ID and Filter for Second Purchase 

  SELECT 
    buyer_id,
    purchase_time
FROM (
    SELECT 
        buyer_id,
        purchase_time,
        ROW_NUMBER() OVER (PARTITION BY buyer_id ORDER BY purchase_time) AS rn
    FROM 
        transactions
    WHERE 
        refund_item IS NULL
) AS subquery
WHERE 
    rn = 2;
    
    
    
    
    
    
    
   --  8) Second Transaction Time per Buyer
   
   SELECT 
    buyer_id,
    purchase_time
FROM (
    SELECT 
        buyer_id,
        purchase_time,
        ROW_NUMBER() OVER (PARTITION BY buyer_id ORDER BY purchase_time) AS rn
    FROM 
        transactions
) AS subquery
WHERE 
    rn = 2;
   