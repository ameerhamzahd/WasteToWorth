CREATE DATABASE FoodWasteManagementDB;
USE FoodWasteManagementDB;

-- Create tables
CREATE TABLE Inventory (
    ItemID INT PRIMARY KEY IDENTITY,
    ItemName VARCHAR(255),
    Category VARCHAR(255),
    Quantity INT,
    ExpirationDate DATE,
    Location VARCHAR(255),
	StoreID INT FOREIGN KEY REFERENCES Stores(StoreID)
);

CREATE TABLE Charities (
    CharityID INT PRIMARY KEY IDENTITY,
    CharityName VARCHAR(255),
    Address VARCHAR(255),
    ContactNumber VARCHAR(255),
	Website VARCHAR(255)
);

CREATE TABLE Donations (
    DonationID INT PRIMARY KEY IDENTITY,
    ItemID INT FOREIGN KEY REFERENCES Inventory(ItemID),
    CharityID INT FOREIGN KEY REFERENCES Charities(CharityID),
    Quantity INT,
    DonationDate DATE
);

CREATE TABLE Stores (
    StoreID INT PRIMARY KEY IDENTITY,
    StoreName VARCHAR(255),
    Address VARCHAR(255),
    ContactNumber VARCHAR(255),
	Website VARCHAR(255)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY,
    EmployeeName VARCHAR(255),
    StoreID INT FOREIGN KEY REFERENCES Stores(StoreID),
    Role VARCHAR(255),
	Email VARCHAR(255)
);

CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY IDENTITY,
    SupplierName VARCHAR(255),
    ContactNumber VARCHAR(255),
    Email VARCHAR(255)
);

CREATE TABLE SupplierInventory (
    SupplierInventoryID INT PRIMARY KEY IDENTITY,
    SupplierID INT FOREIGN KEY REFERENCES Suppliers(SupplierID),
    ItemID INT FOREIGN KEY REFERENCES Inventory(ItemID),
    Quantity INT, 
	StoreID INT FOREIGN KEY REFERENCES Stores(StoreID)
);

CREATE TABLE DonationRequests (
    RequestID INT PRIMARY KEY IDENTITY,
    CharityID INT FOREIGN KEY REFERENCES Charities(CharityID),
    RequestedItem VARCHAR(255),
    Quantity INT,
    RequestDate DATE
);

CREATE TABLE Reports (
    ReportID INT PRIMARY KEY IDENTITY,
    ReportType VARCHAR(255),
    GeneratedDate DATE,
    Details VARCHAR(MAX),
	SupplierID INT FOREIGN KEY REFERENCES Suppliers(SupplierID),
	EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID)
);

INSERT INTO Inventory (ItemName, Category, Quantity, ExpirationDate, Location, StoreID)
VALUES 
('Bread', 'Bakery', 30, '2024-12-15', 'Warehouse A', 3),
('Egg', 'Dairy', 30, '2024-12-12', 'Warehouse B', 1),
('Olive Oil', 'Edible Oils', 50, '2024-12-21', 'Warehouse C', 2),
('Rice', 'Grains', 100, '2024-12-18', 'Warehouse A', 1),
('Lavender Essential Oil', 'Essential Oils', 20, '2024-12-27', 'Warehouse D', 3),
('Cheese', 'Dairy', 10, '2024-12-24', 'Warehouse B', 2);

SELECT * FROM Inventory;

-- Insert sample data into Charities
INSERT INTO Charities (CharityName, Address, ContactNumber, Website)
VALUES 
('As-Sunnah Foundation', 'Block C, 70, Road No. 3, Dhaka 1212.', '09610-001089', 'https://assunnahfoundation.org/'),
('BRAC', 'BRAC Centre 75 Mohakhali, Dhaka-1212.', '02 2222 81265', 'http://www.brac.net/'),
('Jaggo Foundation', 'H-57, Road-7B, Dhaka 1213.', '01766666654', 'https://jaago.com.bd/');

INSERT INTO Charities (CharityName, Address, ContactNumber)
VALUES
('Bangladesh Bondhu Foundation (BONDHU)', 'House -8, 12 BLOCK # B, Dhaka 1207.', '01833-104100'),
('Nova Foundation', 'H# Padmarag, Yusuf Kazi Lane, Bogura 5800.', '09613-825925');

SELECT * FROM Charities;

-- Insert sample data into Donations
INSERT INTO Donations (ItemID, CharityID, Quantity, DonationDate)
VALUES 
(1, 1, 25, '2024-12-09'),
(4, 2, 15, '2024-12-17'),
(2, 3, 20, '2024-12-15'),
(3, 4, 10, '2024-12-11'), 
(4, 5, 5, '2024-12-12');

SELECT * FROM Donations;

-- Insert sample data into Stores
INSERT INTO Stores (StoreName, Address, ContactNumber, Website)
VALUES 
('Shwapno', 'Port Connecting Rd, Chattogram', '01708138470', 'http://shwapno.com/'),
('Agora Super Shop', 'Afmi Plaza, 1/A Bayazid Bostami Rd, Chattogram 4000', '09612311172', 'http://agorasuperstores.com/'),
('Daily Shopping', 'Block-H, Road-1, House-2 In front of Garib-E-Newaz High School, Chattogram 4216', '01322848877', 'https://dailyshoppingbd.com/');

SELECT * FROM Stores;

-- Insert sample data into Employees
INSERT INTO Employees (EmployeeName, StoreID, Role, Email)
VALUES 
('Muhammad', 1, 'Manager', 'muhammad@gmail.com'),
('Siddiq', 2, 'Inventory Specialist', 'siddiq@gmail.com'),
('Omar', 3, 'Donation Coordinator', 'omar@gmail.com'),
('Uthman', 2, 'Supplier Liaison', 'uthman@gmail.com'),
('Ali', 1, 'Data Analyst', 'ali@gmail.com'),
('Khalid', 3, 'Customer Service Representative', 'khalid@gmail.com'),
('Talhah', 1, 'Warehouse Worker', 'talhah@gmail.com'),
('Zubair', 2, 'Logistics Coordinator', 'zubair@gmail.com'),
('Sa-d', 3, 'Quality Inspector', 'sa_d@gmail.com');

SELECT * FROM Employees;

-- Insert sample data into Suppliers
INSERT INTO Suppliers (SupplierName, ContactNumber, Email)
VALUES 
('Kazi Farms Kitchen', '02 961229093', 'info@kazifarms.com'),
('CP Five Star', '01713164396', 'info.food@cpbangladesh.com'),
('Golden Harvest', '02 88787847', 'info@goldenharvestbd.com'),
('ACI Foods', '02 8834121', 'info@aciexport.com'),
('Square Food & Beverage', '09-612-111-333', 'sfblcareline@squaregroup.com');

SELECT * FROM Suppliers;

-- Insert sample data into SupplierInventory
INSERT INTO SupplierInventory (SupplierID, ItemID, Quantity)
VALUES 
(3, 5, 125),
(1, 3, 750),
(5, 1, 300),
(2, 4, 425),
(4, 2, 500);

SELECT * FROM SupplierInventory;

-- Insert sample data into SupplierInventory
INSERT INTO DonationRequests (CharityID, RequestedItem, Quantity, RequestDate)
VALUES 
(1, 'Bread', 20, '2024-12-15'),
(2, 'Egg', 5, '2024-12-12'),
(3, 'Olive Oil', 10, '2024-12-21'),
(4, 'Rice', 25, '2024-12-18'),
(5, 'Lavender Essential Oil', 15, '2024-12-27'),
(1, 'Cheese', 2, '2024-12-24');

SELECT * FROM DonationRequests;

-- Insert sample data into Reports
INSERT INTO Reports (ReportType, GeneratedDate, Details)
VALUES 
('Monthly Donation Report', '2024-12-14', 'Detailed report of November donations'),
('Inventory Expiration Report', '2024-12-20', 'Report on items nearing expiration within 7 days'),
('Supplier Inventory Report', '2024-12-24', 'Summary of supplier inventory levels for December'),
('Charity Donation Summary', '2024-12-18', 'Total donations made to all charities this quarter'),
('Store Performance Report', '2024-12-22', 'Performance analysis of store sales and donations');

SELECT * FROM Reports;

-- Update queries
UPDATE Inventory
SET Quantity = Quantity - 20
WHERE ItemID = 1;

SELECT * FROM Inventory;

UPDATE Inventory
SET ExpirationDate = '2025-01-05'
WHERE ItemName = 'Egg';

SELECT * FROM Inventory;

UPDATE Stores
SET Address = 'Zakir Hossain Rd, Chattogram'
WHERE StoreID = 3;

SELECT * FROM Stores;

-- Delete queries
DELETE FROM Inventory
WHERE ExpirationDate < GETDATE();

DELETE FROM Donations
WHERE CharityID = 2;

-- Select queries
SELECT * 
FROM Inventory
WHERE ExpirationDate < DATEADD(DAY, 7, GETDATE());

SELECT * 
FROM DonationRequests
WHERE Quantity > 10;

-- Order by queries
SELECT * 
FROM Inventory
ORDER BY ExpirationDate ASC;

-- Order by ASC/DESC query
SELECT * 
FROM Donations
ORDER BY DonationDate DESC, Quantity ASC;

-- Min and Max functions
SELECT MIN(ExpirationDate) AS EarliestExpiration
FROM Inventory;

SELECT MAX(RequestDate) AS LatestRequest
FROM DonationRequests;

-- Count function
SELECT COUNT(*) AS EmployeeCount
FROM Employees
WHERE StoreID = 1;

-- Sum function
SELECT SUM(Quantity) AS TotalDonated
FROM Donations;

-- Avg function
SELECT AVG(Quantity) AS AverageQuantity
FROM Inventory;

-- Like operator
SELECT * 
FROM Inventory
WHERE ItemName LIKE '%Oil%';

-- Join queries
SELECT d.DonationID, c.CharityName, i.ItemName, d.Quantity
FROM Donations d
INNER JOIN Charities c ON d.CharityID = c.CharityID
INNER JOIN Inventory i ON d.ItemID = i.ItemID;

SELECT i.ItemName, i.Quantity, s.StoreName, s.Address
FROM Inventory i
INNER JOIN Stores s ON i.StoreID = s.StoreID;

SELECT si.SupplierInventoryID, si.Quantity, s.SupplierName, st.StoreName
FROM SupplierInventory si
INNER JOIN Suppliers s ON si.SupplierID = s.SupplierID
INNER JOIN Stores st ON si.StoreID = st.StoreID;

SELECT r.ReportID, r.ReportType, r.GeneratedDate, sup.SupplierName
FROM Reports r
INNER JOIN Suppliers sup ON r.SupplierID = sup.SupplierID;

SELECT r.ReportID, r.ReportType, r.GeneratedDate, e.EmployeeName, e.Role
FROM Reports r
INNER JOIN Employees e ON r.EmployeeID = e.EmployeeID;

-- Union query
SELECT StoreName AS Name, Address, ContactNumber, 'Store' AS Type
FROM Stores
WHERE ContactNumber LIKE '017%' 
UNION
SELECT CharityName AS Name, Address, ContactNumber, 'Charity' AS Type
FROM Charities
WHERE ContactNumber LIKE '017%';

-- Distinct query
SELECT DISTINCT Category
FROM Inventory;

-- Exists query
SELECT CASE 
           WHEN EXISTS (SELECT 1 FROM Inventory WHERE ItemName = 'Cheese') 
           THEN 'Item Exists' 
           ELSE 'Item Not Found' 
       END AS ItemStatus;

-- Case statement
SELECT ItemName,
       CASE 
           WHEN ExpirationDate < GETDATE() THEN 'Expired'
           WHEN ExpirationDate < DATEADD(DAY, 7, GETDATE()) THEN 'Near Expiration'
           ELSE 'Safe'
       END AS ExpiryStatus
FROM Inventory;

-- Having clause
SELECT Category, SUM(Quantity) AS TotalQuantity
FROM Inventory
GROUP BY Category
HAVING SUM(Quantity) > 50;

-- Left join
SELECT i.ItemName, s.SupplierName, si.Quantity
FROM Inventory i
LEFT JOIN SupplierInventory si ON i.ItemID = si.ItemID
LEFT JOIN Suppliers s ON si.SupplierID = s.SupplierID;

-- Inner join
SELECT dr.RequestID, c.CharityName, dr.RequestedItem, dr.Quantity
FROM DonationRequests dr
INNER JOIN Charities c ON dr.CharityID = c.CharityID;

-- Group by query
SELECT c.CharityName, SUM(d.Quantity) AS TotalDonated
FROM Donations d
INNER JOIN Charities c ON d.CharityID = c.CharityID
GROUP BY c.CharityName;