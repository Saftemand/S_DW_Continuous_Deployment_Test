<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="QueryResult.aspx.vb" Inherits="Dynamicweb.Admin.Management.QueryAnalyzer.QueryResult" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <dw:ControlResources ID="ControlResources1" runat="server">
    </dw:ControlResources>

    <style type="text/css">
        /* Column names are fixed and do not scroll away when going through the recordset */
   
        body{
          border-top: 1px solid rgb(160, 175, 195);
        }

        /* .footer doesn't exist in the html output but it´s the last TR that contains paging.
        Improvement: Paging is fixed on the left side and always shown when scrolling through the recordset */
        .footer {
          background: none repeat scroll 0 0 rgb(221, 236, 255);
          bottom: 0 !important;
          left: 0;
          right: 0;
          position: fixed;
          z-index: 100;
        }

        <asp:Literal id="litAdditionalStyles" runat="server" />
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <dw:List ID="List1" runat="server" ShowTitle="false" ShowPaging="true">
        </dw:List>
    </div>
    </form>
</body>
</html>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()%>