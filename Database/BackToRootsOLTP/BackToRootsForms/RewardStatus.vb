Public Class RewardStatus
    Private Sub RewardStatusBindingNavigatorSaveItem_Click(sender As Object, e As EventArgs) Handles RewardStatusBindingNavigatorSaveItem.Click
        'RewardStatus form: Save any changes made back to the database
        Me.Validate()
        Me.RewardStatusBindingSource.EndEdit()
        Me.TableAdapterManager.UpdateAll(Me.BackToRootsDataSet)
    End Sub

    Private Sub RewardStatus_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        'RewardStatus form: Load data
        Try
            'TODO: This line of code loads data into the 'BackToRootsDataSet.RewardStatus' table. You can move, or remove it, as needed.
            Me.RewardStatusTableAdapter.Fill(Me.BackToRootsDataSet.RewardStatus)
            SearchSummary()
        Catch ex As Exception
            MsgBox("Unable to Load Form")
        End Try
    End Sub
    Private Sub SearchSummary()
        'RewardStatus form: Summarize the search results
        Dim count As Integer
        count = Me.RewardStatusDataGridView.Rows.Count
        lblQuantity.Text = count.ToString("#,##0")
    End Sub

    Private Sub btnClose_Click(sender As Object, e As EventArgs) Handles btnClose.Click
        'RewardStatus form: Close form
        Me.Close()
    End Sub
    Private Sub OrderSearchToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles OrderSearchToolStripMenuItem.Click
        'RewardStatus form: Open OrderSearch form from menu
        Try
            Dim frmSearch As New OrderSearch
            frmSearch.Show()
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub

    Private Sub OrdersToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles OrdersToolStripMenuItem.Click
        'RewardStatus form: Open Orders form from menu
        Try
            Dim frmOrders As New Orders
            frmOrders.Show()
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub

    Private Sub CustomersToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles CustomersToolStripMenuItem.Click
        'RewardStatus form: Open Customers form from menu
        Try
            Dim frmCustomers As New Customers
            frmCustomers.Show()
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub

    Private Sub RewardStatusToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles RewardStatusToolStripMenuItem.Click
        'RewardStatus form: Open RewardStatus form from menu
        Try
            Dim frmRewardStatus As New RewardStatus
            frmRewardStatus.Show()
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub
End Class