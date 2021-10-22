<a name="top"></a>

# Back to Roots Bakery OLAP
[Executive Summary](#ExecutiveSummary) | [Business Requirements](#BusinessRequirements) | [Data Mart Design](#DataMartDesign) |
<br>[Build Script](#BuildScript) | [ETL](#ETL) | [Download and Explore!](#DownloadExplore)

<a name="ExecutiveSummary"></a>
## Executive Summary
Back-to-Roots Bakery is a health-conscious, community-centered bakery focused on helping people feel their best while still enjoying “going for ice cream.” The bakery makes and sells a variety of treats and comfort foods for in-store ordering, pre-ordered pick-up, and delivery. Orders can be placed using a variety of methods, including in-store, by phone, and online. In 2018, Back-to-Roots Bakery opened their first location in Boulder, Colorado and recently opened a new location in Longmont, Colorado. With this expansion, the bakery has seen an increase in demand.
<br>
<br>The Back-to-Roots OLTP gives Back-to-Roots Bakery the competitive advantage, customer insights, process optimization, and data-driven decision-making capabilities to compete in an increasingly competitive industry and to maximize their potential. However, Back-to-Roots has grown beyond their needs for a traditional OLTP, and due to the volume of data coming into the Back-to-Roots OLTP, the need to create a data mart is realized for the following reasons: (1) optimize reporting, (2) archive data, and (3) consolidate data. With particular emphasis on optimizing reporting, a data mart will allow faster reporting design and results at Back-to-Roots Bakery, empowering a focus on analysis and data-driven decision making to continue competing in the industry and maximizing potential, building upon the goals and benefits of the OLTP.
<br>

<a name="BusinessRequirements"></a>
## Business Requirements
<b>Chief Operating Officer (COO):</b> <i>What is the quantity of sales monthly, seasonally, and yearly summarized by product, product type, and diet, in addition to location and order fulfillment?</i>
<blockquote>This analysis will allow the COO to understand demand for products and order fulfillment at each location, informing decisions regarding what products should be stocked and which order fulfillment methods should be supported for those products.</blockquote>

<b>Hiring Manager:</b> <i>What are the sales monthly, quarterly, and yearly summarized by location, position name, and employee, with an indicator for number of days worked by the employee?</i>
<blockquote>This analysis will inform the hiring manager of the sales brought in by each employee, including location, position, and days worked information. This provides information regarding employee performance in terms of sales, informing decisions on allocation of support resources (including training), promotion, wage, and firing.</blockquote>

<b>Chief Marketing Officer (CMO):</b> <i>What are the sales monthly, quarterly, and yearly summarized by customer age and reward status, in addition to order placement method?</i>
<blockquote>This analysis will allow the CMO to understand the demographics, loyalty, and order placement habits of customers in terms of sales. This information will inform marketing and promotion decisions to reach customers and establish loyalty, in addition to the development and support of the appropriate order placement platforms.</blockquote>

<a name="DataMartDesign"></a>
## Data Mart Design
### Information Package

![BackToRootsDMInformationPackage](https://user-images.githubusercontent.com/91146906/138394990-ba725c47-4bd2-4478-aa8c-23640d321c27.png)

### Snowflake Schema

![BackToRootsDMSnowflakeSchema](https://user-images.githubusercontent.com/91146906/138395442-53585d50-d802-4794-bf6c-3b6ec1aeb7df.png)

<a name="BuildScript"></a>
## Build Script
The Back to Roots data mart build script creates the "BackToRootsDM" data mart if it does not exist, deletes tables if they exist, and creates dimension tables and the fact table with the appropriate attributes and constraints. Due to the logic, the script can be run multiple times without error.
<br>
<br><i>See the BuildBackToRootsDM.sql build script [here](../BackToRootsOLAP/BuildBackToRootsDM.sql).</i>

<a name="ETL"></a>
## Extract, Transform, and Load the Data Mart
Using Visual Studio and SSIS, data is extracted from the Back to Roots OLTP, transformed, and loaded into the data mart.

![BackToRootsDMETL](https://user-images.githubusercontent.com/91146906/138397836-485fec03-a356-45c7-9377-3f0d16099afe.png)

### DimDate
DimDate is loaded using the LoadDimDate.sql SQL query found [here](../BackToRootsOLAP/LoadDimDate.sql)

### DimProduct
DimProduct is loaded using the following SQL query
```SQL
-- BackToRootsDM DimProduct Source Query Written by Hannah McDonald
-- Originally Written: October 2021 | Updated October 2021
---------------------------------------------------------------
-- Script query to select products for DimProduct
SELECT
	BackToRoots.dbo.Product.ProductID,
	BackToRoots.dbo.ProductType.ProductTypeName AS ProductType,       -- Type 0: Fixed
	BackToRoots.dbo.Product.ProductName AS ProductName,               -- Type 0: Fixed
	-- Subquery to get multiple diets on one line to show in single record
	STUFF((SELECT ', ' + BackToRoots.dbo.Diet.DietName
		   FROM BackToRoots.dbo.DietProduct
		   LEFT OUTER JOIN BackToRoots.dbo.Diet
				ON BackToRoots.dbo.Diet.DietID = BackToRoots.dbo.DietProduct.DietID
			WHERE BackToRoots.dbo.DietProduct.ProductID = BackToRoots.dbo.Product.ProductID
			FOR XML PATH('')),1,1,'') AS Diet,                -- Type 0: Fixed
	BackToRoots.dbo.Product.ProductPrice AS ProductPrice              -- Type 2: Historical
FROM BackToRoots.dbo.Product
LEFT OUTER JOIN BackToRoots.dbo.ProductType
	ON BackToRoots.dbo.ProductType.ProductTypeID = BackToRoots.dbo.Product.ProductTypeID;
```

### DimPosition
DimPosition is loaded using the following SQL query
```SQL
-- BackToRootsDM DimPosition Source Query Written by Hannah McDonald
-- Originally Written: October 2021 | Updated October 2021
---------------------------------------------------------------
-- Script query to select positions for DimPosition
SELECT
	BackToRoots.dbo.Position.PositionID,
	BackToRoots.dbo.Position.PositionType,	-- Type 0: Fixed
	BackToRoots.dbo.Position.PositionName	-- Type 0: Fixed
FROM BackToRoots.dbo.Position;
```

### DimEmployee
DimEmployee is loaded using the following SQL query
```SQL
-- BackToRootsDM DimEmployee Source Query Written by Hannah McDonald
-- Originally Written: October 2021 | Updated October 2021
---------------------------------------------------------------
-- Script query to select employees for DimEmployee
SELECT
	BackToRoots.dbo.Employee.EmployeeID,
	BackToRoots.dbo.Employee.EmployeeFirstName AS FirstName,                    -- Type 0: Fixed
	BackToRoots.dbo.Employee.EmployeeLastName AS LastName                       -- Type 1: Changing
	BackToRoots.dbo.EmploymentHistory.WageType,                                 -- Type 0: Fixed
	ISNULL(BackToRoots.dbo.EmploymentHistory.Wage, -1) AS Wage,                 -- Type 0: Fixed      -- Replace null with illogical wage
	BackToRoots.dbo.EmploymentHistory.HireDate,                                 -- Type 0: Fixed
	ISNULL(BackToRoots.dbo.EmploymentHistory.EndDate, '9999-01-01') AS EndDate, -- Type 1: Changing   -- Replace null with illogical date
	BackToRootsDM.dbo.DimPosition.PositionSK                                    -- Type 0: Fixed
FROM BackToRoots.dbo.Employee
LEFT OUTER JOIN BackToRoots.dbo.EmploymentHistory
	ON BackToRoots.dbo.EmploymentHistory.EmployeeID = BackToRoots.dbo.Employee.EmployeeID
INNER JOIN BackToRootsDM.dbo.DimPosition
	ON BackToRootsDM.dbo.DimPosition.PositionAK = BackToRoots.dbo.EmploymentHistory.PositionID;
```

### DimReward
DimReward is loaded using the following SQL query
```SQL
-- BackToRootsDM DimReward Source Query Written by Hannah McDonald
-- Originally Written: October 2021 | Updated October 2021
---------------------------------------------------------------
-- Script query to select rewards for DimReward
SELECT
	BackToRoots.dbo.RewardStatus.RewardStatusID,
	BackToRoots.dbo.RewardStatus.RewardStatusName AS RewardStatus	-- Type 0: Fixed
FROM BackToRoots.dbo.RewardStatus;
```

### DimCustomer
DimCustomer is loaded using the following SQL query
```SQL
-- BackToRootsDM DimCustomer Source Query Written by Hannah McDonald
-- Originally Written: October 2021 | Updated October 2021
---------------------------------------------------------------
-- Script query to select customers for DimCustomer
SELECT
	Customer.CustomerID,
	ISNULL(Customer.CustomerDOB, '9999-01-01') AS DOB,                              -- Type 0: Fixed      -- Replace null with illogical date
	ISNULL(Customer.CustomerCity, 'N/A') AS City,                                   -- Type 1: Changing
	ISNULL(Customer.CustomerState, 'N/A') AS State,                                 -- Type 1: Changing
	ISNULL(Customer.CustomerZipCode, 00000) AS ZipCode,                             -- Type 1: Changing   -- Replace null with illogical zip code
	RewardHistory.RewardStatusJoinDate,                                             -- Type 0: Fixed
	ISNULL(RewardHistory.RewardStatusEndDate, '9999-01-01') AS RewardStatusEndDate, -- Type 1: Changing   -- Replace null with illogical date
	BackToRootsDM.dbo.DimReward.RewardSK                                            -- Type 0: Fixed
FROM BackToRoots.dbo.Customer
LEFT OUTER JOIN BackToRoots.dbo.RewardHistory
	ON BackToRoots.dbo.RewardHistory.CustomerID = BackToRoots.dbo.Customer.CustomerID
INNER JOIN BackToRootsDM.dbo.DimReward
	ON BackToRootsDM.dbo.DimReward.RewardAK = BackToRoots.dbo.RewardHistory.RewardStatusID;
```

### DimOrder
DimOrder is loaded using the following SQL query
```SQL
-- BackToRootsDM DimOrder Source Query Written by Hannah McDonald
-- Originally Written: October 2021 | Updated October 2021
---------------------------------------------------------------
-- Script query to select orders for DimOrder
SELECT
	BackToRoots.dbo.CustomerOrder.OrderID,                          -- Type 0: Fixed
	BackToRoots.dbo.CustomerOrder.OrderPlacement AS Placement,      -- Type 0: Fixed
	BackToRoots.dbo.CustomerOrder.OrderFulfillment AS Fulfillment,  -- Type 0: Fixed
	BackToRoots.dbo.StoreLocation.LocationStreetAddress,            -- Type 0: Fixed
	BackToRoots.dbo.StoreLocation.LocationCity,                     -- Type 0: Fixed
	BackToRoots.dbo.StoreLocation.LocationState,                    -- Type 0: Fixed
	BackToRoots.dbo.StoreLocation.LocationZipCode                   -- Type 0: Fixed
FROM BackToRoots.dbo.CustomerOrder
LEFT OUTER JOIN BackToRoots.dbo.StoreLocation
	ON BackToRoots.dbo.StoreLocation.LocationID = BackToRoots.dbo.CustomerOrder.LocationID;
```

### FactSales
FactSales is loaded using the following SQL query, then uses a series of lookups in the ETL to populate the SKs
```SQL
-- BackToRootsDM FactSales Source Query Written by Hannah McDonald
-- Originally Written: October 2021 | Updated October 2021
---------------------------------------------------------------
-- Script query to load the FactSales table
-- Use lookups in ETL to bring in SKs
SELECT 
	BackToRoots.dbo.CustomerOrder.OrderID,
	BackToRoots.dbo.Customer.CustomerID,
	BackToRoots.dbo.Employee.EmployeeID,
	BackToRoots.dbo.CustomerOrder.OrderDate,
	BackToRoots.dbo.Product.ProductID,
	BackToRoots.dbo.OrderLine.Quantity, 
	BackToRoots.dbo.Product.ProductPrice
FROM BackToRoots.dbo.Customer 
INNER JOIN BackToRoots.dbo.CustomerOrder 
	ON BackToRoots.dbo.Customer.CustomerID = BackToRoots.dbo.CustomerOrder.CustomerID 
INNER JOIN BackToRoots.dbo.Employee 
	ON BackToRoots.dbo.CustomerOrder.EmployeeID = BackToRoots.dbo.Employee.EmployeeID 
INNER JOIN BackToRoots.dbo.OrderLine 
	ON BackToRoots.dbo.CustomerOrder.OrderID = BackToRoots.dbo.OrderLine.OrderID 
INNER JOIN BackToRoots.dbo.Product 
	ON BackToRoots.dbo.OrderLine.ProductID = BackToRoots.dbo.Product.ProductID;
```
The lookups in the ETL, which popluate the SKs, are as follows

![BackToRootsDMLoadFactSales](https://user-images.githubusercontent.com/91146906/138399979-b6b7c8ec-0cf8-4f0a-8ef0-80fc0d892424.png)
