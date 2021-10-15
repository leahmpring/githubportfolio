<a name="top"></a>

# Back to Roots Bakery OLTP
[Executive Summary](#ExecutiveSummary) | [Problem and Opportunity](#ProblemOpportunity) | [Database Design](#DatabaseDesign) | [Simulating Data](#SimulatingData)
<br>[Build Script](#BuildScript) | [View, Function, Stored Procedure](#ViewFunctionSPROC) | [VB.NET Application](#Application) | [Download and Explore!](#YouTry)

<a name="ExecutiveSummary"></a>
## Executive Summary
Back to Roots Bakery is a health-conscious, community-centered bakery focused on helping people feel their best while still enjoying “going for ice cream.” The bakery makes and sells a variety of treats and comfort foods for in-store ordering, pre-ordered pick-up, and delivery. Orders can be placed using a variety of methods, including in-store, by phone, and online. In 2018, Back to Roots Bakery opened their first location in Boulder, Colorado and recently opened a new location in Longmont, Colorado. With this expansion, the bakery has seen an increase in demand. This proposed database will give Back to Roots Bakery the competitive advantage, customer insights, process optimization, and data-driven decision-making capabilities to compete in an increasingly competitive industry and to maximize their potential.
<br>

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

<a name="DatabaseDesign"></a>
## Database Design: Entity Relationship Diagram (ERD)

<img width="1003" alt="Back to Roots OLTP ERD" src="https://user-images.githubusercontent.com/91146906/137017556-bae865cc-df49-48f9-9cf5-417b10a44c3f.png">

<a name="SimulatingData"></a>
## Simulating Data
Coming soon...

<a name="BuildScript"></a>
## Build Script
The Back to Roots build script creates the "BackToRoots" database if it does not exist, deletes tables if they exist, creates tables with the appropriate attributes and constraints, populates each table with data from CSV files, and then lists table names and row counts for confirmation. Due to the logic, the script can be run multiple times without error.
<br>
<br><i>See the BuildBackToRoots.sql build script [here](../Database/BuildBackToRoots.sql).</i>
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

<a name="ViewFunctionSPROC"></a>
## View, Function, and Stored Procedure
<i>See the BackToRootsScript.sql (including a view, function, and stored procedure) [here](../Database/BackToRootsScript.sql).</i>
### View: CurrentEmployee
The CurrentEmployee view lists all current employees and their information, excluding HR and payroll information (sensitive information). The purpose is to allow managers to see current employees, their position, and other relevant information without exposing sensitive HR and payroll information.
<br>
<br>The CurrentEmployee view is then used to create a list of the current employees' positions and contact information. The purpose is to share this list with staff members, so they can effectively communicate with the appropriate people when needed.

### Function: ufn_OrderTotal
The ufn_OrderTotal function calculates the order total for a specified order. The purpose is to quickly aggregate each line item and calculate the order total, so it is clear what customers need to pay. An order total needs to be calclated for every order placed, making it a highly purposeful user-defined function.

### Stored Procedure: usp_CustomerOrders
The usp_CustomerOrders stored procedure returns customer's order history. The purpose is to list every order placed by a customer, in addition to details regaring those orders, making it easy to track-down information regarding customers' orders if compliments, complaints, or questions arise. Additionally, it reveals the buying patterns of individual customers.


<a name="Application"></a>
## Order Management Application: Forms and Reports
<b>Forms: </b>[Start-Up Form](../Database/BackToRootsForms/#StartUpForm) | [Order Search Form](../Database/BackToRootsForms/#OrderSearchForm) | [Order Form](../Database/BackToRootsForms/#OrderForm) | [Customer Form](../Database/BackToRootsForms/#CustomerForm) | [Reward Status Form](../Database/BackToRootsForms/#RewardStatusForm)
<br><b>Reports: </b>[Product Sales Report](#ProductSalesReport) | [Employee Performance Report](#EmployeePerformanceReport)


https://user-images.githubusercontent.com/91146906/137153830-d4bc600c-1931-483e-86c0-f72f6e6f0806.mp4

<br><i><b>See more about the Back to Roots Bakery forms [here](../Database/BackToRootsForms/#Top).</b></i>

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

<a name="YouTry"></a>
## Downlaod and Explore!
Want to explore the Back to Roots OLTP yourself?
<br>
<br>Download the BackToRootsOLTP.zip [here] and open the readme.txt for instructions. This zip file contains all the project's components.
<br>
<br><i>Note: You must have Microsoft SQL Server Management Studio and Visual Studio installed on your machine.</i>
