<%@ Page Language="vb" AutoEventWireup="false" Codebehind="UserFieldEdit.aspx.vb" Inherits="Dynamicweb.Admin.DealerSearch.Backend.UserFieldEdit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
Dim udTxt as string = Translate.Translate("Felt")
%>


<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<title></title>
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		
		<script>
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

		function CreateField(){
			if (document.getElementById('Form1').DisplayName.value.length < 1) {
				alert("<%=Translate.JSTranslate("Angiv ´%%´", "%%", Translate.JSTranslate("Tekst/Label"))%>");
				document.getElementById('Form1').DisplayName.focus();
			} else if (document.getElementById('Form1').SystemName.value.length < 1) {
				alert("<%=Translate.JSTranslate("Angiv ´%%´", "%%", Translate.JSTranslate("Systemnavn"))%>");
				document.getElementById('Form1').SystemName.focus();
			} else if (!checkfield(document.getElementById('Form1').SystemName.value)){
				alert("<%=Translate.JSTranslate("´%%´ indeholder ugyldige tegn!", "%%", Translate.JSTranslate("Systemnavn"))%>");
				document.getElementById('Form1').SystemName.focus();
			} else {
				document.getElementById('Form1').submit();
			}
		}
		</script>
		
		<%=Gui.MakeHeaders(Translate.JSTranslate("%m% - Rediger %c%","%m%",Translate.Translate("Forhandlersøgning",9),"%c%",Translate.Translate("felt")), udTxt, "Javascript", false, "")%>
	</head>
	<body>
	
	<%=Gui.MakeHeaders(Translate.Translate("%m% - Rediger %c%","%m%",Translate.Translate("Forhandlersøgning",9),"%c%",Translate.Translate("felt")), udTxt, "Html", false, "")%>
	<table border="0" cellpadding="0" cellspacing="0" class="tabTable" style="height:180px;">
		<form action="UserFieldSave.aspx" name="Form1" method="post">
		<input type="hidden" name="_ID" id="_ID" value="" runat="server">
		<tr>
			<td valign="top">
				<br>
				<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
				<table>
					<tr>
						<td width="170"><%=Translate.Translate("Tekst/Label")%></td>
						<td><input type="text" name="DisplayName" id="DisplayName" value="" class="std" runat="server"></td>
					</tr>
					<tr>
						<td width="170"><%=Translate.Translate("Systemnavn")%></td>
						<td>
						<%If hideSystem Then%>
							<input type="text" name="SystemNameHidden" id="SystemNameHidden" value="<%=hiddenValue%>" class="std" disabled>
						<%End If%>
						<div id="SystemNameSpan" style="display:<%=blockOrNone%>;"><input type="text" name="SystemName" id="SystemName" value="" class="std" runat="server"></div>
						</td>
					</tr>
				</table>
				<%=Gui.GroupBoxEnd()%>
			</td>
		</tr>
		<tr>
			<td align="right" colspan="2">
				<table>
					<tr>
						<td><%=Gui.Button("OK", "CreateField();", 0)%></td>
						<td><%=Gui.Button(Translate.Translate("Annuller"), "location = 'CategoryList.aspx?Tab=3';", 0)%></td>
					</tr>
				</table>
			</td>
		</tr>
		</form>
	</table>
							
  </body>
</html>
<%Translate.GetEditOnlineScript()%>