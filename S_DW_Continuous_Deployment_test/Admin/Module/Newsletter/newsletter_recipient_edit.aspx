<%@ Page CodeBehind="newsletter_recipient_edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.newsletter_recipient_edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
Dim arrNewsletterRecipientCategoryIDs() As String
Dim NewsletterRecipientEmail As String
Dim SetChecked As Boolean
Dim Sql As String
Dim NewsletterRecipientID As String
Dim i As Integer
Dim NewsletterRecipientCategoryIDFound As Boolean
Dim NewsletterRecipientFormatOutput As String
Dim arrNewsletterRecipientCategoryID() As String
Dim NewsletterRecipientFormat As String
Dim GroupBoxWidth As Integer
Dim NewsletterRecipientName As String
Dim NewsletterRecipientCategoryID As String


Dim cn		As IDbConnection	= Database.CreateConnection("Newsletter.mdb")
Dim cmd		As IDbCommand		= cn.CreateCommand
Dim dr		As IDataReader	

Dim arrNewsletterRecipientFormatText()	As String = New String() {Translate.Translate("Tekst"), Translate.Translate("HTML"), Translate.Translate("Standard")}
Dim arrNewsletterRecipientFormatValue() As String = New String() {"txt", "html", "default"}

    If Not Len(Request.QueryString.Item("NewsletterRecipientID")) < 1 Then
	
        cmd.CommandText = "SELECT * FROM NewsletterRecipient WHERE NewsletterRecipientID = " & Base.ChkNumber(Request.QueryString.Item("NewsletterRecipientID")) & ""
        dr = cmd.ExecuteReader()
	
        If dr.Read() Then
            NewsletterRecipientEmail = dr("NewsletterRecipientEmail").ToString
            NewsletterRecipientName = dr("NewsletterRecipientName").ToString
            NewsletterRecipientFormat = dr("NewsletterRecipientFormat").ToString
            NewsletterRecipientID = dr("NewsletterRecipientID").ToString
            'Do While Not RS.EOF
            If Not IsDBNull(dr("NewsletterRecipientCategoryID")) Then
                NewsletterRecipientCategoryID = dr("NewsletterRecipientCategoryID").ToString
            Else
                NewsletterRecipientCategoryID = ""
            End If
            'Loop 
            'RS.Close()
            arrNewsletterRecipientCategoryID = Split(NewsletterRecipientCategoryID.Replace(" ", ""), ",")
        End If
        dr.Close()
    End If

For i = LBound(arrNewsletterRecipientFormatText) To UBound(arrNewsletterRecipientFormatText)
	NewsletterRecipientFormatOutput = NewsletterRecipientFormatOutput & "<tr>" & vbNewLine & vbTab & "<td width=170>&nbsp;" & arrNewsletterRecipientFormatText(i) & "</td>" & vbNewLine
	If NewsletterRecipientFormat = arrNewsletterRecipientFormatValue(i) Then
		NewsletterRecipientFormatOutput = NewsletterRecipientFormatOutput & vbTab & "<td><input checked class=""clean"" type=""radio"" value=""" & arrNewsletterRecipientFormatValue(i) & """ name=""NewsletterRecipientFormat""></td>" & vbNewLine
	Else
		NewsletterRecipientFormatOutput = NewsletterRecipientFormatOutput & vbTab & "<td><input class=""clean"" type=""radio"" value=""" & arrNewsletterRecipientFormatValue(i) & """ name=""NewsletterRecipientFormat""></td>" & vbNewLine
	End If
	NewsletterRecipientFormatOutput = NewsletterRecipientFormatOutput & "<tr>" & vbNewLine
Next 
GroupBoxWidth = 490
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><%=Translate.JsTranslate("Rediger %%","%%",Translate.Translate("modtager"))%></title>
	<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	
	<script language="JavaScript" type="text/javascript">
	
	function chkNewsletterCategory(){
		if(document.getElementById('NewsletterRecipientEdit').NewsletterRecipientCategoryID.length){
			for(i=0;i<document.getElementById('NewsletterRecipientEdit').NewsletterRecipientCategoryID.length;i++){
				if(document.getElementById('NewsletterRecipientEdit').NewsletterRecipientCategoryID[i].checked){
					return true;
				}
			}
		}else{
			if(document.getElementById('NewsletterRecipientEdit').NewsletterRecipientCategoryID.checked){
				return true;
			}
		}
	}
	function Send(){
		if (document.getElementById('NewsletterRecipientEdit').NewsletterRecipientName.value.length < 1){
			alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>.');
		}
		else if (document.getElementById('NewsletterRecipientEdit').NewsletterRecipientEmail.value.length < 1){
			alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Email adresse"))%>.');
		}
		else if (!chkNewsletterCategory()){
			alert("<%=Translate.JsTranslate("VÃ¦lg mindst en kategori")%>.");
		}
		else{
		document.getElementById('NewsletterRecipientEdit').action = 'newsletter_recipient_save.aspx';
		document.getElementById('NewsletterRecipientEdit').submit();
		}
	}
	
	</script>
<%=Gui.MakeHeadersPopup(Translate.Translate("Rediger %%","%%",Translate.Translate("modtager")), Translate.Translate("Modtager") & "," & Translate.Translate("Lister"), "javascript")%>
<%=Gui.MakeHeadersPopup(Translate.Translate("Rediger %%","%%",Translate.Translate("modtager")), Translate.Translate("Modtager") & "," & Translate.Translate("Lister"), "all")%>

<table border="0" cellpadding="0" cellspacing="0" width="500" class="tabTable" style="width:500;">
<form name="NewsletterRecipientEdit" id="NewsletterRecipientEdit" method="post" action="Calender_category_save.aspx">
<input type="Hidden" value="<%=NewsletterRecipientID%>" name="NewsletterRecipientID">
	<tr>
		<td valign="top">
		<div id="Tab1">
			<br>
			<table cellspacing="0" border="0" cellpadding="0" width="498">
				<tr>
					<td colspan="2">
					<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
						<table cellpadding=2 cellspacing=0>
							<tr>
								<td width=170>&nbsp;<%=Translate.Translate("Navn")%></td>
								<td><input class="std" maxlength="255" type="Text" value="<%=NewsletterRecipientName%>" name="NewsletterRecipientName"></td>
							</tr>
							<tr>
								<td>&nbsp;<%=Translate.Translate("Email")%></td>
								<td><input class="std" maxlength="255" type="Text" value="<%=NewsletterRecipientEmail%>" name="NewsletterRecipientEmail"></td>
							</tr>
						</table>
						<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
<!--
				<tr>
					<td height=5></td>
				</tr>
				<tr>
					<td colspan="2">
					<%=Gui.GroupBoxStart(Translate.Translate("Mailformat"))%>
						<table cellpadding=2 cellspacing=0>
							<%=NewsletterRecipientFormatOutput%>
						</table>
					<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
-->
			</table>
		</div>
		<div id="Tab2" style="display:none;">
			<br>
			<table cellspacing="0" border="0" cellpadding="0" width="498">
				<tr>
					<td colspan="2">
					<%=Gui.GroupBoxStart(Translate.Translate("Lister"))%>
					<div style="overflow:auto;height:150px;width:475px;">
						<table cellpadding=2 cellspacing=0>
				<%

cmd.CommandText = "SELECT * FROM NewsletterCategory ORDER BY NewsletterCategoryName"
dr = cmd.ExecuteReader()
Dim blnDrHasRows As Boolean = False
Do While dr.Read()
	If Not blnDrHasRows Then blnDrHasRows = True
		Response.Write("<tr>")
		Response.Write("<td width=170>&nbsp;" & Server.HtmlEncode(dr("NewsletterCategoryName").ToString) & "</td>")
		If IsArray(arrNewsletterRecipientCategoryID) Then
			For i = LBound(arrNewsletterRecipientCategoryID) To UBound(arrNewsletterRecipientCategoryID)
				If CInt(arrNewsletterRecipientCategoryID(i)) = CInt(dr("NewsletterCategoryID").ToString) Then
					NewsletterRecipientCategoryIDFound = True
				End If
			Next 
		End If
		arrNewsletterRecipientCategoryIDs = Split(NewsletterRecipientCategoryID, ",")
		For i = 0 To UBound(arrNewsletterRecipientCategoryIDs)
			If Trim(arrNewsletterRecipientCategoryIDs(i)) = CStr(dr("NewsletterCategoryID").ToString) Then
				SetChecked = True
				Exit For
			End If
		Next 
		If SetChecked Then
			SetChecked = False
			Response.Write("<td><input checked class=""clean"" type=""CheckBox"" name=""NewsletterRecipientCategoryID"" value=""" & dr("NewsletterCategoryID").ToString & """></td>")
		Else
			Response.Write("<td><input class=""clean"" type=""CheckBox"" name=""NewsletterRecipientCategoryID"" value=""" & dr("NewsletterCategoryID").ToString & """></td>")
		End If
		'Next
		Response.Write("</tr>")
		NewsletterRecipientCategoryIDFound = False
Loop 
dr.Close()
dr.Dispose()
cmd.Dispose()
cn.Dispose()
	
If Not blnDrHasRows Then
	Response.Write("<tr>")
	Response.Write("<td colspan=""2"">" & Translate.Translate("Der er ikke oprettet nogen %c%", "%c%", Translate.Translate("kategorier")) & "</td>")
	Response.Write("</tr>")
End If
%>
					</div>
					</table>
					<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
			</table>	
		</div>
		</td>
		</form>
	</tr>
	<tr>
		<td align="right" valign="bottom">
		<table cellpadding="0" cellspacing="0">
			<tr>
				<td colspan="6"><br></td>
			</tr>
			<tr>
				<td align="right"><%=Gui.Button(Translate.Translate("OK"), "javascript:Send();", 0)%></td>
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
</body>
<%
Translate.GetEditOnlineScript()
%>
