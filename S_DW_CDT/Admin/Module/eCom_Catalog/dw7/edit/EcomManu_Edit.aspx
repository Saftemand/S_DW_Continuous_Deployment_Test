<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="EcomManu_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.ManuEdit" %>
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

		    input, select, textarea {
		        font-size: 11px;
		        font-family: verdana,arial;
		    }

		    textarea {
                overflow: auto;
		    }
		</style>		
		
		<script src="/Admin/FileManager/FileManager_browse2.js" type="text/javascript"></script>
	    <script type="text/javascript" src="/Admin/FormValidation.js"></script>	
        <script type="text/javascript">
            $(document).observe('dom:loaded', function () {
                window.focus(); // for ie8-ie9 
                document.getElementById('Name').focus();
            });

            function save(close) {
                document.getElementById("Close").value = close ? 1 : 0;
                document.getElementById('Form1').SaveButton.click();
            }
        </script>
	</HEAD>
	<body MS_POSITIONING="GridLayout" style="background: #DFE9F5 url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;">
	
	<asp:Literal id="BoxStart" runat="server"></asp:Literal>
	
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
					<td width="170"><dw:TranslateLabel id="tLabelName" runat="server" Text="Navn"></dw:TranslateLabel></td>
					<td>
				        <div id="errName" name="errName" style="color: Red;"></div>
				        <asp:textbox id="Name" CssClass="NewUIinput" runat="server" MaxLength="255"></asp:textbox>
				    </td>
					</tr>

					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelAddress" runat="server" Text="Adresse"></dw:TranslateLabel></td>
					<td><asp:textbox id="Address" CssClass="NewUIinput" runat="server" MaxLength="255"></asp:textbox></td>
					</tr>

					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelZipCode" runat="server" Text="Postnummer"></dw:TranslateLabel></td>
					<td><asp:textbox id="ZipCode" CssClass="NewUIinput" runat="server" MaxLength="255"></asp:textbox></td>
					</tr>
					
					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelCity" runat="server" Text="By"></dw:TranslateLabel></td>
					<td><asp:textbox id="City" CssClass="NewUIinput" runat="server" MaxLength="255"></asp:textbox></td>
					</tr>

					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelCountry" runat="server" Text="Land"></dw:TranslateLabel></td>
					<td><asp:textbox id="Country" CssClass="NewUIinput" runat="server" MaxLength="255"></asp:textbox></td>
					</tr>
					
					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelPhone" runat="server" Text="Telefon"></dw:TranslateLabel></td>
					<td><asp:textbox id="Phone" CssClass="NewUIinput" runat="server" MaxLength="255"></asp:textbox></td>
					</tr>
					
					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelFax" runat="server" Text="Fax"></dw:TranslateLabel></td>
					<td><asp:textbox id="Fax" CssClass="NewUIinput" runat="server" MaxLength="255"></asp:textbox></td>
					</tr>
					
					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelEmail" runat="server" Text="Email"></dw:TranslateLabel></td>
					<td><asp:textbox id="Email" CssClass="NewUIinput" runat="server" MaxLength="255"></asp:textbox></td>
					</tr>
					
					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelWeb" runat="server" Text="URL"></dw:TranslateLabel></td>
					<td><asp:textbox id="Web" CssClass="NewUIinput" runat="server" MaxLength="255"></asp:textbox></td>
					</tr>
					
					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelLogo" runat="server" Text="Logo"></dw:TranslateLabel></td>
					<td><dw:FileArchive CssClass="NewUIinput" runat="server" id="Logo"></dw:FileArchive></td>
					</tr>
					
					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelDescription" runat="server" Text="Beskrivelse"></dw:TranslateLabel></td>
					<td><asp:TextBox id="Description" CssClass="NewUIinput" TextMode="MultiLine" Rows="5" runat="server" MaxLength="255"></asp:TextBox></td>
					</tr>
					</table>
				</td></tr>
				</table>

				</fieldset><br><br>

				</td></tr>
				</table>

				<br>					

				<asp:Button id="SaveButton" style="display:none;" runat="server"></asp:Button>
				<asp:Button id="DeleteButton" style="display:none;" runat="server"></asp:Button>
				
			</div>
			
			</td>
			</tr>
			</table>

		</form>

	<asp:Literal id="BoxEnd" runat="server"></asp:Literal>

	<script>
        addMinLengthRestriction('Name', 1, '<%=Translate.JsTranslate("A name is needed")%>');
        activateValidation('Form1');
    </script>
	</body>
</HTML>

<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>