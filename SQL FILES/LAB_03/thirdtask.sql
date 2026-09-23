---1. Give the details of items having the price > 1000. 
SELECT * 
FROM sales.items 
WHERE saleprice > 1000;

---2. Give the details of items having the price > 1000 and belonging to category 5.
SELECT * 
FROM sales.items 
WHERE saleprice > 1000 AND category = 5;

---3. List the Invoices (number, date) of a customer id = 'C05'.
SELECT invno, invdate 
FROM sales.invoice 
WHERE customerid = 'C05';

---4. List all items (code, qty, rate) for invoice number = 1.
SELECT itemcode AS code, qty, rate 
FROM sales.invoicedetails 
WHERE invno = 1;

---5. List the Invoices (number, date) of the customer named Harsh. 
SELECT i.invno, i.invdate 
FROM sales.invoice i 
JOIN sales.customer c ON i.customerid = c.custid 
WHERE c.name = 'Harsh';

---6. List all invoices (inv no, date, customer rid) that have item code = 1103.
SELECT i.invno, i.invdate, i.customerid 
FROM sales.invoice i 
JOIN sales.invoicedetails id ON i.invno = id.invno 
WHERE id.itemcode = 1103;

---7. List all items (inv no, item code, qty) that customer 'C05' has bought.
SELECT id.invno, id.itemcode, id.qty 
FROM sales.invoicedetails id 
JOIN sales.invoice i ON id.invno = i.invno 
WHERE i.customerid = 'C05';

---8. List all customers (customer id, name, city) that have bought item 1101.
SELECT DISTINCT c.custid, c.name, c.city 
FROM sales.customer c 
JOIN sales.invoice i ON c.custid = i.customerid 
JOIN sales.invoicedetails id ON i.invno = id.invno 
WHERE id.itemcode = 1101;

---9. List all items (item code, item name) sold on 2011-08-23.
SELECT DISTINCT it.code, it.name 
FROM sales.items it 
JOIN sales.invoicedetails id ON it.code = id.itemcode 
JOIN sales.invoice i ON id.invno = i.invno 
WHERE i.invdate = '2011-08-23';

---10. List all items (item code, item name) sold in month '2011-07' from category=3.
SELECT DISTINCT it.code, it.name 
FROM sales.items it 
JOIN sales.invoicedetails id ON it.code = id.itemcode 
JOIN sales.invoice i ON id.invno = i.invno 
WHERE it.category = 3 
  AND TO_CHAR(i.invdate, 'YYYY-MM') = '2011-07';

---11. List customers (customer id, name, city) who are from Gujarat and have bought item items from category=3.
SELECT DISTINCT c.custid, c.name, c.city 
FROM sales.customer c 
JOIN sales.invoice i ON c.custid = i.customerid 
JOIN sales.invoicedetails id ON i.invno = id.invno 
JOIN sales.items it ON id.itemcode = it.code 
WHERE c.state = 'GJ' AND it.category = 3;

---12. List the items (code, name) of items purchased by a customer named 'Dev' on the date 2011-08-23.
SELECT DISTINCT it.code, it.name 
FROM sales.items it 
JOIN sales.invoicedetails id ON it.code = id.itemcode 
JOIN sales.invoice i ON id.invno = i.invno 
JOIN sales.customer c ON i.customerid = c.custid 
WHERE c.name = 'Dev' AND i.invdate = '2011-08-23';
