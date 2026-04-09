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
