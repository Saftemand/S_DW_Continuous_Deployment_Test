<%@ Page CodeBehind="newsletter_front.aspx.vb" Language="vb" ValidateRequest="false" AutoEventWireup="false" Inherits="Dynamicweb.Admin.newsletter_front" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title></title>
		<%
Dim NewsletterMailAttach As String
Dim NewsletterMailBody As String
Dim Sql As String
Dim recordcount As Integer
Dim arrNewsletterRecipientIDs() As String
Dim NewsletterCategoryDescription As String
Dim i As Integer

If Not isnothing(Session("NewsletterSubscriptionMailContent")) Then
	NewsletterMailBody = Base.ChkString(Session("NewsletterSubscriptionMailContent"))
	Session.Remove("NewsletterSubscriptionMailContent")
End If


Dim cnNewsletter	As IDbConnection = Database.CreateConnection("Newsletter.mdb")
Dim cmdSelect		As IDbCommand	 = cnNewsletter.CreateCommand
Dim drNewsletter	As IDataReader	 

cmdSelect.CommandText = "SELECT * FROM NewsletterCategory ORDER BY NewsletterCategoryName"
Response.Expires = -100
%>
		<script language="JavaScript">
function DeleteNewsletterCategory(NewsletterCategoryID,NewsletterCategoryName){
	if (confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("liste"))%>\n(' + NewsletterCategoryName + ')\n\n<%=Translate.JSTranslate("ADVARSEL!")%>\n<%=Translate.JSTranslate("Alle modtagere vil blive slettet!")%>')){
			location = "newsletter_Category_delete.aspx?NewsletterCategoryID=" + NewsletterCategoryID;
	}
}

function show(i) {
	if (document.all) {
		if (document.all[i].style.display=='none') {
			document.all[i].style.display='';
		if(typeof(hideEditor) == "function")
			hideEditor();
		} 
		
		else {
		document.all[i].style.display='none';
		if(typeof(unHideEditor) == "function")
			unHideEditor();
		
		}
	}
}

function chkNewsletterCategory(){
	if(document.getElementById('NewsletterMail').NewsletterMailCategory) {
		if(document.getElementById('NewsletterMail').NewsletterMailCategory.length){
			for(i=0;i<document.getElementById('NewsletterMail').NewsletterMailCategory.length;i++){
				if(document.getElementById('NewsletterMail').NewsletterMailCategory[i].checked){
					return true;
				}
			}
		}else{
			if(document.getElementById('NewsletterMail').NewsletterMailCategory.checked){
				return true
			}
		}
	}
}

function validateEmail(strEmail)
{
	 var re = new RegExp(/^[\w-\.]{1,}\@([\w-]{1,}\.){1,}[\w]{2,3}$/);
	 var s = re.test(strEmail);
	 return(s);
}

function Send(){
		if (document.getElementById('NewsletterMail').NewsletterMailSubject.value.length < 1){
			alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Emne"))%>');
			document.getElementById('NewsletterMail').NewsletterMailSubject.focus();
		}
		else if (document.getElementById('NewsletterMail').NewsletterMailSenderName.value.length < 1){
			alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>');
			document.getElementById('NewsletterMail').NewsletterMailSenderName.focus();
		}
		else if (!validateEmail(document.getElementById('NewsletterMail').NewsletterMailSenderEmail.value)){
			alert('<%=Translate.JsTranslate("Ugyldig værdi i: %%", "%%", Translate.JsTranslate("Email adresse"))%>');
			document.getElementById('NewsletterMail').NewsletterMailSenderEmail.focus()
		}
		else if (!chkNewsletterCategory()){
			alert('<%=Translate.JsTranslate("Der skal vælges mindst en liste nyhedsbrevet skal udsendes til")%>');
		}
		else{
			document.getElementById('NewsletterMail').action = 'newsletter_send.aspx';
			window.open('newsletter_blank.aspx','newsletter_sender','resizable=no,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=250,height=150');
			document.getElementById('NewsletterMail').submit();
		}
	}
		</script>
		<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
			<%=Gui.MakeHeaders(Translate.Translate("Nyhedsbreve",9), Translate.Translate("Nyhedsbrev") & ", " & Translate.Translate("Lister") & ", " & Translate.Translate("Arkiv"), "javascript")%>
	</HEAD>
	<body onLoad="document.all.BodyContent.style.display=''; InitFckEditor();">
		<div ID="BodyContent" style="DISPLAY:none">
			<%=Gui.MakeHeaders(Translate.Translate("Nyhedsbreve",9), Translate.Translate("Nyhedsbrev") & ", " & Translate.Translate("Lister") & ", " & Translate.Translate("Arkiv"), "html")%>
			<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
				<tr>
					<td valign="top">
						<div ID="Tab1">
							<br>
							<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
							<table border="0" cellpadding="0">
								<form name="NewsletterMail" method="post" action="newsletter_send.aspx" target="newsletter_sender">
									<tr>
										<td width="170"><%=Translate.Translate("Emne")%></td>
										<td><input type="text" class="std" maxlength="255" name="NewsletterMailSubject"> <a href="javascript:show('Send_options');">
												&nbsp;<img src="../../images/Icons/Settings.gif" border="0" align="absMiddle" alt="<%=Translate.Translate("Egenskaber")%>"></a></td>
									</tr>
									<tr>
										<td width="170"><%=Translate.Translate("Afsender navn")%></td>
										<td><input type="text" maxlength="255" class="std" name="NewsletterMailSenderName"></td>
									</tr>
									<tr>
										<td width="170"><%=Translate.Translate("Afsender e-mail")%></td>
										<td><input type="text" maxlength="255" class="std" name="NewsletterMailSenderEmail"></td>
									</tr>
									<tr>
										<td width="170"><%=Translate.Translate("Encoding")%></td>
										<td colspan="6"><%=Gui.EncodingList("utf-8", "NewsletterEncodingUsed", True)%></td>
									</tr>
							</table>
							<%=Gui.GroupBoxEnd%>
							<%=Gui.GroupBoxStart(Translate.Translate("Tekst"))%>
							<table border="0" cellpadding="0" width="100%">
								<tr>
									<td colspan="2">&nbsp;<%= Gui.Editor("NewsletterMailBody", 0, 0, NewsletterMailBody, "", Nothing, "", "DwCustomConfig", Gui.EditorEdition.SystemDefault, True, False, True)%></td>
								</tr>
							</table>
							<%=Gui.GroupBoxEnd%>
							<%=Gui.GroupBoxStart(Translate.Translate("Send til lister"))%>
							<table border="0" cellpadding="0">
								<%
	                            Dim blnHasRows = False
	                            drNewsletter = cmdSelect.ExecuteReader()
	                            Do While drNewsletter.Read()
		                            If Not blnHasRows Then blnHasRows = True
		                            If Base.HasAccess("NewsletterCategories", drNewsletter("NewsletterCategoryID").ToString) Then
			                            Response.Write("<tr>")
			                            Response.Write("<td>&nbsp;" & Server.HtmlEncode(drNewsletter("NewsletterCategoryName").ToString) & "</td>")
			                            Response.Write("<td><input name=""NewsletterMailCategory"" type=""CheckBox"" class=""clean"" value=""" & drNewsletter("NewsletterCategoryID").ToString & """></td>")
			                            Response.Write("</tr>")
		                            End If
	                            Loop 
                            if Not blnHasRows Then
	                            Response.Write("<tr>")
	                            Response.Write("<td colspan=""2""><br />" & Translate.Translate("Der er ikke oprettet nogen %c%", "%c%", Translate.Translate("lister")) & "</td>")
	                            Response.Write("</tr>")
                            End If

                            drNewsletter.Close
                            %>
								<tr>
									<td colspan="2"><br>
									</td>
								</tr>
							</table>
							<%=Gui.GroupBoxEnd%>
							<table border="0" cellpadding="0" width="100%">
								<tr>
									<td align="right">
										<table border="0" cellpadding="0">
											<tr>
												<td align="right"><%=Gui.Button(Translate.Translate("OK"), "if(html()){Send();}", 0)%></td>
												<td width="5"></td>
												<td align="right"><%= Gui.Button(Translate.Translate("Luk"), "location='../../Content/Moduletree/EntryContent.aspx'", 0)%></td>
												<%=Gui.HelpButton("newsletter_send", "modules.newsletter.general.send",,5)%>
												<td width="10"></td>
											</tr>
											<tr>
												<td colspan="4" height="5"></td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</div>
						<div ID="Tab2" STYLE="DISPLAY:none">
							<BR>
							<table border="0" cellpadding="0" cellspacing="2" width="598">
								<tr>
									<td width="450" height="17">&nbsp;<strong><%=Translate.Translate("Navn")%></strong></td>
									<td width="55"><strong><%=Translate.Translate("Tilmeldte")%></strong></td>
									<td width="35"><strong><%=Translate.Translate("Slet")%></strong></td>
								</tr>
								<tr>
									<td colspan="3" bgcolor="#c4c4c4"><img src="../../images/nothing.gif" width="1" height="1" alt="" border="0"></td>
								</tr>
								<%

drNewsletter			= cmdSelect.ExecuteReader()

Dim blnDrNewsLetterHasRows As Boolean = False

Do While drNewsletter.Read()
		If Not blnDrNewsLetterHasRows Then blnDrNewsLetterHasRows = True
		If Base.HasAccess("NewsletterCategories", drNewsletter("NewsletterCategoryID").ToString) Then
			If Len(drNewsletter("NewsletterCategoryDescription").ToString()) > 1 Then
				NewsletterCategoryDescription = Replace(drNewsletter("NewsletterCategoryDescription").ToString, vbCrLf, "@@@@")
			Else
				NewsletterCategoryDescription = ""
			End If
			Response.Write("<tr>")
			Response.Write("<td height=""17"">&nbsp;<a href=""newsletter_category_edit.aspx?NewsletterCategoryID=" & drNewsletter("NewsletterCategoryID")  & """>" & Server.HtmlEncode(drNewsletter("NewsletterCategoryName")) & "</a></td>")
			
			Dim cnRecipient			As IDbConnection	= Database.CreateConnection("Newsletter.mdb")
			Dim cmdRecipient		As IDbCommand		= cnRecipient.CreateCommand
			cmdRecipient.CommandText = "SELECT * FROM NewsletterRecipient"
			Dim drRecipient			As IDataReader		= cmdRecipient.ExecuteReader()			
			
			Response.Write("<td align=""center"">")
						
			recordcount = 0
			Do While drRecipient.Read()
				If drRecipient("NewsletterRecipientCategoryID").ToString <> "" Then
					arrNewsletterRecipientIDs = Split(drRecipient("NewsletterRecipientCategoryID").ToString, ",")
					For i = 0 To UBound(arrNewsletterRecipientIDs)
						If Trim(arrNewsletterRecipientIDs(i)) = drNewsletter("NewsletterCategoryID").ToString Then
							recordcount = recordcount + 1
							Exit for
						End If
					Next 
				End If
			Loop 
						
			Response.Write(recordCount & "</td>")
			'**
			drRecipient.Dispose()
			cmdRecipient.Dispose()
			cnRecipient.Dispose()
			
			Response.Write("<td align=""center""><img src=""../../images/delete.gif"" border=""0"" onclick=""DeleteNewsletterCategory('" & drNewsletter("NewsletterCategoryID") & "','" & Base.JSEnable(Server.HtmlEncode(drNewsletter("NewsletterCategoryName"))) & "');"" style=""cursor:hand;""></td>")
			Response.Write("</tr>")
			Response.Write("<tr>")
			Response.Write("<td colspan=""3"" bgcolor=""#C4C4C4""><img src=""../../images/nothing.gif"" width=""1"" height=""1"" alt="""" border=""0""></td>")
			Response.Write("</tr>")
		End If
Loop 
If Not blnDrNewsLetterHasRows Then
	Response.Write("<tr>")
	Response.Write("<td colspan=""3"">" & Translate.Translate("Der er ikke oprettet nogen %c%", "%c%", Translate.Translate("lister")) & "</td>")
	Response.Write("</tr>")
End If

drNewsletter.Close()
%>
								<tr>
									<td colspan="3">&nbsp;</td>
								</tr>
							</table>
							<table border="0" cellpadding="0" width="100%">
								<tr>
									<td align="right">
										<table border="0" cellpadding="0" cellspacing="0">
											<tr>
												<td align="right"><%=Gui.Button(Translate.Translate("Ny liste"), "window.open('newsletter_category_edit.aspx','_self');", 0)%></td>
												<td width="5"></td>
												<td align="right"><%= Gui.Button(Translate.Translate("Luk"), "location='../../Content/Moduletree/EntryContent.aspx'", 0)%></td>
												<%=Gui.HelpButton("newsletter", "modules.newsletter.general.lists",,5)%>
												<td width="10"></td>
											</tr>
											<tr>
												<td colspan="4" height="5"></td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</div>
						<div ID="Tab3" STYLE="DISPLAY:none">
							<br>
							<table border="0" cellpadding="0" width="100%">
								<tr>
									<td width="365" height="17">&nbsp;<strong><%=Translate.Translate("Emne")%></strong></td>
									<td width="25" align="center"><strong>#</strong></td>
									<td width="85"><strong><%=Translate.Translate("Sendt")%></strong></td>
									<td width="35"><strong><%=Translate.Translate("Slet")%></strong></td>
								</tr>
								<tr>
									<td colspan="4" bgcolor="#c4c4c4"><img src="../../images/nothing.gif" width="1" height="1" alt="" border="0"></td>
								</tr>
								<%
cmdSelect.CommandText = "SELECT * FROM NewsletterArchive ORDER BY NewsletterArchiveSend DESC"
drNewsletter			= cmdSelect.ExecuteReader()

Do While drNewsletter.Read()
		Response.Write("<tr>" & vbCrLf)
		Response.Write(vbTab & "<td height=""17"">&nbsp;<a href=""newsletter_archive_view.aspx?ID=" & drNewsletter("NewsletterArchiveID").ToString & """>" & Server.HtmlEncode(drNewsletter("NewsletterArchiveHeader").ToString) & "</a></td>" & vbCrLf)
		Response.Write(vbTab & "<td align=""right"">" & drNewsletter("NewsletterArchiveCount").ToString & "&nbsp;&nbsp;</td>" & vbCrLf)
		Response.Write(vbTab & "<td align=""left"">" & Dates.ShowDate(CDate(drNewsletter("NewsletterArchiveSend")), Dates.Dateformat.Short, True) & "&nbsp;</td>" & vbCrLf)
		Response.Write(vbTab & "<td align=""center""><a href=""Newsletter_Archive_Delete.aspx?ID=" & drNewsletter("NewsletterArchiveID").ToString & """><img src=""../../images/delete.gif"" border=""0""></a></td>" & vbCrLf)
		Response.Write("</tr>" & vbCrLf)
		Response.Write("<tr>")
		Response.Write("<td colspan=""4"" bgcolor=""#C4C4C4""><img src=""../../images/nothing.gif"" width=""1"" height=""1"" alt="""" border=""0""></td>")
		Response.Write("</tr>")
Loop 

drNewsletter.Close()
%>
							</table>
							<table border="0" cellpadding="0" width="100%">
								<tr>
									<td align="right">
										<table border="0" cellpadding="0">
											<tr>
												<td height="5"></td>
											</tr>
											<tr>
												<td align="right"><%= Gui.Button(Translate.Translate("Luk"), "location='../../Content/Moduletree/EntryContent.aspx'", 0)%></td>
												<%=Gui.HelpButton("newsletter_archive", "modules.newsletter.general.archive",,5)%>
												<td width="10"></td>
											</tr>
											<tr>
												<td height="5"></td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</div>
						<%'Popup window start%>
						<style> .Settings { BORDER-RIGHT: #333333 1px solid; BORDER-TOP: #333333 1px solid; LEFT: 170px; BORDER-LEFT: #333333 1px solid; WIDTH: 450px; BORDER-BOTTOM: #333333 1px solid; POSITION: absolute; TOP: 165px; HEIGHT: 150px; BACKGROUND-COLOR: #ffffff } </style>
						<div id="Send_options" style="DISPLAY:none" class="Settings">
							<table cellpadding="0" cellspacing="0" width="100%" height="100%">
								<tr bgColor="#ece9d8" height="23">
									<td><strong>&nbsp;<%=Translate.Translate("Egenskaber")%></strong></td>
									<td align="right"></td>
								</tr>
								<tr bgColor="#aca899" height="1">
									<td colspan="2"></td>
								</tr>
								<tr>
									<td colspan="2"><br>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
										<table cellpadding="0">
											<tr>
												<td width="170"><%=Translate.Translate("Vedhæft fil")%></td>
												<td><%=Gui.FileManager("", Dynamicweb.Content.Management.Installation.FilesFolderName, "NewsletterMailAttach")%></td>
											</tr>
											<tr>
												<td valign="top"><%=Translate.Translate("Udsend mail som")%></td>
												<td>
													<input type="radio" name="NewsletterMailFormat" value="html" checked><%=Translate.Translate("HTML")%><br>
													<input type="radio" name="NewsletterMailFormat" value="txt"><%=Translate.Translate("Tekst")%>
												</td>
											</tr>
											<tr style="DISPLAY:none">
												<td>&nbsp;<%=Translate.Translate("Modtagers valg")%></td>
												<td><input type="radio" name="NewsletterMailFormat" value="user"></td>
											</tr>
											<tr>
												<td width="170"><%=Translate.Translate("Stylesheet")%></td>
												<td><%=Gui.StylesheetList("Default", "NewsletterStylesheet")%></td>
											</tr>
										</table>
										<%=Gui.GroupBoxEnd%>
										<%If 1 = 2 Then%>
										<%	
	 
	cmdSelect.CommandText	= "SELECT * FROM NewsletterCategory ORDER BY NewsletterCategoryName"
	drNewsletter			= cmdSelect.ExecuteReader()
	If drNewsletter.Read() Then
		%>
										<%=Gui.GroupBoxStart(Translate.Translate("Publicer i følgende nyhedskategorier"))%>
										<table cellpadding="0">
											<%		
		drNewsletter.Close()
		drNewsletter			= cmdSelect.ExecuteReader()
		Do While drNewsletter.Read()
			Response.Write("<tr>")
			Response.Write("<td width=""170""></td>")
			Response.Write("<td><input name=""NewsletterNewsCategory"" type=""CheckBox"" class=""clean"" value=""" & drNewsletter("NewsletterCategoryID").ToString & """>" & drNewsletter("NewsletterCategoryName").ToString & "</td>")
			Response.Write("</tr>")
		Loop 
		
		drNewsletter.Close()
		%>
											<tr>
												<td colspan="2"><br>
												</td>
											</tr>
										</table>
										<%=Gui.GroupBoxEnd%>
										<%	End If%>
										<%End If%>
									</td>
								</tr>
								<tr>
									<td colspan="2" align="right">
										<table cellpadding="0" cellspacing="0">
											<tr>
												<td><%=Gui.Button(Translate.Translate("Gem"), "show('Send_options');", 100)%></td>
												<td width="10"></td>
											</tr>
											<tr>
												<td height="5"></td>
											</tr>
										</table>
									</td>
								</tr>
								</FORM>
							</table>
						</div>
						<%'Popup window end%>
						<%=Gui.SelectTab()%>

							<%
'Cleanup
drNewsletter.Close()
drNewsletter.Dispose()
cmdSelect.Dispose()
cnNewsletter.Dispose()

	Translate.GetEditOnlineScript()
%></td></TR></table>
		</div>
	</body>
</HTML>
