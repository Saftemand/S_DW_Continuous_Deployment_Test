<%@ Page Language="vb" AutoEventWireup="false" Codebehind="EcomOrderField_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomOrderFieldEdit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
	<HEAD>
		<title></title>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
	<dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
		<link rel="STYLESHEET" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
		<style type="text/css">
		BODY.margin { MARGIN: 0px }
		input,select,textarea {font-size: 11px; font-family: verdana,arial;}
		</style>
			
	    <script type="text/javascript" src="/Admin/FormValidation.js"></script>	

	<script type="text/javascript">

	    $(document).observe('dom:loaded', function () {
	        window.focus(); // for ie8-ie9 
            document.getElementById('NameStr').focus();
	    }); 

	    function checkfield(field){
		    var result		= true;
		    var fieldTmp	= field.toLowerCase();
            var validChars 	= "0123456789abcdefghijklmnopqrstuvwxyz";

            for (var i = 0; i < fieldTmp.length; i++) {
			    if (validChars.indexOf(fieldTmp.charAt(i)) == -1) {
				    result = false;
			    }
            }
        
            return result;
	    }

	    /*function CreateField(){
		    if (document.getElementById('Form1').NameStr.value.length < 1) {
			    alert("<%=Translate.JSTranslate("Der skal angives en værdi i: %%", "%%", Translate.JSTranslate("navn"))%>");
			    document.getElementById('Form1').NameStr.focus();
		    } else if (document.getElementById('Form1').SystemNameStr.value.length < 1) {
			    alert("<%=Translate.JSTranslate("Der skal angives en værdi i: %%", "%%", Translate.JSTranslate("Systemnavn"))%>");
			    document.getElementById('Form1').SystemNameStr.focus();
		    } else if (!checkfield(document.getElementById('Form1').SystemNameStr.value)){
			    alert("<%=Translate.JSTranslate("Ugyldige tegn i: %%", "%%", Translate.JSTranslate("Systemnavn"))%>");
			    document.getElementById('Form1').SystemNameStr.focus();
		    } else {
			    document.getElementById('Form1').SaveButton.click();
		    }
	    }*/
	    function saveOrderField(close) {
	        document.getElementById("Close").value = close ? 1 : 0;
	        document.getElementById('Form1').SaveButton.click();
	    }
	</script>
	
	</HEAD>
	<body MS_POSITIONING="GridLayout" style="background: #DFE9F5 url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;">
	
	<asp:Literal id="BoxStart" runat="server"></asp:Literal>

	<form id="Form1" method="post" runat="server">
        <input id="Close" type="hidden" name="Close" value="0" />
		<asp:Literal id="TableIsBlocked" runat="server"></asp:Literal>
		<dw:TabHeader id="TabHeader1" runat="server" TotalWidth="100%"></dw:TabHeader>
		<table border="0" cellpadding="0" cellspacing="0" class="tabTable100" id="DW_Ecom_tableTab">
		<tr>
		<td valign="top">
	
		<div id="Tab1">		
			<br>

			<table border=0 cellpadding=0 cellspacing=0 width='95%' style='width:95%;'>
			<tr><td>

			<fieldset style='width: 100%;margin:5px;'><legend class=gbTitle><%=Translate.Translate("Felt")%>&nbsp;</legend>

			<table border=0 cellpadding=2 cellspacing=0 width='100%' style='width:100%;'>
			<tr><td>
				<table border=0 cellpadding=2 cellspacing=2 width="100%">
				<tr>
				<td width="170"><dw:TranslateLabel id="tLabelName" runat="server" Text="Navn"></dw:TranslateLabel></td>
				<td>
				    <div id="errNameStr" name="errNameStr" style="color: Red;"></div>
				    <asp:textbox id="NameStr" CssClass="NewUIinput" runat="server"></asp:textbox>
				</td>
				</tr>

				<tr>
				<td width="170"><dw:TranslateLabel id="tLabelSystemName" runat="server" Text="Systemnavn"></dw:TranslateLabel></td>
				<td>
				    <div id="errSystemNameStr" name="errSystemNameStr" style="color: Red;"></div>
				    <asp:textbox id="SystemNameStr" CssClass="NewUIinput" runat="server"></asp:textbox>
				</td>
				</tr>

				<tr>
				<td width="170"><dw:TranslateLabel id="tLabelTemplatName" runat="server" Text="Template tag"></dw:TranslateLabel></td>
				<td>
				    <div id="errTemplateNameStr" name="errTemplateNameStr" style="color: Red;"></div>
				    <asp:textbox id="TemplateNameStr" CssClass="NewUIinput" runat="server"></asp:textbox>
				</td>
				</tr>
				
				<tr>
				<td width="170"><dw:TranslateLabel id="tLabelType" runat="server" Text="Felt type"></dw:TranslateLabel></td>
				<td><asp:DropDownList id="TypeStr" CssClass="NewUIinput" runat="server"></asp:DropDownList></td>
				</tr>
					
				<tr style="display:none;">
				<td width="170"><dw:TranslateLabel id="tLabelLocked" runat="server" Text="Lås felt"></dw:TranslateLabel></td>
				<td><asp:CheckBox id="Locked" runat="server"></asp:CheckBox></td>
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
        addMinLengthRestriction('NameStr', 1, '<%=Translate.JsTranslate("A name is needed")%>');
        addMinLengthRestriction('SystemNameStr', 1, '<%=Translate.JsTranslate("A system name is needed")%>');
        addMinLengthRestriction('TemplateNameStr', 1, '<%=Translate.JsTranslate("A templatetag-name is needed")%>');
        activateValidation('Form1');
    </script>
	</body>
</HTML>

<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>