.open fittrackpro.db
.mode column

DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS class_schedule;
DROP TABLE IF EXISTS memberships;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS class_attendance;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS personal_training_sessions;
DROP TABLE IF EXISTS member_health_metrics;
DROP TABLE IF EXISTS equipment_maintenance_log;

PRAGMA foreign_keys = ON;

 -- All email addresses should be company addresses, so I added a GLOB constraint to enforce this
CREATE TABLE locations(
    location_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(30) NOT NULL,
    address VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    email VARCHAR(40) NOT NULL CHECK(email GLOB '*@fittrackpro.com'),
    opening_hours CHAR(11) NOT NULL CHECK(opening_hours GLOB '??:??-??:??')
);

 -- member might not have a phone number, so attribute can be null
 -- I decided to not add GLOB constraints to the phone number, as there can be different formats/spacing
 -- depending on whether the number is landline/mobile and which country the number originates from.

 -- Emergency contact number must be given for safety, so it is required (as opposed to the member's number)

 -- I kept the GLOB constraints on email relatively generic to ensure it would cover addresses from different
 -- companies/domains etc.
CREATE TABLE members(
    member_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(15) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(40) NOT NULL CHECK(email GLOB '*@*.*'),
    phone_number VARCHAR(15),
    date_of_birth TEXT NOT NULL CHECK(date_of_birth GLOB '????-??-??'),
    join_date TEXT NOT NULL DEFAULT CURRENT_DATE CHECK(join_date GLOB '????-??-??'),
    emergency_contact_name VARCHAR(30) NOT NULL,
    emergency_contact_phone VARCHAR(15) NOT NULL
);

-- staff member might not have a phone number, so attribute can be null
CREATE TABLE staff(
    staff_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(15) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(40) NOT NULL CHECK(email GLOB '*@*.*'),
    phone_number VARCHAR(15), 
    position VARCHAR(15) NOT NULL CHECK (position IN ('Trainer','Manager','Receptionist','Maintenance')),
    hire_date TEXT DEFAULT CURRENT_DATE CHECK(hire_date GLOB '????-??-??'),
    location_id INTEGER NOT NULL REFERENCES location(location_id)
);

CREATE TABLE equipment(
    equipment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(30) NOT NULL,
    type VARCHRA(15) NOT NULL CHECK(type IN ('Cardio','Strength')),
    purchase_date TEXT NOT NULL DEFAULT CURRENT_DATE CHECK(purchase_date GLOB '????-??-??'),
    last_maintenance_date TEXT NOT NULL CHECK(last_maintenance_date GLOB '????-??-??'),
    next_maintenance_date TEXT NOT NULL CHECK(next_maintenance_date GLOB '????-??-??'),
    location_id INTEGER NOT NULL REFERENCES location(location_id)
);

CREATE TABLE classes(
    class_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(30) NOT NULL,
    description VARCHAR(100) NOT NULL,
    capacity INTEGER NOT NULL,
    duration INTEGER NOT NULL,
    location_id INTEGER NOT NULL REFERENCES location(location_id)
);

CREATE TABLE class_schedule(
    schedule_id INTEGER PRIMARY KEY AUTOINCREMENT,
    class_id INTEGER NOT NULL REFERENCES classes(class_id),
    staff_id INTEGER NOT NULL REFERENCES staff(staff_id),
    start_time TEXT NOT NULL CHECK(start_time GLOB '????-??-?? ??:??:??'),
    end_time TEXT NOT NULL CHECK(end_time GLOB '????-??-?? ??:??:??')
);

CREATE TABLE memberships(
    membership_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL REFERENCES members(member_id),
    type VARCHAR(15) NOT NULL CHECK(type IN ('Standard','Premium')),
    start_date TEXT NOT NULL DEFAULT CURRENT_DATE CHECK(start_date GLOB '????-??-??'),
    end_date TEXT NOT NULL CHECK(end_date GLOB '????-??-??'),
    status VARCHAR(10) NOT NULL CHECK(status IN ('Active','Inactive'))
);

 -- Could be null if the attendance is recorded for check in, and then updated to add check out
CREATE TABLE attendance(
    attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL REFERENCES members(member_id),
    location_id INTEGER NOT NULL REFERENCES location(location_id),
    check_in_time TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP CHECK(check_in_time GLOB '????-??-?? ??:??:??'),
    check_out_time TEXT CHECK(check_out_time GLOB '????-??-?? ??:??:??')
);

CREATE TABLE class_attendance(
    class_attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    schedule_id INTEGER NOT NULL REFERENCES class_schedule(schedule_id),
    member_id INTEGER NOT NULL REFERENCES members(member_id),
    attendance_status VARCHAR(15) NOT NULL CHECK(attendance_status IN ('Registered','Attended','Unattended'))
);

-- NUMERIC is more accurate than REAL, so it is commonly chosen when currency is involved
-- I chose the NUMERIC type because it is more precise and I can specify the max number of d.p.
-- This helps to enforce the standard currency format.
CREATE TABLE payments(
    payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL REFERENCES members(member_id),
    amount NUMERIC(5,2) NOT NULL,
    payment_date TEXT NOT NULL DEFAULT CURRENT_DATE CHECK(payment_date GLOB '????-??-?? ??:??:??'),
    payment_method VARCHAR(30) NOT NULL CHECK(payment_method IN ('Credit Card', 'Bank Transfer', 'PayPal','Cash')),
    payment_type VARCHAR(50) NOT NULL CHECK(payment_type IN ('Monthly membership fee', 'Day pass'))
);

 -- may not need any notes, so is nullable
CREATE TABLE personal_training_sessions(
    session_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL REFERENCES members(member_id),
    staff_id INTEGER NOT NULL REFERENCES staff(staff_id),
    session_date TEXT NOT NULL CHECK(session_date GLOB '????-??-??'),
    start_time TEXT NOT NULL CHECK(start_time GLOB '??:??:??'),
    end_time TEXT NOT NULL CHECK(end_time GLOB '??:??:??'),
    notes VARCHAR(100)
);

CREATE TABLE member_health_metrics(
    metric_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL REFERENCES members(member_id),
    measurement_date TEXT NOT NULL DEFAULT CURRENT_DATE CHECK(measurement_date GLOB '????-??-??'),
    weight REAL NOT NULL,
    body_fat_percentage REAL NOT NULL,
    muscle_mass REAL NOT NULL,
    bmi REAL NOT NULL
);

CREATE TABLE equipment_maintenance_log(
    log_id INTEGER PRIMARY KEY AUTOINCREMENT,
    equipment_id INTEGER NOT NULL REFERENCES equipment(equipment_id),
    maintenance_date TEXT NOT NULL DEFAULT CURRENT_DATE CHECK(maintenance_date GLOB '????-??-??'),
    description TEXT NOT NULL,
    staff_id INTEGER NOT NULL REFERENCES staff(staff_id)
);