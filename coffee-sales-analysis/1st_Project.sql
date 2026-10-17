USE 1st_project;
SELECT*
FROM 1st_project.coffe_sales;

SELECT DISTINCT hour_of_day
FROM coffe_sales;

ALTER TABLE coffe_sales
ADD COLUMN hour_display VARCHAR(10)
AFTER hour_of_day;

UPDATE coffe_sales
SET hour_display = DATE_FORMAT(
    MAKETIME(hour_of_day, 0, 0),
    '%l:00 %p'
);


SELECT DISTINCT cash_type
FROM coffe_sales;

SELECT DISTINCT money
FROM coffe_sales;

SELECT DISTINCT coffee_name
FROM coffe_sales;

UPDATE coffe_sales
SET coffee_name = 'Kona'
WHERE coffee_name = 'Cocoa';

SELECT DISTINCT Time_of_Day
FROM coffe_sales;

SELECT DISTINCT Weekday
FROM coffe_sales;

SELECT DISTINCT Month_name
FROM coffe_sales;

SELECT DISTINCT Weekdaysort
FROM coffe_sales;

SELECT DISTINCT Monthsort
FROM coffe_sales;

SELECT DISTINCT Date
FROM coffe_sales;

SELECT DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = '1st_project'
AND TABLE_NAME = 'coffe_sales'
AND COLUMN_NAME = 'Date';

SELECT DISTINCT Time
FROM coffe_sales;

UPDATE coffe_sales
SET Time = '10:15:50'
WHERE Time ='10:15:50.520000';

SELECT DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = '1st_project'
AND TABLE_NAME = 'coffe_sales'
AND COLUMN_NAME = 'Time';

UPDATE coffe_sales
SET Time = TIME_FORMAT(Time, '%H:%i:%s');

ALTER TABLE coffe_sales
ADD COLUMN customer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;

SELECT
    MONTHNAME(m.month_date) AS month,
    COUNT(CASE
        WHEN YEAR(c.`Date`) = 2024 THEN c.Customer_ID
    END) AS `2024`,
    COUNT(CASE
        WHEN YEAR(c.`Date`) = 2025 THEN c.Customer_ID
    END) AS `2025`
FROM (
    SELECT 1 AS month_num, '2025-01-01' AS month_date
    UNION ALL SELECT 2, '2025-02-01'
    UNION ALL SELECT 3, '2025-03-01'
    UNION ALL SELECT 4, '2025-04-01'
    UNION ALL SELECT 5, '2025-05-01'
    UNION ALL SELECT 6, '2025-06-01'
    UNION ALL SELECT 7, '2025-07-01'
    UNION ALL SELECT 8, '2025-08-01'
    UNION ALL SELECT 9, '2025-09-01'
    UNION ALL SELECT 10, '2025-10-01'
    UNION ALL SELECT 11, '2025-11-01'
    UNION ALL SELECT 12, '2025-12-01'
) m
LEFT JOIN coffe_sales c
    ON MONTH(c.`Date`) = m.month_num
    AND YEAR(c.`Date`) IN (2024, 2025)
GROUP BY m.month_num, m.month_date

UNION ALL

SELECT
    'TOTAL' AS month,
    COUNT(CASE
        WHEN YEAR(`Date`) = 2024 THEN Customer_ID
    END) AS `2024`,
    COUNT(CASE
        WHEN YEAR(`Date`) = 2025 THEN Customer_ID
    END) AS `2025`
FROM coffe_sales;
    
    SELECT 
    Weekday,
    COUNT(*) AS customers
FROM coffe_sales
GROUP BY Weekday
ORDER BY customers ASC;

SELECT 
    coffee_name,
    COUNT(*) AS purchases
FROM coffe_sales
GROUP BY coffee_name
ORDER BY purchases ASC;

SELECT 
    hour_display ,
    COUNT(*) AS customers
FROM coffe_sales
GROUP BY  hour_display
ORDER BY customers ASC;

SELECT 
    Time_of_Day,
    COUNT(*) AS customers
FROM coffe_sales
GROUP BY Time_of_Day
ORDER BY customers ASC;

SELECT 
    coffee_name,
    MIN(money) AS price
FROM coffe_sales
GROUP BY coffee_name
ORDER BY price ASC;

   SELECT  YEAR(`Date`) AS year,
    ROUND(SUM(money), 0) AS total_sales
FROM coffe_sales
WHERE YEAR(`Date`) IN (2024, 2025)
GROUP BY YEAR(`Date`)
ORDER BY year;


SELECT 
    coffee_name,
    ROUND(SUM(CASE WHEN YEAR(`Date`) = 2024 THEN money ELSE 0 END), 0) AS `2024`,
    ROUND(SUM(CASE WHEN YEAR(`Date`) = 2025 THEN money ELSE 0 END), 0) AS `2025`
FROM coffe_sales
WHERE YEAR(`Date`) IN (2024, 2025)
GROUP BY coffee_name
ORDER BY (`2024` + `2025`) DESC;

SELECT 
    MONTHNAME(m.month_date) AS month,
    ROUND(SUM(CASE 
        WHEN YEAR(c.`Date`) = 2024 THEN c.money 
        ELSE 0 
    END), 0) AS `2024`,
    ROUND(SUM(CASE 
        WHEN YEAR(c.`Date`) = 2025 THEN c.money 
        ELSE 0 
    END), 0) AS `2025`
FROM (
    SELECT 1 AS month_num, '2025-01-01' AS month_date
    UNION ALL SELECT 2, '2025-02-01'
    UNION ALL SELECT 3, '2025-03-01'
    UNION ALL SELECT 4, '2025-04-01'
    UNION ALL SELECT 5, '2025-05-01'
    UNION ALL SELECT 6, '2025-06-01'
    UNION ALL SELECT 7, '2025-07-01'
    UNION ALL SELECT 8, '2025-08-01'
    UNION ALL SELECT 9, '2025-09-01'
    UNION ALL SELECT 10, '2025-10-01'
    UNION ALL SELECT 11, '2025-11-01'
    UNION ALL SELECT 12, '2025-12-01'
) m
LEFT JOIN coffe_sales c
    ON MONTH(c.`Date`) = m.month_num
    AND YEAR(c.`Date`) IN (2024, 2025)
GROUP BY m.month_num, m.month_date
ORDER BY m.month_num;