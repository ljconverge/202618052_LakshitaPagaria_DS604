----- SALES DATABASE -----
SET search_path TO sales, public;

--1. Compute total sales of a given item (say item code=1103).
SELECT SUM(id.qty * id.rate) AS total_sales
FROM invoicedetails AS id
WHERE id.itemcode = 1103;

--2. What is sale for a given date? [Total sale amount for a give date; it can be computed by summing (qty*rate) from InvoiceDetails of invoices on given date].
SELECT SUM(id.qty * id.rate) AS total_sale
FROM invoice AS i
JOIN invoicedetails AS id ON i.invno = id.invno
WHERE i.invdate = '2008-08-15';

--3. List item-codes of top 3 most sold item based on quantity.
SELECT itemcode,
       SUM(qty) AS total_quantity
FROM invoicedetails
GROUP BY itemcode
ORDER BY total_quantity DESC
LIMIT 3;

--4. List (item codes, item name, category) of top 3 most sold item based on quantity.
SELECT it.code,
       it.name,
       it.category,
       SUM(id.qty) AS total_quantity
FROM items AS it
JOIN invoicedetails AS id
    ON it.code = id.itemcode
GROUP BY it.code, it.name, it.category
ORDER BY total_quantity DESC
LIMIT 3;

--5. Most valuable customer (customer id) in terms of purchase values. Customer that sums of maximum sale amount.
SELECT i.customerid
FROM invoice AS i
JOIN invoicedetails AS id 
    ON i.invno = id.invno
GROUP BY i.customerid
ORDER BY SUM(id.qty * id.rate) DESC
LIMIT 1;

--6. Most valuable customer (customer id) in terms profit to the company. Assume that profit on an item sale can be computed by formula: [Rate from invoicedetails relation] – [Average Purchase Price].
SELECT i.customerid
FROM invoice AS i
JOIN invoicedetails AS id 
    ON i.invno = id.invno
JOIN items AS it 
    ON id.itemcode = it.code
GROUP BY i.customerid
ORDER BY SUM(id.qty * (id.rate - it.averagepurchaseprice)) DESC
LIMIT 1;

--7. Top selling item (in terms of numbers) for a given year.
SELECT id.itemcode
FROM invoice AS i
JOIN invoicedetails AS id ON i.invno = id.invno
WHERE EXTRACT(YEAR FROM i.invdate) = 2011
GROUP BY id.itemcode
ORDER BY SUM(id.qty) DESC
LIMIT 1;

----- ACAD DATABASE -----
SET search_path TO acad, public;

-- 8. Retrieve ID of faculties who took more than one courses in a semester (for all semester in the database).
SELECT instructorid
FROM offers
GROUP BY instructorid, semester, acadyear
HAVING COUNT(courseno) > 1;

-- 9. List total course count (instructor-name, course-count) for all instructors. Include the faculty name even if course count is zero.
SELECT i.instructorname, COUNT(o.courseno) AS course_count
FROM instructor AS i
LEFT JOIN offers AS o ON i.instructorid = o.instructorid
GROUP BY i.instructorid, i.instructorname;

-- 10. Retrieve all students (StudentID, Name, TotalCreditTaken) for B.Tech. (CS) (progid=’02’) batch 2007 in Autumn’2008.
SELECT s.studentid, s.name, SUM(c.credit) AS total_credit_taken
FROM student AS s
JOIN registers AS r ON s.studentid = r.studentid
JOIN course AS c ON r.courseno = c.courseno
WHERE s.progid = '02' 
  AND s.batch = 2007 
  AND r.semester = 'Autumn' 
  AND r.acadyear = 2008
GROUP BY s.studentid, s.name;

-- 11. Retrieve all students (Id and name) who got more than two F grades in Autumn’2008.
SELECT s.studentid, s.name
FROM student AS s
JOIN registers AS res ON s.studentid = res.studentid
WHERE res.grade = 'F' 
  AND res.semester = 'Autumn' 
  AND res.acadyear = 2008
GROUP BY s.studentid, s.name
HAVING COUNT(*) > 2;
