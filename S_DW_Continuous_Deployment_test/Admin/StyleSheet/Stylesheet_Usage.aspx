﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Stylesheet_Usage.aspx.vb" Inherits="Dynamicweb.Admin.Stylesheet_Usage" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
	<head runat="server">
	    <title>Statistics</title>
		<link href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET" />
		<link href="/Admin/Module/Common/Stylesheet.css" type="text/css" rel="stylesheet"  />
		
		<script language="javascript">
		    function openPage(id) {
		        window.open('/Default.aspx?ID=' + id, 'pageWnd');
		    }
		</script>
	</head>
	<body style="padding: 0px; margin: 0px;">
	    <form id="form1" runat="server">
			<table width="100%">
				<tr>
					<div id="header">
						<dw:TranslateLabel ID="lbTitleStylesheet" Text="Stylesheet" runat="server" />&nbsp;
						<dw:TranslateLabel ID="lbTitleStatistics" Text="Statistik" runat="server" />
					</div>
				</tr>
				<tr>
					<td align="center">
						<dw:TabHeader ID="Tabs" runat="server" Headers="Statistics" />
						<div id="Tab1">
							<table class="tabTable">
							    <tr valign="top">
							        <td></td>
							    </tr>
							    <tr valign="top" id="NotFoundRow" runat="server">
							        <td align="left">
							            <i><dw:TranslateLabel ID="lbNotFound" Text="Ikke_fundet" runat="server" /></i>
							        </td>
							    </tr> 
								<tr valign="top">
									<td align="left">
										<asp:DataGrid ID="Grid" runat="server" PagerStyle-Mode="NumericPages" AllowPaging="True" AllowSorting="False" Width="100%" AutoGenerateColumns="False"
											HeaderStyle-BorderStyle="None" GridLines="Horizontal" BorderStyle="Solid" PageSize="10">
											<Columns>
												<asp:TemplateColumn HeaderText="Page" ItemStyle-Width="100%" HeaderStyle-Width="100%" HeaderStyle-Font-Bold="True">
														<ItemTemplate>
														    <a href='javascript:openPage(<%#Eval("ID")%>);'>
																<%#Eval("MenuText")%>
															</a>	
														</ItemTemplate>
												</asp:TemplateColumn>
											</Columns>
										</asp:DataGrid>
									</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
			</table>
	    </form>
	    <% Translate.GetEditOnlineScript() %>
	</body>
</html>


