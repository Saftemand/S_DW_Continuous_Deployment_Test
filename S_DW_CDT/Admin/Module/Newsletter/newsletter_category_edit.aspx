<%@ Page CodeBehind="newsletter_category_edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.newsletter_category_edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%

Dim i As Integer
Dim arrNewsletterRecipientCategoryIDs() As String
Dim sql As String

Response.Expires = -100

Dim strNewsletterCategoryID As String = request.QueryString.Item("NewsletterCategoryID")
Dim strNewsletterCategoryName As String	
Dim strNewsletterCategoryDescription As String

Dim cnNewsletter		As IDbConnection	= Database.CreateConnection("Newsletter.mdb")
Dim cmdNewsletter		As IDbCommand		= cnNewsletter.CreateCommand


If strNewsletterCategoryID <> "" And Not strNewsletterCategoryID = "0" Then
	cmdNewsletter.CommandText = "SELECT * FROM [NewsletterCategory] WHERE [NewsletterCategoryID]=" & strNewsletterCategoryID
	Dim dr As IDataReader = cmdNewsletter.ExecuteReader()

	If dr.Read() Then
		strNewsletterCategoryName = dr("NewsletterCategoryName").ToString
		strNewsletterCategoryDescription = dr("NewsletterCategoryDescription").ToString
	End If	
	dr.Close()
	dr.Dispose()
End If

%>
<!doctype html public "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>"Newsletter Category List"</title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<script language="JavaScript">
function Send(){
	if (document.getElementById('NewsletterCategory').NewsletterCategoryName.value.length < 1){
		alert("<%=Translate.JsTranslate("Der skal angives en vÃ¦rdi i: %%", "%%", Translate.JsTranslate("Navn"))%>");
	}
	else if (document.getElementById('NewsletterCategory').NewsletterCategoryName.value.length > 75){
		alert("<%=Translate.JSTranslate("Max %% tegn i: ","%%","75")%><%=Translate.JSTranslate("Kategori")%>");
	}
	else if (document.getElementById('NewsletterCategory').NewsletterCategoryDescription.value.length > 2000){
		alert("<%=Translate.JSTranslate("Max %% tegn i: ","%%","2000")%><%=Translate.JSTranslate("Beskrivelse")%>");
	}
	else{
		document.getElementById('NewsletterCategory').action = 'newsletter_category_save.aspx';
		document.getElementById('NewsletterCategory').submit();
	}
}
function DeleteRecip(RecipID,RecipName,CategoryID){
	if(confirm('<%=Translate.JsTranslate("Slet %%?", "%%", Translate.JSTranslate("modtager"))%>\n(' + RecipName + ')')){
		location = 'newsletter_recipient_del.aspx?NewsletterRecipientID='+RecipID+'&NewsletterCategoryID='+CategoryID;
	}
}

</script>
<%=Gui.MakeHeaders(Translate.Translate("Rediger %%","%%",Translate.Translate("nyhedsbrevsliste")), Translate.Translate("Liste"), "all")%>
<table border="0" cellpadding="0" cellspacing="0" width="600" class="tabTable">
	<form name="NewsletterCategory" id="NewsletterCategory" method="post" action="newsletter_category_save.aspx">
	<tr>
		<td valign="top"><br>
			<div id="Tab1">
			
			<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
			<table cellspacing="0" border="0" cellpadding="0" width="100%">
				<tr>
					<td width=170>&nbsp;<%=Translate.Translate("Navn")%></td>
					<td><input id="NewsletterCategoryName" name="NewsletterCategoryName" maxlength="75" class="std" type="Text" value="<%=Server.HtmlEncode(strNewsletterCategoryName)%>"></td>
				</tr>
				<tr>
					<td valign="top">&nbsp;<%=Translate.Translate("Beskrivelse")%></td>
					<td><textarea class="std" id="NewsletterCategoryDescription" name="NewsletterCategoryDescription" rows="3" cols="50"><%=strNewsletterCategoryDescription%></textarea></td>
					<input type="Hidden" name="NewsletterCategoryID" value="<%=strNewsletterCategoryID%>">
				</tr></form>
				<tr>
					<td colspan="2" height="5"></td>
				</tr>
			</table>
			<%=Gui.GroupBoxEnd%>
			
			<%If Len(request.QueryString.Item("NewsletterCategoryID")) > 0 Then%>
			<%=Gui.GroupBoxStart(Translate.Translate("Tilmeldte"))%>
			<table width="99%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="17">
					<a href="newsletter_category_edit.aspx?NewsletterCategoryID=<%=strNewsletterCategoryID %>&OrderBy=Name"><strong>&nbsp;<%=Translate.Translate("Navn")%></strong></a></td>
					<td><a href="newsletter_category_edit.aspx?NewsletterCategoryID=<%=strNewsletterCategoryID %>&OrderBy=Email"><strong><%=Translate.Translate("Email")%></strong></a></td>
					<td><a href="newsletter_category_edit.aspx?NewsletterCategoryID=<%=strNewsletterCategoryID %>&OrderBy=Date"><strong><%=Translate.Translate("Tilmeldt")%></strong></a></td>
					<td><strong><%=Translate.Translate("Slet")%></strong></td>
				
				</tr>
				<%	
	                If Len(request.QueryString.Item("NewsletterCategoryID")) > 0 Then
                		
		                cmdNewsletter.CommandText = "SELECT * FROM NewsletterRecipient" ' WHERE NewsletterRecipientCategoryID = " &request.querystring("NewsletterCategoryID") & " ORDER BY NewsletterRecipientName"
				        Dim orderBy As String = Base.ChkString(Base.Request("OrderBy"))
				        If orderBy = "Name" Then
				            cmdNewsletter.CommandText &= " ORDER BY NewsletterRecipientName, NewsletterRecipientID"
				        ElseIf orderBy = "Email" Then
				            cmdNewsletter.CommandText &= " ORDER BY NewsletterRecipientEmail, NewsletterRecipientID"
				        ElseIf orderBy = "Date" Then
				            cmdNewsletter.CommandText &= " ORDER BY NewsletterRecipientCreated, NewsletterRecipientID"
				        End If
				        Dim drNewsletter As IDataReader = cmdNewsletter.ExecuteReader()
                			
		                Dim blnDrNewsletterHasRows As Boolean = False
		                Do While drNewsletter.Read()
			                If Not blnDrNewsletterHasRows Then blnDrNewsletterHasRows = True
                			
			                If drNewsletter("NewsletterRecipientCategoryID").ToString <> "" Then
				                arrNewsletterRecipientCategoryIDs = Split(drNewsletter("NewsletterRecipientCategoryID").ToString(), ",")
			                Else
				                Redim arrNewsletterRecipientCategoryIDs(1) 
				                arrNewsletterRecipientCategoryIDs(0) = "0"
			                End If
                			
			                For i = 0 To UBound(arrNewsletterRecipientCategoryIDs)
				                If Trim(arrNewsletterRecipientCategoryIDs(i)) = CStr(request.QueryString.Item("NewsletterCategoryID")) Then
					                %>
						                <tr>
			    			                <td colspan="4" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
						                </tr>
						                <tr valign="middle">
							                <td height="17">&nbsp;<a href="#" onclick="window.open('newsletter_recipient_edit.aspx?NewsletterRecipientID=<%=drNewsletter("NewsletterRecipientID").ToString%>','NewsletterRecipientEdit','resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=510,height=290,screenX=0,screenY=0')"><%=Server.HtmlEncode(drNewsletter("NewsletterRecipientName").ToString).Replace("&amp;", "&")%></a></td>
							                <td valign="middle"><%=Server.HtmlEncode(drNewsletter("NewsletterRecipientEmail").ToString).Replace("&amp;", "&")%><%						If Not Base.ValidateEmail(drNewsletter("NewsletterRecipientEmail").ToString) Then Response.Write(" <img alt=""" & Translate.JsTranslate("Ugyldig værdi i: %%", "%%", Translate.JsTranslate("Email adresse")) & """ align=""absmiddle"" src=""../../Images/Icons/stop.gif"" >")%></td>
							                <td><%=drNewsletter("NewsletterRecipientCreated").ToString%></td>
							                <td><a href="javascript:DeleteRecip('<%=drNewsletter("NewsletterRecipientID").ToString%>','<%=Base.JSEnable(drNewsletter("NewsletterRecipientName").ToString)%>','<%=strNewsletterCategoryID%>');"><img src="../../images/delete.gif" border="0" alt="<%=Translate.Translate("Slet %%", "%%", Translate.Translate("modtager"))%>"></a></td>
                						
						                </tr>
					                <%						
					                Exit For
				                End If
			                Next 
		                Loop 
                		
		                drNewsletter.Close()
		                drNewsletter.Dispose()
		                cmdNewsletter.Dispose()
		                cnNewsletter.Dispose()
                		
		                If Not blnDrNewsletterHasRows Then
			                Response.Write("<tr><td colspan=""4"">" & Translate.Translate("Ingen brugere tilmeldt") & ".</td></tr>")
		                End If
	                End If
	%>
				<tr>
				    	<td colspan="4" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
				</tr>
				<tr>
					<td colspan="4" height="5"></td>
				</tr>
				
				<tr align="right">
					<td colspan="4"><%=Gui.Button(Translate.Translate("Ny modtager"), "window.open('newsletter_recipient_edit.aspx?NewsletterCategoryID=" & request.QueryString.Item("NewsletterCategoryID") & "','NewsletterRecipientEdit','resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=520,height=290,screenX=0,screenY=0');", 90)%></td>
				</tr>
				<tr>
					<td colspan="4" height="3"></td>
				</tr>
								
			</table>
			<%=Gui.GroupBoxEnd%>
			<%End If%>
			</div>
		</td>
	</tr>
	<tr valign="bottom">
		<td colspan="4" align="right">
		
		<table cellpadding="0" cellspacing="0">
			<tr>
				<td align="right"><%=Gui.Button(Translate.Translate("OK"), "javascript:Send();", 0)%></td>
				<td width="5"></td>
				<td align="right"><%=Gui.Button(Translate.Translate("Luk"), "javascript:history.back(1)", 0)%></td>
				<td width="10"></td>
			</tr>
			<tr>
				<td colspan="4" height="5"></td>
			</tr>			
		</table>
		</td>
	</tr>
</table>
</body>
<%
Translate.GetEditOnlineScript()
%>