                    --Table Creations

--Clinics Table
CREATE TABLE clinics (
    cid TEXT PRIMARY KEY,
    clinic_name TEXT,
    city TEXT,
    state TEXT,
    country TEXT
);


--Customer Table
CREATE TABLE customer (
    uid TEXT PRIMARY KEY,
    name TEXT,
    mobile TEXT
);


--Clinic sales Table
CREATE TABLE clinic_sales (
    oid TEXT PRIMARY KEY,
    uid TEXT,
    cid TEXT,
    amount REAL,
    datetime TEXT,
    sales_channel TEXT,
    FOREIGN KEY(uid) REFERENCES customer(uid),
    FOREIGN KEY(cid) REFERENCES clinics(cid)
);


--Expenses Table
CREATE TABLE expenses (
    eid TEXT PRIMARY KEY,
    cid TEXT,
    description TEXT,
    amount REAL,
    datetime TEXT,
    FOREIGN KEY(cid) REFERENCES clinics(cid)
);



                                  --Data Insertions into Tables


INSERT INTO clinics VALUES
('cnc-100001','XYZ Clinic','Hyderabad','Telangana','India'),
('cnc-100002','ABC Clinic','Chennai','Tamil Nadu','India'),
('cnc-100003','Care Clinic','Hyderabad','Telangana','India');


INSERT INTO customer VALUES
('bk-001','John Doe','9876543210'),
('bk-002','Alice','9123456780'),
('bk-003','Bob','9012345678');


INSERT INTO clinic_sales VALUES
('ord-1','bk-001','cnc-100001',25000,'2021-09-23 12:03:22','online'),
('ord-2','bk-002','cnc-100001',15000,'2021-10-10 10:00:00','offline'),
('ord-3','bk-003','cnc-100002',30000,'2021-09-15 11:00:00','online'),
('ord-4','bk-001','cnc-100003',20000,'2021-09-20 09:30:00','app');


INSERT INTO expenses VALUES
('exp-1','cnc-100001','supplies',5000,'2021-09-23 07:30:00'),
('exp-2','cnc-100002','rent',8000,'2021-09-18 10:00:00'),
('exp-3','cnc-100003','maintenance',3000,'2021-09-25 08:00:00');




