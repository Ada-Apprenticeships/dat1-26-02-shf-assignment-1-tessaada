.open fittrackpro.db
.mode column

-- 3.1 
SELECT * FROM equipment WHERE julianday(next_maintenance_date) <= julianday(

-- 3.2 - DONE
SELECT type AS equipment_type, COUNT(*) AS count 
    FROM equipment
    GROUP BY equipment_type;

-- 3.3 - DONE
SELECT type AS equipment_type, ROUND(AVG(JulianDay('now') - JulianDay(purchase_date))) AS avg_age_days 
    FROM equipment
    GROUP BY equipment_type;
