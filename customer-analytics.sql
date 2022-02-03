#Mengecek tabel orders_1 :
SELECT * FROM orders_1 limit 5;
#Mengecek tabel orders_2 :
SELECT * FROM orders_2 limit 5;
#Mengecek tabel customer:
SELECT * FROM customer limit 5;

#Total Penjualan dan Revenue pada Quarter-1 (Jan, Feb, Mar) dan Quarter-2 (Apr,Mei,Jun)
SELECT SUM(quantity) AS total_penjualan, SUM(quantity*priceeach) AS revenue 
FROM orders_1 
WHERE status = "Shipped";
SELECT SUM(quantity) AS total_Penjualan, SUM(quantity*priceeach) AS revenue 
FROM orders_2
WHERE status = "Shipped";

#Menghitung persentasi keseluruhan penjualanSELECT quarter, SUM(quantity) AS total_Penjualan, SUM(priceeach*quantity) AS revenue 
FROM (SELECT orderNumber, status, quantity, priceeach, '1' quarter 
FROM orders_1
UNION 
SELECT orderNumber, status, quantity, priceeach, '2' quarter FROM orders_2)
AS tabel_a
WHERE status="Shipped"
GROUP BY quarter ;

#Apakah jumlah customers xyz.com semakin bertambah?
SELECT quarter, COUNT(DISTINCT customerID) AS total_customers 
FROM (SELECT customerID, createDate, QUARTER(createDate) AS quarter
	  FROM customer 
	  WHERE createDate BETWEEN '2004-01-01' AND '2004-06-30' ) AS tabel_b
GROUP BY quarter ;

#Seberapa banyak customers tersebut yang sudah melakukan transaksi?
SELECT quarter, COUNT(DISTINCT customerID) AS total_customers 
FROM (SELECT customerID, createDate, QUARTER(createDate) AS quarter 
	  FROM customer WHERE createDate BETWEEN '2004-01-01' AND '2004-06-30')
		AS tabel_b
WHERE customerID IN (SELECT customerID FROM orders_1
						   UNION
						   SELECT customerID FROM orders_2)
GROUP BY quarter;
ORDER BY quarter ASC;

#Category produk apa saja yang paling banyak di-order oleh customers di Quarter-2
SELECT LEFT(productCode,3) AS categoryid, COUNT(DISTINCT orderNumber) AS total_order, SUM(quantity) AS total_penjualan FROM 
(SELECT productCode, orderNumber, quantity, status FROM orders_2 
 WHERE status = 'shipped') AS tabel_c
GROUP BY categoryid
ORDER BY total_order DESC;

#Seberapa banyak customers yang tetap aktif bertransaksi setelah transaksi pertamanya?
#Menghitung total unik customers yang transaksi di quarter_1
SELECT COUNT(DISTINCT customerID) as total_customers FROM orders_1;

SELECT '1' AS quarter, COUNT(DISTINCT customerID)*100/25 AS q2 FROM orders_1
WHERE customerID IN (SELECT DISTINCT customerID FROM orders_2)

#Menghitung total unik customers 
SELECT COUNT(DISTINCT customerID) as total_customers FROM customer;

#Menghitung total unik customers yang transaksi di quarter_2
SELECT COUNT(DISTINCT customerID) as total_customers FROM orders_2;
#output = 25


