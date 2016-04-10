<%@ Page Language="vb" AutoEventWireup="false" Codebehind="EcomNumber_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.NumberEdit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
	<HEAD>
		<title></title>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		
			<dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
		<link rel="STYLESHEET" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
		
		<style type="text/css">
		body.margin {
			margin-top: 0px;
			margin-left: 0px;
			margin-right: 0px;
			margin-bottom: 0px;
			
		}
		
		input,select,textarea {font-size: 11px; font-family: verdana,arial;}
		</style>		
		
		<script src="/Admin/FileManager/FileManager_browse2.js" type="text/javascript"></script>
        <script type="text/javascript">
            function save(close) {
                document.getElementById("Close").value = close ? 1 : 0;
                document.getElementById('Form1').SaveButton.click();
            }
        </script>
	</HEAD>
	<body MS_POSITIONING="GridLayout" style="background: #DFE9F5 url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;">
	
	<asp:Literal id="BoxStart" runat="server"></asp:Literal>
	<dw:Infobar ID="formatWarning" runat="server" type="Warning" Visible=false >
    </dw:Infobar> 
		<form id="Form1" method="post" runat="server">
        <input id="Close" type="hidden" name="Close" value="0" />
		<dw:TabHeader id="TabHeader1" runat="server" TotalWidth="100%"></dw:TabHeader>
		
			<table border="0" cellpadding="0" cellspacing="0" class="tabTable100" id="DW_Ecom_tableTab">
			<tr>
			<td valign="top">
		
			<div id="Tab1">			
				<br>

				<table border=0 cellpadding=0 cellspacing=0 width='95%' style='width:95%;'>
				<tr><td>

				<fieldset style='width: 100%;margin:5px;'><legend class=gbTitle><%=Translate.Translate("Indstillinger")%>&nbsp;</legend>

				<table border=0 cellpadding=2 cellspacing=0 width='100%' style='width:100%;'>
				<tr><td>
					<table border=0 cellpadding=2 cellspacing=2 width="100%">
					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelType" runat="server" Text="Navn"></dw:TranslateLabel></td>
					<td><asp:textbox id="type" CssClass="NewUIinput" runat="server" Enabled=False></asp:textbox></td>
					</tr>

					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelDescription" runat="server" Text="Beskrivelse"></dw:TranslateLabel></td>
					<td><asp:textbox id="description" CssClass="NewUIinput" runat="server" Enabled=False></asp:textbox></td>
					</tr>

					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelCounter" runat="server" Text="Startværdi"></dw:TranslateLabel></td>
					<td><asp:textbox id="counter" CssClass="NewUIinput" runat="server" Enabled=False></asp:textbox></td>
					</tr>
					
					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelPrefix" runat="server" Text="Præfiks"></dw:TranslateLabel></td>
					<td><asp:textbox id="prefix" CssClass="NewUIinput" runat="server"></asp:textbox></td>
					</tr>

					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelPostfix" runat="server" Text="Postfiks"></dw:TranslateLabel></td>
					<td><asp:textbox id="postfix" CssClass="NewUIinput" runat="server"></asp:textbox></td>
					</tr>
					
					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelAdd" runat="server" Text="Tilvækst"></dw:TranslateLabel></td>
					<td><asp:textbox id="add" CssClass="NewUIinput" runat="server"></asp:textbox></td>
					</tr>
					</table>
				</td></tr>
				</table>

				</fieldset><br><br>

				</td></tr>
				</table>

				<br>					

				<asp:Button id="SaveButton" style="display:none;" runat="server"></asp:Button>
				
			</div>
			
			</td>
			</tr>
			</table>

		</form>

	<asp:Literal id="BoxEnd" runat="server"></asp:Literal>

	</body>
</HTML>

<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>