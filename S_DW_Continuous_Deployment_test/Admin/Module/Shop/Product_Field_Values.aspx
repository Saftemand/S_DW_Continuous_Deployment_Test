<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Product_Field_Values.aspx.vb" Inherits="Dynamicweb.Admin.Product_Field_Values"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb.Admin" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Product_Field_Values</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
		<%=Gui.MakeHeaders(Translate.Translate("Værdi",9), Translate.Translate("Værdi"), "Javascript", false, "")%>
	</head>
	<body>
		<%=Gui.MakeHeaders(Translate.Translate("Værdi",9), Translate.Translate("Værdi"), "Html", false, "")%>
		<form id="Form1" method="post" action="Product_Field_Values_Save.aspx" runat="server" style="MARGIN:0px" v>
			<table class="tabTable" cellspacing="0" cellpadding="0" border="0" style="HEIGHT:120px">
				<tr>
					<td valign="top"><br>
						<dw:groupboxstart id="GroupBoxStart1" runat="server" title="Værdi" />
						<table>
							<tr>
								<td width="170" style="HEIGHT: 21px"><%=Translate.Translate("Værdi")%></td>
								<td style="HEIGHT: 21px">
									<asp:textbox id="Key" runat="server" cssclass="std"></asp:textbox></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Navn")%></td>
								<td>
									<asp:textbox id="Value" runat="server" cssclass="std"></asp:textbox></td>
							</tr>
						</table>
						<asp:textbox id="ValueID" runat="server" visible="True" style="display:none;"></asp:textbox>
						<asp:textbox id="FieldID" runat="server" visible="True" style="display:none;"></asp:textbox>
						<dw:groupboxend id="GroupBoxEnd1" runat="server"></dw:groupboxend>
					</td>
				</tr>
				<tr>
					<td align="right"><table cellpadding="0" cellspacing="0">
							<tr>
								<td><%= Gui.Button(Translate.Translate("OK"), "document.getElementById('Form1').submit();", 0)%>
								</td>
								<td width="5"></td>
								<td><%=Gui.Button(Translate.Translate("Annuller"), "history.back();", 0)%></td>
								<%=Gui.HelpButton("Shop_Product_Field_Values", "gui.tabs.shop.field.list.item.edit",,5)%>
								<td width="7"></td>
							</tr>
							<tr height="5">
								<td></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
