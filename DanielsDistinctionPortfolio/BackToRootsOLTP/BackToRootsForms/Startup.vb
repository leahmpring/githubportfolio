Public Class Startup
    Private Sub btnOrderSearch_Click(sender As Object, e As EventArgs) Handles btnOrderSearch.Click
        'Startup form: Open OrderSearch form on button click
        Try
            Dim frmSearch As New OrderSearch
            frmSearch.Show()
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub

    Private Sub btnCustomers_Click(sender As Object, e As EventArgs) Handles btnCustomers.Click
        'Startup form: Open Customers form on button click
        Try
            Dim frmCustomers As New Customers
            frmCustomers.Show()
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub

    Private Sub btnOrders_Click(sender As Object, e As EventArgs) Handles btnOrders.Click
        'Startup form: Open Orders form on button click
        Try
            Dim frmOrders As New Orders
            frmOrders.Show()
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub

    Private Sub btnRewardStatus_Click(sender As Object, e As EventArgs) Handles btnRewardStatus.Click
        'Startup form: Open RewardStatus form on button click
        Try
            Dim frmRewardStatus As New RewardStatus
            frmRewardStatus.Show()
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub

    Private Sub OrderSearchToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles OrderSearchToolStripMenuItem.Click
        'Startup form: Open OrderSearch form from menu
        Try
            Dim frmSearch As New OrderSearch
            frmSearch.Show()
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub

    Private Sub OrdersToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles OrdersToolStripMenuItem.Click
        'Startup form: Open Orders form from menu
        Try
            Dim frmOrders As New Orders
            frmOrders.Show()
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub

    Private Sub CustomersToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles CustomersToolStripMenuItem.Click
        'Startup form: Open Customers form from menu
        Try
            Dim frmCustomers As New Customers
            frmCustomers.Show()
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub

    Private Sub RewardStatusToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles RewardStatusToolStripMenuItem.Click
        'Startup form: Open RewardStatus form from menu
        Try
            Dim frmRewardStatus As New RewardStatus
            frmRewardStatus.Show()
        Catch ex As Exception
            System.Windows.Forms.MessageBox.Show(ex.Message)
        End Try
    End Sub

    Private Sub btnClose_Click(sender As Object, e As EventArgs) Handles btnClose.Click
        'Startup form: Close form
        Me.Close()
    End Sub
End Class