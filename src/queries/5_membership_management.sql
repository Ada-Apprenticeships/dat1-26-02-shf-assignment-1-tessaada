.open fittrackpro.db
.mode column

-- 5.1 - DONE
SELECT members.member_id, first_name, last_name, type, join_date
    FROM members
    JOIN memberships
    ON members.member_id = memberships.member_id
    WHERE memberships.status = 'Active';


-- 5.2 


-- 5.3 

