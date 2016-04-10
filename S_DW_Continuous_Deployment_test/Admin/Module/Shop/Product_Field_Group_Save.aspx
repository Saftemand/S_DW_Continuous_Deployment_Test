    <%@ Page Language="vb" AutoEventWireup="false" %>
    <%@ Import namespace="Dynamicweb" %>
    <%@ Import namespace="System.Data" %>
    <%@ Import namespace="Dynamicweb.Backend" %>


    <script language="VB" runat="Server">
    Dim SQL As String
    Dim ShopProductFieldGroupName As String
    Dim ShopProductFieldGroupID As Integer
    Dim strCheckSQL As String
    Dim ShopProductFieldGroupTag As String
    </script>

    <%
    '**************************************************************************************************
    '	Current version:	1.0
    '	Created:			23-09-2002
    '	Last modfied:		23-09-2002
    '
    '	Purpose: Save field
    '
    '	Revision history:
    '		1.0 - 23-09-2002 - Nicolai Pedersen
    '		First version.
    '
    '**************************************************************************************************

        'Dim ShopConn As IDbConnection = Database.CreateConnection("DWShop.mdb")
        'Dim cmdShop As IDbCommand = ShopConn.CreateCommand

        ShopProductFieldGroupID = Request.Form.Item("GroupID")
        ShopProductFieldGroupName = Request.Form.Item("ShopProductFieldGroupName")
        ShopProductFieldGroupTag = Request.Form.Item("ShopProductFieldGroupTag")

        SQL = "SELECT * FROM ShopProductFieldGroup WHERE ShopProductFieldGroupID=" & ShopProductFieldGroupID

        Dim dm As New DataManager()
        'Dim adShopAdapter As IDbDataAdapter = Database.GetAdapter()
        'Dim cb As Object = Database.GetCommandBuilder(adShopAdapter)
        Dim dsShop As DataSet = dm.getDataSet("DWShop.mdb", SQL)
        Dim newRow As DataRow

        'cmdShop.CommandText = sql
        'adShopAdapter.SelectCommand = cmdShop
        'adShopAdapter.Fill(dsShop)

        Dim blnNew As Boolean = False
        If Not CStr(ShopProductFieldGroupID) = "0" Then
            newRow = dsShop.Tables(0).Rows(0)
        Else
            newRow = dsShop.Tables(0).NewRow()
            dsShop.Tables(0).Rows.Add(newRow)

            'Sortvalue hentes frem
            SQL = "SELECT MAX(ShopProductFieldGroupSort) AS SortCounter FROM ShopProductFieldGroup"
    	
            'Dim cmdShopReader As IDbCommand = ShopConn.CreateCommand

            'cmdShopReader.CommandText = SQL
            Dim drProductFieldGroupReader As IDataReader = Database.CreateDataReader(SQL, "DWShop.mdb") 'cmdShopReader.ExecuteReader()

            If drProductFieldGroupReader.Read Then
                newRow("ShopProductFieldGroupSort") = Base.ChkNumber(drProductFieldGroupReader("SortCounter")) + 1
            Else
                newRow("ShopProductFieldGroupSort") = 1
            End If

            drProductFieldGroupReader.Close()
            drProductFieldGroupReader.Dispose()
            'cmdShopReader.Dispose()
            blnNew = True
        End If

        newRow("ShopProductFieldGroupName") = LTrim(RTrim(ShopProductFieldGroupName))
        newRow("ShopProductFieldGroupTag") = LTrim(RTrim(ShopProductFieldGroupTag))

        'adShopAdapter.Update(dsShop)
        dm.Update(dsShop)
        
        If blnNew Then
            ShopProductFieldGroupID = dm.GetIdentity
        End If

        'ShopProductFieldGroupID = CType(Database.UpdateDatasetIdentity(dsShop.Tables(0).Rows.Item(dsShop.Tables(0).Rows.Count - 1), ShopConn, 0), String)

        dm.Dispose()
        dsShop.Dispose()
        'cmdShop.Dispose
        'ShopConn.Dispose

        Response.Redirect(("Product_Field_Group_Edit.aspx?GroupID=" & ShopProductFieldGroupID))
%>
