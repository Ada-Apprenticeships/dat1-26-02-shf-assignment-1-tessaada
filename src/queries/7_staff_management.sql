.open fittrackpro.db
.mode box

-- 7.1 - DONE
SELECT staff_id, first_name, last_name, position AS role
    FROM staff
    ORDER BY role;

-- 7.2 - DONE
SELECT s.staff_id AS trainer_id, s.first_name || ' ' || s.last_name AS trainer_name, count(*) AS session_count
    FROM staff AS s
    JOIN personal_training_sessions AS pts
        ON s.staff_id = pts.staff_id
    WHERE julianday(session_date) <= julianday('2025-01-20','+30 days')
    GROUP BY s.staff_id;
