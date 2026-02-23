.open fittrackpro.db
.mode box

-- 5.1 - DONE
SELECT m.member_id, m.first_name, m.last_name, ms.type AS membership_type, m.join_date
    FROM members AS m
    JOIN memberships AS ms
    ON m.member_id = ms.member_id
    WHERE ms.status = 'Active';

-- 5.2 - DONE
-- Multiply average to get answer in minutes rather than days (there are 1440 minutes in a day)
-- Round to 2 decimal places
SELECT ms.type AS membership_type, ROUND(AVG((julianday(a.check_out_time) - julianday(a.check_in_time)))*1440, 2) AS avg_visit_duration_minutes
    FROM attendance AS a
    JOIN members AS m 
    ON a.member_id = m.member_id
    JOIN memberships AS ms 
    ON m.member_id = ms.member_id
    GROUP BY ms.type;

-- 5.3 - DONE
SELECT m.member_id, m.first_name, m.last_name, m.email, ms.end_date
    FROM members AS m
    JOIN memberships AS ms
    ON m.member_id = ms.member_id
    WHERE strftime('%Y', ms.end_date) = '2025';
