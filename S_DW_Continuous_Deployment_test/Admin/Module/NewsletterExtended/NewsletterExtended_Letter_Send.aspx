	<%@ Page CodeBehind="NewsletterExtended_Letter_Send.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Letter_Send" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>


<%
Dim NewsletterName As String
Dim sql As String
Dim NewsletterID As String
Dim SendType As String
Dim Accept As String
Dim NumberOfLines As String
NewsletterID = request.Item("ID")
Accept = request.Item("Accept")
SendType = request.Item("SendType")

'Dim cnNewsletterExtended		As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
'Dim cmdNewsletterExtended		As IDbCommand	 = cnNewsletterExtended.CreateCommand

Dim cn		As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
Dim cmd		As IDbCommand	 = cn.CreateCommand

If Accept = "Yes" Then
	sql =	" SELECT COUNT(NewsletterCategoryRecipientRecipientID) as NumberOfLines " & _
			" FROM (select distinct NewsletterCategoryRecipientRecipientID " & _
			" FROM NewsletterExtendedCategoryRecipient " & _
			" WHERE NewsletterCategoryRecipientCategoryID IN (SELECT NewsletterCategoryLetterCategoryID " & _
			" FROM NewsletterExtendedCategoryLetter " & _
			" WHERE NewsletterCategoryLetterLetterID = " & NewsletterID & ")) A"
			
	cmd.CommandText = sql
	NumberOfLines = cmd.ExecuteScalar().ToString()
	
	'drCount.Dispose()
	cmd.Dispose()
	cn.Dispose()
        Response.Write("<SCRIPT LANGUAGE=""JavaScript"">" & vbNewLine & "<!--" & vbNewLine & "parent.document.getElementById(""ListRight"").setAttribute(""src"", ""NewsletterExtended_letter_sendExec.aspx?NewsletterID=" & NewsletterID & "&SendType=" & SendType & "&NumberOfLines=" & NumberOfLines & "&Ticks=" & Base.Request("Ticks") & """);" & vbNewLine & "//-->" & vbNewLine & "</SCRIPT>")
	'Response.Write(Translate.Translate("Initier afsendelse af nyhedsbrevet til ") & NumberOfLines & Translate.Translate(" modtagere"))
Else
	sql = " SELECT * " & " FROM NewsletterExtended where NewsletterID = " & NewsletterID
	cmd.CommandText = sql
	Dim drNewsletterExtended As IDataReader = cmd.ExecuteReader()
	If drNewsletterExtended.Read() Then
		NewsletterName = drNewsletterExtended("NewsletterName").ToString()
	End If
	
	drNewsletterExtended.Dispose()
	cmd.Dispose()
	cn.Dispose()
	%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title><%=Translate.JsTranslate("Rediger %%","%%",Translate.Translate("modtager"))%></title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	
<script language="JavaScript" type="text/javascript">

function Send()
{
	if(confirm("<%=Translate.JsTranslate("Skal nyhedsbrevet sendes?")%>"))
	{		
		document.getElementById('NewsletterSend').Accept.value = 'Yes';
		document.getElementById('NewsletterSend').submit();
	}
}

</script>

<%=Gui.MakeHeaders(Translate.Translate("Afsend"), Translate.Translate("Afsend"), "javascript")%>
<body LEFTMARGIN="20" TOPMARGIN="16">
<%=Gui.MakeHeaders(Translate.Translate("Afsend"), Translate.Translate("Afsend"), "html")%>

<div ID="Tab1" STYLE="display:;">
<TABLE border="0" cellpadding="0" width="598" cellspacing="2" class="tabTable">
	<tr>
		<td valign="top"><br><br>
			<form name="NewsletterSend" id="NewsletterSend" method="post">
			<%=Gui.GroupBoxStart(Translate.Translate("Send"))%>
				<table cellpadding=2 cellspacing=0>
					<tr>
						<td width=170><%=Translate.Translate("Navn")%>
							<input type="Hidden" value="<%=NewsletterID%>" name="ID">
							<input type="Hidden" value="" name="Accept">
						</td>
						<td><input type="textbox" readonly name="name" value="<%=NewsletterName%>"></td>	
					</tr>
					<tr>
						<td width=170><%=Translate.Translate("Send")%></td>
						<td><input type="radio" name="SendType" value="1" checked> &nbsp;<%=Translate.Translate("Online")%> &nbsp;&nbsp;&nbsp;<input type="radio" name="SendType" value="2"> &nbsp;<%=Translate.Translate("via Dropbox")%> </td>
					</tr>
				</table>
			<%=Gui.GroupBoxEnd%>
		</td>
	</tr>
	<tr>
		<td align="right" valign="bottom">
		<table cellpadding="0" cellspacing="0">
			<tr>
				<td colspan="6"><br></td>
			</tr>
			<tr>
				<td align="right"><%=Gui.Button(Translate.Translate("Send"), "javascript:Send();", 0)%></td>
				<td width="5"></td>
				<td align="right"><%=Gui.Button(Translate.Translate("Annuller"), "window.close();", 0)%></td>
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
				</form>

</body>
<%	
	
End If

Translate.GetEditOnlineScript()

%>
