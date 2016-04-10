<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" CodeBehind="NewsletterExtended_Letter_Body_Preview_Send.aspx.vb" Inherits="Dynamicweb.Admin.NewsletterExtended_Letter_Body_Preview_Send" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<%

Dim NewsletterContentEnd As String
Dim NewsletterLevel As String
Dim NewsletterStylesheetID As String
Dim NewsletterDescription As String
Dim NewsletterCancelLink  As String
Dim NewsletterName As String
Dim NewsletterEncodingID As String
Dim NewsletterContentHead As String
Dim sql As String
Dim NewsletterTextMailBody As String
Dim NewsletterSaved As String
Dim NewsletterSubscriptionLink As String
Dim strSendText As String
Dim NewsletterContent As String
Dim varAttachmentList As String
Dim NewsletterMailSenderEmail As String
Dim NewsletterCancelLinkText As String
Dim StaticCounter As Byte
Dim NewsletterSubscriptionLinkText As String
Dim NewsletterSpecTextMail As Boolean
Dim NewsletterEndcodingID As String
Dim NewsletterID As String
Dim NewsletterMailSenderName As String
Dim NewsletterTemplateID As String
Dim NewsletterMailSubject As String
Dim ParagraphTemplateID As String
Dim varTab As String
Dim Counter As Integer
Dim cnNewsletterExtended	As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
Dim cmdNewsletterExtended	As IDbCommand	 = cnNewsletterExtended.CreateCommand

Dim drNewsletter			As IDataReader	 
Dim drAttachment			As IDataReader

response.Expires = -100

varTab = Request.QueryString.Item("Tab")
NewsletterID = Base.ChkNumber(Request.Item("ID"))
varTab = "Tab1"
sql = "SELECT * FROM NewsletterExtended WHERE NewsletterID = " & NewsletterID
cmdNewsletterExtended.CommandText = sql
drNewsletter = cmdNewsletterExtended.ExecuteReader() 

If drNewsletter.Read() Then
	'NewsletterID = drNewsletter("NewsletterID").ToString
	NewsletterName = drNewsletter("NewsletterName").ToString
	NewsletterDescription = drNewsletter("NewsletterDescription").ToString
	If drNewsletter("NewsletterStylesheetID").ToString <> "" And Not drNewsletter("NewsletterStylesheetID").ToString = "0" Then
		NewsletterStylesheetID = drNewsletter("NewsletterStylesheetID").ToString
	Else
		NewsletterStylesheetID = "1"
	End If
	NewsletterTemplateID = drNewsletter("NewsletterTemplateID").ToString
	NewsletterEncodingID = drNewsletter("NewsletterEncodingID").ToString
	NewsletterLevel = drNewsletter("NewsletterLevel").ToString
	NewsletterContent = drNewsletter("NewsletterContent").ToString
	NewsletterMailSenderName = drNewsletter("NewsletterMailSenderName").ToString
	NewsletterMailSenderEmail = drNewsletter("NewsletterMailSenderEmail").ToString
	NewsletterMailSubject = drNewsletter("NewsletterMailSubject").ToString
	NewsletterCancelLink = drNewsletter("NewsletterCancelLink").ToString
	NewsletterSubscriptionLink = drNewsletter("NewsletterSubscriptionLink").ToString
	NewsletterCancelLinkText = drNewsletter("NewsletterCancelLinkText").ToString
	NewsletterSubscriptionLinkText = drNewsletter("NewsletterSubscriptionLinkText").ToString
	NewsletterDescription = drNewsletter("NewsletterDescription").ToString
	ParagraphTemplateID = drNewsletter("NewsletterTemplateID").ToString
	NewsletterEncodingID = drNewsletter("NewsletterEncodingID").ToString
	NewsletterLevel = drNewsletter("NewsletterLevel").ToString
	NewsletterTextMailBody = drNewsletter("NewsletterTextMailBody").ToString
	
	NewsletterSpecTextMail = Base.ChkBoolean(LTrim(RTrim(drNewsletter("NewsletterSpecTextMail").ToString)))
	NewsletterSaved = "Yes"
Else
	NewsletterName = ""
	NewsletterDescription = ""
	NewsletterStylesheetID = "1"
	NewsletterEndcodingID = "utf-8"
	NewsletterLevel = "1"
	NewsletterSaved = "No"
End If

drNewsletter.Close()
drNewsletter.Dispose()

cmdNewsletterExtended.CommandText = "SELECT * FROM NewsletterExtendedAttachment WHERE NewsletterletterID = " & NewsletterID
drAttachment = cmdNewsletterExtended.ExecuteReader()

varAttachmentList = "<table width=""100%""><tr width='100%'>" & "<td><strong>" & Translate.Translate("Fil") & "</strong></td>" & "<td align='center' valign='middle'><strong>" & Translate.Translate("Størrelse") & "</strong></td></tr>"
Dim dblTotalAttachment As Double = 0
Dim blnDrAttachmentHasRows As Boolean = false
Do While drAttachment.Read()
	If Not blnDrAttachmentHasRows Then
		blnDrAttachmentHasRows = True
	End If
	Try
            Dim fi As New System.IO.FileInfo(Server.MapPath("/Files/" & Dynamicweb.Content.Management.Installation.FilesFolderName & "/" & drAttachment("NewsletterAttachmentPath").ToString))
		dblTotalAttachment += Math.Round((fi.Length / 1024), 2)
		varAttachmentList = varAttachmentList & "<tr  width='100%'><td>"
		varAttachmentList = varAttachmentList & "<img src=""../../images/Icons/Language_Small.gif"" align=""absMiddle"" border=""0"" width=""15"" height=""17"">"
		varAttachmentList = varAttachmentList & "  " & drAttachment("NewsletterAttachmentPath").ToString & "</td>"
		varAttachmentList = varAttachmentList & "<td align='center' valign='middle'>" & Math.Round((fi.Length / 1024), 2) &  " Kb </td>" 
		varAttachmentList = varAttachmentList & "<tr width='100%' ><span width='100%' id=""bodyheight""><td  width='100%' bgColor=""#c4c4c4"" colSpan=""3"">"
		varAttachmentList = varAttachmentList & "</td></span></tr>"
	Catch e As Exception
		varAttachmentList = varAttachmentList & "<tr  width='100%'><td>"
		varAttachmentList = varAttachmentList & "<img src=""../../images/Icons/Language_Small.gif"" align=""absMiddle"" border=""0"" width=""15"" height=""17"">"
		varAttachmentList = varAttachmentList & "  " & drAttachment("NewsletterAttachmentPath").ToString & "</td>"
		varAttachmentList = varAttachmentList & "<td valign='middle'></td>" 
		varAttachmentList = varAttachmentList & "<tr width='100%' ><span width='100%' id=""bodyheight""><td  width='100%' bgColor=""#c4c4c4"" colSpan=""3"">"
		varAttachmentList = varAttachmentList & "</td></span></tr>"
	End Try
Loop 

drAttachment.Close()
drAttachment.Dispose()

If Not blnDrAttachmentHasRows Then
	varAttachmentList = varAttachmentList & "<tr  width='100%'><td>"
	varAttachmentList = varAttachmentList & "&nbsp;" & Translate.Translate("Ingen vedhæftede filer") & "</td>"
	varAttachmentList = varAttachmentList & "</tr>"
Else
	varAttachmentList = varAttachmentList & "<tr><td></td><td align='center'><strong>" & dblTotalAttachment & " Kb</strong></td></tr>"
End If

varAttachmentList = varAttachmentList & "</table>"

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

%>
<SCRIPT LANGUAGE="JavaScript">
<!--
function hide(strDiv)
{
	document.getElementById(strDiv + "open").style.display= 'none'
	document.getElementById(strDiv + "close").style.display= 'block'
	document.getElementById(strDiv + "open").outerHTML = document.getElementById(strDiv + "open").outerHTML
	document.getElementById(strDiv + "close").outerHTML = document.getElementById(strDiv + "close").outerHTML

}

function unhide(strDiv)
{
	document.getElementById(strDiv + "open").style.display= 'block'
	document.getElementById(strDiv + "close").style.display= 'none'
	document.getElementById(strDiv + "open").outerHTML = document.getElementById(strDiv + "open").outerHTML
	document.getElementById(strDiv + "close").outerHTML = document.getElementById(strDiv + "close").outerHTML

}
//-->
</SCRIPT>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>

<title></title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">

<%
If NewsletterLevel < 3 Then
	Response.Redirect("NewsletterExtended_Letter_Body.aspx?ID=" & NewsletterID)
Else
	strSendText = Translate.Translate("(Sendt)")
End If
%>
<%
		Response.Write(Gui.MakeHeaders(Translate.Translate("Preview nyhedsbrev - %%", "%%", NewsletterName ) & strSendText & "<br>", Translate.Translate("Sendt Brev"), "javascript"))		
%>
<body LEFTMARGIN="20" TOPMARGIN="16">
<SCRIPT LANGUAGE="JavaScript">
<!--

arkiver = new Array('Tab1');

function TabClick(srcElement) {
	for (i = 0; i < arkiver.length; i++){
		if (document.all[arkiver[i]][0]){
			if ((document.all[arkiver[i]][0].className.slice(document.all[arkiver[i]][0].className.length-3))=="big") {
				document.all[arkiver[i]][0].className = "tab_big";
			}
			else {
				document.all[arkiver[i]][0].className = "tab";
			}
		}
	}
	if (srcElement){
		if ((srcElement.className.slice(srcElement.className.length-3))=="big") {
			srcElement.className = "seltab_big";
		}
		else {
			srcElement.className = "seltab";
		}
	}
	for (j = 0; j < arkiver.length; j++){
		if (document.all[arkiver[j]][1]){
			document.all[arkiver[j]][1].style.display = "none";
		}
	}
	
	if (srcElement){
		document.all[srcElement.id][1].style.display = "";
	}
	
}
//-->
</SCRIPT>
<%	
	Response.Write(Gui.MakeHeaders(Translate.Translate("Preview nyhedsbrev - %%", "%%", NewsletterName ) & strSendText & "<br>", Translate.Translate("Sendt Brev"), "html"))
%>

<div ID="Tab1" STYLE="display:none;">
	<TABLE border="0" cellpadding="0" width="598" cellspacing="2" class="tabTable">
		<tr>
			<td><br><br>
				<%=Gui.GroupBoxStart(Translate.Translate("Afsender"))%>
				<TABLE cellpadding=2 cellspacing=0>
					<tr>
						<td width="170px"><%=Translate.Translate("Afsender navn")%></td>
						<td><%=NewsletterMailSenderName%></td> 
					</tr>
					<tr>
						<td width="170px"><%=Translate.Translate("Afsender e-mail")%></td>
						<td><%=NewsletterMailSenderEmail%></td> 
					</tr>
					
					<tr>
						<td width='170px'><%=Translate.Translate("Emne")%></td>
						<td><%=NewsletterMailSubject%>
							<input type="hidden" name="NewsletterID" value="<%=NewsletterID%>">
							<input type="hidden" name="Counter" value="<%=StaticCounter%>">
							<input type="hidden" name="NewsletterLevel" value="<%=NewsletterLevel%>">
						</td> 
					</tr>
					
					<tr>
						<td width="170px"></td>
					</tr>
				</TABLE>
				<%=Gui.GroupBoxEnd()%>
				
				<%=Gui.GroupBoxStart(Translate.Translate("Info"))%>
				<table cellpadding=2 cellspacing=0>
					 <tr>
						<td width=170><%=Translate.Translate("Kategorier")%></td>
						
						<%
							sql = " SELECT NewsletterExtendedCategory.*, (select ' checked ' FROM NewsletterExtendedCategoryLetter where NewsLetterCategoryLetterCategoryID = NewsletterExtendedCategory.NewsletterCategoryID AND NewsLetterCategoryLetterLetterID = " & NewsletterID & ") AS Selected, (SELECT COUNT(NewsLetterCategoryRecipientID) FROM NewsletterExtendedCategoryRecipient WHERE NewsletterExtendedCategoryRecipient.NewsLetterCategoryRecipientCategoryID = NewsletterExtendedCategory.NewsletterCategoryID) AS NumberOfLines FROM NewsletterExtendedCategory"
							cmdNewsletterExtended.CommandText = sql
							drNewsletter = cmdNewsletterExtended.ExecuteReader() 

							Dim blnCategoryChecked As Integer = 0
							Dim intNumberOfLines As Integer = 0
							Dim blnDrHasRows As Boolean = False
							Do While drNewsletter.Read()
								If Not blnDrHasRows Then 
									If drNewsletter("Selected").ToString <> "" Then
										blnDrHasRows = True
										Response.Write("<td width='170px'>" & drNewsletter("NewsletterCategoryName").ToString & "</td><td align=right>" & drNewsletter("NumberOfLines").ToString & "</td></tr>")
										intNumberOfLines += Base.ChkNumber(drNewsletter("NumberOfLines").ToString)
									End If
								Else
									If drNewsletter("Selected").ToString <> "" Then
										response.Write("<tr></td><td width='170px'></td><td width='170px'>" & drNewsletter("NewsletterCategoryName") & "</td><td align=right>" & drNewsletter("NumberOfLines").ToString & "</td></tr>")
										intNumberOfLines += Base.ChkNumber(drNewsletter("NumberOfLines").ToString)
									End If
								End If
							Loop 
							
							Response.Write("<tr><td width='170px'></td><td width='170px'><br><b>" & Translate.Translate("Total") & "</b></td><td align=right><br><b>" & intNumberOfLines & "</b></td></tr>")
							
							drNewsletter.Close()
							drNewsletter.Dispose	
							cmdNewsletterExtended.Dispose()
							cnNewsletterExtended.Dispose()
						%>
							
					</tr>
				</table>
				<%=Gui.GroupBoxEnd%>
							
				<%=Gui.GroupBoxStart(Translate.Translate("Vedhæftede filer"))%>
					<%=varAttachmentList%>
				<%=Gui.GroupBoxEnd%>
			
			
				<%=Gui.GroupBoxStart(Translate.Translate("Html"))%>
				<TABLE cellpadding="0" cellspacing="0" class="InfoBox" ID="Table3">
					<tr>
						<td><br>&nbsp;&nbsp;
							<iframe src="<%="NewsletterExtended_Preview.aspx?NewsletterID=" & NewsletterID%>" frameborder="1" width="555" height="300" scrolling=yes ></iframe>
						</td>
						<tr><td><br></td></tr>
					</tr>
				</TABLE>	
				<%=Gui.GroupBoxEnd%>
				
				<%=Gui.GroupBoxStart(Translate.Translate("Tekstudgave"))%>
				<TABLE cellpadding=2 cellspacing=0>
					<tr Name="tr_NewsletterTextMailBody" ID="tr_NewsletterTextMailBody" style="display:"">
						<td colspan="2"><br>&nbsp;
							&nbsp;<textarea readonly style="BACKGROUND-COLOR: #F4F4F4; BORDER-BOTTOM: #666666 solid 1px; BORDER-LEFT: #666666 solid 1px; BORDER-RIGHT: #666666 solid 1px; BORDER-TOP: #666666 solid 1px; COLOR: #333333; FONT-FAMILY: Verdana, Helvetica, Arial, Tahoma, Verdana, Arial; FONT-SIZE: 11px;	z-index:10;" rows="10" cols="89" name="NewsletterTextMailBody" id="NewsletterTextMailBody"><%=NewsletterExtended.GetTextMailPreview(NewsletterID)%></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2"><br></td>
					</tr>
				</TABLE>
				<%=Gui.GroupBoxEnd()%>
			</td>
		</tr>	
		
		<tr>
			<td align="right" valign="bottom">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<%If Not NewsletterLevel >= 3 Then%>
						<td align="right"><%=Gui.Button(Translate.Translate("Egenskaber"), "location='NewsletterExtended_Letter_Edit.aspx?ID=" & NewsletterID & "'", 0)%></td>
						<td width="5"></td>
						<td align="right"><%=Gui.Button(Translate.Translate("Tilbage"), "GoToBody();", 0)%></td>
						<td width="5"></td>
						<td align="right"><%=Gui.Button(Translate.Translate("Næste"), "GoToSend();", 0)%></td>
						<%=Gui.HelpButton("NewsletterExtended","modules.newsletterextended.general.letter.edit.preview.test.send",,5)%>
						<%End If%>
						<td width="5"></td>
					</tr>
					<tr>
						<td colspan="4" height="5"></td>
					</tr>			
				</table>
			</td>
		</tr>
	</table>
</div>

						<!--NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN-->
						</TD>
					</TR>
				</TABLE>
			</DIV>
		</TD>
	</TR>
</TABLE>

<SCRIPT LANGUAGE="JavaScript">
<!--
<% 
If varTab <> "" Then
	response.write("TabClick(document.getElementById('" & varTab & "'));")
End If 
%>
parent.document.getElementById("StatusFrame").setAttribute("src", "NewsletterExtended_Blank_with_color.html");
parent.updateinfo('');

//-->
</SCRIPT>
</body>
</html>


<%
	Translate.GetEditOnlineScript()
%>
