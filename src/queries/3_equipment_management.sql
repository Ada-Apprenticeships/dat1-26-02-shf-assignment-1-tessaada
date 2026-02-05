.open fittrackpro.db
.mode column

-- 3.1 


-- 3.2 - DONE
SELECT type AS equipment_type, COUNT(*) AS count 
    FROM equipment
    GROUP BY equipment_type;

-- 3.3 

