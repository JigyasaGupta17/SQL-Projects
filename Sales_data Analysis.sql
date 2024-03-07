create database db_project1;
-- dentify the Records  present in data1 but missing in data2

SELECT COUNT(*) AS NumMissingRecords
FROM db_project1..data1
WHERE NOT EXISTS (
    SELECT 1
    FROM db_project1..data2
    WHERE data1.OrderID = data2.OrderID AND data1.ProductID = data2.ProductID
);
--dentify the Records  present in data2 but missing in data1
SELECT COUNT(*) AS NumMissingRecords
FROM db_project1..data2
WHERE NOT EXISTS (
    SELECT 1
    FROM db_project1..data1
    WHERE data1.OrderID = data2.OrderID AND data1.ProductID = data2.ProductID
);
--Sum of the total Qty of Records missing in data1 but present in data2
SELECT SUM(QTY)AS SUM_OF_TOTAL
FROM db_project1..data2
WHERE NOT EXISTS (
    SELECT 1 
	FROM db_project1..data1
	WHERE data1.OrderID = DATA2.OrderID AND data1.ProductID = data2.ProductID
	);
SELECT SUM(data2.Qty) AS TotalQtyMissing
FROM db_project1..data2
WHERE NOT EXISTS (
    SELECT 1
    FROM db_project1..data1
    WHERE data1.OrderID = data2.OrderID AND data1.ProductID = data2.ProductID
);
--total number of unique records present in the combined dataset of data1 and data2

SELECT COUNT(DISTINCT combined.OrderID + combined.ProductID) AS TotalUniqueRecords
FROM (
    SELECT OrderID, ProductID FROM db_project1..data1
    UNION
    SELECT OrderID, ProductID FROM db_project1..data2
) AS combined;


