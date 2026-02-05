.open fittrackpro.db
.mode column

-- 1.1 - DONE
SELECT member_id, first_name, last_name, email, join_date FROM members;

-- 1.2 - DONE
-- SELECT * FROM members WHERE member_id = 5;
UPDATE members SET phone_number = '07000 100005', email = 'emily.jones.updated@email.com' WHERE member_id = 5;
-- SELECT * FROM members WHERE member_id = 5;

-- 1.3
SELECT COUNT(*) FROM members;

-- 1.4
-- GO BACK TO THISSSS!!!!
SELECT m.member_id, m.first_name, m.last_name, COUNT(*) AS registration_count
FROM members
WHERE 

SELECT m.member_id, m.first_name, m.last_name, MAX(count) AS registration_count
    FROM class_attendance AS c
    JOIN members AS m 
    ON c.member_id = m.member_id
    WHERE (
        SELECT COUNT(*) AS count 
        FROM class_attendance
        GROUP BY c.member_id
    );

-- 1.5


-- 1.6
SELECT COUNT(*) FROM class_attendance WHERE 

SELECT COUNT(*) AS Count, c.member_id 
    FROM class_attendance AS c
    GROUP BY c.member_id
    HAVING Count >= 2;
