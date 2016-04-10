<%@ Page CodeBehind="NewsletterExtended_Recipient_UserFields_Option_Edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Recipient_UserFields_Option_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>


<%
Dim NewsletterUserFieldID As String
Dim i As Integer
Dim NewsletterUserFieldOptionsValue As Object
Dim NewsletterUserFieldOptionsID As String
Dim UserFieldsOptionsSort As Object
Dim NewsletterUserType As String
Dim sql As String
Dim NewsletterUserFieldOptionsText As Object


NewsletterUserFieldID = request.QueryString.Item("NewsletterUserFieldID")
NewsletterUserFieldOptionsID = request.QueryString.Item("NewsletterUserFieldOptionsID")
UserFieldsOptionsSort = 1

Dim cn As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
Dim cmd As IDbCommand = cn.CreateCommand


NewsletterUserType = "text"

If NewsletterUserFieldID <> "" And Not NewsletterUserFieldID = "0" Then
	cmd.CommandText = "SELECT * FROM NewsletterExtendedUserField WHERE NewsletterUserFieldID = " & NewsletterUserFieldID
	Dim drType As IDataReader = cmd.ExecuteReader()
	If drType.Read() Then
		NewsletterUserType = LCase(drType("NewsletterUserFieldDBType").ToString())
	End If
	drType.Close()
	drType.Dispose()
End If

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title></title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
</head>
<script>
function DeleteOption(NewsletterUserFieldID,UserFieldsOptionsID){
	if(confirm('<%=Translate.Translate("Slet %%?", "%%", Translate.JSTranslate("valgmulighed"))%>')){
		location = 'NewsletterExtended_recipient_UserFields_Option_Del.aspx?NewsletterUserFieldID='+ NewsletterUserFieldID + '&NewsletterUserFieldOptionsID=' + UserFieldsOptionsID + '&Redirect=Option'
	}
}

function ValidateForm(){
	FormOK = true;
	if(document.getElementById('UserFieldsOptionForm').NewsletterUserFieldOptionsValue.value.length <= 0){
		alert('<%=Translate.Translate("Angiv værdi!")%>');
		document.getElementById('UserFieldsOptionForm').NewsletterUserFieldOptionsValue.focus();
		FormOK = false;
	}
	if('<%=NewsletterUserType%>' == 'numeric' && isNumeric(document.getElementById('UserFieldsOptionForm').NewsletterUserFieldOptionsValue.value)) {
		alert('<%=Translate.Translate("Skal være numerisk!")%>');
		document.getElementById('UserFieldsOptionForm').NewsletterUserFieldOptionsValue.value = '';
		document.getElementById('UserFieldsOptionForm').NewsletterUserFieldOptionsValue.focus();
		return false;
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
</script>
<body>
<%


If NewsletterUserFieldOptionsID <> "" And Not NewsletterUserFieldOptionsID = "0" Then
	cmd.CommandText = "SELECT * FROM NewsletterExtendedUserFieldOptions WHERE NewsletterUserFieldOptionsID = " & NewsletterUserFieldOptionsID
	Dim dr As IDataReader = cmd.ExecuteReader()
	If dr.Read() Then
		NewsletterUserFieldOptionsText = dr("NewsletterUserFieldOptionsText")
		NewsletterUserFieldOptionsValue = dr("NewsletterUserFieldOptionsValue")
	End If
	dr.Close()
	dr.Dispose()
End If
%>

<%=Gui.MakeHeaders(Translate.Translate("Form"), Translate.Translate("Valg"), "all")%>
<table border="0" cellpadding="0" cellspacing="0" Class="TabTable" ID="Table1">
	<tr>
		<td valign="top">
			<form name="UserFieldsOptionForm" method="POST" action="NewsletterExtended_recipient_UserFields_Option_Save.aspx?NewsletterUserFieldID=<%=NewsletterUserFieldID%>" id="UserFieldsOptionForm">
			<input type="Hidden" name="NewsletterUserFieldOptionsID" value="<%=NewsletterUserFieldOptionsID%>" ID="Hidden1">
			<br>
			<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
				<table border="0" cellpadding="0" ID="Table2">
					<tr>
						<td width=170><%=Translate.Translate("Tekst")%></td>
						<td><input type="Text" name="NewsletterUserFieldOptionsText" value="<%=NewsletterUserFieldOptionsText%>" class="std" ID="Text1"></td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Værdi")%> &nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td><input type="Text" name="NewsletterUserFieldOptionsValue" value="<%=NewsletterUserFieldOptionsValue%>" class="std" ID="Text2"></td>
					</tr>
					<tr>
						<td colspan="2" align="right"><%=Gui.Button(Translate.Translate("Gem"), "javascript:if(ValidateForm()){UserFieldsOptionForm.submit();};", 0)%></td>
					</tr>
				</table>
			<%Response.Write(Gui.GroupBoxEnd)
If Not NewsletterUserFieldID = "" Then%>
			</td>
		</tr>
	<tr>
		<td>
			<%=Gui.GroupBoxStart(Translate.Translate("Valgmuligheder"))%>
				<table border="0" cellpadding="0" width="574" ID="Table3">
					<tr>
						<td width="175"><strong><%=Translate.Translate("Tekst")%></strong></td>
						<td width="175"><strong><%=Translate.Translate("Værdi")%></strong></td>
						<td align="center"><strong><%=Translate.Translate("Sortering")%></strong>&nbsp;</td>
						<td align="center"><strong><%=Translate.Translate("Medtag")%></strong>&nbsp;</td>
						<td align="center"><strong><%=Translate.Translate("Default")%></strong>&nbsp;</td>
						<td align="center"><strong><%=Translate.Translate("Slet")%></strong></td>
					</tr>
					<%	
	cmd.CommandText = "SELECT Count(*) FROM NewsletterExtendedUserFieldOptions WHERE NewsletterUserFieldOptionsFieldID =" & NewsletterUserFieldID 
	Dim recordCount As Integer = 0
	recordCount = cmd.ExecuteScalar()
	
	cmd.CommandText = "SELECT * FROM NewsletterExtendedUserFieldOptions WHERE NewsletterUserFieldOptionsFieldID =" & NewsletterUserFieldID & " ORDER BY NewsletterUserFieldOptionsSort"
	Dim dr As IDataReader = cmd.ExecuteReader()
	
	i = 0
	Do While dr.Read()
		i = i + 1
		UserFieldsOptionsSort = dr("NewsletterUserFieldOptionsSort")
		Response.Write("<tr>")
		Response.Write("<td width=""175""><a href=""NewsletterExtended_recipient_UserFields_Option_Edit.aspx?NewsletterUserFieldOptionsID=" & dr("NewsletterUserFieldOptionsID") & "&NewsletterUserFieldID=" & NewsletterUserFieldID & """>" & dr("NewsletterUserFieldOptionsText") & "</a></td>")
		Response.Write("<td width=""175"">" & dr("NewsletterUserFieldOptionsValue") & "</td>")
		
		If i = 1 Then
			Response.Write("<td align=""center""><img src=""../../images/nothing.gif"" width=""15"">&nbsp;<a href=""NewsletterExtended_recipient_UserFields_Option_Sort.aspx?SortDirection=Down&Redirect=Option&NewsletterUserFieldOptionsID=" & dr("NewsletterUserFieldOptionsID") & "&NewsletterUserFieldID=" & NewsletterUserFieldID & """><img src=""../../images/PilNed.gif"" alt=""" & Translate.JsTranslate("Flyt ned") & """ border=""0""></a></td>")
		ElseIf i = recordCount Then 
			Response.Write("<td align=""center""><a href=""NewsletterExtended_recipient_UserFields_Option_Sort.aspx?SortDirection=Up&Redirect=Option&NewsletterUserFieldOptionsID=" & dr("NewsletterUserFieldOptionsID") & "&NewsletterUserFieldID=" & NewsletterUserFieldID & """><img src=""../../images/PilOp.gif"" alt=""" & Translate.JsTranslate("Flyt op") & """ border=""0""></a>&nbsp;<img src=""../../images/Nothing.gif"" width=""15""></td>")
		Else
			Response.Write("<td align=""center""><a href=""NewsletterExtended_recipient_UserFields_Option_Sort.aspx?SortDirection=Up&Redirect=Option&NewsletterUserFieldOptionsID=" & dr("NewsletterUserFieldOptionsID") & "&NewsletterUserFieldID=" & NewsletterUserFieldID & """><img src=""../../images/PilOp.gif"" alt=""" & Translate.JsTranslate("Flyt op") & """ border=""0""></a>&nbsp;<a href=""NewsletterExtended_recipient_UserFields_Option_Sort.aspx?SortDirection=Down&Redirect=Option&NewsletterUserFieldOptionsID=" & dr("NewsletterUserFieldOptionsID") & "&NewsletterUserFieldID=" & NewsletterUserFieldID & """><img src=""../../images/PilNed.gif"" alt=""" & Translate.JsTranslate("Flyt ned") & """ border=""0""></a></td>")
		End If
		
		'response.write "<td align=""center""><a href=""NewsletterExtended_recipient_UserFields_Option_Sort.aspx?SortDirection=Up&Redirect=Option&NewsletterUserFieldOptionsID="& rs("NewsletterUserFieldOptionsID") &"&NewsletterUserFieldID="& NewsletterUserFieldID &"""><img src=""../../images/PilOp.gif"" alt=""" & Translate.JsTranslate("Flyt op") & """ border=""0""></a>&nbsp;<a href=""NewsletterExtended_recipient_UserFields_Option_Sort.aspx?SortDirection=Down&NewsletterUserFieldOptionsID="& rs("NewsletterUserFieldOptionsID") &"&NewsletterUserFieldID="& NewsletterUserFieldID &"&Redirect=Option""><img src=""../../images/PilNed.gif"" alt=""" & Translate.JsTranslate("Flyt ned") & """ border=""0""></a></td>"
					        If Base.ChkBoolean(dr("NewsletterUserFieldOptionsActive")) Then
					            Response.Write("<td align=""center""><a href=""NewsletterExtended_recipient_UserFields_Option_SetActive.aspx?SetActive=False&Redirect=Option&NewsletterUserFieldOptionsID=" & dr("NewsletterUserFieldOptionsID") & "&NewsletterUserFieldID=" & NewsletterUserFieldID & """><img src=""../../images/Check.gif"" border=""0""></a></td>")
					        Else
					            Response.Write("<td align=""center""><a href=""NewsletterExtended_recipient_UserFields_Option_SetActive.aspx?SetActive=True&Redirect=Option&NewsletterUserFieldOptionsID=" & dr("NewsletterUserFieldOptionsID") & "&NewsletterUserFieldID=" & NewsletterUserFieldID & """><img src=""../../images/Minus.gif"" border=""0""></a></td>")
					        End If
					        If Base.ChkBoolean(dr("NewsletterUserFieldOptionsDefaultSelected")) Then
					            Response.Write("<td align=""center""><a href=""NewsletterExtended_recipient_UserFields_Option_SetDefault.aspx?NewsletterUserFieldOptionsID=" & dr("NewsletterUserFieldOptionsID") & "&NewsletterUserFieldID=" & NewsletterUserFieldID & "&Redirect=Option""><img src=""../../images/Check.gif"" border=""0""></a></td>")
					        Else
					            Response.Write("<td align=""center""><a href=""NewsletterExtended_recipient_UserFields_Option_SetDefault.aspx?NewsletterUserFieldOptionsID=" & dr("NewsletterUserFieldOptionsID") & "&NewsletterUserFieldID=" & NewsletterUserFieldID & "&Redirect=Option""><img src=""../../images/Minus.gif"" border=""0""></a></td>")
					        End If
		Response.Write("<td align=""center""><a href=""javascript:DeleteOption(" & NewsletterUserFieldID & "," & dr("NewsletterUserFieldOptionsID") & ");""><img src=""../../images/delete.gif"" border=""0"" alt=""" & Translate.JSTranslate("Slet %%", "%%", Translate.JSTranslate("valgmulighed")) & """></a></td>")
		Response.Write("</tr>")
	Loop 
	dr.Close()
	dr.Dispose()
		
%>
				</table>
<%Response.Write(Gui.GroupBoxEnd)
End If%>
			<input type="hidden" name="UserFieldsOptionsSort" value="<%=UserFieldsOptionsSort%>" ID="Hidden2">
		</td>
	</tr>
	<tr>
		<td align="right" valign=bottom>
			<table border="0" cellpadding="0" cellspacing="0" ID="Table4">
				<tr>
					<td colspan="10" height="5"></td>
				</tr>
				<tr>
					<td><%=Gui.Button(Translate.Translate("OK"), "location='NewsletterExtended_recipient_UserFields_Edit.aspx?NewsletterUserFieldID=" & NewsletterUserFieldID & "'", 0)%></td>
					<td width="5"></td>
					<td><%=Gui.Button(Translate.Translate("Annuller"), "location='NewsletterExtended_recipient_UserFields_Edit.aspx?NewsletterUserFieldID=" & NewsletterUserFieldID & "'", 0)%></td>
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
cmd.Dispose()
cn.Close()
cn.Dispose()

Translate.GetEditOnlineScript()
%>
