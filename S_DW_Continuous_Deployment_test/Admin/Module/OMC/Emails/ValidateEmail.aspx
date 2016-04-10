<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ValidateEmail.aspx.vb" Inherits="Dynamicweb.Admin.ValidateEmail" %>
<%@ Register TagPrefix="omc" TagName="ValidationList" Src="~/Admin/Module/OMC/Controls/ValidationList.ascx" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
<dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="True" runat="server" />
</head>
<body style="height: auto">
    <form id="frmRecipientsList" runat="server">
        <omc:ValidationList id="vValidationList" runat="server" />
    </form>
</body>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>

