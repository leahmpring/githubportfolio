-- BackToRootsDM Data Mart Developed and Written by Hannah McDonald
-- Peer Reviewed by Emily Sandberg October 07, 2021
-- Originally Written: October 2021 | Updated: November 2021
---------------------------------------------------------------
-- Create data mart if it does not exist
--
IF NOT EXISTS(SELECT * FROM sys.databases
	WHERE NAME = N'BackToRootsDM')
	CREATE DATABASE BackToRootsDM
GO
USE BackToRootsDM
--
-- Delete existing tables
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'FactSales'
       )
	DROP TABLE FactSales;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'DimProduct'
       )
	DROP TABLE DimProduct;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'DimCustomer'
       )
	DROP TABLE DimCustomer;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'DimEmployee'
       )
	DROP TABLE DimEmployee;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'DimOrder'
       )
	DROP TABLE DimOrder;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'DimDate'
       )
	DROP TABLE DimDate;
--
-- Create tables
--
CREATE TABLE DimDate
	(DateSK					INT CONSTRAINT pk_date_sk PRIMARY KEY,
	Date					DATE,
	FullDate				NCHAR(10),		-- Date in MM-dd-yyyy format
	DayOfMonth				INT,			-- Field will hold day number of month
	DayName					NVARCHAR(9),	-- Contains name of the day (Sunday, Monday, etc.)
	DayOfWeek				INT,			-- First day Sunday = 1 and Saturday = 7
	DayOfWeekInMonth		INT,			-- 1st Monday or 2nd Monday in month
	DayOfWeekInYear			INT,
	DayOfQuarter			INT,
	DayOfYear				INT,
	WeekOfMonth				INT,			-- Week number of month
	WeekOfQuarter			INT,			-- Week number of the quarter
	WeekOfYear				INT,			-- Week number of the year
	Month					INT,			-- Number of the month 1 to 12
	MonthName				NVARCHAR(9),	-- January, February, etc.
	MonthOfQuarter			INT,			-- Month number belongs to quarter
	Quarter					NCHAR(2),
	QuarterName				NVARCHAR(9),	-- First, second, etc.
	Year					INT,			-- Year value of date
	YearName				CHAR(7),		-- CY 2017, CY 2018, etc.
	MonthYear				CHAR(10),		-- Jan-2018, Feb-2018, etc.
	MMYYYY					INT,
	FirstDayOfMonth			DATE,
	LastDayOfMonth			DATE,
	FirstDayOfQuarter		DATE,
	LastDayOfQuarter		DATE,
	FirstDayOfYear			DATE,
	LastDayOfYear			DATE,
	IsHoliday				BIT,			-- Flag (1 = national holiday, 0 = no national holiday)
	IsWeekday				BIT,			-- Flag (1 = weekday, 0 = weekend)
	Holiday					NVARCHAR(50),	-- Name of holiday in US
	Season					NVARCHAR(10)	-- Name of season
	);
--
CREATE TABLE DimOrder
	(OrderSK				INT IDENTITY(1,1) NOT NULL CONSTRAINT pk_order_sk PRIMARY KEY,
	OrderAK					INT NOT NULL,
	Placement				NVARCHAR(10) NOT NULL,
	Fulfillment				NVARCHAR(10) NOT NULL,
	LocationStreetAddress	NVARCHAR(50) NOT NULL,
	LocationCity			NVARCHAR(50) NOT NULL,
	LocationState			NVARCHAR(2)  NOT NULL,
	LocationZipCode			NVARCHAR(11) NOT NULL,
	AssociatedRewardStatus	NVARCHAR(10) NOT NULL
	);
--
CREATE TABLE DimEmployee
	(EmployeeSK				INT IDENTITY(1,1) NOT NULL CONSTRAINT pk_employee_sk PRIMARY KEY,
	EmployeeAK				INT NOT NULL,
	FirstName				NVARCHAR(25) NOT NULL,
	LastName				NVARCHAR(25) NOT NULL,
	PositionType			NVARCHAR(9)  NOT NULL,
	PositionName			NVARCHAR(25) NOT NULL,
	WageType				NVARCHAR(6)  NOT NULL,
	Wage					MONEY NOT NULL,
	HireDate				DATE NOT NULL,
	EndDate					DATE NOT NULL,
	StartDateDM				DATE NOT NULL,				-- Added for historical dimension type
	EndDateDM				DATE NULL					-- Added for historical dimension type
	);
--
CREATE TABLE DimCustomer
	(CustomerSK				INT IDENTITY(1,1) NOT NULL CONSTRAINT pk_customer_sk PRIMARY KEY,
	CustomerAK				INT NOT NULL,
	DOB						DATE NOT NULL,
	City					NVARCHAR(50) NOT NULL,
	State					NVARCHAR(2) NOT NULL,
	ZipCode					NVARCHAR(11) NOT NULL,
	RewardStatus			NVARCHAR(10) NOT NULL,
	RewardStatusJoinDate	DATE NOT NULL,
	RewardStatusEndDate		DATE NOT NULL,
	StartDateDM				DATE NOT NULL,				-- Added for historical dimension type
	EndDateDM				DATE NULL					-- Added for historical dimension type
	);
--
CREATE TABLE DimProduct
	(ProductSK				INT IDENTITY(1,1) NOT NULL CONSTRAINT pk_product_sk PRIMARY KEY,
	ProductAK				NVARCHAR(8) NOT NULL,
	ProductType				NVARCHAR(15) NOT NULL,
	ProductName				NVARCHAR(35) NOT NULL,
	Diet					NVARCHAR(25) NOT NULL,
	ProductPrice			MONEY NOT NULL,
	StartDateDM				DATE NOT NULL,				-- Added for historical dimension type
	EndDateDM				DATE NULL					-- Added for historical dimension type
	);
--
CREATE TABLE FactSales
	(ProductSK				INT NOT NULL,
	EmployeeSK				INT NOT NULL,
	CustomerSK				INT NOT NULL,
	OrderSK					INT NOT NULL,
	DateSK					INT NOT NULL,
	ProductPrice			MONEY,
	Quantity				INT
	CONSTRAINT pk_fact_sales PRIMARY KEY (ProductSK, EmployeeSK, CustomerSK, OrderSK, DateSK),
	CONSTRAINT fk_order_dim_date FOREIGN KEY (DateSK) REFERENCES DimDate(DateSK),
	CONSTRAINT fk_order FOREIGN KEY (OrderSK) REFERENCES DimOrder(OrderSK),
	CONSTRAINT fk_customer FOREIGN KEY (CustomerSK) REFERENCES DimCustomer(CustomerSK),
	CONSTRAINT fk_employee FOREIGN KEY (EmployeeSK) REFERENCES DimEmployee(EmployeeSK),
	CONSTRAINT fk_product FOREIGN KEY (ProductSK) REFERENCES DimProduct(ProductSK)
	);
--
GO