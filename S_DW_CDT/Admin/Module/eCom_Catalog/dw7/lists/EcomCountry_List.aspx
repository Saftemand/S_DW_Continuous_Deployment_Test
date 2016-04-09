<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EcomCountry_List.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomCountry_List" %>

<%@ Register assembly="Dynamicweb.Controls" namespace="Dynamicweb.Controls" tagprefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" IncludeUIStylesheet="true" runat="server"></dw:ControlResources>
	<link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
    <script type="text/javascript" src="../js/ecomLists.js"></script>
    <script type="text/javascript">
        var addAllMsg = '<%= AddAllMessage %>';
        function addAllCountries() {
            if (confirm(addAllMsg)) selectCountry('-1');
            else $('CountryLayer').hide();
        }
	</script>
</head>
<body>
    <form id="form1" runat="server">
		<input type="hidden" name="selctedRowID" id="selctedRowID" />
	    <asp:Literal id="BoxStart" runat="server"></asp:Literal>

        <dw:List ID="List1" runat="server" Title="" ShowTitle="false" StretchContent="true"  PageSize="25">
            <Filters></Filters>
            <Columns>
			    <dw:ListColumn ID="colCode" runat="server" Name="Landekode" EnableSorting="true" Width="300" />
			    <dw:ListColumn ID="colName" runat="server" Name="Navn" EnableSorting="true" />
            </Columns>
        </dw:List>

	    <asp:Literal id="BoxEnd" runat="server"></asp:Literal> 
    </form>
</body>
</html>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>