<%@ Page ValidateRequest="false" CodeBehind="Paragraph_ImageSettings.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Paragraph_ImageSettings" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
	Response.Expires = -100
Dim stronclickLink As String
Dim ParagraphImageWindow() As String
Dim SpecialTotalWidth As String
Dim ParagraphImageHAlign As String
Dim ParagraphImageCaption As String
Dim ParagraphImageHAlignTxtArr() As Object
Dim ParagraphImageHSpace As String
Dim BolUseWindowProperties As Object
Dim ParagraphImageVAlignValArr() As String
Dim ParagraphImageVAlignTxtArr() As Object
Dim ParagraphImageMouseOver As String
Dim ParagraphImageVSpace As String
Dim ParagraphImageURL As String
Dim ParagraphImageResize As String
Dim i As Integer
Dim ParagraphImageHAlignValArr() As String
Dim ParagraphImageVAlign As String
Dim ParagraphImageTarget As String


If Request.Form.Item("Save") = "yes" Then
	ParagraphImageURL = Base.ParseLinkManager("ParagraphImageURL")
	
	BolUseWindowProperties = Base.OpenWindowStrip(ParagraphImageURL, ParagraphImageWindow)
	If BolUseWindowProperties = True Then
		ParagraphImageURL = ParagraphImageWindow(11)
	End If
	
	stronclickLink = "window.open('Paragraph_ImageSettings.aspx?ParagraphImageHAlign=" & Request.Form.Item("ParagraphImageHAlign")
	stronclickLink = stronclickLink & "&ParagraphImageHSpace=" & Request.Form.Item("ParagraphImageHSpace")
	stronclickLink = stronclickLink & "&ParagraphImageVSpace=" & Request.Form.Item("ParagraphImageVSpace")
	stronclickLink = stronclickLink & "&ParagraphImageVAlign=" & Request.Form.Item("ParagraphImageVAlign")
	If Request.Form.Item("LinkManagerSettings_ParagraphImageURL_Mode") = "10" Then
		stronclickLink = stronclickLink & "&ParagraphImageTarget="
	Else
		stronclickLink = stronclickLink & "&ParagraphImageTarget=" & Request.Form.Item("ParagraphImageWindowSelect")
	End If
	
	If Base.HasVersion("18.1.1.0") Then
		stronclickLink = stronclickLink & "&ParagraphImageMouseOver=" & Request.Form.Item("ParagraphImageMouseOver")
	Else
		stronclickLink = stronclickLink & "&ParagraphImageMouseOver="
	End If
	stronclickLink = stronclickLink & "&ParagraphImageCaption=" & Request.Form.Item("ParagraphImageCaption")
	
	If ParagraphImageURL = "" Or IsNothing(ParagraphImageURL) Then
		stronclickLink = stronclickLink & "&ParagraphImageURL="
	Else
		stronclickLink = stronclickLink & "&ParagraphImageURL=" & Server.URLEncode(ParagraphImageURL)
	End If
	If Base.HasVersion("18.2.2.0") Then
		stronclickLink = stronclickLink & "&ParagraphImageResize=" & Request.Form.Item("ParagraphImageResize")
	Else
		stronclickLink = stronclickLink & "&ParagraphImageResize="
	End If
	
	stronclickLink = stronclickLink & "', '_lala', 'resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=600,height=350,top=155,left=202');"
	
	
	
	%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title><%=Translate.JSTranslate("Egenskaber for billede")%></title>
<link rel="STYLESHEET" type="text/css" href="../Stylesheet.css">

<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>

<BODY>
<input type=hidden value="<%=ParagraphImageURL%>" Name="ParagraphImageURL" ID="ParagraphImageURL">
</body>
<html>
<SCRIPT LANGUAGE="JavaScript">
<!--
	//window.opener.document.all.ImageSettingsOpen.setAttribute("onclick", "<%=stronclickLink%>");
	//window.opener.document.all.ImageSettingsOpen.outerHTML = window.opener.document.all.ImageSettingsOpen.outerHTML;
	window.opener.document.all.ParagraphImageURL.value = document.all.ParagraphImageURL.value;
	window.close();
//-->
</SCRIPT>

<%	
Else
	
	ParagraphImageHAlign = Request.QueryString.Item("ParagraphImageHAlign")
	ParagraphImageHSpace = Request.QueryString.Item("ParagraphImageHSpace")
	ParagraphImageVSpace = Request.QueryString.Item("ParagraphImageVSpace")
	ParagraphImageVAlign = Request.QueryString.Item("ParagraphImageVAlign")
	ParagraphImageTarget = Request.QueryString.Item("ParagraphImageTarget")
	ParagraphImageMouseOver = Request.QueryString.Item("ParagraphImageMouseOver")
	ParagraphImageCaption = Request.QueryString.Item("ParagraphImageCaption")
	ParagraphImageURL = Request.QueryString.Item("ParagraphImageURL")
	ParagraphImageURL = Replace(Replace(Replace(Replace(ParagraphImageURL, "%p3", "."), "%p2", ")"),  "%p1", "("), "%p", "'")
	ParagraphImageResize = Request.QueryString.Item("ParagraphImageResize")
	
%>
<SCRIPT LANGUAGE="JavaScript">
<!--

function Send() {
	//if(document.all.LinkManagerSettings_ParagraphImageURL_Mode.options[document.all.LinkManagerSettings_ParagraphImageURL_Mode.selectedIndex].value == 10)
	//	document.all.ParagraphImageWindowSelect.selectedIndex = 0;
	
	if(document.all.ParagraphImageURL.value.search("'") >= 0) {
		alert('<%=Translate.JsTranslate("Ugyldig værdi i: %%", "%%", Translate.JsTranslate("Link"))%>');
		return false;
	}
		
	window.opener.document.all.ParagraphImageHAlign.value = document.all.ParagraphImageHAlign.value;
	window.opener.document.all.ParagraphImageHSpace.value = document.all.ParagraphImageHSpace.value;
	window.opener.document.all.ParagraphImageVSpace.value = document.all.ParagraphImageVSpace.value;
	window.opener.document.all.ParagraphImageVAlign.value = document.all.ParagraphImageVAlign.value;
	window.opener.document.all.ParagraphImageWindowSelect.value = document.all.ParagraphImageWindowSelect.value;
<%	If Base.HasVersion("18.1.1.0") Then%>
	window.opener.document.all.ParagraphImageMouseOver.value = document.all.ParagraphImageMouseOver.value;
<%	End If%>
	window.opener.document.all.ParagraphImageCaption.value = document.all.ParagraphImageCaption.value;
	window.opener.document.all.ParagraphImageURL.value = document.all.ParagraphImageURL.value;
	//window.opener.document.all.LinkManagerSettings_ParagraphImageURLTarget.value = document.all.LinkManagerSettings_ParagraphImageURLTarget.value;
<%	If Base.HasVersion("18.2.2.0") Then%>

	if(document.all.ParagraphImageResize.checked) {
		window.opener.document.all.ParagraphImageResize.value = "Checked"
	} else {
		window.opener.document.all.ParagraphImageResize.value = ""
	}
<%	End If%>
stronclickLink = "window.open('Paragraph_ImageSettings.aspx?ParagraphImageHAlign=" + document.all.ParagraphImageHAlign.value;
stronclickLink = stronclickLink + "&ParagraphImageHSpace=" + document.all.ParagraphImageHSpace.value; 
stronclickLink = stronclickLink + "&ParagraphImageVSpace=" + document.all.ParagraphImageVSpace.value;
stronclickLink = stronclickLink + "&ParagraphImageVAlign=" + document.all.ParagraphImageVAlign.value; 
stronclickLink = stronclickLink + "&ParagraphImageTarget=" + document.all.ParagraphImageWindowSelect.value;

<%	If Base.HasVersion("18.1.1.0") Then%>
	stronclickLink = stronclickLink + "&ParagraphImageMouseOver=" + document.all.ParagraphImageMouseOver.value;
<%	Else%>
	stronclickLink = stronclickLink + "&ParagraphImageMouseOver="
<%	End If%>
stronclickLink = stronclickLink + "&ParagraphImageCaption=" + document.all.ParagraphImageCaption.value;
stronclickLink = stronclickLink + "&ParagraphImageURL=" + document.all.ParagraphImageURL.value;
<%	If Base.HasVersion("18.2.2.0") Then%>
	stronclickLink = stronclickLink + "&ParagraphImageResize=" + document.all.ParagraphImageResize.checked
<%	Else%>
	stronclickLink = stronclickLink + "&ParagraphImageResize="
<%	End If%>

stronclickLink = stronclickLink + "', '_lala', 'resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=600,height=350,top=155,left=202');"

	window.opener.document.all.ImageSettingsOpen.setAttribute("onclick", stronclickLink);
	window.opener.document.all.ImageSettingsOpen.outerHTML = window.opener.document.all.ImageSettingsOpen.outerHTML;

		document.getElementById('ImageSettings').submit();
}


function ValidateInt(obj) {
	if (!parseInt(obj.value)) {
		obj.value=0;
		alert('<%=Translate.JsTranslate("Angiv heltal")%>');
	}
	else {
		obj.value = parseInt(obj.value);
	}
}

//-->
</SCRIPT>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=Translate.JSTranslate("Egenskaber for billede")%></title>
<link rel="STYLESHEET" type="text/css" href="../Stylesheet.css">

<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
</HEAD>

<BODY>
<%= Gui.MakeHeaders(Translate.Translate("Indstillinger for billede"), Translate.Translate("Indstillinger"), "all", false, "500") %>

			<table border="0" cellspacing="0" cellpadding="0" class=tabTable style="width:500px;">
			<form name="ImageSettings" id="ImageSettings" method="post">
				<tr height=5>
					<td></td>
				</tr>
				<tr>
					<td colspan=2>
						<%=Gui.GroupBoxStart(Translate.Translate("Justering"))%>
						<table cellpadding=2 cellspacing=0>
							<tr>
								<td width=130><%=Translate.Translate("Horisontal")%></td>
								<td><INPUT TYPE="TEXT" NAME="ParagraphImageHSpace" onChange="ValidateInt(this)" VALUE="<%=ParagraphImageHSpace%>" class=std style="width:20px;"> <%=Translate.Translate("px. fra")%> <select name="ParagraphImageHAlign" class=std style="width:120px;">
										<%	
										ParagraphImageHAlignValArr = New String(){"left", "right", "center"}
										ParagraphImageHAlignTxtArr = New string(){Translate.Translate("Venstre"), Translate.Translate("HÃ¸jre"), Translate.Translate("Centreret")}
										
										For i = 0 To UBound(ParagraphImageHAlignValArr)
											If ParagraphImageHAlign = ParagraphImageHAlignValArr(i) Then
												Response.Write("<option value=""" & ParagraphImageHAlignValArr(i) & """ selected>" & ParagraphImageHAlignTxtArr(i) & "</option>" & vbCrLf)
											Else
												Response.Write("<option value=""" & ParagraphImageHAlignValArr(i) & """>" & ParagraphImageHAlignTxtArr(i) & "</option>" & vbCrLf)
											End If
										Next 
										%>
									</select></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Vertikal")%></td>
								<td><INPUT TYPE="TEXT" NAME="ParagraphImageVSpace" onChange="ValidateInt(this)" VALUE="<%=ParagraphImageVSpace%>" class=std style="width:20px;"> <%=Translate.Translate("px. fra")%> <select name="ParagraphImageVAlign" class=std style="width:120px;">
										<%	
										ParagraphImageVAlignValArr = New String(){"top", "bottom", "middle"}
										ParagraphImageVAlignTxtArr = New string(){Translate.Translate("Top"), Translate.Translate("Bund"), Translate.Translate("Midt")}
										
										For i = 0 To UBound(ParagraphImageVAlignValArr)
											If ParagraphImageVAlign = ParagraphImageVAlignValArr(i) Then
												Response.Write("<option value=""" & ParagraphImageVAlignValArr(i) & """ selected>" & ParagraphImageVAlignTxtArr(i) & "</option>" & vbCrLf)
											Else
												Response.Write("<option value=""" & ParagraphImageVAlignValArr(i) & """>" & ParagraphImageVAlignTxtArr(i) & "</option>" & vbCrLf)
											End If
										Next 
										%>
									</select></td>
							</tr>
						</table>
						<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
				<tr>
					<td colspan=2>
						<%	If Base.HasVersion("18.2.2.0") Then%>
						<%=Gui.GroupBoxStart(Translate.Translate("Skalering"))%>
							<table cellpadding=2 cellspacing=0>
								<!--
								Commented out due to problems with integration of this function and the templates - we dont know the size to force to! //Nic
								21/1-2003 - Well problem solved... Reactivatet!
								-->
								
								<tr>
									<td></td>
									<td><%=Gui.CheckBox(ParagraphImageResize, "ParagraphImageResize")%><label for="ParagraphImageResize"> <%=Translate.Translate("Tilpas billede")%></label></td>
								</tr>
							</table>
						<%=Gui.GroupBoxEnd%>
						<%	End If%>
					</td>
				<tr>
					<td colspan=2>
						<%=Gui.GroupBoxStart(Translate.Translate("Link"))%>
							<table cellpadding=2 cellspacing=0>
								<tr>
									<td width="130" valign="top"><%=Translate.Translate("Link")%></td>
									<td><%= Gui.LinkManagerExt(ParagraphImageURL, "ParagraphImageURL", "")%></td>
								</tr>
								<tr>
									<td><%=Translate.Translate("Billedetekst")%></td>
									<td><INPUT type="TEXT" name="ParagraphImageCaption" MAXLENGTH="255" VALUE="<%=ParagraphImageCaption%>" class="std"></td>
								</tr>
								<%	If Base.HasVersion("18.1.1.0") Then%>
								<tr>
									<td><%=Translate.Translate("Alt-tekst")%></td>
									<td><INPUT type="TEXT" name="ParagraphImageMouseOver" MAXLENGTH=255 VALUE="<%=ParagraphImageMouseOver%>" class=std></td>
								</tr>
								<%	End If%>
								<TR>
									<TD><%=Translate.Translate("Target")%></TD>
									<TD>
										<SELECT name="ParagraphImageWindowSelect" id="ParagraphImageWindowSelect" class="std">
											<OPTION <%=Base.IIf(ParagraphImageTarget = "", "selected", "")%> value=""><%=Translate.Translate("Standard")%></OPTION>
											<OPTION <%=Base.IIf(ParagraphImageTarget = "_blank", "selected", "")%> value="_blank"><%=Translate.Translate("Nyt vindue (_blank)")%></OPTION>
											<OPTION <%=Base.IIf(ParagraphImageTarget = "_top", "selected", "")%> value="_top"><%=Translate.Translate("Samme vindue (_top)")%></OPTION>
											<OPTION <%=Base.IIf(ParagraphImageTarget = "_self", "selected", "")%> value="_self"><%=Translate.Translate("Samme ramme (_self)")%></OPTION>
										</SELECT>
									</TD>
								</TR>
							</table>
						<%=Gui.GroupBoxEnd%>
						<BR>
					</td>
				</tr>
				<tr>
					<td align="right" valign="bottom">
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td align="right"><%=Gui.Button(Translate.Translate("OK"), "Send();", 0)%><input type="hidden" Name="Save" ID="Save" Value="yes"></td>
								<td width="5"></td>
								<td align="right"><%=Gui.Button(Translate.Translate("Annuller"), "window.close();", 0)%></td>
								<%=Gui.HelpButton("paragraph_edit", "page.paragraph.edit.image",,5)%>
								<td width="5"></td>
							</tr>
							<tr>
								<td colspan="4" height="5"></td>
							</tr>			
						</table>
					</td>
				</tr>
				</form>
			</table>
</BODY>
</HTML>
<SCRIPT LANGUAGE="JavaScript">
<!--
function linkManagerToggleSettings(Name) {
	var objHwnd = document.getElementById(Name);
	if (objHwnd.style.display == "none") {
		objHwnd.style.display = "";
		window.resizeTo(560, 600);
	}
	else {
		objHwnd.style.display = "none";
		window.resizeTo(560, 450);
	}
}
//-->
</SCRIPT>

<%	
End If

Translate.GetEditOnlineScript()
%>
