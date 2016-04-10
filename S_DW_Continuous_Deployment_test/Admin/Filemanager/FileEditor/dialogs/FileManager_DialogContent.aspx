<%@ Page EnableViewState="false" Language="vb" AutoEventWireup="false" CodeBehind="FileManager_DialogContent.aspx.vb" Inherits="Dynamicweb.Admin.FileManager_DialogContent" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" runat="server" />
    <title></title>
    <link href="../FileManager_FileEditorV2.css" rel="stylesheet" type="text/css" />
    <link href="FileManager_DialogContent.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="MainForm" runat="server">
        <asp:PlaceHolder ID="phDialog" runat="server" />
    </form>
</body>
</html>
