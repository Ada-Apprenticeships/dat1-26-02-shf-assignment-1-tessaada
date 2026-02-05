.open fittrackpro.db
.mode column

-- 4.1 


-- 4.2 


-- 4.3 
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


