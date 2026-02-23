.open fittrackpro.db
.mode box

-- 2.1 - DONE
INSERT INTO payments VALUES
    (8, 11, 50.00, CURRENT_TIMESTAMP, 'Credit Card', 'Monthly membership fee');

-- 2.2 - DONE
SELECT strftime('%m-%Y', payment_date) AS month, SUM(amount) AS total_revenue 
    FROM payments 
    WHERE payment_type = 'Monthly membership fee'
    AND payment_date BETWEEN '2024-11' AND '2025-02'
    GROUP BY month
    ORDER BY payment_date DESC;

-- 2.3 - DONE
SELECT payment_id, amount, payment_date, payment_method 
    FROM payments 
    WHERE payment_type = 'Day pass';
