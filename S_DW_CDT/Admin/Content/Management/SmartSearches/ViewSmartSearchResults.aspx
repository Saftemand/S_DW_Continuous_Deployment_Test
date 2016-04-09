<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ViewSmartSearchResults.aspx.vb" Inherits="Dynamicweb.Admin.ViewSmartSearchResults" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" style="height: 100%;" >
<head runat="server">
    <title></title>
    
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

    <dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true" />
	
    <script type="text/javascript">
    var itemId = <%= Base.ChkInteger(Base.Request("ID"))%>;
    var redirCMD = '<%= Base.ChkString(Base.Request("CMD"))%>';
    if ('<%=Base.ChkBoolean(Base.Request("Refresh")) %>' == 'True') {
        if (redirCMD.length != 0) {
            parent.submitReload(itemId, redirCMD);
        }else{
            parent.submitMe(itemId);
        }
    }    
    </script>

</head>
<body style="height: 100%;">
    <form id="form1" runat="server" style="height: 100%;">
        <dw:List ID="ListResults" runat="server" Title="Items" PageSize="30" />
        <dw:Infobar ID="previewDescription" Visible="False" Type="Information"  runat="server" />
    </form>
     <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</body>
</html>
