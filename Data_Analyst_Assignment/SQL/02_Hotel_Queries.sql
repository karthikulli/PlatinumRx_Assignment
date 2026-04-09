
--Query-1
SELECT b.user_id, b.room_no
FROM bookings b
WHERE b.booking_date = (
    SELECT MAX(b2.booking_date)
    FROM bookings b2
    WHERE b2.user_id = b.user_id
);

--Query-2
SELECT 
    bc.booking_id,
    SUM(i.item_rate * bc.item_quantity) AS total_amount
FROM booking_commercials bc
JOIN items i 
ON bc.item_id = i.item_id
WHERE strftime('%m', bc.bill_date) = '11'
  AND strftime('%Y', bc.bill_date) = '2021'
GROUP BY bc.booking_id;

--Query-3
SELECT 
    bc.bill_id,
    SUM(i.item_rate * bc.item_quantity) AS bill_amount
FROM booking_commercials bc
JOIN items i 
ON bc.item_id = i.item_id
WHERE strftime('%m', bc.bill_date) = '10'
  AND strftime('%Y', bc.bill_date) = '2021'
GROUP BY bc.bill_id
HAVING bill_amount > 1000;


--Query-4
SELECT 
    strftime('%m', bc.bill_date) AS month,
    bc.item_id,
    SUM(bc.item_quantity) AS total_qty
FROM booking_commercials bc
WHERE strftime('%Y', bc.bill_date) = '2021'
GROUP BY month, bc.item_id

UNION ALL

SELECT 
    strftime('%m', bc.bill_date) AS month,
    bc.item_id,
    SUM(bc.item_quantity) AS total_qty
FROM booking_commercials bc
WHERE strftime('%Y', bc.bill_date) = '2021'
GROUP BY month, bc.item_id
HAVING total_qty = (
    SELECT MIN(qty)
    FROM (
        SELECT SUM(item_quantity) AS qty
        FROM booking_commercials
        WHERE strftime('%Y', bill_date) = '2021'
          AND strftime('%m', bill_date) = month
        GROUP BY item_id
    )
);



--Query-5
SELECT t.user_id, t.month, t.total_bill
FROM (
    SELECT 
        b.user_id,
        strftime('%m', bc.bill_date) AS month,
        SUM(i.item_rate * bc.item_quantity) AS total_bill
    FROM booking_commercials bc
    JOIN bookings b 
        ON bc.booking_id = b.booking_id
    JOIN items i 
        ON bc.item_id = i.item_id
    WHERE strftime('%Y', bc.bill_date) = '2021'
    GROUP BY b.user_id, month
) t
WHERE 1 = (
    SELECT COUNT(DISTINCT t2.total_bill)
    FROM (
        SELECT 
            b2.user_id,
            strftime('%m', bc2.bill_date) AS month,
            SUM(i2.item_rate * bc2.item_quantity) AS total_bill
        FROM booking_commercials bc2
        JOIN bookings b2 
            ON bc2.booking_id = b2.booking_id
        JOIN items i2 
            ON bc2.item_id = i2.item_id
        WHERE strftime('%Y', bc2.bill_date) = '2021'
        GROUP BY b2.user_id, month
    ) t2
    WHERE t2.month = t.month
      AND t2.total_bill > t.total_bill
);
