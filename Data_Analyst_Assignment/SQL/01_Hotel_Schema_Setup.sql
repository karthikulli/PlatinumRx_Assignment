            --Table Creations

-- USERS TABLE
CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(15),
    mail_id VARCHAR(100),
    billing_address VARCHAR(255)
);

-- BOOKINGS TABLE
CREATE TABLE bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date TIMESTAMP,
    room_no VARCHAR(50),
    user_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


-- BOOKING COMMERCIALS TABLE
CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date TIMESTAMP,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10,2),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);


-- ITEMS TABLE
CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate DECIMAL(10,2)
);


                                --Data Insertions

--Users Data Insertion
INSERT INTO users VALUES
('21wrcxuy-67erf', 'John Doe', '98xxxxxxxx', 'john@example.com', 'Hyderabad'),
('22wrcxuy-67erfn', 'Alice Smith', '91xxxxxxxx', 'alice@example.com', 'Bangalore'),
('23wrcxuy-67erfn', 'Bob Lee', '99xxxxxxxx', 'bob@example.com', 'Chennai');


--Bookings Data Insertion
INSERT INTO bookings VALUES
('b1', '2021-10-05 10:00:00', '101', '21wrcxuy-67erfn'),
('b2', '2021-10-20 12:00:00', '102', '21wrcxuy-67erfn'),
('b3', '2021-11-10 09:00:00', '201', '22wrcxuy-67erfn'),
('b4', '2021-11-15 14:00:00', '202', '23wrcxuy-67erfn');


--Booking Commercials Data Insertion
INSERT INTO booking_commercials VALUES
('c1', 'b1', 'bill1', '2021-10-05 12:00:00', 'i1', 3),
('c2', 'b1', 'bill1', '2021-10-05 12:00:00', 'i2', 2),
('c3', 'b2', 'bill2', '2021-10-20 13:00:00', 'i3', 5),
('c4', 'b2', 'bill2', '2021-10-20 13:00:00', 'i4', 4),
('c5', 'b3', 'bill3', '2021-11-10 11:00:00', 'i1', 10),
('c6', 'b3', 'bill3', '2021-11-10 11:00:00', 'i3', 2),
('c7', 'b4', 'bill4', '2021-11-15 15:00:00', 'i2', 6),
('c8', 'b4', 'bill4', '2021-11-15 15:00:00', 'i4', 3);


--Items Data Insertion
INSERT INTO items VALUES
('i1', 'Tawa Paratha', 20),
('i2', 'Mix Veg', 80),
('i3', 'Paneer Curry', 150),
('i4', 'Rice', 50);
