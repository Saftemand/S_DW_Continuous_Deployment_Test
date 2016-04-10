<%@ Page CodeBehind="NewsletterExtended_Recipient_UserFields.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Recipient_UserFields" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<%
Dim FormID As String
Dim i As Integer
Dim sql As String
Dim j As Integer

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
	if(document.getElementById('FormForm').FormName.value.length <= 0){
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>');
		document.getElementById('FormForm').FormName.focus();
		FormOK = false;
	}
	if(FormOK){
		return true;
	}else{
		return false;
	}
}
</script>
<%=Gui.MakeHeaders(Translate.Translate("Bruger felter"), Translate.Translate("Bruger felter"), "all")%>
<%
Dim newsletterConn As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
Dim cmdNewsletter As IDbCommand = newsletterConn.CreateCommand

sql = "SELECT * FROM NewsletterExtendedUserField ORDER BY NewsletterUserFieldSort ASC"

Dim adNewsletterAdapter As IDbDataAdapter = Database.CreateAdapter()
Dim cb As Object = Database.CreateCommandBuilder(adNewsletterAdapter)
Dim dsNewsletter As DataSet = New DataSet

cmdNewsletter.CommandText = SQL
adNewsletterAdapter.SelectCommand = cmdNewsletter
adNewsletterAdapter.Fill(dsNewsletter)

Dim recipientView As DataView = New DataView(dsNewsletter.Tables(0))

%>
<body LEFTMARGIN="20" TOPMARGIN="16">
<table border="0" cellpadding="0" cellspacing="0" class="TabTable">
	<form action="Form_Module_Save.aspx" method="post" name="FormForm" id="FormForm">
	<input type="Hidden" name="FormID" value="<%=FormID%>">
	<tr>
		<td valign="top"><br>
			<DIV ID="Tab1" STYLE="display:;">
				<%=Gui.GroupBoxStart(Translate.Translate("Felter"))%>
					<table border="0" cellpadding="0" width="570">
						<tr>
							<td><strong><%=Translate.Translate("Navn")%></strong></td>
							<td width=165><strong><%=Translate.Translate("Type")%></strong></td>
							<td width=75 align="center"><strong><%=Translate.Translate("Sortering")%></strong></td>
							<td width=75 align="center"><strong><%=Translate.Translate("Aktiv")%></strong></td>
							<td width=35 align="center"><strong><nobr><%=Translate.Translate("Slet")%></nobr></strong></td>
						</tr><%
						Response.Write(("<tr>"))
						Response.Write(("	<td colspan=""6"" bgcolor=""#C4C4C4""><img src=""../../images/nothing.gif"" width=1 height=1 border=""0""></td>"))
						Response.Write(("</tr>"))

						i = 0
						
						For j = 0 To recipientView.count - 1
							i = i + 1
							Response.Write(("<tr>"))
							Response.Write(("<td><a href=""NewsletterExtended_recipient_UserFields_Edit.aspx?NewsletterUserFieldID=" & recipientView(j)("NewsletterUserFieldID").ToString & """>" & recipientView(j)("NewsletterUserFieldName").ToString & "</a></td>"))
							Response.Write(("<td width=75>" & FieldType(recipientView(j)("NewsletterUserFieldType").ToString & "</td>")))
							If i = 1 Then
								Response.Write(("<td width=75 align=""center""><img src=""../../images/Nothing.gif"" width=""15"">&nbsp;<a href=""NewsletterExtended_recipient_UserFields_Sort.aspx?SortDirection=Down&NewsletterUserFieldID=" & recipientView(j)("NewsletterUserFieldID").ToString & "&FormID=" & FormID & """><img src=""../../images/PilNed.gif"" alt=""" & Translate.JsTranslate("Flyt ned") & """ border=""0""></a></td>"))
							ElseIf i = recipientView.count Then 
								Response.Write(("<td width=75 align=""center""><a href=""NewsletterExtended_recipient_UserFields_Sort.aspx?SortDirection=Up&NewsletterUserFieldID=" & recipientView(j)("NewsletterUserFieldID").ToString & """><img src=""../../images/PilOp.gif"" alt=""" & Translate.JsTranslate("Flyt op") & """ border=""0""></a>&nbsp;<img src=""../../images/nothing.gif"" width=""15""></a></td>"))
							Else
								Response.Write(("<td width=75 align=""center""><a href=""NewsletterExtended_recipient_UserFields_Sort.aspx?SortDirection=Up&NewsletterUserFieldID=" & recipientView(j)("NewsletterUserFieldID").ToString & """><img src=""../../images/PilOp.gif"" alt=""" & Translate.JsTranslate("Flyt op") & """ border=""0""></a>&nbsp;<a href=""NewsletterExtended_recipient_UserFields_Sort.aspx?SortDirection=Down&NewsletterUserFieldID=" & recipientView(j)("NewsletterUserFieldID").ToString & "&FormID=" & FormID & """><img src=""../../images/PilNed.gif"" alt=""" & Translate.JsTranslate("Flyt ned") & """ border=""0""></a></td>"))
							End If
							If recipientView(j)("NewsletterUserFieldActive").ToString Then
								Response.Write("<td align=""center""><a href=""NewsletterExtended_recipient_UserFields_SetActive.aspx?SetActive=False&NewsletterUserFieldID=" & recipientView(j)("NewsletterUserFieldID").ToString & """><img src=""../../images/Check.gif"" border=""0""></a></td>")
							Else
								Response.Write("<td align=""center""><a href=""NewsletterExtended_recipient_UserFields_SetActive.aspx?SetActive=True&NewsletterUserFieldID=" & recipientView(j)("NewsletterUserFieldID").ToString & """><img src=""../../images/Minus.gif"" border=""0""></a></td>")
							End If
							Response.Write(("<td width=35 align=""center""><a href=""javascript:if(confirm('" & Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("felt")) & "\n(" & recipientView(j)("NewsletterUserFieldName").ToString & ")')){location='NewsletterExtended_recipient_UserFields_Del.aspx?NewsletterUserFieldID=" & recipientView(j)("NewsletterUserFieldID").ToString & "&NewsletterUserFieldSystemName=" & recipientView(j)("NewsletterUserFieldSystemName").ToString & "&FormID=" & FormID & "'}""><img src=""../../images/Delete.gif"" border=0 alt=""" & Translate.JSTranslate("Slet felt") & """></a></td>"))
							Response.Write(("</tr>"))
							
							Response.Write(("<tr>"))
							Response.Write(("	<td colspan=""6"" bgcolor=""#C4C4C4""><img src=""../../images/nothing.gif"" width=1 height=1 border=""0""></td>"))
							Response.Write(("</tr>"))
						Next 
						if recipientView.count=0 then%>
							<tr><td colspan="5"><br /><strong><%=Translate.Translate("Ingen felter defineret.")%></strong></td></tr>						
						<%end if
						%>
					</table>
				<%=Gui.GroupBoxEnd%>
			</DIV>
		</td>
	</tr>
	<tr>
		<td align="right" valign=bottom>
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="4" height="10"></td>
				</tr>
				<tr>
					<td width="5"></td>
					<td>
						<%=Gui.Button(Translate.Translate("Nyt felt"), "Javascript:location='NewsletterExtended_recipient_UserFields_Edit.aspx?NewsletterUserFieldFormID=" & FormID & "';", 0)%>
					</td>
					<td width="5"></td>
					<td>
						<%=Gui.Button(Translate.Translate("Annuller"), "location='NewsletterExtended_blank.html'", 0)%>
					</td>
					<%=Gui.HelpButton("newsletterV2","modules.newsletterextended.general.userfield",,5)%>
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
recipientView.Dispose
dsNewsletter.Dispose()
cmdNewsletter.Dispose()
newsletterConn.Dispose()
%>
</body>
</html>