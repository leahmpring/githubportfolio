<a name="top"></a>

# Back to Roots Bakery OLTP
[Executive Summary](ExecutiveSummary) | [The Problem and Opportunity](ProblemOpportunity) | [Database Design](DatabaseDesign) | [Build Script](BuildScript)

<a name="ExecutiveSummary"></a>
### Executive Summary
Back to Roots Bakery is a health-conscious, community-centered bakery focused on helping people feel their best while still enjoying “going for ice cream.” The bakery makes and sells a variety of treats and comfort foods for in-store ordering, pre-ordered pick-up, and delivery. Orders can be placed using a variety of methods, including in-store, by phone, and online. In 2018, Back to Roots Bakery opened their first location in Boulder, Colorado and recently opened a new location in Longmont, Colorado. With this expansion, the bakery has seen an increase in demand. This proposed database will give Back to Roots Bakery the competitive advantage, customer insights, process optimization, and data-driven decision-making capabilities to compete in an increasingly competitive industry and to maximize their potential.
<br>

<a name="ProblemOpportunity"></a>
### The Problem and Opportunity
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

<a name="DatabaseDesign"></a>
### Database Design: Entity Relationship Diagram (ERD)

<img width="1003" alt="Back to Roots OLTP ERD" src="https://user-images.githubusercontent.com/91146906/137017556-bae865cc-df49-48f9-9cf5-417b10a44c3f.png">

<a name="PopulatingData"></a>
### Populating Data
Coming soon...

<a name="BuildScript"></a>
### Build Script
The Back to Roots build script creates the "BackToRoots" database if it does not exist, deletes tables if they exist, creates tables with the appropriate attributes and constraints, populates each table with data from CSV files, and then lists table names and row counts for confirmation.
<br>
<br> Below is a sampling of my create table SQL statements:
```SQL
CREATE TABLE Customer
	(CustomerID             INT IDENTITY(0,1)   CONSTRAINT pk_customer PRIMARY KEY,
	CustomerFirstName       NVARCHAR(25)        CONSTRAINT nn_customer_first_name NOT NULL,
	CustomerLastName        NVARCHAR(25)        CONSTRAINT nn_customer_last_name NOT NULL,
	CustomerDOB             DATE,
	CustomerEmail           NVARCHAR(100),
	CustomerPhoneNumber     NVARCHAR(14),
	CustomerStreetAddress   NVARCHAR(50),
	CustomerCity            NVARCHAR(50),
	CustomerState           NVARCHAR(2),
	CustomerZipCode         NVARCHAR(11)
	);
  ```
```SQL
CREATE TABLE Employee
	(EmployeeID             INT IDENTITY(1,1)   CONSTRAINT pk_employee PRIMARY KEY,
	EmployeeFirstName       NVARCHAR(25)        CONSTRAINT nn_employee_first_name NOT NULL,
	EmployeeLastName        NVARCHAR(25)        CONSTRAINT nn_employee_last_name NOT NULL,
	EmployeeDOB             DATE                CONSTRAINT nn_employee_dob NOT NULL,
	EmployeeEmail           NVARCHAR(67)        CONSTRAINT nn_employee_email NOT NULL,
	EmployeePhoneNumber     NVARCHAR(14)        CONSTRAINT nn_employee_phone NOT NULL CONSTRAINT un_employee_phone UNIQUE,
	EmployeeStreetAddress   NVARCHAR(50)        CONSTRAINT nn_employee_street NOT NULL,
	EmployeeCity            NVARCHAR(50)        CONSTRAINT nn_employee_city NOT NULL,
	EmployeeState           NVARCHAR(2)         CONSTRAINT nn_employee_state NOT NULL,
	EmployeeZipCode         NVARCHAR(11)        CONSTRAINT nn_employee_zip NOT NULL
	);
  ```
```SQL
CREATE TABLE CustomerOrder
	(OrderID            INT IDENTITY(1,1)                 	CONSTRAINT pk_customer_order PRIMARY KEY,
	EmployeeID          INT                               	CONSTRAINT fk_order_employee_id FOREIGN KEY
		REFERENCES Employee(EmployeeID),
	LocationID          NVARCHAR(13)                      	CONSTRAINT fk_order_location_id FOREIGN KEY
		REFERENCES StoreLocation(LocationID),
	CustomerID          INT DEFAULT 0           		CONSTRAINT fk_order_customer_id FOREIGN KEY
		REFERENCES Customer(CustomerID),
	OrderDate           DATE DEFAULT GetDate()   		CONSTRAINT nn_order_date NOT NULL,
	OrderPlacement      NVARCHAR(10) DEFAULT 'In-Store'	CONSTRAINT ck_order_placement CHECK ((OrderPlacement = 'In-Store') OR (OrderPlacement = 'Online') OR (OrderPlacement = 'Phone')) NOT NULL,
	OrderFulfillment    NVARCHAR(10) DEFAULT 'In-Store'	CONSTRAINT ck_order_fulfillment CHECK ((OrderFulfillment = 'In-Store') OR (OrderFulfillment = 'Pick-Up') OR (OrderFulfillment = 'Delivery')) NOT NULL
	);
  ```
Below is a sampling of my SQL statements to load data from CSV files into the tables:
```SQL
EXECUTE (N'BULK INSERT CustomerOrder FROM ''' + @data_path + N'CustomerOrder.csv''
WITH (
	
	FIRSTROW = 2,
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	TABLOCK
	);
');
```
To confirm the creation of the database, the below list of table names and row counts is output by the following code:
```SQL
SET NOCOUNT ON
SELECT 'Customer' AS "Table",	COUNT(*) AS "Rows"	FROM Customer			UNION
SELECT 'RewardStatus',		COUNT(*)		FROM RewardStatus		UNION
SELECT 'RewardHistory',		COUNT(*)		FROM RewardHistory		UNION
SELECT 'Employee',		COUNT(*)		FROM Employee			UNION
SELECT 'Position',		COUNT(*)		FROM Position			UNION
SELECT 'EmploymentHistory',	COUNT(*)		FROM EmploymentHistory		UNION
SELECT 'Diet',			COUNT(*)		FROM Diet			UNION
SELECT 'ProductType',		COUNT(*)		FROM ProductType		UNION
SELECT 'Product',		COUNT(*)		FROM Product			UNION
SELECT 'DietProduct',		COUNT(*)		FROM DietProduct		UNION
SELECT 'StoreLocation',		COUNT(*)		FROM StoreLocation		UNION
SELECT 'CustomerOrder',		COUNT(*)		FROM CustomerOrder		UNION
SELECT 'OrderLine',		COUNT(*)		FROM OrderLine
ORDER BY 1;
SET NOCOUNT OFF
GO
```
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
