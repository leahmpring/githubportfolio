Imports System.ComponentModel
'Imports System.Data
'Imports System.Data.SqlClient

Public Class Orders
    Private Sub Orders_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        'Order form: Load data
        Try
            'TODO: This line of code loads data into the 'BackToRootsDataSet.OrderFulfillment' table. You can move, or remove it, as needed.
            Me.OrderFulfillmentTableAdapter.Fill(Me.BackToRootsDataSet.OrderFulfillment)
            'TODO: This line of code loads data into the 'BackToRootsDataSet.OrderPlacement' table. You can move, or remove it, as needed.
            Me.OrderPlacementTableAdapter.Fill(Me.BackToRootsDataSet.OrderPlacement)
            'TODO: This line of code loads data into the 'BackToRootsDataSet1.Product' table. You can move, or remove it, as needed.
            Me.ProductTableAdapter.Fill(Me.BackToRootsDataSet1.Product)
            'TODO: This line of code loads data into the 'BackToRootsDataSet.OrderLine' table. You can move, or remove it, as needed.
            Me.OrderLineTableAdapter.Fill(Me.BackToRootsDataSet.OrderLine)
            'TODO: This line of code loads data into the 'BackToRootsDataSet.Employee' table. You can move, or remove it, as needed.
            Me.EmployeeTableAdapter.Fill(Me.BackToRootsDataSet.Employee)
            'TODO: This line of code loads data into the 'BackToRootsDataSet.Customer' table. You can move, or remove it, as needed.
            Me.CustomerTableAdapter.Fill(Me.BackToRootsDataSet.Customer)
            'TODO: This line of code loads data into the 'BackToRootsDataSet.StoreLocation' table. You can move, or remove it, as needed.
            Me.StoreLocationTableAdapter.Fill(Me.BackToRootsDataSet.StoreLocation)
            'TODO: This line of code loads data into the 'BackToRootsDataSet.CustomerOrder' table. You can move, or remove it, as needed.
            Me.CustomerOrderTableAdapter.Fill(Me.BackToRootsDataSet.CustomerOrder)
        Catch ex As Exception
            MsgBox("Error Loading Form")
        End Try
    End Sub
    
    Private Sub CustomerOrderBindingNavigatorSaveItem_Click(sender As Object, e As EventArgs) Handles CustomerOrderBindingNavigatorSaveItem.Click
        'Order form: Save any changes made on form and subform to db by clicking the save icon
        'Try
        Me.Validate()
            Me.CustomerOrderBindingSource.EndEdit()
            Me.CustomerOrderTableAdapter.Update(Me.BackToRootsDataSet.CustomerOrder)
            'Me.TableAdapterManager.UpdateAll(Me.BackToRootsDataSet)
            Me.OrderLineBindingSource.EndEdit()
            Me.OrderLineTableAdapter.Update(Me.BackToRootsDataSet.OrderLine)
        'Catch ex As Exception
        'MsgBox("Error Saving Data")
        'End Try
    End Sub
    
    Private Sub FillByToolStripOrder_Click(sender As Object, e As EventArgs) Handles FillByToolStripOrder.Click
        'Order form: Press search button when searching for specific order to find order
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
    End Sub
    
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
    
    Private Sub ToolStripFillAllOrders_Click(sender As Object, e As EventArgs) Handles ToolStripFillAllOrders.Click
        'Order form: Press "Fill All" button to load all records (useful after searching for one record)
        Try
            Me.CustomerOrderTableAdapter.Fill(Me.BackToRootsDataSet.CustomerOrder)
            txtOrderIDToolStrip.Text = ""
        Catch ex As Exception
            MsgBox(ex.Message, "Error Filling All Customer Orders")
        End Try
    End Sub
    
    Private Sub OrderLineDataGridView_RowPrePain(sender As Object, e As DataGridViewRowPrePaintEventArgs) Handles OrderLineDataGridView.RowPrePaint
        'Order form: Show line item numbers on the data grid (order line subform)
        If e.RowIndex >= 0 Then
            Me.OrderLineDataGridView.Rows(e.RowIndex).Cells(0).Value = e.RowIndex + 1
        End If
    End Sub
    
    Private Sub OrderDateDateTimePicker_Validating(sender As Object, e As CancelEventArgs) Handles dtOrderDate.Validating
        'Order form: Validate that the selected order date is not in the future
        If CType(dtOrderDate.Text, DateTime) > Today Then
            MsgBox("Order date must be today or earlier")
            e.Cancel = True
        End If
    End Sub
    
    'Order form: Declare variable to determine if user is adding a new record
    Dim IsAdding As Boolean = False
    Private Sub BindingNavigatorAddNewItem_Click(sender As Object, e As EventArgs) Handles BindingNavigatorAddNewItem.Click
        'Order form: Indicate user is adding a new record
        IsAdding = True
        'Order form: Disable the back arrow after adding new item to prevent break mode for violating data validation
        Me.BindingNavigatorMovePreviousItem.Available = False
        Me.BindingNavigatorMoveFirstItem.Available = False
        'Order form: Hide tool strip with search and fill all after adding new item to prevent the manually added ID from "sticking"
        FillBy1ToolStrip.Visible = False
    End Sub
    
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

    Private Sub OrderLineDataGridView_RowPostPaint(sender As Object, e As DataGridViewRowPostPaintEventArgs) Handles OrderLineDataGridView.RowPostPaint
        'Order form: Calculate and display order total
        Try
            Dim total As Decimal
            Dim dgvr As System.Windows.Forms.DataGridViewRow
            For Each dgvr In Me.OrderLineDataGridView.Rows
                total += dgvr.Cells("LineTotal").Value
            Next dgvr
            lblOrderTotal.Text = total.ToString("$ #,##0.00")
        Catch ex As Exception
            'Do nothing
        End Try
    End Sub

    Public Sub FillItem(ByVal OrderID As Integer)
        'Order form: When using OrderSearch form or Customer form to find information on an order, this allows the form to be opened to the selected orderID
        Try
            Me.CustomerOrderTableAdapter.FillBy(Me.BackToRootsDataSet.CustomerOrder, OrderID)
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub

    Private Sub cboOrderPlacement_SelectionChangeCommitted(sender As Object, e As EventArgs) Handles cboOrderPlacement.SelectionChangeCommitted
        'Order form: Auto-populate order fulfillment combo box based on selected order placement
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
        'Order form: Error message if placement and fulfillment method are not compatible (evaluated on fulfillment change)
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

    Private Sub btnClose_Click(sender As Object, e As EventArgs) Handles btnClose.Click
        'Order form: Close form
        Me.Close()
    End Sub

    Private Sub OrderSearchToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles OrderSearchToolStripMenuItem.Click
        'Order form: Open OrderSearch form from menu
        Try
            Dim frmSearch As New OrderSearch
            frmSearch.Show()
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub

    Private Sub OrdersToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles OrdersToolStripMenuItem.Click
        'Order form: Open Orders form from menu
        Try
            Dim frmOrders As New Orders
            frmOrders.Show()
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub

    Private Sub CustomersToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles CustomersToolStripMenuItem.Click
        'Order form: Open Customers form from menu
        Try
            Dim frmCustomers As New Customers
            frmCustomers.Show()
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub

    Private Sub RewardStatusToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles RewardStatusToolStripMenuItem.Click
        'Order form: Open RewardStatus form from menu
        Try
            Dim frmRewardStatus As New RewardStatus
            frmRewardStatus.Show()
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub
End Class
