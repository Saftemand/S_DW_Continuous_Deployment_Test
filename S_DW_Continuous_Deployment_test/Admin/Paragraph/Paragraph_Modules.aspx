<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" Codebehind="Paragraph_Modules.aspx.vb" Inherits="Dynamicweb.Admin.Paragraph_Modules" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><%=Translate.JSTranslate("Moduler")%></title>
	<link rel="STYLESHEET" type="text/css" href="../Stylesheet.css" />
  </head>
  <body style="background-color:#FFFFFF;margin:7px;">
    <form id="Form1" method="post" runat="server">
    <%=Gui.MakeHeaders(Translate.Translate("Indsæt %%", "%%", Translate.Translate("modul")), Translate.Translate("Moduler") &","& Translate.Translate("eCom"), "all", false, "370")%>
		<table border="0" cellspacing="0" cellpadding="2" class="tabTable" style="width: 370px;">
			<tr>
				<td valign="top">
					<%=Gui.GroupBoxStart(Translate.Translate("Moduler"))%>
					<div id="Tab1">
					<table border="0" cellspacing="0" cellpadding="0">
						<%=GetModules()%>
					</table>
					</div>
					<div id="Tab2" style="display:none;">
					<table border="0" cellspacing="0" cellpadding="0">
						<%=GetModules("ecom")%>
					</table>
					</div>
					<%=Gui.GroupBoxEnd%>
				</td>
			</tr>
		</table>
    </form>
  </body>
</html>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>