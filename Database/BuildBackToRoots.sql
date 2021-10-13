-- BackToRoots Database Developed and Written by Hannah McDonald
-- Peer Reviewed by Emily Sandberg April 26, 2021
-- Originally Written: April 2021 | Updated: May 2021
---------------------------------------------------------------
-- Replace <data_path> with the full path to this file 
-- Ensure it ends with a backslash 
-- E.g., C:\MyDatabases\ See line 21
---------------------------------------------------------------
-- Create database if it does not exist
--
IF NOT EXISTS(SELECT * FROM sys.databases
	WHERE NAME = N'BackToRoots')
	CREATE DATABASE BackToRoots
GO
USE BackToRoots
--
-- Alter the path so the script can find the CSV files
--
DECLARE
	@data_path NVARCHAR(256);
SELECT @data_path = 'C:\BuildBackToRoots\';
--
-- Delete existing tables
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'OrderLine'
       )
	DROP TABLE OrderLine;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'CustomerOrder'
       )
	DROP TABLE CustomerOrder;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'StoreLocation'
       )
	DROP TABLE StoreLocation;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'DietProduct'
       )
	DROP TABLE DietProduct;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'Product'
       )
	DROP TABLE Product;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'ProductType'
       )
	DROP TABLE ProductType;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'Diet'
       )
	DROP TABLE Diet;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'EmploymentHistory'
       )
	DROP TABLE EmploymentHistory;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'Position'
       )
	DROP TABLE Position;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'Employee'
       )
	DROP TABLE Employee;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'RewardHistory'
       )
	DROP TABLE RewardHistory;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'RewardStatus'
       )
	DROP TABLE RewardStatus;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'Customer'
       )
	DROP TABLE Customer;
--
-- Create tables
--
CREATE TABLE Customer
	(CustomerID				INT IDENTITY(0,1) CONSTRAINT pk_customer PRIMARY KEY,
	CustomerFirstName		NVARCHAR(25) CONSTRAINT nn_customer_first_name NOT NULL,
	CustomerLastName		NVARCHAR(25) CONSTRAINT nn_customer_last_name NOT NULL,
	CustomerDOB				DATE,
	CustomerEmail			NVARCHAR(100),
	CustomerPhoneNumber		NVARCHAR(14),
	CustomerStreetAddress	NVARCHAR(50),
	CustomerCity			NVARCHAR(50),
	CustomerState			NVARCHAR(2),
	CustomerZipCode			NVARCHAR(11)
	);
--
CREATE TABLE RewardStatus
	(RewardStatusID			NVARCHAR(4) CONSTRAINT pk_reward_status PRIMARY KEY,
	RewardStatusName		NVARCHAR(10) CONSTRAINT nn_reward_status_name NOT NULL,
	RewardStatusDescription	NVARCHAR(100) CONSTRAINT nn_reward_status_description NOT NULL,
	RewardStatusPerks		NVARCHAR(100) CONSTRAINT nn_reward_status_perks NOT NULL
	);
--
CREATE TABLE RewardHistory
	(CustomerID				INT,
	RewardStatusID			NVARCHAR(4),
	RewardStatusJoinDate	DATE DEFAULT GETDATE(),
	RewardStatusEndDate		DATE,
	CONSTRAINT pk_reward_history PRIMARY KEY (CustomerID, RewardStatusID),
	CONSTRAINT fk_reward_history_customer_id FOREIGN KEY(CustomerID) 
		REFERENCES Customer(CustomerID),
	CONSTRAINT fk_reward_history_rewardstatus_id FOREIGN KEY(RewardStatusID) 
		REFERENCES RewardStatus(RewardStatusID)
	);
--
CREATE TABLE Employee
	(EmployeeID				INT IDENTITY(1,1) CONSTRAINT pk_employee PRIMARY KEY,
	EmployeeFirstName		NVARCHAR(25) CONSTRAINT nn_employee_first_name NOT NULL,
	EmployeeLastName		NVARCHAR(25) CONSTRAINT nn_employee_last_name NOT NULL,
	EmployeeDOB				DATE CONSTRAINT nn_employee_dob NOT NULL,
	EmployeeEmail			NVARCHAR(67) CONSTRAINT nn_employee_email NOT NULL,
	EmployeePhoneNumber		NVARCHAR(14) CONSTRAINT nn_employee_phone NOT NULL CONSTRAINT un_employee_phone UNIQUE,
	EmployeeStreetAddress	NVARCHAR(50) CONSTRAINT nn_employee_street NOT NULL,
	EmployeeCity			NVARCHAR(50) CONSTRAINT nn_employee_city NOT NULL,
	EmployeeState			NVARCHAR(2) CONSTRAINT nn_employee_state NOT NULL,
	EmployeeZipCode			NVARCHAR(11) CONSTRAINT nn_employee_zip NOT NULL
	);
--
CREATE TABLE Position
	(PositionID				INT IDENTITY(1,1) CONSTRAINT pk_position PRIMARY KEY,
	PositionType			NVARCHAR(9) CONSTRAINT ck_position_type CHECK ((PositionType = 'Part-Time') OR (PositionType = 'Full-Time')) NOT NULL,
	PositionName			NVARCHAR(25) CONSTRAINT nn_position_name NOT NULL
	);
--
CREATE TABLE EmploymentHistory
	(EmployeeID				INT,
	PositionID				INT,
	HireDate				DATE DEFAULT GETDATE() CONSTRAINT nn_hire_date NOT NULL,
	EndDate					DATE,
	WageType				NVARCHAR(6) DEFAULT 'Hourly' CONSTRAINT ck_wage_type CHECK ((WageType = 'Hourly') OR (WageType = 'Salary') OR (WageType = 'Draw')) NOT NULL,
	Wage					MONEY CONSTRAINT ck_wage CHECK (Wage >= 7.25),
	CONSTRAINT pk_employment_history PRIMARY KEY (EmployeeID, PositionID),
	CONSTRAINT fk_employment_history_employee_id FOREIGN KEY(EmployeeID) 
		REFERENCES Employee(EmployeeID),
	CONSTRAINT fk_employment_history_position_id FOREIGN KEY(PositionID) 
		REFERENCES Position(PositionID)
	);
--
CREATE TABLE Diet
	(DietID					NVARCHAR(3) CONSTRAINT pk_diet PRIMARY KEY,
	DietName				NVARCHAR(20) CONSTRAINT nn_diet_name NOT NULL,
	DietDescription			NVARCHAR(100) CONSTRAINT nn_diet_description NOT NULL
	);
--
CREATE TABLE ProductType
	(ProductTypeID			INT IDENTITY(1,1) CONSTRAINT pk_product_type PRIMARY KEY,
	ProductTypeName			NVARCHAR(15) CONSTRAINT nn_product_type_name NOT NULL
	);
--
CREATE TABLE Product
	(ProductID				NVARCHAR(8) CONSTRAINT pk_product PRIMARY KEY,
	ProductTypeID			INT CONSTRAINT fk_product_product_type_id FOREIGN KEY
		REFERENCES ProductType(ProductTypeID),
	ProductName				NVARCHAR(35) CONSTRAINT nn_product_name NOT NULL,
	ProductPrice			MONEY CONSTRAINT ck_product_price CHECK (ProductPrice >= 0) NOT NULL,
	ProductPhoto			IMAGE
	);
--
CREATE TABLE DietProduct
	(ProductID				NVARCHAR(8),
	DietID					NVARCHAR(3),
	CONSTRAINT pk_diet_product PRIMARY KEY (ProductID, DietID),
	CONSTRAINT fk_diet_product_product_id FOREIGN KEY(ProductID) 
		REFERENCES Product(ProductID),
	CONSTRAINT fk_diet_product_diet_id FOREIGN KEY(DietID) 
		REFERENCES Diet(DietID)
	);
--
CREATE TABLE StoreLocation
	(LocationID				NVARCHAR(13) CONSTRAINT pk_store_location PRIMARY KEY,
	LocationPhoneNumber		NVARCHAR(14) CONSTRAINT nn_location_phone NOT NULL,
	LocationStreetAddress	NVARCHAR(50) CONSTRAINT nn_location_street NOT NULL,
	LocationCity			NVARCHAR(50) CONSTRAINT nn_location_city NOT NULL,
	LocationState			NVARCHAR(2) CONSTRAINT nn_location_state NOT NULL,
	LocationZipCode			NVARCHAR(11) CONSTRAINT nn_location_zip NOT NULL
	);
--
--
CREATE TABLE CustomerOrder
	(OrderID				INT IDENTITY(1,1) CONSTRAINT pk_customer_order PRIMARY KEY,
	EmployeeID				INT CONSTRAINT fk_order_employee_id FOREIGN KEY
		REFERENCES Employee(EmployeeID),
	LocationID				NVARCHAR(13) CONSTRAINT fk_order_location_id FOREIGN KEY
		REFERENCES StoreLocation(LocationID),
	CustomerID				INT DEFAULT 0 CONSTRAINT fk_order_customer_id FOREIGN KEY
		REFERENCES Customer(CustomerID),
	OrderDate				DATE DEFAULT GetDate() CONSTRAINT nn_order_date NOT NULL,
	OrderPlacement			NVARCHAR(10) DEFAULT 'In-Store' CONSTRAINT ck_order_placement CHECK ((OrderPlacement = 'In-Store') OR (OrderPlacement = 'Online') OR (OrderPlacement = 'Phone')) NOT NULL,
	OrderFulfillment		NVARCHAR(10) DEFAULT 'In-Store' CONSTRAINT ck_order_fulfillment CHECK ((OrderFulfillment = 'In-Store') OR (OrderFulfillment = 'Pick-Up') OR (OrderFulfillment = 'Delivery')) NOT NULL
	);
--
CREATE TABLE OrderLine
	(ProductID				NVARCHAR(8),
	OrderID					INT,
	Quantity				INT CONSTRAINT nn_quantity NOT NULL,
	CONSTRAINT pk_order_line PRIMARY KEY (ProductID, OrderID),
	CONSTRAINT fk_order_line_product_id FOREIGN KEY(ProductID) 
		REFERENCES Product(ProductID),
	CONSTRAINT fk_order_line_order_id FOREIGN KEY(OrderID) 
		REFERENCES CustomerOrder(OrderID)
	);
--
-- Load table data
--
EXECUTE (N'BULK INSERT Customer FROM ''' + @data_path + N'Customer.csv''
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
--
EXECUTE (N'BULK INSERT RewardStatus FROM ''' + @data_path + N'RewardStatus.csv''
WITH (
	
	FIRSTROW = 2,
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= ''\t'',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');
--
EXECUTE (N'BULK INSERT RewardHistory FROM ''' + @data_path + N'RewardHistory.csv''
WITH (
	
	FIRSTROW = 2,
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');
--
EXECUTE (N'BULK INSERT Employee FROM ''' + @data_path + N'Employee.csv''
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
--
EXECUTE (N'BULK INSERT Position FROM ''' + @data_path + N'Position.csv''
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
--
EXECUTE (N'BULK INSERT EmploymentHistory FROM ''' + @data_path + N'EmploymentHistory.csv''
WITH (
	
	FIRSTROW = 2,
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');
--
EXECUTE (N'BULK INSERT Diet FROM ''' + @data_path + N'Diet.csv''
WITH (
	
	FIRSTROW = 2,
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= ''\t'',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');
--
EXECUTE (N'BULK INSERT ProductType FROM ''' + @data_path + N'ProductType.csv''
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
--
EXECUTE (N'BULK INSERT Product FROM ''' + @data_path + N'Product.csv''
WITH (
	
	FIRSTROW = 2,
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');
--
EXECUTE (N'BULK INSERT DietProduct FROM ''' + @data_path + N'DietProduct.csv''
WITH (
	
	FIRSTROW = 2,
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');
--
EXECUTE (N'BULK INSERT StoreLocation FROM ''' + @data_path + N'StoreLocation.csv''
WITH (
	
	FIRSTROW = 2,
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');
--
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
--
EXECUTE (N'BULK INSERT OrderLine FROM ''' + @data_path + N'OrderLine.csv''
WITH (
	
	FIRSTROW = 2,
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');
--
-- List table names and row counts for confirmation
--
SET NOCOUNT ON
SELECT 'Customer' AS "Table",	COUNT(*) AS "Rows"	FROM Customer				UNION
SELECT 'RewardStatus',			COUNT(*)			FROM RewardStatus			UNION
SELECT 'RewardHistory',			COUNT(*)			FROM RewardHistory			UNION
SELECT 'Employee',				COUNT(*)			FROM Employee				UNION
SELECT 'Position',				COUNT(*)			FROM Position				UNION
SELECT 'EmploymentHistory',		COUNT(*)			FROM EmploymentHistory		UNION
SELECT 'Diet',					COUNT(*)			FROM Diet					UNION
SELECT 'ProductType',			COUNT(*)			FROM ProductType			UNION
SELECT 'Product',				COUNT(*)			FROM Product				UNION
SELECT 'DietProduct',			COUNT(*)			FROM DietProduct			UNION
SELECT 'StoreLocation',			COUNT(*)			FROM StoreLocation			UNION
SELECT 'CustomerOrder',			COUNT(*)			FROM CustomerOrder			UNION
SELECT 'OrderLine',				COUNT(*)			FROM OrderLine
ORDER BY 1;
SET NOCOUNT OFF
GO