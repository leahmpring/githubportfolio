Imports System.ComponentModel
Imports System.Data.SqlClient

Public Class Customers
    Private Sub CustomerBindingNavigatorSaveItem_Click(sender As Object, e As EventArgs) Handles CustomerBindingNavigatorSaveItem.Click
        'Customers form: Save any changes made back to database
        Try
            Me.Validate()
            Me.CustomerBindingSource.EndEdit()
            Me.CustomerTableAdapter.Update(Me.BackToRootsDataSet.Customer)
            Me.RewardHistoryBindingSource.EndEdit()
            Me.RewardHistoryTableAdapter.Update(Me.BackToRootsDataSet.RewardHistory)
            Me.TableAdapterManager.UpdateAll(Me.BackToRootsDataSet)
        Catch ex As Exception
            MsgBox(ex.Message, "Error Saving Data")
        End Try
    End Sub
    
    Private Sub Customers_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        'Customers form: Load data
        Try
            'TODO: This line of code loads data into the 'BackToRootsDataSet.OrderSearch' table. You can move, or remove it, as needed.
            Me.OrderSearchTableAdapter.Fill(Me.BackToRootsDataSet.OrderSearch)
            'TODO: This line of code loads data into the 'BackToRootsDataSet.RewardStatus' table. You can move, or remove it, as needed.
            Me.RewardStatusTableAdapter.Fill(Me.BackToRootsDataSet.RewardStatus)
            'TODO: This line of code loads data into the 'BackToRootsDataSet.RewardHistory' table. You can move, or remove it, as needed.
            Me.RewardHistoryTableAdapter.Fill(Me.BackToRootsDataSet.RewardHistory)
            'TODO: This line of code loads data into the 'BackToRootsDataSet.Customer' table. You can move, or remove it, as needed.
            Me.CustomerTableAdapter.Fill(Me.BackToRootsDataSet.Customer)
        Catch ex As Exception
            MsgBox("Error Loading Form")
        End Try
    End Sub
    
    'Customer form: Declare variable to determine if user is adding a new record
    Dim IsAdding As Boolean = False
    Private Sub BindingNavigatorAddNewItem_Click(sender As Object, e As EventArgs) Handles BindingNavigatorAddNewItem.Click
        'Customer form: Indicate user is adding a new record
        IsAdding = True
        'Customer form: Disable the back arrow after adding new item to prevent break mode for violating data validation
        Me.BindingNavigatorMovePreviousItem.Available = False
        Me.BindingNavigatorMoveFirstItem.Available = False
        'Customer form: Hide tool strip with search and fill all after adding new item to prevent the manually added ID from "sticking"
        FillByToolStrip.Visible = False
    End Sub
    
    Private Sub CustomerBindingSource_CurrentItemChanged(sender As Object, e As EventArgs) Handles CustomerBindingSource.CurrentItemChanged
        'Customer form: Set default customerID for new customers
        If (IsAdding) Then
            Try
                Dim cmd As New Data.SqlClient.SqlCommand
                cmd.CommandText = "SELECT Max(CustomerID) AS MaxID FROM Customer"
                cmd.CommandType = CommandType.Text
                cmd.Connection = Me.CustomerOrderTableAdapter.Connection
                Dim i As Integer
                cmd.Connection.Open()
                i = cmd.ExecuteScalar() + 1
                cmd.Connection.Close()
                Me.txtCustomerID.Text = i.ToString
            Catch ex As Exception
                MsgBox(ex.Message)
            End Try
        End If
    End Sub
    
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
    
    Private Sub FillByToolStripButton_Click(sender As Object, e As EventArgs) Handles FillByToolStripButton.Click
        'Customer form: Press the "Search" button when searching for specific customer to find customer (by last name)
        Try
            Dim cmd As New Data.SqlClient.SqlCommand
            cmd.CommandText = "SELECT CustomerLastName FROM Customer WHERE CustomerLastName LIKE '" + txtCustomerLastNameSearch.Text + "'"
            cmd.CommandType = CommandType.Text
            cmd.Connection = Me.CustomerTableAdapter.Connection
            cmd.Connection.Open()
            Dim rdr As SqlDataReader = cmd.ExecuteReader()
            If rdr.HasRows = False Then
                MsgBox("No Customers Found")
            Else
                rdr.Close()
                Me.CustomerTableAdapter.FillBy(Me.BackToRootsDataSet.Customer, txtCustomerLastNameSearch.Text)
            End If
            cmd.Connection.Close()
        Catch ex As System.Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub
    
    Private Sub txtCustomerLastNameSearch_KeyDown(sender As Object, e As KeyEventArgs) Handles txtCustomerLastNameSearch.KeyDown
        'Customer form: Press enter key when searching for specific customer to find customer (by last name)
        If e.KeyCode = Keys.Enter Then
            Try
                Dim cmd As New Data.SqlClient.SqlCommand
                cmd.CommandText = "SELECT CustomerLastName FROM Customer WHERE CustomerLastName LIKE '" + txtCustomerLastNameSearch.Text + "'"
                cmd.CommandType = CommandType.Text
                cmd.Connection = Me.CustomerTableAdapter.Connection
                cmd.Connection.Open()
                Dim rdr As SqlDataReader = cmd.ExecuteReader()
                If rdr.HasRows = False Then
                    MsgBox("No Customers Found")
                Else
                    rdr.Close()
                    Me.CustomerTableAdapter.FillBy(Me.BackToRootsDataSet.Customer, txtCustomerLastNameSearch.Text)
                End If
                cmd.Connection.Close()
            Catch ex As System.Exception
                System.Windows.Forms.MessageBox.Show(ex.Message)
            End Try
            e.SuppressKeyPress = True
        End If
    End Sub
    
    Private Sub btnFillAll_Click(sender As Object, e As EventArgs) Handles btnFillAll.Click
        'Customer form: Press "Fill All" button to load all records (useful after searching for one record)
        Try
            Me.CustomerTableAdapter.Fill(Me.BackToRootsDataSet.Customer)
            txtCustomerLastNameSearch.Text = ""
        Catch ex As Exception
            MsgBox(ex.Message, "Error Filling All Customers")
        End Try
    End Sub
    
    Private Sub OrderSearchDataGridView_CellContentDoubleClick(sender As Object, e As DataGridViewCellEventArgs) Handles OrderSearchDataGridView.CellContentDoubleClick
        'Customer form: Open the Orders form to the orderID that was double clicked on
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
    
    Private Sub btnRewardsInfo_Click(sender As Object, e As EventArgs) Handles btnRewardsInfo.Click
        'Customer form: Open the RewardStatus form
        Try
            Dim frmRewardStatus As New RewardStatus
            frmRewardStatus.Show()
        Catch ex As Exception
            MsgBox("Unable to Open Form")
        End Try
    End Sub
    
    Public Sub FillItem(ByVal CustomerID As Integer)
        'Customer form: Click "Customer Details" button on Order form to open customer form to the customer on that order
        Try
            Me.CustomerTableAdapter.FillByID(Me.BackToRootsDataSet.Customer, CustomerID)
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub
    
    Private Sub FillByIDToolStripButton_Click(sender As Object, e As EventArgs) Handles FillByIDToolStripButton.Click
        'Customer form: This is the CustomerID fill by to support the form being opened from the order form; tool strip hidden on Customer form
        Try
            Me.CustomerTableAdapter.FillByID(Me.BackToRootsDataSet.Customer, CType(CustomerIDToolStripTextBox.Text, Integer))
        Catch ex As System.Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub
    
    Private Sub OrderSearchDataGridView_RowPostPaint(sender As Object, e As DataGridViewRowPostPaintEventArgs) Handles OrderSearchDataGridView.RowPostPaint
        'Customer form: Calculate and display customer's total spent and how much they need to spend to reach the next rewards tier
        Try
            RewardsInformation()
        Catch ex As Exception
            'Do nothing
        End Try
    End Sub
    
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

    Private Sub btnClose_Click(sender As Object, e As EventArgs) Handles btnClose.Click
        ' Customers form: Close form
        Me.Close()
    End Sub

    Private Sub OrderSearchToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles OrderSearchToolStripMenuItem.Click
        'Customers form: Open OrderSearch form from menu
        Try
            Dim frmSearch As New OrderSearch
            frmSearch.Show()
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub

    Private Sub OrdersToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles OrdersToolStripMenuItem.Click
        'Customers form: Open Orders form from menu
        Try
            Dim frmOrders As New Orders
            frmOrders.Show()
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub

    Private Sub CustomersToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles CustomersToolStripMenuItem.Click
        'Customers form: Open Customers form from menu
        Try
            Dim frmCustomers As New Customers
            frmCustomers.Show()
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub

    Private Sub RewardStatusToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles RewardStatusToolStripMenuItem.Click
        'Customers form: Open RewardStatus form from menu
        Try
            Dim frmRewardStatus As New RewardStatus
            frmRewardStatus.Show()
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub
End Class
