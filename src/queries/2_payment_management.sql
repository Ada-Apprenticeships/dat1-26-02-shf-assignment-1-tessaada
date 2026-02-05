.open fittrackpro.db
.mode column

-- 2.1 - DONE
INSERT INTO payments VALUES
(8, 11, 50.00, CURRENT_TIMESTAMP, 'Credit Card', 'Monthly membership fee');

-- 2.2 


-- 2.3 
SELECT payment_id, amount, payment_date, payment_method 
    FROM payments 
    WHERE payment_type = 'Monthly membership fee';
