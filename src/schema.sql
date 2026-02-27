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

CREATE TABLE locations(
    location_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(30) NOT NULL,
    address VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    email VARCHAR(40) NOT NULL,
    opening_hours CHAR(11) NOT NULL
);

 -- member might not have a phone number, so attribute can be null
CREATE TABLE members(
    member_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(15) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(40) NOT NULL,
    phone_number VARCHAR(15),
    date_of_birth TEXT NOT NULL,
    join_date TEXT NOT NULL DEFAULT CURRENT_DATE,
    emergency_contact_name VARCHAR(30) NOT NULL,
    emergency_contact_phone VARCHAR(15) NOT NULL
);

-- staff member might not have a phone number, so attribute can be null
CREATE TABLE staff(
    staff_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(15) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(40) NOT NULL,
    phone_number VARCHAR(15), 
    position VARCHAR(15) CHECK (position IN ('Trainer','Manager','Receptionist','Maintenance')),
    hire_date TEXT DEFAULT CURRENT_DATE,
    location_id INTEGER NOT NULL REFERENCES location(location_id)
);

CREATE TABLE equipment(
    equipment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(30) NOT NULL,
    type VARCHRA(15) NOT NULL CHECK(type IN ('Cardio','Strength')),
    purchase_date TEXT NOT NULL DEFAULT CURRENT_DATE,
    last_maintenance_date TEXT NOT NULL,
    next_maintenance_date TEXT NOT NULL,
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
    start_time TEXT,
    end_time TEXT
);

CREATE TABLE memberships(
    membership_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL REFERENCES members(member_id),
    type VARCHAR(15) NOT NULL CHECK(type IN ('Standard','Premium')),
    start_date TEXT NOT NULL DEFAULT CURRENT_DATE,
    end_date TEXT NOT NULL,
    status VARCHAR(10) NOT NULL CHECK(status IN ('Active','Inactive'))
);

 -- Could be null if the attendance is recorded for check in, and then updated to add check out
CREATE TABLE attendance(
    attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL REFERENCES members(member_id),
    location_id INTEGER NOT NULL REFERENCES location(location_id),
    check_in_time TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    check_out_time TEXT 
);

CREATE TABLE class_attendance(
    class_attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    schedule_id INTEGER NOT NULL REFERENCES class_schedule(schedule_id),
    member_id INTEGER NOT NULL REFERENCES members(member_id),
    attendance_status VARCHAR(15) NOT NULL CHECK(attendance_status IN ('Registered','Attended','Unattended'))
);

CREATE TABLE payments(
    payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL REFERENCES members(member_id),
    amount INTEGER NOT NULL,
    payment_date TEXT NOT NULL DEFAULT CURRENT_DATE,
    payment_method VARCHAR(30) NOT NULL CHECK(payment_method IN ('Credit Card', 'Bank Transfer', 'PayPal','Cash')),
    payment_type VARCHAR(50) NOT NULL CHECK(payment_type IN ('Monthly membership fee', 'Day pass'))
);

 -- may not need any notes, so is nullable
CREATE TABLE personal_training_sessions(
    session_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL REFERENCES members(member_id),
    staff_id INTEGER NOT NULL REFERENCES staff(staff_id),
    session_date TEXT NOT NULL,
    start_time TEXT NOT NULL,
    end_time TEXT NOT NULL,
    notes VARCHAR(100)
);

CREATE TABLE member_health_metrics(
    metric_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL REFERENCES members(member_id),
    measurement_date TEXT NOT NULL DEFAULT CURRENT_DATE,
    weight REAL NOT NULL,
    body_fat_percentage REAL NOT NULL,
    muscle_mass REAL NOT NULL,
    bmi REAL NOT NULL
);

CREATE TABLE equipment_maintenance_log(
    log_id INTEGER PRIMARY KEY AUTOINCREMENT,
    equipment_id INTEGER NOT NULL REFERENCES equipment(equipment_id),
    maintenance_date TEXT NOT NULL DEFAULT CURRENT_DATE,
    description TEXT NOT NULL,
    staff_id INTEGER NOT NULL REFERENCES staff(staff_id)
);