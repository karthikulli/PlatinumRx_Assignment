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



                    --Queries

--Query-1
SELECT 
    sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales
WHERE strftime('%Y', datetime) = '2021'
GROUP BY sales_channel;


--Query-2
SELECT 
    c.uid,
    c.name,
    SUM(cs.amount) AS total_spent
FROM clinic_sales cs
JOIN customer c ON cs.uid = c.uid
GROUP BY c.uid
ORDER BY total_spent DESC
LIMIT 10;


--Query-3
SELECT 
    month,
    revenue,
    expense,
    (revenue - expense) AS profit,
    CASE
        WHEN (revenue - expense) > 0 THEN 'Profitable'
        ELSE 'Not Profitable'
    END AS status
FROM (
    SELECT 
        strftime('%Y-%m', s.datetime) AS month,
        SUM(s.amount) AS revenue,
        IFNULL((
            SELECT SUM(e.amount)
            FROM expenses e
            WHERE strftime('%Y-%m', e.datetime)=strftime('%Y-%m', s.datetime)
        ),0) AS expense
    FROM clinic_sales s
    GROUP BY month
);


--Query-4
WITH profit_data AS (
    SELECT 
        cl.city,
        cl.cid,
        SUM(cs.amount) -
        IFNULL((SELECT SUM(e.amount)
                FROM expenses e
                WHERE e.cid = cl.cid),0) AS profit
    FROM clinics cl
    JOIN clinic_sales cs ON cl.cid = cs.cid
    WHERE strftime('%Y-%m', cs.datetime)='2021-09'
    GROUP BY cl.cid
)

SELECT *
FROM profit_data p
WHERE profit = (
    SELECT MAX(profit)
    FROM profit_data
    WHERE city = p.city
);




--query-5
WITH profit_data AS (
    SELECT 
        cl.state,
        cl.cid,
        SUM(cs.amount) -
        IFNULL((SELECT SUM(e.amount)
                FROM expenses e
                WHERE e.cid = cl.cid),0) AS profit
    FROM clinics cl
    JOIN clinic_sales cs ON cl.cid = cs.cid
    WHERE strftime('%Y-%m', cs.datetime)='2021-09'
    GROUP BY cl.cid
)

SELECT *
FROM profit_data p1
WHERE 1 = (
    SELECT COUNT(DISTINCT p2.profit)
    FROM profit_data p2
    WHERE p2.state = p1.state
      AND p2.profit < p1.profit
);
