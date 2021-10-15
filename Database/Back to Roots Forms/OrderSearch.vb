Public Class OrderSearch
    Private Sub OrderSearch_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Try
            'TODO: This line of code loads data into the 'BackToRootsDataSet.OrderSearch' table. You can move, or remove it, as needed.
            'Me.OrderSearchTableAdapter.Fill(Me.BackToRootsDataSet.OrderSearch)
            'TODO: This line of code loads data into the 'BackToRootsDataSet1.Employee' table. You can move, or remove it, as needed.
            Me.EmployeeTableAdapter.Fill(Me.BackToRootsDataSet.Employee)
            'TODO: This line of code loads data into the 'BackToRootsDataSet.OrderFulfillment' table. You can move, or remove it, as needed.
            Me.OrderFulfillmentTableAdapter.Fill(Me.BackToRootsDataSet.OrderFulfillment)
            'TODO: This line of code loads data into the 'BackToRootsDataSet.OrderPlacement' table. You can move, or remove it, as needed.
            Me.OrderPlacementTableAdapter.Fill(Me.BackToRootsDataSet.OrderPlacement)
            'TODO: This line of code loads data into the 'BackToRootsDataSet.StoreLocation' table. You can move, or remove it, as needed.
            Me.StoreLocationTableAdapter.Fill(Me.BackToRootsDataSet.StoreLocation)
        Catch ex As Exception
            MsgBox("Error Loading Form")
        End Try
    End Sub

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
    Private Sub cbEmpAll_CheckStateChanged(sender As Object, e As EventArgs) Handles cbEmpAll.CheckStateChanged
        'OrderSearch form: Check if the "search all employees" checkbox is selected and update the text in cbo.Employee accordingly
        If cbEmpAll.Checked Then
            cboEmployee.Text = "All Employees"
        Else
            cboEmployee.Text = "Ondrea Swanston"
        End If
    End Sub

    Private Sub btnClose_Click(sender As Object, e As EventArgs) Handles btnClose.Click
        'OrderSearch form: Close form
        Me.Close()
    End Sub
    Private Sub OrderSearchToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles OrderSearchToolStripMenuItem.Click
        'OrderSearch form: Open OrderSearch form from menu
        Try
            Dim frmSearch As New OrderSearch
            frmSearch.Show()
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub

    Private Sub OrdersToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles OrdersToolStripMenuItem.Click
        'OrderSearch form: Open Orders form from menu
        Try
            Dim frmOrders As New Orders
            frmOrders.Show()
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub

    Private Sub CustomersToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles CustomersToolStripMenuItem.Click
        'OrderSearch form: Open Customers form from menu
        Try
            Dim frmCustomers As New Customers
            frmCustomers.Show()
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub

    Private Sub RewardStatusToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles RewardStatusToolStripMenuItem.Click
        'OrderSearch form: Open RewardStatus form from menu
        Try
            Dim frmRewardStatus As New RewardStatus
            frmRewardStatus.Show()
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub
End Class