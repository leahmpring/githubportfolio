/*
Back-to-Roots Bakery Queries
Hannah McDonald
Updated: February 8, 2022
*/
USE BackToRoots
GO
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 
QUERY 1: Birthdays

Question:
List the rewards program customers who have a birthday this month and have placed an order over $10 in the last year. Union this with a list of current employees who have a birthday this month.
Order by relation (customer or employee) descending and birthday. (Rows returned varies by month and year query run.)

Business Purpose:
This query will be run on the first day of every month to get a list of customers and employees meeting the criteria to receive a birthday promotion that month. It will allow Back-to-Roots Bakery 
to email their customers and employees a coupon on the first of the month with which to celebrate their birthday. This will help Back-to-Roots Bakery maintain good relationships with their
customers and employees, and it will help incentivize customers to participate in the rewards program.
*/
	SELECT 
		Customer.CustomerFirstName AS [First Name],
		Customer.CustomerLastName AS [Last Name],
		Customer.CustomerDOB AS [Birthday],
		Customer.CustomerEmail AS [Email],
		'Customer' AS [Relation]
	FROM Customer
	JOIN RewardHistory
		ON Customer.CustomerID = RewardHistory.CustomerID
		AND RewardHistory.RewardStatusEndDate IS NULL
	WHERE 
		RewardHistory.RewardStatusID <> 'NO-R'
		AND MONTH(Customer.CustomerDOB) = MONTH(GETDATE())
		AND CUSTOMER.CustomerID IN 
			(SELECT DISTINCT CustomerOrder.CustomerID
			FROM (CustomerOrder
			INNER JOIN OrderLine
				ON CustomerOrder.OrderID = OrderLine.OrderID)
			INNER JOIN Product
				ON Product.ProductID = OrderLine.ProductID
			WHERE 
				CustomerOrder.OrderDate BETWEEN DATEADD(YEAR,-1,CAST(GETDATE() AS Date)) AND GETDATE()
				AND (Product.ProductPrice * OrderLine.Quantity) > 10)
UNION
	SELECT
		Employee.EmployeeFirstName,
		Employee.EmployeeLastName,
		Employee.EmployeeDOB,
		Employee.EmployeeEmail,
		'Employee' AS [Relation]
	FROM EMPLOYEE
	WHERE 
		MONTH(Employee.EmployeeDOB) = MONTH(GETDATE())
		AND Employee.EmployeeID IN 	
			(SELECT EmploymentHistory.EmployeeID
			FROM EmploymentHistory
			WHERE EmploymentHistory.EndDate IS NULL)
ORDER BY 
	[Relation] DESC, 
	[Birthday];
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUERY 2: Employee Performance

Question:
Return the quantity of orders filled, quantity of products sold, and total sales for employees working in the front of house for the duration of their employment in that position.
Include the store location and whether the position is current. Order by store location, position name descending, whether the position is current descending, and total sales descending. (16 rows)

Business Purpose:
This query will allow Back-to-Roots management to monitor employee success for front of house workers based on how many orders they are filling, how many products they are selling, and how much 
money they are brining-in with their sales. Employee performance can be compared by normalizing it against the number of months an employee worked in the given position. This information will help 
Back-to-Roots management identify which employees are highly successful and should be considered for a raise or promotion and which employess might be struggling and need additional support or training.
*/
SELECT 
	StoreLocation.LocationID AS [Location],
	Position.PositionName AS [Position],
	(Employee.EmployeeFirstName + ' ' + Employee.EmployeeLastName) AS [Employee Name],
	IIF(EmploymentHistory.EndDate IS NULL, 'Current', 'End Dated') AS [Position Current?],
	IIF(EmploymentHistory.EndDate IS NULL, DATEDIFF(MONTH, EmploymentHistory.HireDate, GETDATE()), DATEDIFF(MONTH, EmploymentHistory.HireDate, EmploymentHistory.EndDate)) AS [Months in Position],
	FORMAT(COUNT(CustomerOrder.OrderID),'###,###,###') AS [Quantity of Orders Filled],
	FORMAT(SUM(OrderLine.Quantity),'###,###,###') AS [Quantity of Product Sold], 
	'$' + CONVERT(NVARCHAR,SUM(Product.ProductPrice * OrderLine.Quantity),1) AS [Total Sales]
FROM (((((Position
INNER JOIN EmploymentHistory
	ON Position.PositionID = EmploymentHistory.PositionID)
INNER JOIN Employee
	ON Employee.EmployeeID = EmploymentHistory.EmployeeID)
INNER JOIN CustomerOrder
	ON Employee.EmployeeID = CustomerOrder.EmployeeID)
INNER JOIN StoreLocation
	ON StoreLocation.LocationID = CustomerOrder.LocationID)
INNER JOIN OrderLine
	ON CustomerOrder.OrderID = OrderLine.OrderID)
INNER JOIN Product
	ON Product.ProductID = OrderLine.ProductID
WHERE 
	Position.PositionName LIKE 'Front of House%'
	AND CustomerOrder.OrderDate BETWEEN EmploymentHistory.HireDate AND IIF(EmploymentHistory.EndDate IS NULL, GETDATE(), EmploymentHistory.EndDate)
GROUP BY 
	StoreLocation.LocationID,
	Position.PositionName,
	(Employee.EmployeeFirstName + ' ' + Employee.EmployeeLastName),
	IIF(EmploymentHistory.EndDate IS NULL, DATEDIFF(MONTH, EmploymentHistory.HireDate, GETDATE()), DATEDIFF(MONTH, EmploymentHistory.HireDate, EmploymentHistory.EndDate)),
	IIF(EmploymentHistory.EndDate IS NULL, 'Current', 'End Dated')
ORDER BY 
	StoreLocation.LocationID,
	Position.PositionName DESC,
	IIF(EmploymentHistory.EndDate IS NULL, 'Current', 'End Dated') DESC,
	SUM(Product.ProductPrice * OrderLine.Quantity) DESC;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUERY 3: Products Ordered by Month

Question:
By product type and product, how many products have been purchased each month? Order by product type and product. Filter by year. Pivot the output. (33 rows)

Business Purpose:
This query will assist Back-to-Roots management in identifying seasonal trends by product. In purchasing inventory and menu planning, Back-to-Roots management can refer to this query to 
determine which products should be available for a given month, in addition to what inventory is needed and at what volume.
*/
DECLARE @year INT = '2020';

SELECT *
INTO #tempPivot3
FROM (SELECT 
	ProductType.ProductTypeName AS [Product Type],
	Product.ProductName AS [Product Name],
	DATENAME(MONTH, CustomerOrder.OrderDate) AS [Month],
	SUM(OrderLine.Quantity) AS [Total Quantity Sold]
FROM ProductType
INNER JOIN Product
	ON ProductType.ProductTypeID = Product.ProductTypeID
INNER JOIN OrderLine
	ON Product.ProductID = OrderLine.ProductID
INNER JOIN CustomerOrder
	ON CustomerOrder.OrderID = OrderLine.OrderID
WHERE YEAR(CustomerOrder.OrderDate) = @year
GROUP BY
	ProductType.ProductTypeName,
	Product.ProductName,
	DATENAME(MONTH, CustomerOrder.OrderDate)) AS MonthlyOrderData
PIVOT(SUM([Total Quantity Sold])
    FOR [Month] IN ([January],[February],[March],[April],[May],[June],[July],[August],[September],[October],[November],[December])) AS MonthNamePivot;

SELECT
	[Product Type],
	[Product Name],
	FORMAT([January],'###,###,###')		AS [January],
	FORMAT([February],'###,###,###')	AS [February],
	FORMAT([March],'###,###,###')		AS [March],
	FORMAT([April],'###,###,###')		AS [April],
	FORMAT([May],'###,###,###')			AS [May],
	FORMAT([June],'###,###,###')		AS [June],
	FORMAT([July],'###,###,###')		AS [July],
	FORMAT([August],'###,###,###')		AS [August],
	FORMAT([September],'###,###,###')	AS [September],
	FORMAT([October],'###,###,###')		AS [October],
	FORMAT([November],'###,###,###')	AS [November],
	FORMAT([December],'###,###,###')	AS [December]
FROM #tempPivot3
ORDER BY 
	[Product Type], 
	[Product Name];
	
DROP TABLE #tempPivot3;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUERY 4A: Order Fulfillment

Question:
By product type, how many orders have been filled using each of the order received methods (delivery, in-store, pick-up)? Pivot the output. (10 rows)

Business Purpose:
This query will allow Back-to-Roots management to understand how customers are receiving their orders. Based on this information, management can determine how they should optimize processes 
to meet consumers' needs. If there is high demand for delivery, Back-to-Roots needs to have the proper packaging and to-go materials, in addition to enough drivers, to fulfill these orders. 
Further, the packaging materials needed may vary by product type. For example, different packaging is needed to deliver cakes and drinks. If there is high demand for pick-up, Back-to-Roots 
needs the appropriate physical space and processes to provide this service in an organized and efficient manner.
*/
SELECT *
INTO #tempPivot4A
FROM (SELECT 
	ProductType.ProductTypeName AS [Product Type],
	CustomerOrder.OrderFulfillment,
	COUNT(CustomerOrder.OrderID) AS [Quantity of Orders]
FROM CustomerOrder
INNER JOIN OrderLine
	ON CustomerOrder.OrderID = OrderLine.OrderID
INNER JOIN Product
	ON Product.ProductID = OrderLine.ProductID
INNER JOIN ProductType
	ON ProductType.ProductTypeID = Product.ProductTypeID
GROUP BY 
	ProductType.ProductTypeName,
	CustomerOrder.OrderFulfillment) AS OrderData
PIVOT(SUM([Quantity of Orders])
	FOR OrderFulfillment IN ([Delivery],[In-Store],[Pick-Up])) AS FulfillmentPivot;

SELECT
	[Product Type],
	FORMAT([Delivery],'###,###,###') AS [Delivery],
	FORMAT([In-Store],'###,###,###') AS [In-Store],
	FORMAT([Pick-Up],'###,###,###') AS [Pick-Up]
FROM #tempPivot4A
ORDER BY [Product Type];

DROP TABLE #tempPivot4A;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUERY 4B: Order Fulfillment

Question:
What are the total sales by order fulfillment method (delivery, in-store, pick-up) between the user input dates? Order descending by total sales. (Rows returned varies by input)

Business Purpose:
This query will allow Back-to-Roots management to gain further insight into the information revealed by Query 4A, as they can filter by a specific date range. This will allow 
management to see more timely and relevant information in making their decisions. Perhaps delivery was not popular in 2019 but became much more relevant in 2020 with the COVID-19 pandemic.
This is timely information management needs to make the best decisions possible.

User Inputs:
1. @beginDate4B = 1/1/2018 AND @endDate4B = 12/31/2018 (2 rows)
2. @beginDate4B = 1/1/2019 AND @endDate4B = 12/31/2019 (3 rows)
3. @beginDate4B = 4/1/2020 AND @endDate4B = 5/31/2020 (1 row)
*/
DECLARE @beginDate4B DATE = '1/1/2019';
DECLARE @endDate4B DATE = '12/31/2019';

SELECT
	CustomerOrder.OrderFulfillment AS [Order Fulfillment], 
	'$' + CONVERT(NVARCHAR,SUM(Product.ProductPrice * OrderLine.Quantity),1) AS [Total Sales]
FROM (CustomerOrder
INNER JOIN OrderLine
	ON CustomerOrder.OrderID = OrderLine.OrderID)
INNER JOIN PRODUCT
	ON Product.ProductID = OrderLine.ProductID
WHERE CustomerOrder.OrderDate BETWEEN @beginDate4B AND @endDate4B
GROUP BY CustomerOrder.OrderFulfillment
ORDER BY SUM(Product.ProductPrice * OrderLine.Quantity) DESC;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUERY 5A: Order Placement

Question:
By product type, how many orders have been placed using each of the order placement methods (in-store, online, phone)? Pivot the output. (10 rows)

Bussiness Purpose:
This query will allow Back-to-Roots management to understand how customers are placing their orders. Based on this information, management can determine how they should optimize processes 
to meet consumers' needs. If there is heavy online traffic, perhaps Back-to-Roots should improve their online-ordering system. If there is heavy in-store traffic, perhaps Back-to-Roots should 
consider rethinking the layout of the physical store space and optimizing this ordering system to meet the demand.
*/
SELECT *
INTO #tempPivot5A
FROM (SELECT 
	ProductType.ProductTypeName AS [Product Type],
	CustomerOrder.OrderPlacement,
	COUNT(CustomerOrder.OrderID) AS [Quantity of Orders]
FROM CustomerOrder
INNER JOIN OrderLine
	ON CustomerOrder.OrderID = OrderLine.OrderID
INNER JOIN Product
	ON Product.ProductID = OrderLine.ProductID
INNER JOIN ProductType
	ON ProductType.ProductTypeID = Product.ProductTypeID
GROUP BY 
	ProductType.ProductTypeName,
	CustomerOrder.OrderPlacement) AS OrderData
PIVOT(SUM([Quantity of Orders])
	FOR OrderPlacement IN ([In-Store],[Online],[Phone])) AS FulfillmentPivot;

SELECT
	[Product Type],
	FORMAT([In-Store],'###,###,###') AS [In-Store],
	FORMAT([Online],'###,###,###') AS [Online],
	FORMAT([Phone],'###,###,###') AS [Phone]
FROM #tempPivot5A
ORDER BY [Product Type];

DROP TABLE #tempPivot5A;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUERY 5B: Order Placement

Question:
What are the total sales by order placement method (in-store, online, phone) between the user input dates? Order descending by total sales. (Rows returned varies by input)

Business Purpose:
This query will allow Back-to-Roots management to gain further insight into the information revealed by Query 5A, as they can filter by a specific date range. This will allow 
management to see more timely and relevant information in making their decisions. Perhaps the online platform was not popular in 2019 but was used much more frequently in 2020.
This is timely information management needs to make the best decisions possible.

User Inputs:
1. @beginDate5B = 1/1/2018 AND @endDate5B = 12/31/2018 (2 rows)
2. @beginDate5B = 1/1/2019 AND @endDate5B = 12/31/2019 (3 rows)
3. @beginDate5B = 4/1/2020 AND @endDate5B = 5/31/2020 (2 rows)
*/
DECLARE @beginDate5B DATE = '1/1/2019';
DECLARE @endDate5B DATE = '12/31/2019';

SELECT
	CustomerOrder.OrderPlacement AS [Order Placement],
	'$' + CONVERT(NVARCHAR,SUM(Product.ProductPrice * OrderLine.Quantity),1) AS [Total Sales]
FROM (CustomerOrder
INNER JOIN OrderLine
	ON CustomerOrder.OrderID = OrderLine.OrderID)
INNER JOIN Product
	ON Product.ProductID = OrderLine.ProductID
WHERE CustomerOrder.OrderDate BETWEEN @beginDate5B AND @endDate5B
GROUP BY CustomerOrder.OrderPlacement
ORDER BY SUM(Product.ProductPrice * OrderLine.Quantity) DESC;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUERY 6A: Product Sales by Store Location

Question:
For each product, display the price, quantity sold, and total sales at each store location. Order by store location, product type, and total sales descending. (64 rows)

Business Purpose:
This query gives Back-to-Roots management insight into how products are selling at each location. Decisions can be made from this information regarding whether a location should stop selling 
a particular product or whether a location should consider selling a new product based on the success of other products.
*/
SELECT 
	StoreLocation.LocationID AS [Location], 
	ProductType.ProductTypeName AS [Product Type], 
	Product.ProductName, 
	'$' + CONVERT(NVARCHAR,Product.ProductPrice,1) AS [Product Price], 
	FORMAT(SUM(OrderLine.Quantity),'###,###,###') AS [Quantity Products Sold], 
	'$' + CONVERT(NVARCHAR,SUM(Product.ProductPrice * OrderLine.Quantity),1) AS [Total Sales]
FROM (((ProductType
INNER JOIN Product
	ON ProductType.ProductTypeID = Product.ProductTypeID)
INNER JOIN OrderLine
	ON Product.ProductID = OrderLine.ProductID)
INNER JOIN CustomerOrder
	ON CustomerOrder.OrderID = OrderLine.OrderID)
INNER JOIN StoreLocation
	ON StoreLocation.LocationID = CustomerOrder.LocationID
GROUP BY 
	StoreLocation.LocationID, 
	ProductType.ProductTypeName, 
	Product.ProductName, Product.ProductPrice
ORDER BY
	StoreLocation.LocationID, 
	ProductType.ProductTypeName, 
	SUM(Product.ProductPrice * OrderLine.Quantity) DESC;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUERY 6B: Product Sales by Store Location

Question:
List all the products that have never been ordered in Longmont within the user-input date range. (Rows returned varies by input)

Business Purpose:
This query will allow Back-to-Roots management to gain further insight into the information revealed by Query 6A, as they can see which products have not been ordered at the Longmont location in 
a given date range. If these products are currently offered in Longmont and are not selling, perhaps they should be removed from the Longmont menu. Conversely, if these products are not currently 
offered, perhaps they should be, given the results of Query 6A indicate the product may be successful at this location.

User Inputs:
1. @beginDate6B = 1/1/2018 AND @endDate6B = 3/1/2021 (2 rows)
2. @beginDate6B = 11/1/2019 AND @endDate6B = 11/30/2019 (4 rows)
3. @beginDate6B = 4/1/2020 AND @endDate6B = 5/31/2020 (6 rows)
*/
DECLARE @beginDate6B DATE = '4/1/2020';
DECLARE @endDate6B DATE = '5/31/2020';

SELECT
	Product.ProductName
FROM Product
LEFT OUTER JOIN
	(SELECT 
		OrderLine.ProductID
	FROM (StoreLocation
	INNER JOIN CustomerOrder
		ON StoreLocation.LocationID = CustomerOrder.LocationID)
	INNER JOIN OrderLine
		ON CustomerOrder.OrderID = OrderLine.OrderID
	WHERE 
		StoreLocation.LocationID LIKE 'LONG%'
		AND CustomerOrder.OrderDate BETWEEN @beginDate6B AND @endDate6B) AS LongmontOrder
ON Product.ProductID = LongmontOrder.ProductID
WHERE LongmontOrder.ProductID IS NULL;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUERY 7: Store Location Performance

Question:
What are the total sales at each location every year? Pivot the output. (4 rows)

Business Purpose:
This query will allow Back-to-Roots management to compare the yearly performance of each store location in terms of revenue. If one location is performing significantly better than another, 
strategies can be developed to transfer some of that demand from one location to another. It can also help identify if a location should close or remain open or if another location should
open, perhaps close to a current location, given high demand. Lastly, this query can assist with staffing decisions. If one location is seeing high demand, it may need more staffing, while
a slower location may need less staffing.
*/
SELECT *
INTO #tempPivot7
FROM (SELECT 
	YEAR(CustomerOrder.OrderDate) AS [Year],
	StoreLocation.LocationCity,
	SUM(Product.ProductPrice * OrderLine.Quantity) AS [Total Sales]
FROM ((StoreLocation
INNER JOIN CustomerOrder
	ON StoreLocation.LocationID = CustomerOrder.LocationID)
INNER JOIN OrderLine
	ON CustomerOrder.OrderID = OrderLine.OrderID)
INNER JOIN Product
	ON Product.ProductID = OrderLine.ProductID
GROUP BY 
	YEAR(CustomerOrder.OrderDate),
	StoreLocation.LocationCity) AS LocationSales
PIVOT(SUM([Total Sales])
	FOR LocationCity IN ([Boulder],[Longmont])) AS LocationPivot;

SELECT 
	Year, 
	'$' + CONVERT(NVARCHAR,Boulder,1) AS Boulder, 
	'$' + CONVERT(NVARCHAR,Longmont,1) AS Longmont
FROM #tempPivot7
ORDER BY Year;

DROP TABLE #tempPivot7;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
QUERY 8: Quarterly Sales

Question:
What are the total sales by quarter each year? Pivot the output. (4 rows)

Business Purpose:
This query will allow Back-to-Roots management to identify seasonal trends in their business each year. Which quarters are the busiest and which quarters are the slowest? This information 
will help Back-to-Roots management properly staff their stores and purchase inventory. Perhaps seasonal employees are needed during busy quarters to optimize productivity and sales.
*/
SELECT *
INTO #tempPivot8
FROM(SELECT 
	YEAR(CustomerOrder.OrderDate) AS [Year],
	DATEPART(QUARTER,CustomerOrder.OrderDate) AS [Quarter],
	SUM(Product.ProductPrice * OrderLine.Quantity) AS [Total Sales]
FROM (CustomerOrder
INNER JOIN OrderLine
	ON CustomerOrder.OrderID = OrderLine.OrderID)
INNER JOIN Product
	ON Product.ProductID = OrderLine.ProductID
GROUP BY 
	YEAR(CustomerOrder.OrderDate),
	DATEPART(QUARTER,CustomerOrder.OrderDate)) AS QuarterlySales
PIVOT(SUM([Total Sales])
	FOR [Quarter] IN ([1],[2],[3],[4])) AS QuarterPivot;

SELECT
	Year,
	'$' + CONVERT(NVARCHAR,[1],1) AS [Qtr 1],
	'$' + CONVERT(NVARCHAR,[2],1) AS [Qtr 2],
	'$' + CONVERT(NVARCHAR,[3],1) AS [Qtr 3],
	'$' + CONVERT(NVARCHAR,[4],1) AS [Qtr 4]
FROM #tempPivot8
ORDER BY Year;

DROP TABLE #tempPivot8;