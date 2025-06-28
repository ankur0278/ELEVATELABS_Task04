-- List all customers from USA:
SELECT * FROM Customer
WHERE Country = 'USA';

-- Top 5 most expensive tracks:
SELECT Name, UnitPrice
FROM Track
ORDER BY UnitPrice DESC
LIMIT 5;

-- Number of customers per country using GROUP BY and AGGREGATE FUNCTIONS:
SELECT Country, COUNT(CustomerId) AS CustomerCount
FROM Customer
GROUP BY Country
ORDER BY CustomerCount DESC;

-- Average invoice total per billing country:
SELECT BillingCountry, AVG(Total) AS AvgInvoice
FROM Invoice
GROUP BY BillingCountry
ORDER BY AvgInvoice DESC;

-- Invoice details with customer name using JOINS:
SELECT i.InvoiceId, c.FirstName || ' ' || c.LastName AS CustomerName, i.Total, i.InvoiceDate
FROM Invoice i
JOIN Customer c ON i.CustomerId = c.CustomerId
ORDER BY i.InvoiceDate DESC;

-- Track name, album title, artist name:
SELECT t.Name AS Track, al.Title AS Album, ar.Name AS Artist
FROM Track t
JOIN Album al ON t.AlbumId = al.AlbumId
JOIN Artist ar ON al.ArtistId = ar.ArtistId
LIMIT 10;

-- SUBQUERY
SELECT * FROM Customer
WHERE CustomerId IN (
    SELECT CustomerId
    FROM Invoice
    GROUP BY CustomerId
    HAVING COUNT(InvoiceId) > 5
);
--  Invoice Summary (Customer Name + Total):
CREATE VIEW invoice_summary AS
SELECT i.InvoiceId, c.FirstName || ' ' || c.LastName AS CustomerName, i.Total
FROM Invoice i
JOIN Customer c ON i.CustomerId = c.CustomerId;

SELECT * FROM invoice_summary;

-- Created an index on CustomerId in Invoices:
CREATE INDEX idx_customer_invoice ON Invoice(CustomerId);
