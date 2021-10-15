<a name="Top"></a>
# Back to Roots Bakery Forms

<a name="StartUpForm"></a>
## Start-Up Form
The Start-Up form serves as a homepage for the other forms; all forms can be opened from the Start-Up form. There is also a menu on each form that allows any form to be opened from any form.
<br>
<br>
<img width="669" alt="Back to Roots Start-Up Form" src="https://user-images.githubusercontent.com/91146906/137418165-e97a5446-28b0-42e4-80ae-70e9be06293a.png">
<br>
<br><i>See the VB code behind the Start-Up form [here](../BackToRootsForms/Startup.vb).</i>

<a name="OrderSearchForm"></a>
## Order Search Form
The Order Search form returns orders from the database that meet specified criteria, allowing orders to quickly and easily be found. 
<br>
<br>
<img width="964" alt="Back to Roots Order Search Form" src="https://user-images.githubusercontent.com/91146906/137174709-5fbce691-44a1-4805-95a1-6b241c17695a.png">
<br>
<br><b>Order Search View:</b> To create the Order Search form, an Order Search view is first created to list all relevant information about an order. This view is then used to create the Order Search form. <i>See the BackToRootsView.sql (including the OrderSearch view) [here](../Database/BackToRootsView.sql).</i>
<br>
<br><i>See the VB code behind the Order Search form [here](../Database/BackToRootsForms/OrderSearch.vb).</i>
<br>
<br> Back to Roots only allows certain combinations of order placement and fulfillment methods. Thus, the Order Search form auto-populates the order fulfillment method based on the order placement method, using the following sub.
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
To execute the search, the user clicks the "Search" button and orders that meet the specified criteria are loaded. Different FillBy methods are used, depending on whether the user is searching by all employees or a specific employee. If no orders matching the criteria are found, a "No Orders Found" message is displayed.
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
In the orders returned by the search, users can double click on the OrderID to open the Orders form to the specified order, allowing users to easily see all information on the given order.
<br>
<br>To do this, the following sub is included on the Order Search form.
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
Additionally, the following sub is included on the Order form.
```VBA
    Public Sub FillItem(ByVal OrderID As Integer)
        'Order form: When using OrderSearch form or Customer form to find information on an order, this allows the form to be opened to the selected orderID
        Try
            Me.CustomerOrderTableAdapter.FillBy(Me.BackToRootsDataSet.CustomerOrder, OrderID)
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub
```

<a name="OrderForm"></a>
## Order Form
The Order form allows users to view individual orders, including information on the orders and the products ordered. Further, existing orders can be modified and new orders can be added.
<br>
<br>
<img width="845" alt="Back to Roots Order Form" src="https://user-images.githubusercontent.com/91146906/137210957-72085121-618f-40ed-ac20-0c2145c5fced.png">
<br>
<br><i>See the VB code behind the Orders form [here](../Database/BackToRootsForms/Orders.vb).</i>
<br>
<br>Similar to the Order Search form, the Orders form uses subs to ensure only acceptable order placement and fulfillment methods are selected. Further, the order total is calculated and displayed, like the summary information on the Order Search form.
<br>
<br>The line item for each product in the order is displayed using the following sub.
```VBA
    Private Sub OrderLineDataGridView_RowPrePain(sender As Object, e As DataGridViewRowPrePaintEventArgs) Handles OrderLineDataGridView.RowPrePaint
        'Order form: Show line item numbers on the data grid (order line subform)
        If e.RowIndex >= 0 Then
            Me.OrderLineDataGridView.Rows(e.RowIndex).Cells(0).Value = e.RowIndex + 1
        End If
    End Sub
```
The following sub, and another similar sub, allows users to search for a specific order by typing the orderID and either clicking "Search" or pressing the enter key. If no orders matching the search are found, a "No Orders Found" message is displayed.
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
When new orders are added, the following sub auto-populates the orderID and sets the order date to today.
```VBA
    Private Sub CustomerOrderBindingSource_CurrentItemChanged(sender As Object, e As EventArgs) Handles CustomerOrderBindingSource.CurrentItemChanged
        'Order form: Set default date (today) and OrderID for new orders
        If (IsAdding) Then
            Try
                Me.dtOrderDate.Value = Today
                Dim cmd As New Data.SqlClient.SqlCommand
                cmd.CommandText = "SELECT Max(OrderID) AS MaxID FROM CustomerOrder"
                cmd.CommandType = CommandType.Text
                cmd.Connection = Me.OrderLineTableAdapter.Connection
                Dim i As Integer
                cmd.Connection.Open()
                i = cmd.ExecuteScalar() + 1
                cmd.Connection.Close()
                Me.OrderIDTextBox.Text = i.ToString
            Catch ex As Exception
                MsgBox(ex.Message)
            End Try
        End If
    End Sub
```
The following sub ensures the selected order date is not in the future.
```VBA
    Private Sub OrderDateDateTimePicker_Validating(sender As Object, e As CancelEventArgs) Handles dtOrderDate.Validating
        'Order form: Validate that the selected order date is not in the future
        If CType(dtOrderDate.Text, DateTime) > Today Then
            MsgBox("Order date must be today or earlier")
            e.Cancel = True
        End If
    End Sub
```
To get information on the customer associated with an order, users can click the "Customer Information" button to open the Customer form to the given customer. To do this, the following sub is included on the Order form and two subs are included on the Customer form.
```VBA
    Private Sub btnCustomerInfo_Click(sender As Object, e As EventArgs) Handles btnCustomerInfo.Click
        'Order form: Open Customer form to current order's customer
        Try
            Dim frmCustomer As New Customers
            frmCustomer.Show()
            frmCustomer.FillItem(cboCustomer.SelectedValue)
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub
```

<a name="CustomerForm"></a>
## Customer Form
The Customer form allows users to view information regarding customers, including their personal information, rewards history, and order history. Additionally, it displays the customer's total spending at Back to Roots, and how much more they need to spend to reach the next rewards tier. Further, existing customers' information can be modified and new customers can be added.
<br>
<br>
<img width="1207" alt="Back to Roots Customer Form" src="https://user-images.githubusercontent.com/91146906/137405419-a87373b4-eb91-4fc0-84d9-1cebbb4328ee.png">
<br>
<br><i>See the VB code behind the Customers form [here](../Database/BackToRootsForms/Customers.vb).</i>
<br>
<br>Similar to the Orders form, the Customer form allows users to search for a customer by last name (or part of a last name). Users can then click "Fill All" to reload all customers and toggle between them. Further, when a new customer is added, the customer ID is auto-populated, like the order ID. Similar to the Order Search form, users can double click on the orderID in the customer's order history to open the Orders form to the specified order. Additionally, the total spent by the customer is calculated and displayed, like the summary information on the Order Search form.
<br>
<br> The customer's current rewards status is displayed on the form using the following sub.
```VBA
    Private Sub RewardHistoryDataGridView_RowPostPaint(sender As Object, e As DataGridViewRowPostPaintEventArgs) Handles RewardHistoryDataGridView.RowPostPaint
        'Display customer's current reward status on main form
        Try
            Dim CurrentRewardStatus As String
            CurrentRewardStatus = RewardHistoryDataGridView.Rows(0).Cells(0).Value
            If CurrentRewardStatus = "NO-R" Then
                lblCurrentRewardStatus.Text = "NO REWARDS"
            ElseIf CurrentRewardStatus = "BRON" Then
                lblCurrentRewardStatus.Text = "BRONZE"
            ElseIf CurrentRewardStatus = "SILV" Then
                lblCurrentRewardStatus.Text = "SILVER"
            ElseIf CurrentRewardStatus = "GOLD" Then
                lblCurrentRewardStatus.Text = "GOLD"
            ElseIf CurrentRewardStatus = "PLAT" Then
                lblCurrentRewardStatus.Text = "PLATINUM"
            End If
        Catch ex As Exception
            'Do nothing
        End Try
    End Sub
```
The RewardsInformation() function is used to calculate how much a customer must spend to reach the next rewards tier.
```VBA
    Private Function RewardsInformation()
        'Calculate and display total spent
        Dim total As Decimal
        Dim dgvr As System.Windows.Forms.DataGridViewRow
        For Each dgvr In Me.OrderSearchDataGridView.Rows
            total += dgvr.Cells("OrderTotal").Value
        Next dgvr
        lblTotalSpent.Text = total.ToString("$ #,##0.00")
        'Find difference between total spent and cut-off for the next rewards tier
        Dim difference As Decimal
        Dim CurrentRewardStatus As String
        CurrentRewardStatus = RewardHistoryDataGridView.Rows(0).Cells(0).Value
        If CurrentRewardStatus = "BRON" Then
            difference = 500 - total
        ElseIf CurrentRewardStatus = "SILV" Then
            difference = 2000 - total
        ElseIf CurrentRewardStatus = "GOLD" Then
            difference = 3500 - total
        End If
        'Display the appropriate message (or hide the message) for how much customer needs to spend to reach next rewards tier
        If CurrentRewardStatus = "NO-R" Then
            lblNextRewardTier.Text = "Ask customer about joining the rewards program!"
        ElseIf CurrentRewardStatus = "PLAT" Then
            lblNextRewardTier.Text = "Customer reached maximum rewards tier!"
        Else
            lblNextRewardTier.Text = "Customer needs to spend " + difference.ToString("$ #,##0.00") + " to reach next rewards tier."
        End If
    End Function
```
The RewardsInformation() function is called in the following sub to display the appropriate message on the Customer form.
```VBA
    Private Sub OrderSearchDataGridView_RowPostPaint(sender As Object, e As DataGridViewRowPostPaintEventArgs) Handles OrderSearchDataGridView.RowPostPaint
        'Customer form: Calculate and display customer's total spent and how much they need to spend to reach the next rewards tier
        Try
            RewardsInformation()
        Catch ex As Exception
            'Do nothing
        End Try
    End Sub
```
To get more information on the reward statuses, users can click the "Rewards Information" button to open the Reward Status form.
```VBA
    Private Sub btnRewardsInfo_Click(sender As Object, e As EventArgs) Handles btnRewardsInfo.Click
        'Customer form: Open the RewardStatus form
        Try
            Dim frmRewardStatus As New RewardStatus
            frmRewardStatus.Show()
        Catch ex As Exception
            MsgBox("Unable to Open Form")
        End Try
    End Sub
```

<a name="RewardStatusForm"></a>
## Reward Status Form
The Reward Status form is a simple form that allows users to view and modify information regarding reward statuses. 
<br>
<br>
<img width="1016" alt="Back to Roots Reward Status Form" src="https://user-images.githubusercontent.com/91146906/137407991-0de062cc-f591-411d-84f9-08491e2874fa.png">
<br>
<br><i>See the VB code behind the Reward Status form [here](../Database/BackToRootsForms/RewardStatus.vb).</i>
