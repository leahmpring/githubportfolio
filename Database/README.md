<a name="top"></a>

# Back to Roots Bakery OLTP
[Executive Summary](#ExecutiveSummary) | [Problem and Opportunity](#ProblemOpportunity) | [Database Design](#DatabaseDesign) | [Simulating Data](#SimulatingData) | [Build Script](#BuildScript) | [View, Function, Stored Procedure](#ViewFunctionSPROC) | 

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


https://user-images.githubusercontent.com/91146906/137153830-d4bc600c-1931-483e-86c0-f72f6e6f0806.mp4

<a name="OrderSearch"></a>
### Order Search Form
The Order Search form returns orders from the database that meet specified criteria, allowing orders to quickly and easily be found. 
<br>
<br>
<img width="964" alt="Back to Roots Order Search Form" src="https://user-images.githubusercontent.com/91146906/137174709-5fbce691-44a1-4805-95a1-6b241c17695a.png">
<br>
<br><b>Order Search View:</b> To create the Order Search form, an Order Search view is first created to list all relevant information about an order. This view is then used to create the Order Search form. <i>See the BackToRootsView.sql (including the OrderSearch view) [here](../Database/BackToRootsView.sql).</i>
<br>
<br> Back to Roots only allows certain combinations of order placement and order fulfillment methods. Thus, the Order Search form auto-populates the order fulfillment method based on the order placement method, using the following sub.
```VBA
    Private Sub cboOrderPlacement_SelectionChangeCommitted(sender As Object, e As EventArgs) Handles cboOrderPlacement.SelectionChangeCommitted
        'OrderSaerch form: Auto-populate order fulfillment combo box based on selected order placement
        Try
            If cboOrderPlacement.SelectedValue = "In-Store" Then
                cboOrderFulfillment.SelectedValue = "In-Store"
            ElseIf cboOrderPlacement.SelectedValue = "Online" Then
                cboOrderFulfillment.SelectedValue = "Delivery"
            ElseIf cboOrderPlacement.SelectedValue = "Phone" Then
                cboOrderFulfillment.SelectedValue = "Pick-Up"
            End If
        Catch ex As Exception
            'Do Nothing
        End Try
    End Sub
```
Further, if the user changes the auto-populated order fulfillment methed, the form checks whether the order placement and fulfillment methods are compatible using the following sub. If they are not compatible, an error message is returned and the order fulfillment method reverts back to what it was prior to being changed.
```VBA
  Private Sub cboOrderFulfillment_SelectionChangeCommitted(sender As Object, e As EventArgs) Handles cboOrderFulfillment.SelectionChangeCommitted
        'OrderSaerch form: Error message if placement and fulfillment method are not compatible (evaluated on fulfillment change)
        Try
            If cboOrderPlacement.SelectedValue = "In-Store" And cboOrderFulfillment.SelectedValue <> "In-Store" Then
                MsgBox("Orders placed in-store must be filled in-store")
                cboOrderFulfillment.SelectedValue = "In-Store"
            ElseIf cboOrderPlacement.SelectedValue = "Online" And cboOrderFulfillment.SelectedValue = "In-Store" Then
                MsgBox("Orders placed online must be filled via pick-up or delivery")
                cboOrderFulfillment.SelectedValue = "Delivery"
            ElseIf cboOrderPlacement.SelectedValue = "Phone" And cboOrderFulfillment.SelectedValue = "In-Store" Then
                MsgBox("Orders placed via phone must be filled via pick-up or delivery")
                cboOrderFulfillment.SelectedValue = "Pick-Up"
            End If
        Catch ex As Exception
            'Do Nothing
        End Try
    End Sub
```
Users can choose to search by all employees, rather than a specific employee, by checking the box next to "Search all employees." The following sub evaluates whether the box to search by all employees is checked and makes the appropriate changes to the Employee combo box.
```VBA
  Private Sub cbEmpAll_CheckStateChanged(sender As Object, e As EventArgs) Handles cbEmpAll.CheckStateChanged
        'OrderSearch form: Check if the "search all employees" checkbox is selected and update the text in cbo.Employee accordingly
        If cbEmpAll.Checked Then
            cboEmployee.Text = "All Employees"
        Else
            cboEmployee.Text = "Ondrea Swanston"
        End If
    End Sub
```
To execute the search, the user presses the "Search" button and orders that meet the specified criteria are loaded. Different FillBy methods are used, depending on whether the user is searching by all employees or a specific employee. If no orders matching the criteria are found, a "No Orders Found" message is displayed.
```VBA
  Private Sub btnSearch_Click(sender As Object, e As EventArgs) Handles btnSearch.Click
        'OrderSearch Form: Load results meeting search conditions by pressing "Search" button
        Try
            If cbEmpAll.Checked Then
                'Use the FillByEmpAll table adapter when box checked to exclude the employeeID condition in the WHERE clause
                Me.OrderSearchTableAdapter.FillByEmpAll(Me.BackToRootsDataSet.OrderSearch,
                Me.dtBeginDate.Value,
                Me.dtEndDate.Value,
                Me.cboLocation.SelectedValue,
                Me.cboOrderPlacement.SelectedValue,
                Me.cboOrderFulfillment.SelectedValue)
                SearchSummary()
            Else
                'Use the FillBy table adapter when box checked to include the employeeID condition in the WHERE clause (selected value from cboEmployee)
                Me.OrderSearchTableAdapter.FillBy(Me.BackToRootsDataSet.OrderSearch,
                Me.dtBeginDate.Value,
                Me.dtEndDate.Value,
                Me.cboLocation.SelectedValue,
                Me.cboEmployee.SelectedValue,
                Me.cboOrderPlacement.SelectedValue,
                Me.cboOrderFulfillment.SelectedValue)
                SearchSummary()
            End If
        Catch ex As Exception
            MsgBox("Error in the Query")
        End Try
        Dim records As Integer
        records = Me.OrderSearchDataGridView.Rows.Count - 1
        If records = 0 Then
            MsgBox("No Orders Found")
        End If
    End Sub
```
After executing the search, a summary of the results is provided using the following sub.
```VBA
    Private Sub SearchSummary()
        'OrderSearch Form: Summarize the search results
        Dim OrderTotal As Decimal
        Dim TotalItems As Integer
        Dim dgvr As System.Windows.Forms.DataGridViewRow
        For Each dgvr In Me.OrderSearchDataGridView.Rows
            OrderTotal += dgvr.Cells("OrderTotal").Value
            TotalItems += dgvr.Cells("ItemsOrdered").Value
        Next dgvr
        lblTotal.Text = OrderTotal.ToString("$ #,##0.00")
        lblTotalItems.Text = TotalItems.ToString("#,##0")

        Dim count As Integer
        count = Me.OrderSearchDataGridView.Rows.Count - 1
        lblQuantity.Text = count.ToString("#,##0")

        Dim avg As Decimal
        If (count > 0) Then
            avg = OrderTotal / count
        Else
            avg = 0
        End If
        lblAvgTotal.Text = avg.ToString("$ #,##0.00")
    End Sub
```
Users can double click on the orderID of the orders returned by the search to open the Orders form to the specified order, allowing users to easily see all information on the given order.
```VBA
  Private Sub OrderSearchDataGridView_CellContentDoubleClick(sender As Object, e As DataGridViewCellEventArgs) Handles OrderSearchDataGridView.CellContentDoubleClick
        'OrderSearch Form: Open the Orders form to the orderID that was double clicked on
        If (e.ColumnIndex <> 1) Then
            Try
                Dim frmOrder As New Orders
                frmOrder.Show()
                frmOrder.FillItem(OrderSearchDataGridView.Rows(e.RowIndex).Cells("OrderID").Value)
            Catch ex As Exception
                System.Windows.Forms.MessageBox.Show(ex.Message)
            End Try
        End If
    End Sub
```

<a name="OrderForm"></a>
### Order Form
The Order form allows users to view individual orders, including information on the orders and the products ordered. Further, existing orders can be modified and new orders can be added.
<br>
<br>
<img width="845" alt="Back to Roots Order Form" src="https://user-images.githubusercontent.com/91146906/137210957-72085121-618f-40ed-ac20-0c2145c5fced.png">
<br>
<br> The following sub, and another similar sub, allows users to search for a specific order by typing in the orderID and either clicking "Search" or pressing the enter key.
```VBA
    Private Sub txtOrderIDToolStrip_KeyDown(sender As Object, e As KeyEventArgs) Handles txtOrderIDToolStrip.KeyDown
        'Order form: Press enter key when searching for specific order to find order
        If e.KeyCode = Keys.Enter Then
            Try
                Dim cmd As New Data.SqlClient.SqlCommand
                cmd.CommandText = "SELECT OrderID FROM CustomerOrder  WHERE OrderID = @OrderID"
                cmd.CommandType = CommandType.Text
                cmd.Connection = Me.CustomerOrderTableAdapter.Connection
                cmd.Parameters.AddWithValue("@OrderID", txtOrderIDToolStrip.Text)
                cmd.Connection.Open()
                If cmd.ExecuteScalar <> 0 Then
                    Me.CustomerOrderTableAdapter.FillBy(Me.BackToRootsDataSet.CustomerOrder, CType(txtOrderIDToolStrip.Text, Integer))
                Else
                    MsgBox("No Orders Found")
                End If
                cmd.Connection.Close()
            Catch ex As System.Exception
                System.Windows.Forms.MessageBox.Show(ex.Message)
            End Try
            e.SuppressKeyPress = True
        End If
    End Sub
```
After searching for an order, the following sub allows the user to click "Fill All" to reload all orders and toggle between them.
```VBA
    Private Sub ToolStripFillAllOrders_Click(sender As Object, e As EventArgs) Handles ToolStripFillAllOrders.Click
        'Order form: Press "Fill All" button to load all records (useful after searching for one record)
        Try
            Me.CustomerOrderTableAdapter.Fill(Me.BackToRootsDataSet.CustomerOrder)
            txtOrderIDToolStrip.Text = ""
        Catch ex As Exception
            MsgBox(ex.Message, "Error Filling All Customer Orders")
        End Try
    End Sub
```
