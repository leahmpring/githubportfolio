-- BackToRoots Database Script Written by Hannah McDonald
-- Peer Reviewed by Emily Sandberg April 26, 2021
-- Originally Written: April 2021 | Updated: May 2021
---------------------------------------------------------------
USE BackToRoots
GO
---------------------------------------------------------------
-- DROP EXISTING VIEWS
--
IF EXISTS(
	SELECT *
	FROM sys.views
	WHERE NAME = N'CurrentEmployee'
		)
	DROP VIEW CurrentEmployee
GO
--
-- CREATE VIEWS
--
-- CurrentEmployee: Lists all current employees and their information; exclude HR and payroll information (sensitive information)
-- Business Purpose: This view allows managers to see all current employees, their position, and other relevant information without exposing sensitive HR and payroll information.
CREATE VIEW CurrentEmployee
AS
	SELECT
		Employee.EmployeeFirstName,
		Employee.EmployeeLastName,
		Position.PositionName,
		Employee.EmployeeDOB,
		Employee.EmployeeEmail,
		Employee.EmployeePhoneNumber,
		Employee.EmployeeStreetAddress,
		Employee.EmployeeCity,
		Employee.EmployeeState,
		Employee.EmployeeZipCode
	FROM Employee
	INNER JOIN EmploymentHistory
		ON Employee.EmployeeID = EmploymentHistory.EmployeeID
	INNER JOIN Position
		ON Position.PositionID = EmploymentHistory.PositionID
	WHERE EmploymentHistory.EndDate IS NULL
WITH CHECK OPTION;
GO
--
-- USE VIEW: CurrentEmployee (create a list of the current employees' positions and contact information from the CurrentEmployee view)
-- Business Purpose: This creates a list of current employees' positions and contact information to be shared with staff members so they can effectively communicate with the appropriate people when needed.
--
SELECT
	EmployeeFirstName + ' ' + EmployeeLastName AS "Employee Name",
	PositionName AS "Position",
	EmployeeEmail AS "Email",
	EmployeePhoneNumber AS "Phone"
FROM CurrentEmployee
ORDER BY 2,1;
---------------------------------------------------------------
-- DROP EXISTING FUNCTIONS
--
IF EXISTS(
	SELECT * 
	FROM sys.objects
	WHERE NAME = N'ufn_OrderTotal'
		)
	DROP FUNCTION ufn_OrderTotal;
GO
--
-- CREATE FUNCTIONS
--
-- ufn_OrderTotal: Calculates the order total for a specified order
-- Business Purpose: This quickly aggregates each line item and calculates the order total so it is clear what customers need to pay. An order total needs to be calclated for every order placed, making it a highly purposeful user-defined function.
CREATE FUNCTION 
	ufn_OrderTotal(@InputOrderID INT)
	RETURNS MONEY 
AS
BEGIN
	DECLARE @Tally INT, @OrderTotal MONEY;
	--Test OrderID to see if it exists
	SELECT @Tally = COUNT(*)
	FROM CustomerOrder
	WHERE CustomerOrder.OrderID = @InputOrderID;
	-- If OrderID does not exist, output illogical -1
	IF @Tally = 0
		SET @OrderTotal = -1
	-- If OrderID exists, calculate order total
	ELSE
		SELECT @OrderTotal = SUM(Product.ProductPrice*OrderLine.Quantity)
		FROM CustomerOrder
		INNER JOIN OrderLine
			ON CustomerOrder.OrderID = OrderLine.OrderID
		INNER JOIN Product
			ON Product.ProductID = OrderLine.ProductID
		WHERE CustomerOrder.OrderID = @InputOrderID
	RETURN @OrderTotal
END;
GO
--
-- TEST FUNCTION: ufn_OrderTotal
--
SELECT '$' + CONVERT(NVARCHAR, dbo.ufn_OrderTotal(15),1) AS "Order Total: Order #15";
--
SELECT dbo.ufn_OrderTotal(0) AS "Order Does Not Exist";
---------------------------------------------------------------
-- DROP EXISTING SPROCS
--
IF EXISTS(
	SELECT * 
	FROM sys.objects
	WHERE NAME = N'usp_CustomerOrders'
		)
	DROP PROCEDURE usp_CustomerOrders;
GO
--
-- CREATE SPROCS
--
-- usp_CustomerOrders: Returns customer's order history
-- Business Purpose: This lists every order placed by a customer in addition to details regaring those orders, making it easy to track-down information regarding customers' orders if compliments, complaints, or questions arise. Additionally, it reveals the buying patterns of individual customers.
CREATE PROCEDURE 
	usp_CustomerOrders(@FirstName NVARCHAR(25)=NULL, @LastName NVARCHAR(25)=NULL)
AS
BEGIN
	IF @FirstName IS NULL AND @LastName IS NULL
		BEGIN
			-- Argument omitted for procedure
			SELECT 'Omitted Parameter - Use the following form for this procedure: EXEC CustomerOrders''<CustomerFirstName>'' ''<CustomerLastName>''' AS "Warning Message"
		END;
	ELSE
		BEGIN
			-- Determine if customer has placed orders
			DECLARE @CustOrderCount INT
			SELECT @CustOrderCount = COUNT(*)
			FROM CustomerOrder
			INNER JOIN Customer
				ON Customer.CustomerID = CustomerOrder.CustomerID
			WHERE Customer.CustomerFirstName = @FirstName AND Customer.CustomerLastName = @LastName;
			-- If customer has not placed orders, display warning message stating that
			IF @CustOrderCount = 0
				BEGIN
					SELECT 'No orders for customer '+@FirstName+' '+@LastName AS "Warning: Not Found"
					RETURN(1)
				END;
			-- If customer name specified and orders placed, retrieve orders for given customer
			SELECT
				Customer.CustomerID, -- Added to differentiate in the case two customers have the same name
				CustomerOrder.OrderID, 
				CONVERT(NVARCHAR,CustomerOrder.OrderDate,101) AS "Order Date",
				CustomerOrder.LocationID AS "OrderLocation",
				Employee.EmployeeFirstName + ' ' + Employee.EmployeeLastName AS "Employee",
				CustomerOrder.OrderPlacement AS "Order Placed",
				CustomerOrder.OrderFulfillment AS "Order Filled",
				'$' + CONVERT(NVARCHAR,dbo.ufn_OrderTotal(CustomerOrder.OrderID),1) AS "Order Total"
			FROM Customer
			INNER JOIN CustomerOrder
				ON Customer.CustomerID = CustomerOrder.CustomerID
			INNER JOIN Employee
				ON Employee.EmployeeID = CustomerOrder.EmployeeID
			WHERE Customer.CustomerFirstName = @FirstName AND Customer.CustomerLastName = @LastName
			ORDER BY CustomerOrder.OrderDate
		END;
END;
GO
--
-- TEST SPROC: usp_CustomerOrders
--
EXEC usp_CustomerOrders @LastName='Dohr', @FirstName='Sydney';
--
EXEC usp_CustomerOrders 'Hannah','McDonald';
--
EXEC usp_CustomerOrders;
---------------------------------------------------------------