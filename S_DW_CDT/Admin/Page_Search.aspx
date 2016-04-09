<%@ Page Codebehind="Page_Search.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Page_Search" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head id="Head1" runat="server">
    <title>Search</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta http-equiv="Pragma" content="no-cache" />
        <meta name="Cache-control" content="no-cache" />
        <meta http-equiv="Cache-control" content="no-cache" />
        <meta http-equiv="Expires" content="Tue, 20 Aug 1996 14:25:27 GMT" />
        <link rel="STYLESHEET" type="text/css" href="Stylesheet.css">
        <dw:ControlResources ID="ControlResources1" runat="server" />
    </head>
    <body style="background-color:#bfdbff;">
              <form id="UserListForm" runat="server">
                <input type="hidden" id="ResultPageSearchID" name="ResultPageSearchID" value="<%=IIf(IsPostBack, Request.Form("ResultPageSearchID"), Request.Form("PageSearchID")) %>" />
                <input type="hidden" id="ResultParagraphSearchID" name="ResultParagraphSearchID" value="<%=IIf(IsPostBack, Request.Form("ResultParagraphSearchID"), Request.Form("PageSearchParagraphID"))%>" />
                <input type="hidden" id="TextSearch"  name="TextSearch" value="<%=IIf(IsPostBack, Request.Form("TextSearch"), Request.Form("PageSearchText")) %>" />
                <input type="hidden" id="ModuleSearch" name="ModuleSearch" value="<%=IIf(IsPostBack, Request.Form("ModuleSearch"), Request.Form("PageSearch_Modules")) %>" />
                <input type="hidden" id="ResultPageSearchIn" name="ResultPageSearchIn" value="<%=IIf(IsPostBack, Request.Form("ResultPageSearchIn"), Request.Form("PageSearchIn")) %>" />
                <dw:List ID="SearchList" runat="server" Title="Søgeresultat" PageSize="30">
                    <Columns>
                        <dw:ListColumn ID="ListColumn1" runat="server" Name="" EnableSorting="false" Width="5" />
                        <dw:ListColumn runat="server" Name="Overskrift" Width="250" EnableSorting="true"/>
                        <dw:ListColumn ID="WebsiteColumn" runat="server" Name="Website" Width="150" EnableSorting="true"/>
                        <dw:ListColumn runat="server" Name="Aktiv" Width="65" EnableSorting="true"  ItemAlign="Center" />
                        <dw:ListColumn runat="server" Name="Oprettet" Width="80" EnableSorting="true" />
                        <dw:ListColumn runat="server" Name="Redigeret" Width="80" EnableSorting="true" />
                    </Columns>
                </dw:List>
        </form>
    </body>
</html>
<%  Translate.GetEditOnlineScript()%>
