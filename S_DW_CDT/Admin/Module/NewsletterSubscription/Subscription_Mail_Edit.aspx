<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Subscription_Mail_Edit.aspx.vb" Inherits="Dynamicweb.Admin.Subscription_Mail_Edit"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="System.Collections" %>

<%

'Base.w(Request.Item("Page"))
'Base.we(Request.Item("News"))

Dim ShowTab As String
Dim FormEmailFieldID As String
Dim FormColumnShiftFormFieldID As String
Dim FormID As String
Dim FormLabelOverField As Boolean
Dim FormLabelRequired As String
Dim FormName As String
Dim FormLabelBold As String
Dim recordCount as Integer = 0
Dim i As Integer

Dim mySubscriptionCollection As New Dynamicweb.Admin.SubscriptionCollection
Dim myMailSettings as Dynamicweb.Admin.SubscriptionSettings = mySubscriptionCollection.MailSettings

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title></title>
		<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	</head>
	<script>
function ValidateForm(){
	FormOK = true;

	<%If Base.GetGs("/Globalsettings/Settings/NewsletterSubscription/SaveSetting") = "newsletterextended"%>
		if(document.getElementById('NewsletterSubscription').NewsletterName.value.length <= 0){
			alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>');
			document.getElementById('NewsletterSubscription').NewsletterName.focus();
			FormOK = false;
		}
		if(document.getElementById('NewsletterSubscription').NewsletterName.value.length > 100){
			alert("<%=Translate.JSTranslate("Max %% tegn i: ","%%","100")%><%=Translate.JSTranslate("Navn")%>");
			document.getElementById('NewsletterSubscription').NewsletterName.focus();
			FormOK = false;
		}
	<%End If%>
	if(document.getElementById('NewsletterSubscription').NewsParagraphShowXCharacters.value.length <= 0){
		alert('<%=Translate.JSTranslate("Angiv antal tegn")%>');
		document.getElementById('NewsletterSubscription').NewsParagraphShowXCharacters.focus();
		FormOK = false;
	}
	if(isNumeric(document.getElementById('NewsletterSubscription').NewsParagraphShowXCharacters.value)) {
		alert('<%=Translate.JSTranslate("Skal være numerisk!")%>');
		document.getElementById('NewsletterSubscription').NewsParagraphShowXCharacters.focus();
		FormOK = false;
	}
	
	if(FormOK){
		return true;
	}else{
		return false;
	}
}

function isNumeric(str) {
// returns true if str is numeric
// that is it contains only the digits 0-9
// returns false otherwise
// returns false if empty
	var len = str.length;
	if(len==0)
		return false;

	//else
	var p=0;
	var ok= true;
	var ch= "";
	while(ok && p < len) {
		ch= str.charAt(p);
		if('0' <= ch && ch >= '9')
			p++;
		else
			ok = false;
	}
	return ok;
}

function ins_mover(pid){
	//document.getElementById("i" + pid).src='../../images/nothing.gif'
}
function ins_mout(pid){
	//document.getElementById("i" + pid).src='../../images/ins.gif'
}
function ins_clk(intSort){
	if(parseInt(intSort) != "NaN"){
		intSort = parseInt(intSort);
	}
	else{
		intSort = 1;
	}
	location = 'Form_Module_Field_Edit.aspx?FormFieldFormID=<%=request.QueryString.Item("FormID")%>&NewSort=' + intSort;
}

function PreviewMail(){
	if(ValidateForm()){
		document.getElementById('NewsletterSubscription').action = 'Subscription_ActionCaller.aspx?Action=preview';
		document.getElementById('NewsletterSubscription').submit();
	}
}

function OpenNews(ID){
	document.getElementById('NewsletterSubscription').action = 'Subscription_ActionCaller.aspx?Action=edit&Type=news&SubscriptionObjID=' + ID;
	document.getElementById('NewsletterSubscription').submit();
//	window.open("/Default.aspx?m=news&NewsID=" + ID, "News", "resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,width=800,height=600,top=155,left=402");
}

function OpenPage(ID){
	document.getElementById('NewsletterSubscription').action = 'Subscription_ActionCaller.aspx?Action=edit&Type=page&SubscriptionObjID=' + ID;
	document.getElementById('NewsletterSubscription').submit();
//	window.open("/Default.aspx?ID=" + ID, "News", "resizable=yes,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,width=800,height=600,top=155,left=402");
}

function SaveMail(){
	if(ValidateForm()){
		document.getElementById('NewsletterSubscription').action = 'Subscription_ActionCaller.aspx?Action=save';
		document.getElementById('NewsletterSubscription').submit();
	}
}

function GoSearch(){
	document.getElementById('NewsletterSubscription').action = 'Subscription_ActionCaller.aspx?Action=search';
	document.getElementById('NewsletterSubscription').submit();
}

function GoSort(direction, id){
	document.getElementById('NewsletterSubscription').action = 'Subscription_ActionCaller.aspx?Action=sort&Direction=' + direction +'&SubscriptionID='+ id;
	document.getElementById('NewsletterSubscription').submit();
}

function Remove(id){
	if(confirm('<%=Translate.JsTranslate("Fjern %%?","%%", Translate.JsTranslate("indhold"))%>')){
		document.getElementById('NewsletterSubscription').action = 'Subscription_ActionCaller.aspx?Action=Remove&SubscriptionID='+ id;
		document.getElementById('NewsletterSubscription').submit();
	}
}

function ResetMail(){
	if(confirm('<%=Translate.JsTranslate("Nulstil alt indhold og indstillinger?")%>')){
		document.getElementById('NewsletterSubscription').action = 'Subscription_ActionCaller.aspx?Action=Reset';
		document.getElementById('NewsletterSubscription').submit();
	}
}

	</script>
	<%=Gui.MakeHeaders(Translate.Translate("Indholdsabonnement",9), Translate.Translate("E-mail"), "all")%>
	
<%

%>
	<table border="0" cellpadding="0" cellspacing="0" class="TabTable">
		<form action="" method="post" name="NewsletterSubscription" id="NewsletterSubscription">
			<input type="Hidden" name="FormID" value="<%=FormID%>">
			<tr>
				<td valign="top"><br>
					<DIV ID="Tab1" STYLE="display:;">
						<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
						<table border="0" cellpadding="2" cellspacing="0">
							<%If Base.GetGs("/Globalsettings/Settings/NewsletterSubscription/SaveSetting") <> "" Then%>
							<tr>
								<td width="170"><%=Translate.Translate("Navn")%>&nbsp;</td>
								<td><input type="Text" name="NewsletterName" value="<%=Server.HtmlEncode(myMailSettings.Name)%>" maxlength="255" class="std"></td>
							</tr>
							<tr>
								<td valign="Top" width="170px"><%=Translate.Translate("Beskrivelse")%></td>
								<td><textarea class="std" name="NewsletterDescription" rows="3" cols="50" ><%=myMailSettings.Description%></textarea></td>
							</tr>
							<tr>
								<td width="170px"><%=Translate.Translate("Stylesheet")%></td>
								<td><%=Gui.StylesheetList(myMailSettings.StylesheetID, "Stylesheet")%></td>
							</tr>
							<%End If%>
							<tr>
								<td><%=Translate.Translate("Template - %%", "%%", Translate.Translate("E-mail"))%></td>
								<td><%=Gui.FileManager(myMailSettings.MailTemplate, "Templates/NewsletterSubscription", "MailTemplate")%> </td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Sideelement"))%></td>
								<td><%=Gui.FileManager(myMailSettings.PageElementTemplate, "Templates/NewsletterSubscription", "PageElementTemplate")%> </td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Nyhedselement"))%></td>
								<td><%=Gui.FileManager(myMailSettings.NewsElementTemplate, "Templates/NewsletterSubscription", "NewsElementTemplate")%> </td>
							</tr>
							<tr>
								<td width="170" valign="top"><%=Translate.Translate("Visning som")%></td>
								<td>
									<%=Gui.Linkmanager(myMailSettings.NewsParagraphSettings, "NewsParagraphSettings", "", "0", "", False, "on", True)%>
								</td>
							</tr>
							<tr>
								<td  valign="top"></td>
								<td>	
									<%=Gui.RadioButton(myMailSettings.UseTeaser, "UseTeaser", "FirstXChars")%>&nbsp;<%=Translate.Translate("Vis de første %% tegn", "%%", "<input type='text' name='NewsParagraphShowXCharacters' size='4' maxlength='255' class='std' value='" & myMailSettings.NewsParagraphShowXCharacters.ToString &"' style='width:35px;'>")%><br>
									<%=Gui.RadioButton(myMailSettings.UseTeaser, "UseTeaser", "ShowAll")%>&nbsp;<%=Translate.Translate("Vis hele indholdet")%><br>
								</td>
							</tr>
							<tr>
								<td colspan="2">&nbsp;</td>
							</tr>
						</table>
						<%Response.Write(Gui.GroupBoxEnd)
						'If IsNumeric(FormID) And CInt(FormID) > 0 Then
						Response.Write(Gui.GroupBoxStart(Translate.Translate("Indhold")))%>
						<table border="0" cellpadding="2" width="570">
							<tr>
								<td><strong><%=Translate.Translate("Type")%></strong></td>
								<td><strong><%=Translate.Translate("Navn")%></strong></td>
								<td width="75"><strong><%=Translate.Translate("Oprettet")%></strong></td>
								<td width="75"><strong><%=Translate.Translate("Redigeret")%></strong></td>
								<td width="75" align="center"><strong><%=Translate.Translate("Sortering")%></strong></td>
								<td width="35" align="center"><strong><nobr><%=Translate.Translate("Fjern")%></nobr></strong></td>
							</tr>
							<%If Base.HasVersion("18.8.1.0") Then%>
							<td style="" colspan="6" onClick="" onmouseout=""
								onmouseover=""><img src="../images/nothing.gif" alt="" width="3" height="5" border="0" align="absmiddle"
									id="i0"><img src="../images/nothing.gif" width="591" height="1" alt="" border="0" style="background-color:#cccccc;"></td>
							<%Else%>
							<%		
		Response.Write(("<tr>"))
		Response.Write(("	<td colspan=""6"" bgcolor=""#C4C4C4""><img src=""../../images/nothing.gif"" width=1 height=1 border=""0""></td>"))
		Response.Write(("</tr>"))
	End If
    
    
 
	Dim strHome as String = "/Admin/"
	i = 0
	For Each _sub As Dynamicweb.Admin.ISubscription In mySubscriptionCollection
'	Do While drFormField.Read()
		i = i + 1
		Response.Write(("<tr>"))
		Response.Write(("<td>&nbsp;&nbsp;<img src=""" & strHome & _sub.GetIcon & """>" & _sub.SortValue & "</td>"))
		
		If _sub.GetSubscriptionType = "news" Then
            Response.Write(("<td><a href='javascript:OpenNews(" & _sub.ID & ")'>" & _sub.Headline & "</a></td>"))
		Else
            Response.Write(("<td><a href='javascript:OpenPage(" & _sub.ID & ")'>" & _sub.Headline & "</a></td>"))
		End If
		
		Response.Write(("<td>" & _sub.DateCreated & "</td>"))
		Response.Write(("<td width=75>" & _sub.DateUpdated & "</td>"))
		If mySubscriptionCollection.Count = 1 Then
			Response.Write(("<td width=75 align=""center""><img src=""../../images/Nothing.gif"" width=""15"">&nbsp;<a href=""javascript:GoSort('down', " & _sub.SubscriptionID & ")""><img src=""../../images/Nothing.gif"" border=""0""></a></td>"))
		ElseIf i = 1 Then
			Response.Write(("<td width=75 align=""center""><img src=""../../images/Nothing.gif"" width=""15"">&nbsp;<a href=""javascript:GoSort('down', " & _sub.SubscriptionID & ")""><img src=""../../images/PilNed.gif"" alt=""" & Translate.JsTranslate("Flyt ned") & """ border=""0""></a></td>"))
		ElseIf i = mySubscriptionCollection.Count Then 
			Response.Write(("<td width=75 align=""center""><a href=""javascript:GoSort('up', " & _sub.SubscriptionID & ")""><img src=""../../images/PilOp.gif"" alt=""" & Translate.JsTranslate("Flyt op") & """ border=""0""></a>&nbsp;<img src=""../../images/nothing.gif"" width=""15""></a></td>"))
		Else
			Response.Write(("<td width=75 align=""center""><a href=""javascript:GoSort('up', " & _sub.SubscriptionID & ")""><img src=""../../images/PilOp.gif"" alt=""" & Translate.JsTranslate("Flyt op") & """ border=""0""></a>&nbsp;<a href=""javascript:GoSort('down', " & _sub.SubscriptionID & ")""><img src=""../../images/PilNed.gif"" alt=""" & Translate.JsTranslate("Flyt ned") & """ border=""0""></a></td>"))
		End If
		'If drFormField("FormFieldActive") Then
		'	Response.Write("<td align=""center""><a href=""Form_Module_Field_SetActive.aspx?SetActive=False&FormFieldID=" & "&FormID=" & FormID & """><img src=""../../images/Check.gif"" border=""0""></a></td>")
		'Else
		'	Response.Write("<td align=""center""><a href=""Form_Module_Field_SetActive.aspx?SetActive=True&FormFieldID=" &  "&FormID=" & FormID & """><img src=""../../images/Minus.gif"" border=""0""></a></td>")
		'End If
		Response.Write(("<td width=35 align=""center""><a href=""javascript:Remove(" & _sub.SubscriptionID & ")""><img src=""../../images/Delete.gif"" border=0 alt=""" & Translate.JsTranslate("Fjern %%","%%", "side/nyhed") & """></a></td>"))
		Response.Write(("</tr>"))
		
		Response.Write(("<tr title=""" & Translate.JsTranslate("Indsæt felt på denne plads") & """>"))
		%>
							<%If Base.HasVersion("18.8.1.0") Then%>
							<td style="" colspan=6 onClick="" onmouseout="" onmouseover=""><img src="../images/nothing.gif" alt="" width="3" height="5" border="0" align=absmiddle id=""><img src="../images/nothing.gif" width="591" height="1" alt="" border="0" style="background-color:#cccccc;"></td>
							<%Else
			Response.Write(("	<td colspan=""6"" bgcolor=""#C4C4C4""><img src=""../../images/nothing.gif"" width=1 height=1 border=""0""></td>"))
		End If
		Response.Write(("</tr>"))
'	Loop
Next
	%>
							<tr>
								<td colspan="5" align="right"><%=Gui.Button(Translate.Translate("Find"), "GoSearch();", 0)%>
								</td>
							</tr>
						</table>
						<%Response.Write(Gui.GroupBoxEnd)%>
					</DIV>
				</td>
			</tr>
			<tr>
				<td align="right" valign="bottom">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td colspan="4" height="10"></td>
						</tr>
						<tr>
							<td width="5"></td>
							<td><%=Gui.Button(Translate.Translate("Reset"), "ResetMail();", 0)%>
							</td>
							<td width="5"></td>
							<td><%=Gui.Button(Translate.Translate("Preview nyhedsbrev"), "PreviewMail();", 0)%></td>
							<td width="5"></td>
							<td><%=Gui.Button(Translate.Translate("Opret nyhedsbrev"), "SaveMail();", 0)%></td>
							<td width="5"></td>
							<td><%= Gui.Button(Translate.Translate("Luk"), "location='../../Content/Moduletree/EntryContent.aspx'", 0)%></td>
							<%=Gui.HelpButton("", "modules.contextsubscription.general",,5)%>
							<td width="10"></td>
						</tr>
						<tr>
							<td colspan="4" height="5"></td>
						</tr>
					</table>
				</td>
			</tr>
	</table>
<%

Translate.GetEditOnlineScript()
%>
