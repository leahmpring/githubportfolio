-- BackToRoots Database View Written by Hannah McDonald
-- Peer Reviewed by Emily Sandberg May, 2021
-- Originally Written: May 14, 2021 | Updated: May 2021
---------------------------------------------------------------
USE BackToRoots
GO
---------------------------------------------------------------
-- DROP EXISTING VIEWS
--
IF EXISTS(
	SELECT *
	FROM sys.views
	WHERE NAME = N'OrderSearch'
		)
	DROP VIEW OrderSearch
GO
--
-- CREATE VIEWS
--
-- OrderSearch: Lists all relevant information about an order for the OrderSearch form
-- Business Purpose: This view is used to make the OrderSearch form, allowing orders to be quickly and easily found.
CREATE VIEW OrderSearch
AS
	SELECT
		CustomerOrder.OrderID,
		CustomerOrder.OrderDate,
		StoreLocation.LocationCity,
		Employee.EmployeeFirstName + ' ' + Employee.EmployeeLastName AS EmployeeFullName,
		Customer.CustomerID,
		Customer.CustomerFirstName + ' ' + Customer.CustomerLastName AS CustomerFullName,
		CustomerOrder.OrderPlacement,
		CustomerOrder.OrderFulfillment,
		COUNT(OrderLine.ProductID) AS NumLineItems,
		SUM(OrderLine.Quantity) AS TotalNumItemsOrdered,
		SUM(OrderLine.Quantity*Product.ProductPrice) As OrderTotal
	FROM CustomerOrder
	INNER JOIN StoreLocation
		ON StoreLocation.LocationID = CustomerOrder.LocationID
	INNER JOIN Employee
		ON Employee.EmployeeID = CustomerOrder.EmployeeID
	INNER JOIN Customer
		ON Customer.CustomerID = CustomerOrder.CustomerID
	INNER JOIN OrderLine
		ON CustomerOrder.OrderID = OrderLine.OrderID
	INNER JOIN Product
		ON Product.ProductID = OrderLine.ProductID
	GROUP BY
		CustomerOrder.OrderID,
		CustomerOrder.OrderDate,
		StoreLocation.LocationCity,
		Customer.CustomerID,
		Employee.EmployeeFirstName + ' ' + Employee.EmployeeLastName,
		Customer.CustomerFirstName + ' ' + Customer.CustomerLastName,
		CustomerOrder.OrderPlacement,
		CustomerOrder.OrderFulfillment
WITH CHECK OPTION;
GO