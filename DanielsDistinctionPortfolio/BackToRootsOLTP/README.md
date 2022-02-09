<a name="top"></a>

[<img src="https://user-images.githubusercontent.com/91146906/152112781-2de05074-70b1-436b-9bfb-860890cc1de1.svg" height="35"/>](../#top)
<hr>

# Back to Roots Bakery OLTP
[<img src="https://user-images.githubusercontent.com/91146906/152239160-8f8c18a2-e724-4be7-863d-bc94151212ce.svg" height="35"/>](#ExecutiveSummary)
[<img src="https://user-images.githubusercontent.com/91146906/152239264-50077b6e-0879-4769-acc2-f575593d26d0.svg" height="35"/>](#ProblemOpportunity)
[<img src="https://user-images.githubusercontent.com/91146906/152239346-9d454364-ab2b-4de9-a3a7-acd62969a90b.svg" height="35"/>](#DatabaseDesign)
[<img src="https://user-images.githubusercontent.com/91146906/152239424-a41f47e7-ca34-4c15-a454-a32c93cdac05.svg" height="35"/>](#SimulatingData)
[<img src="https://user-images.githubusercontent.com/91146906/152239510-6c631219-71bc-4281-9c8b-b9b1e805b3d8.svg" height="35"/>](#BuildScript)
[<img src="https://user-images.githubusercontent.com/91146906/152941367-252de8c0-9a0f-4659-86b6-944cdfefea93.svg" height="35"/>](#Queries)
[<img src="https://user-images.githubusercontent.com/91146906/152242345-ff52d28e-14c3-445d-bdec-a668a48bc4b4.svg" height="35"/>](#ViewFunctionSPROC)
[<img src="https://user-images.githubusercontent.com/91146906/152242423-78c24a7a-3937-4196-b97b-59fadedc3191.svg" height="35"/>](#Application)
[<img src="https://user-images.githubusercontent.com/91146906/152244444-33feb407-c877-4ea1-8486-490c4a8aec78.svg" height="35"/>](#DownloadExplore)
<hr>

<a name="ExecutiveSummary"></a>
## Executive Summary
Back to Roots Bakery is a (fictitious) health-conscious, community-centered bakery focused on helping people feel their best while still enjoying “going for ice cream.” The bakery makes and sells a variety of treats and comfort foods for in-store ordering, pre-ordered pick-up, and delivery. Orders can be placed using a variety of methods, including in-store, by phone, and online. In 2018, Back to Roots Bakery opened their first location in Boulder, Colorado and recently opened a new location in Longmont, Colorado. With this expansion, the bakery has seen an increase in demand. This proposed database will give Back to Roots Bakery the competitive advantage, customer insights, process optimization, and data-driven decision-making capabilities to compete in an increasingly competitive industry and to maximize their potential.
<br>
<br>
[<img src="https://user-images.githubusercontent.com/91146906/152072378-b0168a2d-e85c-47c6-a272-fcfb3f6a44ae.svg" height="35"/>](#top)

<a name="ProblemOpportunity"></a>
## The Problem and Opportunity
Back to Roots Bakery decided a database is necessary for several key reasons, including creating a competitive advantage and better meeting customer needs:
<ul>
  <li>A rise in the quantity of customers, employees, and orders following the opening of a new store location and the increased interest in health-conscious eating.</li>
  <li>The need to ensure optimal employee contribution and success in managing customer orders.</li>
  <li>The need to understand customer purchasing patterns–including what they are purchasing, when they are purchasing it, where they are purchasing it, and how they are purchasing it–to better meet customer demands and facilitate growth accordingly.</li>
  <li>The need to reduce inventory costs by purchasing inventory and producing products that align with customer demands.</li>
  <li>The need to compete in an increasingly competitive market of health conscious-eating, particularly in the Boulder area.</li>
  </li>The need to improve customer experience to facilitate customer satisfaction and loyalty.</li>
 </ul>
After seeing an increase in health-conscious eating and the success of the Boulder store location, Back to Roots Bakery expanded, opening a new location in Longmont, Colorado to meet this rising demand. With this, Back to Roots Bakery hired more employees and is seeing an increase in both customers and orders. Due to this growth, a database has become necessary to collect valuable data and facilitate its conversion into meaningful information from which data-driven decisions can be made. This database will provide access to valuable information, help analyze customer purchasing habits, improve employee productivity and success, aid in reducing costs, facilitate process optimization, and ultimately lead to improved performance and customer satisfaction through better decision making.
<br>
<br>With the increasing interest in health-conscious eating, particularly in the Boulder area, Back to Roots Bakery is facing more competition, meaning they must differentiate themselves with a competitive advantage. Despite the high initial cost, investment in this database will help provide that competitive advantage and be worthwhile in the long run. Ultimately, this database will guide Back to Roots Bakery’s competitive advantage through its enablement of improved decision-making leading to efficiency, customer satisfaction, and the automation of processes.

<br>[<img src="https://user-images.githubusercontent.com/91146906/152072378-b0168a2d-e85c-47c6-a272-fcfb3f6a44ae.svg" height="35"/>](#top)

<a name="DatabaseDesign"></a>
## Database Design: Entity Relationship Diagram (ERD)

<img width="1003" alt="Back to Roots OLTP ERD" src="https://user-images.githubusercontent.com/91146906/137017556-bae865cc-df49-48f9-9cf5-417b10a44c3f.png">

[<img src="https://user-images.githubusercontent.com/91146906/152072378-b0168a2d-e85c-47c6-a272-fcfb3f6a44ae.svg" height="35"/>](#top)

<a name="SimulatingData"></a>
## Simulating Data
Coming soon...
<br>
<br>
[<img src="https://user-images.githubusercontent.com/91146906/152072343-975b3adf-3d47-4d4b-8c3f-fd7b880f036d.svg" height="35"/>](#SimulatingData)
[<img src="https://user-images.githubusercontent.com/91146906/152072378-b0168a2d-e85c-47c6-a272-fcfb3f6a44ae.svg" height="35"/>](#top)

<a name="BuildScript"></a>
## Build Script
The Back to Roots build script creates the "BackToRoots" database if it does not exist, deletes tables if they exist, creates tables with the appropriate attributes and constraints, populates each table with data from CSV files, and then lists table names and row counts for confirmation. Due to the logic, the script can be run multiple times without error.
<br>
<br>
[<img src="https://user-images.githubusercontent.com/91146906/152126285-8e8e3552-4f25-4e80-89c7-e79000850553.svg" height="35"/>](../BackToRootsOLTP/BuildBackToRoots.sql)
<br>
<br>Below is the list of table names and row counts returned by the build script to confirm creation of the database:
<br>
<table>
  <tr>
    <th>Table</th>
    <th>Rows</th>
  </tr>
  <tr>
    <td>Customer</td>
    <td>7070</td>
  </tr>
  <tr>
    <td>CustomerOrder</td>
    <td>200000</td>
  </tr>
  <tr>
    <td>Diet</td>
    <td>6</td>
  </tr>
  <tr>
    <td>DietProduct</td>
    <td>143</td>
  </tr>
  <tr>
    <td>Employee</td>
    <td>20</td>
  </tr>
  <tr>
    <td>EmploymentHistory</td>
    <td>27</td>
  </tr>
  <tr>
    <td>OrderLine</td>
    <td>553042</td>
  </tr>
  <tr>
    <td>Position</td>
    <td>7</td>
  </tr>
  <tr>
    <td>Product</td>
    <td>33</td>
  </tr>
  <tr>
    <td>ProductType</td>
    <td>10</td>
  </tr>
  <tr>
    <td>RewardHistory</td>
    <td>10863</td>
  </tr>
  <tr>
    <td>RewardStatus</td>
    <td>5</td>
  </tr>
  <tr>
    <td>StoreLocation</td>
    <td>2</td>
  </tr>
</table>

[<img src="https://user-images.githubusercontent.com/91146906/152072378-b0168a2d-e85c-47c6-a272-fcfb3f6a44ae.svg" height="35"/>](#top)

<a name="Queries"></a>
## Queries
Several queries are written, each answering a question and serving a business purpose. In addition to the SQL to run in Microsoft SQL Server Management Studio, there are notes and code snippets for modifying the SQL to run in an Access database. Snapshots of the queries' output from Microsoft SQL Server Management Studio are included.

| Employees and Customers | Store Performance |
| :---: | :---: |
| [<img src="https://user-images.githubusercontent.com/91146906/153065868-ef86de4f-4b60-4e0a-8f62-4727e0237482.svg" height="35"/>](#Query1) <br> [<img src="https://user-images.githubusercontent.com/91146906/153066103-11454751-63e0-4911-882a-d4a9f3b88d5b.svg" height="35"/>](#Query2) | [<img src="https://user-images.githubusercontent.com/91146906/153084800-8ea76771-fa21-4745-9a9f-7bf597c82b69.svg" height="35"/>](#Query3) <br> [<img src="https://user-images.githubusercontent.com/91146906/153088131-f7b24d14-d806-4229-9493-3728751ad39f.svg" height="35"/>](#Query4) |
| **Orders**		        | **Products**			|
| [<img src="https://user-images.githubusercontent.com/91146906/153084586-fd19d670-3d80-4ef2-8b08-36822d9147e6.svg" height="35"/>](#Query5A) <br> [<img src="https://user-images.githubusercontent.com/91146906/153084631-94b27fb1-e299-4ff3-aec4-909ece47f15f.svg" height="35"/>](#Query5B) <br> [<img src="https://user-images.githubusercontent.com/91146906/153066618-2f6fa745-af8a-4849-9f87-b32cdc0ae8ad.svg" height="35"/>](#Query6A) <br> [<img src="https://user-images.githubusercontent.com/91146906/153066719-97bd6289-af04-4029-a497-ddce5f7eb115.svg" height="35"/>](#Query6B) | [<img src="https://user-images.githubusercontent.com/91146906/153066219-568e85e2-827b-4c13-abda-648a1ef9e85d.svg" height="35"/>](#Query7) <br> [<img src="https://user-images.githubusercontent.com/91146906/153084698-840b197f-6968-47a9-9b3c-9fae4255e1c7.svg" height="35"/>](#Query8A) <br> [<img src="https://user-images.githubusercontent.com/91146906/153084755-3a76869b-4ac5-4e64-8a07-9c156ea53138.svg" height="35"/>](#Query8B) |

[<img src="https://user-images.githubusercontent.com/91146906/152126285-8e8e3552-4f25-4e80-89c7-e79000850553.svg" height="35"/>](../BackToRootsOLTP/BackToRootsQueries.sql)

<a name="Query1"></a>
### Query 1: Birthdays
<b>Question:</b> List the rewards program customers who have a birthday this month and have placed an order over $10 in the last year. Union this with a list of current employees who have a birthday this month. Order by relation (customer or employee) descending and birthday. (Rows returned varies by month and year query is run.)
<br>
<br><b>Business Purpose:</b> This query will be run on the first day of every month to get a list of customers and employees meeting the criteria to receive a birthday promotion that month. It will allow Back-to-Roots Bakery to email their customers and employees a coupon on the first of the month with which to celebrate their birthday. This will help Back-to-Roots Bakery maintain good relationships with their customers and employees, and it will help incentivize customers to participate in the rewards program.
<br>
<br><b>Query:</b>
```SQL
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
```
<i>Access Note: When writing SQL for Access, similar result can be obtained by using </i>```DATE()```<i> rather than </i>```GETDATE()```<i>; using </i>```'yyyy'```<i> rather than </i>```YEAR```<i> in the </i>```DATEADD()```<i>; and not using </i>```CAST()```<i> in the </i>```DATEADD()```<i>.</i>
<br>
<br><b>Sample Output:</b>
<br>
<br>![Birthdays](https://user-images.githubusercontent.com/91146906/152905341-de7d0fe2-1693-4e81-a50a-7d45142050cb.png)

[<img src="https://user-images.githubusercontent.com/91146906/152072343-975b3adf-3d47-4d4b-8c3f-fd7b880f036d.svg" height="35"/>](#Queries)
[<img src="https://user-images.githubusercontent.com/91146906/152072378-b0168a2d-e85c-47c6-a272-fcfb3f6a44ae.svg" height="35"/>](#top)

<a name="Query2"></a>
### Query 2: Employee Performance
<b>Question:</b> Return the quantity of orders filled, quantity of products sold, and total sales for employees working in the front of house for the duration of their employment in that position. Include the store location and whether the position is current. Order by store location, position name descending, whether the position is current descending, and total sales descending. (16 rows)
<br>
<br><b>Business Purpose:</b> This query will allow Back-to-Roots management to monitor employee success for front of house workers based on how many orders they are filling, how many products they are selling, and how much money they are brining-in with their sales. Employee performance can be compared by normalizing it against the number of months an employee worked in the given position. This information will help Back-to-Roots management identify which employees are highly successful and should be considered for a raise or promotion and which employess might be struggling and need additional support or training.
<br>
<br><b>Query:</b>
```SQL
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
```
<i>Access Note: When writing SQL for Access, similar result can be obtained by using single quotes rather than double quotes in the employee name concatenation; using </i>```DATE()```<i> rather than </i>```GETDATE()```<i>; using </i>```'Front of House*'```<i> rather than </i>```'Front of House%'```<i> after the </i>```LIKE```<i> statement; using </i>```MONTH```<i> rather than </i>```'m'```<i> in the </i>```DATEDIFF()```<i>; and not using </i>```FORMAT()```<i> or </i>```CONVERT()```<i>.</i>
<br>
<br><b>Output:</b>
<br>
<br>![Query2](https://user-images.githubusercontent.com/91146906/152950929-cf051743-96fe-467d-89fc-fe463df615c0.png)

[<img src="https://user-images.githubusercontent.com/91146906/152072343-975b3adf-3d47-4d4b-8c3f-fd7b880f036d.svg" height="35"/>](#Queries)
[<img src="https://user-images.githubusercontent.com/91146906/152072378-b0168a2d-e85c-47c6-a272-fcfb3f6a44ae.svg" height="35"/>](#top)

<a name="Query3"></a>
### Query 3: Store Location Performance
<b>Question:</b> What are the total sales at each location every year? Pivot the output. (4 rows)
<br>
<br><b>Business Purpose:</b> This query will allow Back-to-Roots management to compare the yearly performance of each store location in terms of revenue. If one location is performing significantly better than another, strategies can be developed to transfer some of that demand from one location to another. It can also help identify if a location should close or remain open or if another location should open, perhaps close to a current location, given high demand. Lastly, this query can assist with staffing decisions. If one location is seeing high demand, it may need more staffing, while a slower location may need less staffing.
<br>
<br><b>Query:</b>
```SQL
SELECT *
INTO #tempPivot
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
FROM #tempPivot
ORDER BY Year;

DROP TABLE #tempPivot;
```
<i>Access Note: When writing SQL for Access, similar result can be obtained by modifying query as follows.</i>
```SQL
TRANSFORM SUM(Product.ProductPrice * OrderLine.Quantity) AS [Sales]
SELECT 
	YEAR(CustomerOrder.OrderDate) AS [Year],
	SUM(Product.ProductPrice * OrderLine.Quantity) AS [Total Sales]
FROM ((StoreLocation
INNER JOIN CustomerOrder
	ON StoreLocation.LocationID = CustomerOrder.LocationID)
INNER JOIN OrderLine
	ON CustomerOrder.OrderID = OrderLine.OrderID)
INNER JOIN Product
	ON Product.ProductID = OrderLine.ProductID
GROUP BY YEAR(CustomerOrder.OrderDate)
PIVOT StoreLocation.LocationCity;
```
<b>Output:</b>
<br>
<br>![StoreLocationPerformance](https://user-images.githubusercontent.com/91146906/153096095-e432837f-5f7b-4b46-8d30-02c6b83d2ce5.png)

[<img src="https://user-images.githubusercontent.com/91146906/152072343-975b3adf-3d47-4d4b-8c3f-fd7b880f036d.svg" height="35"/>](#Queries)
[<img src="https://user-images.githubusercontent.com/91146906/152072378-b0168a2d-e85c-47c6-a272-fcfb3f6a44ae.svg" height="35"/>](#top)

<a name="Query4"></a>
### Query 4: Quarterly Sales
<b>Question:</b> What are the total sales by quarter each year? Pivot the output. (4 rows)
<br>
<br><b>Business Purpose:</b> This query will allow Back-to-Roots management to identify seasonal trends in their business each year. Which quarters are the busiest and which quarters are the slowest? This information will help Back-to-Roots management properly staff their stores and purchase inventory. Perhaps seasonal employees are needed during busy quarters to optimize productivity and sales.
<br>
<br><b>Query:</b>
```SQL
SELECT *
INTO #tempPivot
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
FROM #tempPivot
ORDER BY Year;

DROP TABLE #tempPivot;
```
<i>Access Note: When writing SQL for Access, similar result can be obtained by modifying query as follows.</i>
```SQL
TRANSFORM SUM(Product.ProductPrice * OrderLine.Quantity) AS [Sales]
SELECT 
	YEAR(CustomerOrder.OrderDate) AS [Year],
	SUM(Product.ProductPrice * OrderLine.Quantity) AS [Total Sales]
FROM (CustomerOrder
INNER JOIN OrderLine
	ON CustomerOrder.OrderID = OrderLine.OrderID)
INNER JOIN Product
	ON Product.ProductID = OrderLine.ProductID
GROUP BY YEAR(CustomerOrder.OrderDate)
PIVOT 'Qtr ' & DATEPART('q', CustomerOrder.OrderDate);
```
<b>Output:</b>
<br>
<br>![QuarterlySales](https://user-images.githubusercontent.com/91146906/153096222-58c4fc80-bf23-41e7-aa10-30a6784b188e.png)

[<img src="https://user-images.githubusercontent.com/91146906/152072343-975b3adf-3d47-4d4b-8c3f-fd7b880f036d.svg" height="35"/>](#Queries)
[<img src="https://user-images.githubusercontent.com/91146906/152072378-b0168a2d-e85c-47c6-a272-fcfb3f6a44ae.svg" height="35"/>](#top)

<a name="Query5A"></a>
### Query 5A: Order Placement by Product Type
<b>Question:</b> By product type, how many orders have been placed using each of the order placement methods (in-store, online, phone)? Pivot the output. (10 rows)
<br>
<br><b>Business Purpose:</b> This query will allow Back-to-Roots management to understand how customers are placing their orders. Based on this information, management can determine how they should optimize processes to meet consumers' needs. If there is heavy online traffic, perhaps Back-to-Roots should improve their online-ordering system. If there is heavy in-store traffic, perhaps Back-to-Roots should consider rethinking the layout of the physical store space and optimizing this ordering system to meet the demand.
<br>
<br><b>Query:</b>
```SQL
SELECT *
INTO #tempPivot
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
FROM #tempPivot
ORDER BY [Product Type];

DROP TABLE #tempPivot;
```
<i>Access Note: When writing SQL for Access, similar result can be obtained by modifying query as follows.</i>
```SQL
TRANSFORM COUNT(CustomerOrder.OrderID) AS [Order Count]
SELECT 
	ProductType.ProductTypeName AS [Product Type], 
	COUNT(CustomerOrder.OrderID) AS [Quantity of Orders]
FROM ((CustomerOrder
INNER JOIN OrderLine
	ON CustomerOrder.OrderID = OrderLine.OrderID)
INNER JOIN Product
	ON Product.ProductID = OrderLine.ProductID)
INNER JOIN ProductType
	ON ProductType.ProductTypeID = Product.ProductTypeID
GROUP BY ProductType.ProductTypeName
ORDER BY ProductType.ProductTypeName
PIVOT CustomerOrder.OrderType;
```
<b>Output:</b>
<br>
<br>![Query5A](https://user-images.githubusercontent.com/91146906/152934792-80a48c20-9abe-4173-b6c3-d0f793dadd49.png)

[<img src="https://user-images.githubusercontent.com/91146906/152072343-975b3adf-3d47-4d4b-8c3f-fd7b880f036d.svg" height="35"/>](#Queries)
[<img src="https://user-images.githubusercontent.com/91146906/152072378-b0168a2d-e85c-47c6-a272-fcfb3f6a44ae.svg" height="35"/>](#top)

<a name="Query5B"></a>
### Query 5B: Total Sales by Order Placement
<b>Question:</b> What are the total sales by order placement method (in-store, online, phone) between the user input dates? Order descending by total sales. (Rows returned varies by input)
<br>
<br><b>Business Purpose:</b> This query will allow Back-to-Roots management to gain further insight into the information revealed by Query 5A, as they can filter by a specific date range. This will allow management to see more timely and relevant information in making their decisions. Perhaps the online platform was not popular in 2019 but was used much more frequently in 2020. This is timely information management needs to make the best decisions possible.
<br>
<br>User inputs to test:
<ul>
	<li>@beginDate = 1/1/2018 AND @endDate = 12/31/2018 (2 rows)</li>
	<li>@beginDate = 1/1/2019 AND @endDate = 12/31/2019 (3 rows)</li>
	<li>@beginDate = 4/1/2020 AND @endDate = 5/31/2020 (1 row)</li>
</ul>

<b>Query:</b>
```SQL
DECLARE @beginDate DATE = '1/1/2019';
DECLARE @endDate DATE = '12/31/2019';

SELECT
	CustomerOrder.OrderPlacement AS [Order Placement],
	'$' + CONVERT(NVARCHAR,SUM(Product.ProductPrice * OrderLine.Quantity),1) AS [Total Sales]
FROM (CustomerOrder
INNER JOIN OrderLine
	ON CustomerOrder.OrderID = OrderLine.OrderID)
INNER JOIN Product
	ON Product.ProductID = OrderLine.ProductID
WHERE CustomerOrder.OrderDate BETWEEN @beginDate AND @endDate
GROUP BY CustomerOrder.OrderPlacement
ORDER BY SUM(Product.ProductPrice * OrderLine.Quantity) DESC;
```
<i>Access Note: When writing SQL for Access, similar result can be obtained by removing the </i>```CONVERT()```<i> and the </i>```DECLARE```<i> statements.</i>
<br>
<br><b>Output:</b>
<br>
<br>![OrderPlacementB](https://user-images.githubusercontent.com/91146906/152925142-21d60a7e-d13a-4565-9b47-e7ad519ba723.png)

[<img src="https://user-images.githubusercontent.com/91146906/152072343-975b3adf-3d47-4d4b-8c3f-fd7b880f036d.svg" height="35"/>](#Queries)
[<img src="https://user-images.githubusercontent.com/91146906/152072378-b0168a2d-e85c-47c6-a272-fcfb3f6a44ae.svg" height="35"/>](#top)

<a name="Query6A"></a>
### Query 6A: Order Fulfillment by Product Type
<b>Question:</b> By product type, how many orders have been filled using each of the order received methods (delivery, in-store, pick-up)? Pivot the output. (10 rows)
<br>
<br><b>Business Purpose:</b> This query will allow Back-to-Roots management to understand how customers are receiving their orders. Based on this information, management can determine how they should optimize processes to meet consumers' needs. If there is high demand for delivery, Back-to-Roots needs to have the proper packaging and to-go materials, in addition to enough drivers, to fulfill these orders. Further, the packaging materials needed may vary by product type. For example, different packaging is needed to deliver cakes and drinks. If there is high demand for pick-up, Back-to-Roots needs the appropriate physical space and processes to provide this service in an organized and efficient manner.
<br>
<br><b>Query:</b>
```SQL
SELECT *
INTO #tempPivot
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
FROM #tempPivot
ORDER BY [Product Type];

DROP TABLE #tempPivot;
```
<i>Access Note: When writing SQL for Access, similar result can be obtained by modifying query as follows.</i>
```SQL
TRANSFORM COUNT(CustomerOrder.OrderID) AS [Order Count]
SELECT 
	ProductType.ProductTypeName AS [Product Type], 
	COUNT(CustomerOrder.OrderID) AS [Quantity of Orders]
FROM ((CustomerOrder
INNER JOIN OrderLine
	ON CustomerOrder.OrderID = OrderLine.OrderID)
INNER JOIN Product
	ON Product.ProductID = OrderLine.ProductID)
INNER JOIN ProductType
	ON ProductType.ProductTypeID = Product.ProductTypeID
GROUP BY ProductType.ProductTypeName
ORDER BY ProductType.ProductTypeName
PIVOT CustomerOrder.OrderFulfillment;
```
<b>Output:</b>
<br>
<br>![OrderFulfillmentA](https://user-images.githubusercontent.com/91146906/153096376-6491affa-ef11-48bf-9feb-eff29426e08e.png)

[<img src="https://user-images.githubusercontent.com/91146906/152072343-975b3adf-3d47-4d4b-8c3f-fd7b880f036d.svg" height="35"/>](#Queries)
[<img src="https://user-images.githubusercontent.com/91146906/152072378-b0168a2d-e85c-47c6-a272-fcfb3f6a44ae.svg" height="35"/>](#top)

<a name="Query6B"></a>
### Query 6B: Total Sales by Order Fulfillment
<b>Question:</b> What are the total sales by order fulfillment method (delivery, in-store, pick-up) between the user input dates? Order descending by total sales. (Rows returned varies by input)
<br>
<br><b>Business Purpose:</b> This query will allow Back-to-Roots management to gain further insight into the information revealed by Query 6A, as they can filter by a specific date range. This will allow management to see more timely and relevant information in making their decisions. Perhaps delivery was not popular in 2019 but became much more relevant in 2020 with the COVID-19 pandemic. This is timely information management needs to make the best decisions possible.
<br>
<br>User inputs to test:
<ul>
	<li>@beginDate = 1/1/2018 AND @endDate = 12/31/2018 (2 rows)</li>
	<li>@beginDate = 1/1/2019 AND @endDate = 12/31/2019 (3 rows)</li>
	<li>@beginDate = 4/1/2020 AND @endDate = 5/31/2020 (1 row)</li>
</ul>

<b>Query:</b>
```SQL
DECLARE @beginDate DATE = '1/1/2019';
DECLARE @endDate DATE = '12/31/2019';

SELECT
	CustomerOrder.OrderFulfillment AS [Order Fulfillment], 
	'$' + CONVERT(NVARCHAR,SUM(Product.ProductPrice * OrderLine.Quantity),1) AS [Total Sales]
FROM (CustomerOrder
INNER JOIN OrderLine
	ON CustomerOrder.OrderID = OrderLine.OrderID)
INNER JOIN PRODUCT
	ON Product.ProductID = OrderLine.ProductID
WHERE CustomerOrder.OrderDate BETWEEN @beginDate AND @endDate
GROUP BY CustomerOrder.OrderFulfillment
ORDER BY SUM(Product.ProductPrice * OrderLine.Quantity) DESC;
```
<i>Access Note: When writing SQL for Access, similar result can be obtained by removing the </i>```CONVERT()```<i> and the </i>```DECLARE```<i> statements.</i>
<br>
<br><b>Output:</b>
<br>
<br>![OrderFulfillmentB](https://user-images.githubusercontent.com/91146906/152920095-5e30b383-2204-4f3e-89c7-86d0857d9ec5.png)

[<img src="https://user-images.githubusercontent.com/91146906/152072343-975b3adf-3d47-4d4b-8c3f-fd7b880f036d.svg" height="35"/>](#Queries)
[<img src="https://user-images.githubusercontent.com/91146906/152072378-b0168a2d-e85c-47c6-a272-fcfb3f6a44ae.svg" height="35"/>](#top)

<a name="Query7"></a>
### Query 7: Products Ordered by Month
<b>Question:</b> By product type and product, how many products have been purchased each month? Order by product type and product. Filter by year. Pivot the output. (33 rows)
<br>
<br><b>Business Purpose:</b> This query will assist Back-to-Roots management in identifying seasonal trends by product. In purchasing inventory and menu planning, Back-to-Roots management can refer to this query to determine which products should be available for a given month, in addition to what inventory is needed and at what volume.
<br>
<br><b>Query:</b>
```SQL
DECLARE @year INT = '2020';

SELECT *
INTO #tempPivot
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
	FORMAT([May],'###,###,###')		AS [May],
	FORMAT([June],'###,###,###')		AS [June],
	FORMAT([July],'###,###,###')		AS [July],
	FORMAT([August],'###,###,###')		AS [August],
	FORMAT([September],'###,###,###')	AS [September],
	FORMAT([October],'###,###,###')		AS [October],
	FORMAT([November],'###,###,###')	AS [November],
	FORMAT([December],'###,###,###')	AS [December]
FROM #tempPivot
ORDER BY 
	[Product Type], 
	[Product Name];
	
DROP TABLE #tempPivot;
```
<i>Access Note: When writing SQL for Access, similar result can be obtained by modifying query as follows (does not filter by year).</i>
```SQL
TRANSFORM SUM(OrderLine.Quantity) AS [Quantity Products Sold]
SELECT 
	ProductType.ProductTypeName AS [Product Type],
	Product.ProductName AS [Product Name], 
	SUM(OrderLine.Quantity) AS [Total Quantity Sold]
FROM ((ProductType
INNER JOIN Product
	ON ProductType.ProductTypeID = Product.ProductTypeID)
INNER JOIN OrderLine
	ON Product.ProductID = OrderLine.ProductID)
INNER JOIN CustomerOrder
	ON CustomerOrder.OrderID = OrderLine.OrderID
GROUP BY
	ProductType.ProductTypeName,
	Product.ProductName
ORDER BY 
	ProductType.ProductTypeName,
	Product.ProductName
PIVOT MONTHNAME(DATEPART('m', CustomerOrder.OrderDate)) IN (January, February, March, April, May, June, July, August, September, October, November, December);
```
<b>Output:</b>
<br>
<br>![ProductsByMonth](https://user-images.githubusercontent.com/91146906/153096881-2c546f08-353c-4a33-a069-5cbf6ef91719.png)

[<img src="https://user-images.githubusercontent.com/91146906/152072343-975b3adf-3d47-4d4b-8c3f-fd7b880f036d.svg" height="35"/>](#Queries)
[<img src="https://user-images.githubusercontent.com/91146906/152072378-b0168a2d-e85c-47c6-a272-fcfb3f6a44ae.svg" height="35"/>](#top)

<a name="Query8A"></a>
### Query 8A: Product Sales by Store Location
<b>Question:</b> For each product, display the price, quantity sold, and total sales at each store location. Order by store location, product type, and total sales descending. (64 rows)
<br>
<br><b>Business Purpose:</b> This query gives Back-to-Roots management insight into how products are selling at each location. Decisions can be made from this information regarding whether a location should stop selling a particular product or whether a location should consider selling a new product based on the success of other products.
<br>
<br><b>Query:</b>
```SQL
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
```
<i>Access Note: When writing SQL for Access, similar result can be obtained by removing the </i>```CONVERT()```<i> and </i>```FORMAT()```<i>.</i>
<br>
<br><b> Sample Output:</b>
<br>
<br>![ProductSalesByLoc](https://user-images.githubusercontent.com/91146906/153096678-beff702f-a3c3-45ac-a4d2-dbd4393c2c8f.png)

[<img src="https://user-images.githubusercontent.com/91146906/152072343-975b3adf-3d47-4d4b-8c3f-fd7b880f036d.svg" height="35"/>](#Queries)
[<img src="https://user-images.githubusercontent.com/91146906/152072378-b0168a2d-e85c-47c6-a272-fcfb3f6a44ae.svg" height="35"/>](#top)

<a name="Query8B"></a>
### Query 8B: Products Not Sold by Store Location
<b>Question:</b> List all the products that have never been ordered in Longmont within the user-input date range. (Rows returned varies by input)
<br>
<br><b>Business Purpose:</b> This query will allow Back-to-Roots management to gain further insight into the information revealed by Query 8A, as they can see which products have not been ordered at the Longmont location in a given date range. If these products are currently offered in Longmont and are not selling, perhaps they should be removed from the Longmont menu. Conversely, if these products are not currently offered, perhaps they should be, given the results of Query 6A indicate the product may be successful at this location.
<br>
<br>User inputs to test:
<ul>
	<li>@beginDate = 1/1/2018 AND @endDate = 3/1/2021 (2 rows)</li>
	<li>@beginDate = 11/1/2019 AND @endDate = 11/30/2019 (4 rows)</li>
	<li>@beginDate = 4/1/2020 AND @endDate = 5/31/2020 (6 rows)</li>
</ul>

<b>Query:</b>
```SQL
DECLARE @beginDate DATE = '4/1/2020';
DECLARE @endDate DATE = '5/31/2020';

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
		AND CustomerOrder.OrderDate BETWEEN @beginDate AND @endDate) AS LongmontOrder
ON Product.ProductID = LongmontOrder.ProductID
WHERE LongmontOrder.ProductID IS NULL;
```
<i>Access Note: When writing SQL for Access, similar result can be obtained by using </i>```'LONG*'```<i> rather than </i>```'LONG%'```<i> after the </i>```LIKE```<i> statement and by removing the </i>```DECLARE```<i> statements.</i>
<br>
<br><b>Output:</b>
<br>
<br>![ProductsNotSold](https://user-images.githubusercontent.com/91146906/153096756-58c9a0c1-b96d-4592-8d1c-d3ce0525fa9b.png)

[<img src="https://user-images.githubusercontent.com/91146906/152072343-975b3adf-3d47-4d4b-8c3f-fd7b880f036d.svg" height="35"/>](#Queries)
[<img src="https://user-images.githubusercontent.com/91146906/152072378-b0168a2d-e85c-47c6-a272-fcfb3f6a44ae.svg" height="35"/>](#top)

<a name="ViewFunctionSPROC"></a>
## View, Function, and Stored Procedure
[<img src="https://user-images.githubusercontent.com/91146906/152126285-8e8e3552-4f25-4e80-89c7-e79000850553.svg" height="35"/>](../BackToRootsOLTP/BackToRootsScript.sql)

### View: CurrentEmployee
The CurrentEmployee view lists all current employees and their information, excluding HR and payroll information (sensitive information). The purpose is to allow managers to see current employees, their position, and other relevant information without exposing sensitive HR and payroll information.
<br>
<br>The CurrentEmployee view is then used to create a list of the current employees' positions and contact information. The purpose is to share this list with staff members, so they can effectively communicate with the appropriate people when needed.

### Function: ufn_OrderTotal
The ufn_OrderTotal function calculates the order total for a specified order. The purpose is to quickly aggregate each line item and calculate the order total, so it is clear what customers need to pay. An order total needs to be calclated for every order placed, making it a highly purposeful user-defined function.

### Stored Procedure: usp_CustomerOrders
The usp_CustomerOrders stored procedure returns customer's order history. The purpose is to list every order placed by a customer, in addition to details regaring those orders, making it easy to track-down information regarding customers' orders if compliments, complaints, or questions arise. Additionally, it reveals the buying patterns of individual customers.
<br>
<br>
[<img src="https://user-images.githubusercontent.com/91146906/152072378-b0168a2d-e85c-47c6-a272-fcfb3f6a44ae.svg" height="35"/>](#top)

<a name="Application"></a>
## Order Management Application: Forms and Reports
This is a VB.NET application built using Microsoft Visual Studio, consisting of forms and reports that allow Back to Roots to interact with and gain insight from their OLTP. The forms support business operations, and the reports empower data-driven decision making.
<br>
<br>[<img src="https://user-images.githubusercontent.com/91146906/152129492-1c5f8b6c-1462-43d6-8d9e-f571185c5d48.svg" height="35"/>](#VideoDemo)
[<img src="https://user-images.githubusercontent.com/91146906/152121038-d7b30614-94b3-4e39-af73-e5dc5f7f3c35.svg" height="35"/>](../BackToRootsOLTP/BackToRootsForms/#top)
<br>[<img src="https://user-images.githubusercontent.com/91146906/152122847-b1e7132a-dfcb-4e29-a3a0-507e5eb44449.svg" height="35"/>](#ProductSalesReport)
[<img src="https://user-images.githubusercontent.com/91146906/152122928-5e85bc64-ca76-4228-abc1-0a2518d831ed.svg" height="35"/>](#EmployeePerformanceReport)
<br>
<a name="VideoDemo"></a>
### Video Demo
Below is a video demo of the application's forms and reports, followed by detailed descriptions and the code behind them.
<br>
<br><i>Unmute video for narration</i>

https://user-images.githubusercontent.com/91146906/137153830-d4bc600c-1931-483e-86c0-f72f6e6f0806.mp4

<br>[<img src="https://user-images.githubusercontent.com/91146906/152072343-975b3adf-3d47-4d4b-8c3f-fd7b880f036d.svg" height="35"/>](#Application)
[<img src="https://user-images.githubusercontent.com/91146906/152072378-b0168a2d-e85c-47c6-a272-fcfb3f6a44ae.svg" height="35"/>](#top)

<a name="ProductSalesReport"></a>
### Product Sales Report
The Product Sales report shows users the quantity sold and sales by product type and product yearly and monthly. The report can be filtered by month and location. Additionally, there are graphs displaying the sales by month and sales by product type.
<br>
<br> This report can inform decisions regarding the menu and purchasing of inventory.
<br>
<br>
![Back to Roots Product Sales Report](https://user-images.githubusercontent.com/91146906/137420652-78e29fc3-1a25-4691-b66a-8bf17649a969.png)
<br>
<br>The following query is used to create the Product Sales report.
```SQL
-- Select the appropriate data for the ProductSales Report
SELECT 
	YEAR(CustomerOrder.OrderDate) AS 'Year',
	MONTH(CustomerOrder.OrderDate) AS 'MonthSort',
	DATENAME(month, CustomerOrder.OrderDate) AS 'Month',
	CustomerOrder.LocationID, 
	ProductType.ProductTypeName, 
	Product.ProductName, 
	OrderLine.Quantity,
	OrderLine.Quantity*Product.ProductPrice AS Sales
FROM  CustomerOrder 
INNER JOIN OrderLine 
	ON CustomerOrder.OrderID = OrderLine.OrderID 
INNER JOIN Product 
	ON OrderLine.ProductID = Product.ProductID 
INNER JOIN ProductType 
	ON Product.ProductTypeID = ProductType.ProductTypeID
WHERE (CustomerOrder.LocationID IN (@Location)) AND (YEAR(CustomerOrder.OrderDate) = @Year);
```
[<img src="https://user-images.githubusercontent.com/91146906/152072343-975b3adf-3d47-4d4b-8c3f-fd7b880f036d.svg" height="35"/>](#Application)
[<img src="https://user-images.githubusercontent.com/91146906/152072378-b0168a2d-e85c-47c6-a272-fcfb3f6a44ae.svg" height="35"/>](#top)

<a name="EmployeePerformanceReport"></a>
### Employee Performance Report
The Employee Performance report allows users to select a date range then displays employee position information, in addition to the number of days worked, the orders filled, and the sales brought in. Additionally, there is a graph displaying the number of orders filled by employee.
<br>
<br> This report can inform wage, promotion, training, and firing decisions.
<br>
<br>
![Back to Roots Employee Performance Report](https://user-images.githubusercontent.com/91146906/137421507-f5d0e87b-41e3-42b0-bc51-acc61ccdb133.png)
<br>
<br>The following query is used to create the Employee Performance report.
```SQL
-- Select the appropriate data for the EmployeePerformance Report
SELECT
	EmploymentHistory.WageType,
	Position.PositionName,
	(Employee.EmployeeFirstName + ' ' + Employee.EmployeeLastName) AS 'EmployeeName',
	EmploymentHistory.Wage,
	IIF(EmploymentHistory.EndDate IS NULL, 'Current', 'End Dated') AS 'PositionStatus',
	COUNT(DISTINCT CustomerOrder.OrderDate) AS 'DaysWorked',
	COUNT(DISTINCT CustomerOrder.OrderID) AS 'OrdersFilled',
	SUM(OrderLine.Quantity*Product.ProductPrice) AS 'Sales'
FROM Position
INNER JOIN EmploymentHistory
	ON Position.PositionID = EmploymentHistory.PositionID
INNER JOIN Employee
	ON Employee.EmployeeID = EmploymentHistory.EmployeeID
INNER JOIN CustomerOrder
	ON Employee.EmployeeID = CustomerOrder.EmployeeID
INNER JOIN OrderLine
	ON CustomerOrder.OrderID = OrderLine.OrderID
INNER JOIN Product
	ON Product.ProductID = OrderLine.ProductID
WHERE 
	CustomerOrder.OrderDate BETWEEN EmploymentHistory.HireDate AND IIF(EmploymentHistory.EndDate IS NULL, GetDate(), EmploymentHistory.EndDate)
	AND CustomerOrder.OrderDate BETWEEN @ReportStartDate AND @ReportEndDate
GROUP BY
	Position.PositionName,
	EmploymentHistory.WageType,
	(Employee.EmployeeFirstName + ' ' + Employee.EmployeeLastName),
	EmploymentHistory.Wage,
	IIF(EmploymentHistory.EndDate IS NULL, 'Current', 'End Dated');
```

[<img src="https://user-images.githubusercontent.com/91146906/152072343-975b3adf-3d47-4d4b-8c3f-fd7b880f036d.svg" height="35"/>](#Application)
[<img src="https://user-images.githubusercontent.com/91146906/152072378-b0168a2d-e85c-47c6-a272-fcfb3f6a44ae.svg" height="35"/>](#top)

<a name="DownloadExplore"></a>
## Download and Explore!
Want to explore the Back to Roots OLTP yourself? Download the BackToRootsOLTP.zip and open the readme.txt for instructions. This zip file contains all the project's components.
<br>
<br>[<img src="https://user-images.githubusercontent.com/91146906/152245279-8e2a2d13-3ea0-4f4d-bd19-131e8d895360.svg" height="35"/>](../BackToRootsOLTP/BackToRootsOLTP.zip)
<br>
<br><i>Note: You must have Microsoft SQL Server Management Studio and Visual Studio installed on your machine.</i>
<br>
<br>
[<img src="https://user-images.githubusercontent.com/91146906/152072378-b0168a2d-e85c-47c6-a272-fcfb3f6a44ae.svg" height="35"/>](#top)
