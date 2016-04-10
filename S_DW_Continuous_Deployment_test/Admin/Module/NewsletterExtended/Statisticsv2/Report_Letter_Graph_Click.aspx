<%@ Page Language="vb" debug="true" trace="false" Description="dotnetCHARTING Component" validateRequest="false" CodeBehind="Report_Letter_Graph_Click.aspx.vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Report_Letter_Graph_Click" %>
<%@ Register TagPrefix="dotnet"  Namespace="dotnetCHARTING" Assembly="dotnetCHARTING"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%@ Import Namespace="System.Drawing" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>

<HTML><HEAD><TITLE></TITLE></HEAD>
<BODY>
<DIV align=center>
 <dotnet:Chart id="Chart"  runat="server"/>
</DIV>
</BODY>
</BODY>
</HTML>