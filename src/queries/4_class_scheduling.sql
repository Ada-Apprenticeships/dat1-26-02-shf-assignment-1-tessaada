.open fittrackpro.db
.mode box

-- 4.1 - DONE
-- I used a double pipe (||) to concatenate two fields into one for the purposes of displaying the instructor's full name
-- Using DISTINCT to only show results once (even if there are multiple classes with the same instructor scheduled)
SELECT DISTINCT c.class_id, c.name AS class_name, s.first_name || ' ' || s.last_name AS instructor_name
    FROM classes AS c
    JOIN class_schedule AS cs
        ON cs.class_id = c.class_id
    JOIN staff AS s
        ON cs.staff_id = s.staff_id;

-- 4.2 - DONE
SELECT c.class_id, c.name, cs.start_time, cs.end_time, 
        c.capacity - (
            SELECT COUNT(*) AS attendance_num FROM class_attendance AS ca
            JOIN class_schedule AS cs 
                ON cs.schedule_id = ca.schedule_id 
            GROUP BY cs.class_id
        ) AS available_spots
    FROM class_schedule AS cs 
    JOIN classes AS c 
        ON cs.class_id = c.class_id
    WHERE strftime('%Y-%m-%d', cs.start_time) = '2025-02-01'
    GROUP BY cs.class_id;

-- 4.3 - DONE
INSERT INTO class_attendance VALUES
    (16, 1, 11, 'Registered');

-- 4.4 - DONE
DELETE FROM class_attendance WHERE member_id = 3 AND schedule_id = 7;

-- 4.5 - DONE
SELECT c.class_id, c.name, COUNT(*) AS registration_count
    FROM class_attendance AS a
    JOIN class_schedule AS s
        ON a.schedule_id = s.schedule_id
    JOIN classes AS c 
        ON s.class_id = c.class_id
    WHERE a.attendance_status = 'Registered'
    GROUP BY c.class_id;

-- 4.6 - DONE
-- Round to two decimal places
SELECT ROUND(AVG(member_class_count), 2) AS average_classes_per_member
    FROM (
        SELECT COUNT(*) AS member_class_count
            FROM class_attendance AS ca 
            JOIN class_schedule AS cs 
                ON ca.schedule_id = cs.schedule_id
            JOIN classes AS c 
                ON cs.class_id = c.class_id
            GROUP BY ca.member_id
    );
