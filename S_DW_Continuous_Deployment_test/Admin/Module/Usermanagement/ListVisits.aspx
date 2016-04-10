<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ListVisits.aspx.vb" Inherits="Dynamicweb.Admin.ListVisits" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="omc" TagName="VisitsList" Src="~/Admin/Module/OMC/Controls/VisitsList.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="True" runat="server" />
</head>
<body>
    <form id="frmListVisits" runat="server">
        <omc:VisitsList ID="lstVisits" runat="server" Title="Visits" ShowTitle="True" />
    </form>
</body>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
