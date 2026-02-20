.open fittrackpro.db
.mode column

-- 4.1 - DONE
-- I used a double pipe (||) to concatenate two fields into one for the purposes of displaying the instructor's full name
SELECT cs.class_id, c.name AS class_name, s.first_name || ' ' || s.last_name AS instructor_name
    FROM class_schedule AS cs
    JOIN classes AS c
    ON cs.class_id = c.class_id
    JOIN staff AS s
    ON cs.staff_id = s.staff_id;

-- 4.2 
SELECT c.class_id, c.name, cs.start_time, cs.end_time, c.capacity 
    FROM class_schedule AS cs 
    JOIN classes AS c 
    ON cs.class_id = c.class_id
    WHERE strftime('%Y-%m-%d', cs.start_time) = '2025-02-01';

-- 4.3 - DONE?
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

-- 4.6 


