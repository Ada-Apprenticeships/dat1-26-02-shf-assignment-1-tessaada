.open fittrackpro.db
.mode box

-- 3.1 - DONE
SELECT equipment_id, name, next_maintenance_date FROM equipment WHERE julianday(next_maintenance_date) <= julianday('2025-01-01','+30 days');

-- 3.2 - DONE
SELECT type AS equipment_type, COUNT(*) AS count 
    FROM equipment
    GROUP BY equipment_type;

-- 3.3 - DONE
SELECT type AS equipment_type, ROUND(AVG(JulianDay('now') - JulianDay(purchase_date))) AS avg_age_days 
    FROM equipment
    GROUP BY equipment_type;
