.open fittrackpro.db
.mode column

-- 1.1 - DONE
SELECT member_id, first_name, last_name, email, join_date FROM members;

-- 1.2 - DONE
-- SELECT * FROM members WHERE member_id = 5;
UPDATE members SET phone_number = '07000 100005', email = 'emily.jones.updated@email.com' WHERE member_id = 5;
-- SELECT * FROM members WHERE member_id = 5;

-- 1.3 - DONE
SELECT COUNT(*) AS count FROM members;

-- 1.4 - DONE...
SELECT member_id, first_name, last_name, MAX(count) AS registration_count
    FROM  (
        SELECT m.member_id AS member_id, m.first_name AS first_name, m.last_name AS last_name, COUNT(*) AS count
        FROM class_attendance AS c
        JOIN members AS m 
        ON c.member_id = m.member_id
        GROUP BY c.member_id
);

-- 1.5 - DONE
SELECT member_id, first_name, last_name, MIN(count) AS registration_count
    FROM  (
        SELECT m.member_id AS member_id, m.first_name AS first_name, m.last_name AS last_name, COUNT(*) AS count
        FROM class_attendance AS c
        JOIN members AS m 
        ON c.member_id = m.member_id
        GROUP BY c.member_id
);

-- 1.6 - DONE
SELECT COUNT(*) AS Count FROM (
    SELECT m.member_id AS member_id, m.first_name AS first_name, m.last_name AS last_name, COUNT(*) AS count
    FROM class_attendance AS c
    JOIN members AS m 
    ON c.member_id = m.member_id
    GROUP BY c.member_id
    HAVING count >= 2
);