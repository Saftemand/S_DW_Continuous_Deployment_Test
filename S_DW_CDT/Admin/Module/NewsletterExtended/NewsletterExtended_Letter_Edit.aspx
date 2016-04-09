<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" CodeBehind="NewsletterExtended_Letter_Edit.aspx.vb" Inherits="Dynamicweb.Admin.NewsletterExtended_Letter_Edit" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<%

    Dim NewsletterLevel As String
    Dim NewsletterStylesheetID As String
    Dim NewsletterDescription As String
    Dim NewsletterName As String
    Dim NewsletterEncodingID As String
    Dim NewsletterSaved As String
    Dim NewsletterTemplateID As String
    Dim NewsletterEndcodingID As String
    Dim NewsletterID As String
    Dim NewsletterLetterType As String ' 0 = Normal letter / 1 = Pagebased newsletter
    Dim sql As String
    Dim strSendText As String
    Dim TemplateIcon As String
    Dim ParagraphTemplateID As String
    Dim cnDynamic As IDbConnection = Database.CreateConnection("Dynamic.mdb")
    Dim cnNewsletterExtended As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
    Dim cmdNewsletterExtended As IDbCommand = cnNewsletterExtended.CreateCommand
    Dim cmdDynamic As IDbCommand = cnDynamic.CreateCommand

    Dim drNewsletter As IDataReader
    Dim drSeletedTemplate As IDataReader

    Response.Expires = -100

    NewsletterID = Base.ChkNumber(Base.Request("ID"))

    cmdNewsletterExtended.CommandText = "SELECT * FROM NewsletterExtended WHERE NewsletterID = " & NewsletterID
    drNewsletter = cmdNewsletterExtended.ExecuteReader()

    If drNewsletter.Read() Then
        NewsletterName = drNewsletter("NewsletterName").ToString
        NewsletterDescription = drNewsletter("NewsletterDescription").ToString
        If drNewsletter("NewsletterStylesheetID").ToString <> "" And Not drNewsletter("NewsletterStylesheetID").ToString = "0" Then
            NewsletterStylesheetID = drNewsletter("NewsletterStylesheetID").ToString
        Else
            NewsletterStylesheetID = "1"
        End If
        NewsletterTemplateID = drNewsletter("NewsletterTemplateID").ToString
        NewsletterEncodingID = drNewsletter("NewsletterEncodingID").ToString
        NewsletterDescription = drNewsletter("NewsletterDescription").ToString
        ParagraphTemplateID = drNewsletter("NewsletterTemplateID").ToString
        NewsletterEncodingID = drNewsletter("NewsletterEncodingID").ToString
        NewsletterLevel = drNewsletter("NewsletterLevel").ToString
        NewsletterSaved = "Yes"
        NewsletterLetterType = CStr(Base.ChkNumber(drNewsletter("NewsletterLetterType").ToString))
    Else
        NewsletterName = ""
        NewsletterDescription = ""
        NewsletterStylesheetID = "1"
        NewsletterEncodingID = Base.GetGs("/Globalsettings/Modules/NewsletterExtended/Common/NewsletterEncoding")
        If NewsletterEncodingID = "" Then
            NewsletterEncodingID = Nothing
        End If
        NewsletterEndcodingID = "utf-8"
        NewsletterLevel = "1"
        NewsletterSaved = "No"
        NewsletterLetterType = "0"
    End If

    drNewsletter.Dispose()

    '''''''''''''''''''''''''''''''''template '''''''''''''''''''''''''''''''
    If ParagraphTemplateID <> "" And IsNumeric(ParagraphTemplateID) Then
        sql = "SELECT TemplateID, TemplateIcon FROM Template WHERE TemplateCategoryID = 9 AND TemplateID = " & ParagraphTemplateID
    Else
        sql = "SELECT TemplateID, TemplateIcon FROM Template WHERE TemplateCategoryID = 9 AND TemplateIsDefault = 1"
    End If

    cmdDynamic.CommandText = sql
    drSeletedTemplate = cmdDynamic.ExecuteReader()

    If drSeletedTemplate.Read() Then
        TemplateIcon = drSeletedTemplate("TemplateIcon").ToString()
        ParagraphTemplateID = drSeletedTemplate("TemplateID").ToString()
    Else
        drSeletedTemplate.Close()
        sql = "SELECT Top 1 TemplateID, TemplateIcon FROM Template WHERE TemplateCategoryID = 9"
        cmdDynamic.CommandText = sql
        drSeletedTemplate = cmdDynamic.ExecuteReader()
        If drSeletedTemplate.Read() Then
            TemplateIcon = drSeletedTemplate("TemplateIcon").ToString()
            ParagraphTemplateID = drSeletedTemplate("TemplateID").ToString()
        End If
    End If
    drSeletedTemplate.Close()
    drSeletedTemplate.Dispose()

    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<SCRIPT LANGUAGE="JavaScript">
<!--
var popupTemplateWindow;
function Change_NewsletterType(obj) {
	if(obj.checked) {
		document.getElementById("tr_stylesheet").style.display = "none";
		document.getElementById("tr_template").style.display = "none";
	} else {
		document.getElementById("tr_stylesheet").style.display = "";
		document.getElementById("tr_template").style.display = "";
	}	
}

function SendBasic() {
	if(popupTemplateWindow != null){popupTemplateWindow.close();}
	if (document.getElementById('Newsletter_letter').NewsletterName.value.length < 1)	{
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>');
		return false;
	} else if (document.getElementById('Newsletter_letter').NewsletterName.value.length > 255) {
		alert("<%=Translate.JSTranslate("Max %% tegn i: ","%%","255")%><%=Translate.JSTranslate("Navn")%>");
		return false;
	} else if (document.getElementById('Newsletter_letter').NewsletterDescription.value.length > 2000) {
		alert("<%=Translate.JSTranslate("Max %% tegn i: ","%%","2000")%><%=Translate.JSTranslate("Beskrivelse")%>");
		return false;
	}<%If NewsletterLevel > 1 Then%>
	else if (document.getElementById('Newsletter_letter').ParagraphTemplateID.value != <%=NewsletterTemplateID%>)
		{
		if(confirm('<%=Translate.JsTranslate("Der er valgt en ny Template.")%>\n<%=Translate.JsTranslate("Indholdet af nyhedsbrevet vil blive overskrevet.")%>\n<%=Translate.JsTranslate("Fortsæt?")%>'))
			{
			document.getElementById('Newsletter_letter').submit();
			}
		}
	else if ((document.getElementById("NewsletterLetterType").checked &&  <%=NewsletterLetterType%> != 1) || (!document.getElementById("NewsletterLetterType").checked &&  <%=NewsletterLetterType%> != 0))
		{
		if(confirm("<%=Translate.JsTranslate("Der er valgt en ny type nyhedsbrev.")%>\n<%=Translate.JsTranslate("Indholdet af nyhedsbrevet vil blive overskrevet.")%>\n<%=Translate.JsTranslate("Fortsæt?")%>"))
			{
			document.getElementById('Newsletter_letter').action= "NewsletterExtended_letter_save.aspx?Type=Pagebased"
			document.getElementById('Newsletter_letter').submit();
			}
		}	
	<%End If%>
	else {
		if(document.getElementById("NewsletterLetterType").checked){
			document.getElementById('Newsletter_letter').action= "NewsletterExtended_letter_save.aspx?Type=Pagebased"
			document.getElementById('Newsletter_letter').submit();
		}
		else{
			document.getElementById('Newsletter_letter').action="NewsletterExtended_letter_save.aspx?Type=Basic"
			document.getElementById('Newsletter_letter').submit();
		}
	}
}

//-->
</SCRIPT>

<title></title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">

<%
If NewsletterLevel >= 3 Then
	strSendText = Translate.Translate("(Sendt)")
End If
%>
<%=Gui.MakeHeaders(Translate.Translate("Rediger nyhedsbrev - %%", "%%", NewsletterName) & "&nbsp;" & strSendText & "<br>", Translate.Translate("Stamdata"), "javascript")%>
<body LEFTMARGIN="20" TOPMARGIN="16">

<%=Gui.MakeHeaders(Translate.Translate("Rediger nyhedsbrev - %%", "%%", NewsletterName) & "&nbsp;" & strSendText & "<br>", Translate.Translate("Stamdata"), "html")%>

<div ID="Tab1" STYLE="display:;">
<TABLE border="0" cellpadding="0" width="598" cellspacing="2" class="tabTable">
		<tr>
			<td valign="top"><br><br>
				<form action="NewsletterExtended_letter_save.aspx?Type=Basic" method="post" name="Newsletter_letter" id="Newsletter_letter">
					<%=Gui.GroupBoxStart(Translate.Translate("Stamdata"))%>
					<TABLE cellpadding=2 cellspacing=0>
						<tr>
							<td width="170px"><%=Translate.Translate("Navn")%></td>
							<td>
								<input type="Text" name="NewsletterName" value="<%=Server.HtmlEncode(NewsletterName)%>" class="std">
								<input type="hidden" name="NewsletterID" value="<%=NewsletterID%>">
								<input type="hidden" name="NewsletterLevel" value="<%=NewsletterLevel%>">
							</td>
						</tr>
						<tr>
							<td valign="Top" width="170px"><%=Translate.Translate("Beskrivelse")%></td>
							<td><textarea class="std" name="NewsletterDescription" rows="3" cols="50" ><%=NewsletterDescription%></textarea></td>
						</tr>
						<tr>
							<td width="170px"><%=Translate.Translate("Encoding")%></td>
							<td><%=Gui.EncodingList(NewsletterEncodingID, "AreaEncoding", True)%></td>
						</tr>
						<tr>
							<td valign="Top" width="170px"><%=Translate.Translate("Sidebaseret nyhedsbrev")%></td>
							<td><input type="CheckBox" onclick="javascript:Change_NewsletterType(this);" name="NewsletterLetterType" id="NewsletterLetterType" <%If NewsletterLetterType = "1" Then%> checked<%End If%>></td>
						</tr>
						<tr id="tr_stylesheet" style="display:<%If NewsletterLetterType = "1" Then%>none<%End If%>">
							<td width="170px"><%=Translate.Translate("Stylesheet")%></td>
							<td><%=Gui.StylesheetList(NewsletterStylesheetID, "Stylesheet")%></td>
						</tr>
						<tr id="tr_template" style="display:<%If NewsletterLetterType = "1" Then%>none<%End If%>">
							<td valign="Top" width="170px"><%=Translate.Translate("Template")%></td>
							<!-- <td><a href="JavaScript:openTemplateViewer();"><img src="../../../Files/Templates/Images/<%=TemplateIcon%>" border="0" name="TemplateIcon"></a></strong></td> -->
							<%=Gui.TemplatePreview(NewsletterTemplateID, "newsletters")%>
			
						</tr>
						<tr><td><br></td></tr>
					</TABLE>
				<%=Gui.GroupBoxEnd%>
			</td>
		</tr>
		<tr>
			<td align="right" valign="bottom">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td align="right"><%=Gui.Button(Translate.Translate("Næste"), "SendBasic();", 0)%></td>
						<td width="5"></td>
						<td align="right"><%=Gui.Button(Translate.Translate("Annuller"), "location='NewsletterExtended_Blank.html'", 0)%></td>
						<%=Gui.HelpButton("newsletterV2", "modules.newsletterextended.general.letter.edit",,5)%>
						<td width="10"></td>
					</tr>
					<tr>
						<td colspan="4" height="5"></td>
					</tr>			
				</table>
			</td>
		</tr>
	</table>
<%=Gui.TemplatePreviewScript("newsletters", NewsletterTemplateID, "Newsletter_letter")%>
</form>
</div>

<%
cmdNewsletterExtended.Dispose()
cmdDynamic.Dispose()
cnDynamic.Dispose()		
cnNewsletterExtended.Dispose()
%>

</body>
</html>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>