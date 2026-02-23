.open fittrackpro.db
.mode box

-- 5.1 - DONE
SELECT m.member_id, m.first_name, m.last_name, ms.type AS membership_type, m.join_date
    FROM members AS m
    JOIN memberships AS ms
    ON m.member_id = ms.member_id
    WHERE ms.status = 'Active';

-- 5.2 


-- 5.3 - DONE
SELECT m.member_id, m.first_name, m.last_name, m.email, ms.end_date
    FROM members AS m
    JOIN memberships AS ms
    ON m.member_id = ms.member_id
    WHERE strftime('%Y', ms.end_date) = '2025';
