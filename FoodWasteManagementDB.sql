CREATE DATABASE FoodWasteManagementDB;
USE FoodWasteManagementDB;

-- Create tables
CREATE TABLE Inventory (
    ItemID INT PRIMARY KEY IDENTITY,
    ItemName VARCHAR(255),
    Category VARCHAR(255),
    Quantity INT,
    ExpirationDate DATE,
    Location VARCHAR(255)
);

CREATE TABLE Charities (
    CharityID INT PRIMARY KEY IDENTITY,
    CharityName VARCHAR(255),
    Address VARCHAR(255),
    ContactNumber VARCHAR(255)
);

CREATE TABLE Donations (
    DonationID INT PRIMARY KEY IDENTITY,
    ItemID INT FOREIGN KEY REFERENCES Inventory(ItemID),
    CharityID INT FOREIGN KEY REFERENCES Charities(CharityID),
    Quantity INT,
    DonationDate DATE
);

-- Insert sample data into Inventory
INSERT INTO Inventory (ItemName, Category, Quantity, ExpirationDate, Location)
VALUES 
('Bread', 'Bakery', 30, '2024-12-10', 'Warehouse A'),
('Egg', 'Dairy', 30, '2024-12-07', 'Warehouse B'),
('Olive Oil', 'Edible Oils', 50, '2025-01-01', 'Warehouse C'),
('Rice', 'Grains', 100, '2025-01-15', 'Warehouse A');

INSERT INTO Inventory (ItemName, Category, Quantity, ExpirationDate, Location)
VALUES 
('Lavender Essential Oil', 'Essential Oils', 20, '2026-06-15', 'Warehouse D');

INSERT INTO Inventory (ItemName, Category, Quantity, ExpirationDate, Location)
VALUES 
('Cheese', 'Dairy', 10, '2024-12-12', 'Warehouse B');

SELECT * FROM Inventory;

-- Insert sample data into Charities
INSERT INTO Charities (CharityName, Address, ContactNumber)
VALUES 
('As-Sunnah Foundation', 'Block C, 70, Road No. 3, Dhaka 1212.', '09610-001089'),
('Bangladesh Bondhu Foundation (BONDHU)', 'House -8, 12 BLOCK # B, Dhaka 1207.', '01833-104100'),
('BRAC', 'BRAC Centre 75 Mohakhali, Dhaka-1212.', '88 02 2222 81265'),
('Jaggo Foundation', 'Moti Jharna Ln, Chittagong.', '01766666654'),
('Nova Foundation', 'H# Padmarag, Yusuf Kazi Lane, Bogura 5800.', '09613-825925');

SELECT * FROM Charities;

-- Insert sample data into Donations
INSERT INTO Donations (ItemID, CharityID, Quantity, DonationDate)
VALUES 
(1, 1, 25, '2024-12-05'),
(4, 2, 15, '2024-12-07'),
(2, 3, 20, '2024-12-06'),
(3, 4, 10, '2024-12-09'), 
(4, 5, 5, '2024-12-12');

SELECT * FROM Donations;

-- Update the quantity of an inventory item
UPDATE Inventory
SET Quantity = Quantity - 25
WHERE ItemID = 1;

SELECT * FROM Inventory;

-- Update the expiration date of an inventory item
UPDATE Inventory
SET ExpirationDate = '2024-12-12'
WHERE ItemName = 'Egg';

SELECT * FROM Inventory;

-- Delete expired items from inventory
DELETE FROM Donations
WHERE CharityID = 5;

SELECT * FROM Donations;

-- Retrieve all items close to expiration
SELECT * 
FROM Inventory
WHERE ExpirationDate < DATEADD(DAY, 7, GETDATE());

-- Retrieve available items for donation
SELECT ItemName, Quantity
FROM Inventory
WHERE Quantity > 0;

-- Sort inventory items by expiration date
SELECT * 
FROM Inventory
ORDER BY ExpirationDate ASC;

-- Find the item with the earliest expiration date
SELECT MIN(ExpirationDate) AS EarliestExpiration
FROM Inventory;

-- Find the item with the latest expiration date
SELECT MAX(ExpirationDate) AS LatestExpiration
FROM Inventory;

-- Count items nearing expiration
SELECT COUNT(*) AS NearExpirationCount
FROM Inventory
WHERE ExpirationDate < DATEADD(DAY, 7, GETDATE());

-- Calculate total donated quantity
SELECT SUM(Quantity) AS TotalDonated
FROM Donations;

-- Find the average donation quantity
SELECT AVG(Quantity) AS AverageDonation
FROM Donations;

-- Search for items containing 'Oil'
SELECT * 
FROM Inventory
WHERE ItemName LIKE '%Oil%';

-- Match available inventory items with charities
SELECT i.ItemName, c.CharityName, d.Quantity
FROM Donations d
INNER JOIN Inventory i ON d.ItemID = i.ItemID
INNER JOIN Charities c ON d.CharityID = c.CharityID;

-- Merge inventory data from two warehouses
SELECT ItemName, Quantity, Location
FROM Inventory
WHERE Location = 'Warehouse A'
UNION
SELECT ItemName, Quantity, Location
FROM Inventory
WHERE Location = 'Warehouse B';

-- Retrieve unique food categories
SELECT DISTINCT Location
FROM Inventory;

-- Check if 'Rice' is in stock
SELECT CASE 
           WHEN EXISTS (SELECT 1 FROM Inventory WHERE ItemName = 'Rice') 
           THEN 'In Stock' 
           ELSE 'Out of Stock' 
       END AS StockStatus;

-- Categorize items based on expiration status
SELECT ItemName,
       CASE 
           WHEN ExpirationDate < GETDATE() THEN 'Expired'
           WHEN ExpirationDate < DATEADD(DAY, 7, GETDATE()) THEN 'Urgent Donation'
           ELSE 'Safe for Consumption'
       END AS ExpiryStatus
FROM Inventory;

-- Filter categories with high quantities of near-expiring items
SELECT Category, SUM(Quantity) AS TotalQuantity
FROM Inventory
WHERE ExpirationDate < DATEADD(DAY, 7, GETDATE())
GROUP BY Category
HAVING SUM(Quantity) > 20;

-- List all inventory items with associated donation records
SELECT i.ItemName, d.Quantity AS DonatedQuantity
FROM Inventory i
LEFT JOIN Donations d ON i.ItemID = d.ItemID;

-- Show items that have been donated and received by charities
SELECT i.ItemName, c.CharityName, d.Quantity
FROM Donations d
INNER JOIN Inventory i ON d.ItemID = i.ItemID
INNER JOIN Charities c ON d.CharityID = c.CharityID;

-- Group donations by food category
SELECT i.Category, SUM(d.Quantity) AS TotalDonated
FROM Donations d
INNER JOIN Inventory i ON d.ItemID = i.ItemID
GROUP BY i.Category;

-- Order donations by donation date in descending order
SELECT * 
FROM Donations
ORDER BY DonationDate DESC;
