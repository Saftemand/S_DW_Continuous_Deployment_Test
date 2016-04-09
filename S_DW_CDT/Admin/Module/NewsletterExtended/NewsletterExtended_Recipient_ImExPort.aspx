<%@ Page CodeBehind="NewsletterExtended_Recipient_ImExPort.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Recipient_ImExPort" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="System.IO" %>



<%
Dim ImportFile As String
Dim NewsletterRecipientFormat As String
Dim commaIndex As Integer
Dim NewsletterRecipientPassword As String
Dim SQLOldCategory As String
Dim NewsletterList As String
Dim RecipientID As String
Dim firstIndex As Integer
Dim dbFieldTypeSQL As String
'Dim f As Scripting.ITextStream
Dim strNewsletterUserFieldSystemName As String
Dim strFieldStringOutput As String
Dim varDBFieldList As String
Dim NewsletterRecipientName As String
Dim NewsletterRecipientID As String
Dim strNewsletterUserFieldDBType As String
Dim PortingType As String
Dim strFieldPath As String
Dim AddDBFields As String
Dim strNewsletterUserFieldName As String
Dim NewsletterRecipientEmail As String
Dim DelDBFields As String
Dim Sql As String
Dim ImportingType As String
'Dim fs As Scripting.FileSystemObject

Dim strFieldString As String
Dim arrFields() As String
Dim intIndex As Integer
Dim htDBTypes As New HashTable
Dim htDBName As New HashTable

PortingType = Request.Item("PortingType")
RecipientID = Request.Item("RecipientID")
AddDBFields = Request.QueryString.Item("AddDBFields")
DelDBFields = Request.QueryString.Item("DelDBFields")

Dim cnNewsletterExtended	As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
Dim cmdNewsletterExtended	As IDbCommand	 = cnNewsletterExtended.CreateCommand

Dim cnNewsletter As IDbConnection = Database.CreateConnection("newsletter.mdb")
Dim cmdNewsletter As IDbCommand	 = cnNewsletter.CreateCommand

If RecipientID = "" Then
	RecipientID = "0"
End If
PortingType = Request.Item("PortingType")
If PortingType = "" Then
	PortingType = "1"
End If
ImportingType = Request.Item("ImPortingType")
If ImportingType = "" Then
	ImportingType = "1"
End If

If CInt(PortingType) = 1 Then
	If CInt(ImportingType) = 2 Then
		cmdNewsletter.CommandText = " SELECT * FROM NewsletterCategory "
		Dim drOldCategory As IDataReader = cmdNewsletter.ExecuteReader()
		NewsletterList = NewsletterList & "<SELECT ID='NewsletterList' name='NewsletterList'  class=std>"
		Do While drOldCategory.Read()
			NewsletterList = NewsletterList & "<OPTION value='" & drOldCategory("NewsletterCategoryID").ToString() & "'>" & drOldCategory("NewsletterCategoryName").ToString() & "</option>" & vbNewLine
		Loop 
		NewsletterList = NewsletterList & "</SELECT>"
		drOldCategory.Dispose()
		cmdNewsletter.Dispose()
		cnNewsletter.Dispose()
	End If
End If

If RecipientID <> "" And Not RecipientID = "0" Then
	cmdNewsletter.CommandText = "SELECT * FROM NewsletterExtendedRecipient WHERE NewsletterRecipientID = " & RecipientID
	Dim dr As IDataReader = cmdNewsletter.ExecuteReader()
	
	If dr.Read() Then
		NewsletterRecipientEmail = dr("NewsletterRecipientEmail").ToString()
		NewsletterRecipientName = dr("NewsletterRecipientName").ToString()
		NewsletterRecipientFormat = dr("NewsletterRecipientFormat").ToString()
		NewsletterRecipientID = dr("NewsletterRecipientID").ToString()
		NewsletterRecipientPassword = dr("NewsletterRecipientPassword").ToString()
	End If
	dr.Dispose()
End If

If NewsletterRecipientFormat = "" Then
	NewsletterRecipientFormat = 2
End If

cmdNewsletterExtended.CommandText = "SELECT * FROM NewsletterExtendedUserField"
Dim drDBFields As IDataReader = cmdNewsletterExtended.ExecuteReader()

'fs = New Scripting.FileSystemObject
Dim blnDrDBFieldsHasRows As Boolean = False
Do While drDBFields.Read()
	If Not blnDrDBFieldsHasRows Then blnDrDBFieldsHasRows = True
	strNewsletterUserFieldSystemName = drDBFields("NewsletterUserFieldSystemName").ToString()
	strNewsletterUserFieldDBType = drDBFields("NewsletterUserFieldDBType").ToString()
	strNewsletterUserFieldName = drDBFields("NewsletterUserFieldName").ToString()
	htDBTypes.Add(strNewsletterUserFieldSystemName, strNewsletterUserFieldDBType)
	htDBName.Add(strNewsletterUserFieldSystemName, strNewsletterUserFieldName)
Loop 

drDBFields.Dispose()

htDBTypes.Add("NewsletterRecipientID", "Integer")
htDBName.Add("NewsletterRecipientID", Translate.JsTranslate("Modtagerens tabel ID"))
htDBTypes.Add("NewsletterRecipientName", "Text")
htDBName.Add("NewsletterRecipientName", Translate.JsTranslate("Modtagerens Navn"))
htDBTypes.Add("NewsletterRecipientPassword", "Text")
htDBName.Add("NewsletterRecipientPassword", Translate.JsTranslate("Modtagerens Password"))
htDBTypes.Add("NewsletterRecipientEmail", "Text")
htDBName.Add("NewsletterRecipientEmail", Translate.JsTranslate("Modtagerens E-mail Adresse"))
htDBTypes.Add("NewsletterRecipientFormat", "Numeric")
htDBName.Add("NewsletterRecipientFormat", Translate.JsTranslate("Modtagerens E-Mail format"))
htDBTypes.Add("NewsletterRecipientCategoryID", "Text")
htDBName.Add("NewsletterRecipientCategoryID", Translate.JsTranslate("Modtagerens liste tilmeldinger"))

strFieldString = ""
If File.Exists(Server.MapPath("/Files/DBFields.txt")) Then
	strFieldPath = "/Files/DBFields.txt" 'f.ReadAll
ElseIf File.Exists(Server.MapPath("DBFields.txt")) Then 
	strFieldPath = "DBFields.txt" 'f.ReadAll
End If

If AddDBFields <> "" Then
	If File.Exists(Server.MapPath(strFieldPath)) Then
		strFieldString = Base.ReadTextFile(Server.MapPath(strFieldPath)) 'f.ReadAll
	End If
	
	If htDBTypes.item(AddDBFields) = "Text" Then
		If strFieldString = "" Or IsNothing(strFieldString) Then
			strFieldString = strFieldString & """" & AddDBFields & """"
		Else
			strFieldString = strFieldString & ",""" & AddDBFields & """"
		End If
	Else
		If strFieldString = "" Or IsNothing(strFieldString) Then
			strFieldString = AddDBFields
		Else
			strFieldString = strFieldString & "," & AddDBFields
		End If
	End If
	'Throw new Exception(strFieldString)
	Dim FileNum As Integer = FreeFile()
	FileOpen(FileNum, Server.MapPath("/Files/DBFields.txt"), OpenMode.Binary)
    FilePut(FileNum, strFieldString)
    FileClose(FileNum)

	Response.Redirect("NewsletterExtended_recipient_ImExPort.aspx?PortingType=1&Tab=3")
	Response.End()
End If

If DelDBFields <> "" And Not DelDBFields = "undefined" Then
	If File.Exists(Server.MapPath(strFieldPath)) Then
		strFieldString = Base.ReadTextFile(Server.MapPath(strFieldPath)) 'f.ReadAll
	End If
		If strFieldString <> "" Or Not IsNothing(strFieldString) Then
		If htDBTypes.item(DelDBFields) = "Text" Then
			DelDBFields = """" & DelDBFields & """"
		ElseIf htDBTypes.item(DelDBFields) = "" Then 
			DelDBFields = """" & DelDBFields & """"
		End If
		
		firstIndex = InStr(1, strFieldString, DelDBFields, 1)
		commaIndex = InStr(1, strFieldString, ",", 1)
		If commaIndex > 0 Then
			If firstIndex > 2 Then
				DelDBFields = "," & DelDBFields
			Else
				DelDBFields = DelDBFields & ","
			End If
		End If
		'Throw new Exception(strFieldString)
		strFieldString = Replace(strFieldString, DelDBFields, "")
		
		'f = fs.CreateTextfile(Server.MapPath("/Files/DBFields.txt"), True, False)
		'f.Write((strFieldString))
		Try
			File.Delete(Server.MapPath("/Files/DBFields.txt"))
			
			Dim FileNum As Integer = FreeFile()
			FileOpen(FileNum, Server.MapPath("/Files/DBFields.txt"), OpenMode.Binary, OpenAccess.Default, OpenShare.Default, 1)
			FilePut(FileNum, strFieldString)
			FileClose(FileNum)
		Catch e As Exception
			'Throw new exception("File Error:" & e.Message) 'todo remove 
		End Try
	End If
	Response.Redirect("NewsletterExtended_recipient_ImExPort.aspx?PortingType=1&Tab=3")
End If

If DelDBFields = "" And InStr(Request.QueryString.GetValues(0).ToString(), "DelDBFields=") Then
	'w("test")
	If File.Exists(Server.MapPath(strFieldPath)) Then
		strFieldString = Base.ReadTextFile(Server.MapPath(strFieldPath)) 'f.ReadAll
	End If
	
	If strFieldString <> "" Or IsDbNull(strFieldString) = False Then
		If InStr(strFieldString, """" & """" & vbNewLine) Then
			'we "ALLALALA"
		End If
		'Response.Redirect("NewsletterExtended_recipient_ImExPort.aspx?PortingType=1&Tab=3")
	End If
End If

If File.Exists(Server.MapPath(strFieldPath)) Then
	intIndex = 0
	strFieldString = Base.ReadTextFile(Server.MapPath(strFieldPath)) 'f.ReadAllf.ReadAll
	If strFieldString <> "" And Not IsNothing(strFieldString) Then
		arrFields = Split(strFieldString, ",")
		
		varDBFieldList = "<table width=""100%""><tr width='100%'>" & "<td><strong>" & Translate.Translate("Felt") & "</strong></td>" & "<td valign='middle'><strong>" & Translate.Translate("Slet") & "</strong></td></tr>"
		Do While intIndex <= UBound(arrFields)
			
			varDBFieldList = varDBFieldList & "<tr  width='100%'><td>"
			varDBFieldList = varDBFieldList & "<img src=""../../images/Icons/Language_Small.gif"" align=""absMiddle"" border=""0"" width=""15"" height=""17"">"
			varDBFieldList = varDBFieldList & "  " & htDBName.item(Replace(arrFields(intIndex), """", "")) & "</td>"
			varDBFieldList = varDBFieldList & "<td valign='middle'><a href=""JavaScript:DelDBField('" & Replace(arrFields(intIndex), """", "") & "')"">"
			varDBFieldList = varDBFieldList & "<img src=""../../images/Delete.gif"" border=""0"" width=""15"" height=""17""></a></td>"
			varDBFieldList = varDBFieldList & "</tr>"
			varDBFieldList = varDBFieldList & "<tr width='100%' ><span width='100%' id=""bodyheight""><td  width='100%' bgColor=""#c4c4c4"" colSpan=""2"">"
			varDBFieldList = varDBFieldList & "</td></span></tr>"
			
			intIndex = intIndex + 1
		Loop 
		varDBFieldList = varDBFieldList & "</table>"
	Else
		varDBFieldList = "<Table><tr><td>" & Translate.Translate("Ingen felter defineret.") & "</td></tr></table>"
	End If
Else
	varDBFieldList = "<Table><tr><td>" & Translate.Translate("Ingen felter defineret.") & "</td></tr></table>"
End If
strFieldStringOutput = strFieldString

If strFieldStringOutput = "" Or isNothing(strFieldStringOutput) Then
	strFieldStringOutput = "<Table><tr><td>" & Translate.Translate("Ingen felter defineret.") & "</td></tr></table>"
Else
	strFieldStringOutput = "<Table><tr><td colspan=2>" & strFieldString & "</td></tr></table>"
End If

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title><%=Translate.JsTranslate("Rediger %%","%%",Translate.Translate("modtager"))%></title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	
<script language="JavaScript" type="text/javascript">
	
function chkNewsletterCategory(){
	if(document.getElementById('NewsletterRecipientImExPort').NewsletterRecipientCategoryID.length)
	{
		for(i=0;i<document.getElementById('NewsletterRecipientImExPort').NewsletterRecipientCategoryID.length;i++)
		{
			if(document.getElementById('NewsletterRecipientImExPort').NewsletterRecipientCategoryID[i].checked)
			{
				return true;
			}
		}
	}
	else
	{
		if(document.getElementById('NewsletterRecipientImExPort').NewsletterRecipientCategoryID.checked)
		{
			return true;
		}
	}
}

function Send(){
<%
'w("//" & (strFieldString = "") & " Or " & IsNothing(strFieldString) & " AND (" & (CInt(PortingType) <> 1) & " OR " & (CInt(ImportingType) <> 2) & ")")

If (strFieldString = "" Or isNothing(strFieldString)) And (CInt(PortingType) <> 1 Or CInt(ImportingType) <> 2) Then
	Response.Write("alert('" & Translate.JsTranslate("Import/Export felt opsætning mangler") & "');")
Else
	If PortingType = 1 Then
		If ImportingType = 1 Then
			%>
		if (document.getElementById('NewsletterRecipientImExPort').ImportFile.value.length < 1)
			alert('<%=Translate.JsTranslate("Vælg %%", "%%", Translate.JsTranslate("fil"))%>');
		else if (document.getElementById('NewsletterRecipientImExPort').NewsletterRecipientFormat[0].checked == false && document.getElementById('NewsletterRecipientImExPort').NewsletterRecipientFormat[1].checked == false && document.getElementById('NewsletterRecipientImExPort').NewsletterRecipientFormat[2].checked == false)
			alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("E-mailformat"))%>');
		else if (!chkNewsletterCategory())
			alert('<%=Translate.JsTranslate("Vælg %%", "%%", Translate.JsTranslate("lister"))%>');
		else
		{
			document.getElementById('NewsletterRecipientImExPort').action = 'NewsletterExtended_recipient_ImExPort_caller.aspx';
			document.getElementById('NewsletterRecipientImExPort').submit();
		}
<%			
		Else
			%>
			if (document.getElementById('NewsletterRecipientImExPort').NewsletterRecipientFormat[0].checked == false && document.getElementById('NewsletterRecipientImExPort').NewsletterRecipientFormat[1].checked == false && document.getElementById('NewsletterRecipientImExPort').NewsletterRecipientFormat[2].checked == false)
				alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("E-mailformat"))%>.');
			else if (!chkNewsletterCategory())
				alert("<%=Translate.JsTranslate("Vælg %%", "%%", Translate.JsTranslate("lister"))%>.");
			else
			{
				document.getElementById('NewsletterRecipientImExPort').action = 'NewsletterExtended_recipient_ImExPort_caller.aspx';
				document.getElementById('NewsletterRecipientImExPort').submit();
			}
<%			
		End If
	Else
		%>
		if (!chkNewsletterCategory())
			alert("<%=Translate.JsTranslate("Vælg %%", "%%", Translate.JsTranslate("lister"))%>.");
		else
		{
			document.getElementById('NewsletterRecipientImExPort').action = 'NewsletterExtended_recipient_ImExPort_caller.aspx';
			document.getElementById('NewsletterRecipientImExPort').submit();
		}
<%		
	End If
End If
%>
}

function ChangeType(ID)
{
location="NewsletterExtended_recipient_ImExPort.aspx?RecipientID=<%=RecipientID%>&ImPortingType=<%=ImportingType%>&PortingType=" + ID
}

function ChangeImportType(ID)
{
location="NewsletterExtended_recipient_ImExPort.aspx?RecipientID=<%=RecipientID%>&PortingType=<%=PortingType%>&ImPortingType=" + ID
}

function AddField() {
	if(document.getElementById("DBFields").value == "NewsletterRecipientID")
		if(confirm('<%=Translate.JsTranslate("Feltet ´%%´ bliver ignoreret ved Import, men ikke ved Eksport!", "%%", Translate.JsTranslate("Modtagerens tabel ID"))%>\n<%=Translate.JsTranslate("Fortsæt?")%>') == false)
			return false;
	
	location="NewsletterExtended_recipient_ImExPort.aspx?RecipientID=<%=RecipientID%>&PortingType=<%=PortingType%>&ImPortingType=<%=ImportingType%>&Tab=3&AddDBFields=" + document.getElementById("DBFields").value;
}

function DelDBField(strDBFields) {
location="NewsletterExtended_recipient_ImExPort.aspx?RecipientID=<%=RecipientID%>&PortingType=<%=PortingType%>&ImPortingType=<%=ImportingType%>&Tab=3&DelDBFields=" + strDBFields;
}
</script>

<%=Gui.MakeHeaders(Translate.Translate("Import/eksport bruger"), Translate.Translate("Porter") & ", " & Translate.Translate("Lister") & ", " & Translate.Translate("Felter"), "javascript")%>
<body LEFTMARGIN="20" TOPMARGIN="16">
<%=Gui.MakeHeaders(Translate.Translate("Import/eksport bruger"), Translate.Translate("Porter") & ", " & Translate.Translate("Lister") & ", " & Translate.Translate("Felter"), "html")%>


<table border="0" cellpadding="0" cellspacing="0" width="100" class="tabTable">
<form name="NewsletterRecipientImExPort" id="NewsletterRecipientImExPort" method="post" action="">
<input type="Hidden" value="<%=NewsletterRecipientID%>" name="NewsletterRecipientID">
<input type="Hidden" value="<%=PortingType%>" name="PortingType">
	<tr>
		<td valign="top">
<!--	XXXXXXXXXXXXXXXXXXXXXXXXXXXXX  	PORTER  START xxxxxxxxxxxxxxxxxxxxxxxxxxxx			-->
		<div id="Tab1">
			<br>
			<table cellspacing="0" border="0" cellpadding="0" width="100%">
				<tr>
					<td colspan="2">
					<%=Gui.GroupBoxStart(Translate.Translate("Modtager"))%>
					<%If PortingType = 1 Then%>
						<table cellpadding=2 cellspacing=0>
							<tr>
								<td width=170>&nbsp;<%=Translate.Translate("Type")%></td>
								<td><input onclick="ChangeType(1);" <%If PortingType = 1 Then 
																			response.write("checked") 
																	  End If%> 
								type="radio" name="cbType" value="1"> &nbsp;<%=Translate.Translate("Importer")%> &nbsp;&nbsp;&nbsp;<input onclick="ChangeType(2);" 
								<%	
								If PortingType = 2 Then 
									response.write("checked") 
								End IF%> 
								type="radio" name="cbType" value="2"> &nbsp;<%=Translate.Translate("Eksporter")%> </td>
							</tr>
							<tr>
								<td width=170>&nbsp;<%=Translate.Translate("Import Type")%></td>
								<td><input onclick="ChangeImportType(1);" 
								<%
								If ImPortingType = 1 Then 
									response.write("checked")
								End IF 
								%> 
								type="radio" name="cbImType" value="1"> &nbsp;<%=Translate.Translate("Fil")%> &nbsp;&nbsp;&nbsp;<input onclick="ChangeImportType(2);" 
								<%If ImPortingType = 2 Then
									 response.write("checked")
								  End IF 
								%> 
								type="radio" name="cbImType" value="2"> &nbsp;<%=Translate.Translate("Nyhedslister v.1")%> </td>
							</tr>
							<%	If ImportingType = 1 Then%>
							<tr>
								<td width=170>&nbsp;<%=Translate.Translate("Fil")%></td>
								<td><%=Gui.FileManager(ImportFile, Dynamicweb.Content.Management.Installation.FilesFolderName , "ImportFile")%></td>	
							</tr>
							<tr>
							    <td><%=Translate.Translate("Encoding") %></td>
							    <td>
							        <select name="ImportFileEncoding" id="ImportFileEncoding" class="std">
							            <option value="Default" selected="selected">Default</option>
							            <option value="Ascii">Ascii</option>
							            <option value="Unicode">Unicode</option>
							            <option value="UTF-8">UTF-8</option>
							        </select>
							    </td>
							</tr>
							<%	Else%>
							<tr>
								<td width=170>&nbsp;<%=Translate.Translate("Liste")%></td>
								<td><%=NewsletterList%></td>	
							</tr>
						<%	End If%>							
						</table>
						<%Else%>
						<table cellpadding=2 cellspacing=0>
							<tr>
								<td width=170>&nbsp;<%=Translate.Translate("Brugertype")%></td>
								<td><input onclick="ChangeType(1);" <%If PortingType = 1 Then 
																			response.write("checked")
																	  End IF 
																	%>
								type="radio" name="cbType" value="1"> &nbsp;<%=Translate.Translate("Importer")%> &nbsp;&nbsp;&nbsp;<input onclick="ChangeType(2);" <%If PortingType = 2 Then 
																																										response.write("checked") 
																																								   End IF
																																								   %> 
								type="radio" name="cbType" value="2"> &nbsp;<%=Translate.Translate("Eksporter")%> </td>
							</tr>
						</table>
						<%End If%>
						<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
				<tr>
					<td height=5></td>
				</tr>
				<tr>
					<td colspan="2">
					<%=Gui.GroupBoxStart(Translate.Translate("E-mail"))%>
						<table cellpadding=2 cellspacing=0>
							<tr>
							<td width='170px'><%=Translate.Translate("Format")%></td>
							<td><%=Gui.RadioButton(NewsletterRecipientFormat, "NewsletterRecipientFormat", "1")%>&nbsp;<%=Translate.Translate("Text")%></td>
						</tr>
						<tr>
							<td></td>
							<td><%=Gui.RadioButton(NewsletterRecipientFormat, "NewsletterRecipientFormat", "2")%>&nbsp;<%=Translate.Translate("Html")%></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
			</table>
		</div>
<!--	XXXXXXXXXXXXXXXXXXXXXXXXXXXXX  	PORTER  SLUT  xxxxxxxxxxxxxxxxxxxxxxxxxxxx			-->

<!--	XXXXXXXXXXXXXXXXXXXXXXXXXXXXX  	NYHEDSLITER  START  xxxxxxxxxxxxxxxxxxxxxxxxxxxx			-->
		<div id="Tab2" style="display:none;">
			<br>
			<table cellspacing="0" border="0" cellpadding="0" width="100%">
				<tr>
					<td colspan="2">
					<%=Gui.GroupBoxStart(Translate.Translate("Nyhedslister"))%>
						<table cellpadding=2 cellspacing=0>
							<%

							    cmdNewsletterExtended.CommandText = " SELECT NewsletterExtendedCategory.*, (select TOP 1 ' checked ' FROM NewsletterExtendedCategoryRecipient where NewsLetterCategoryRecipientCategoryID = NewsletterExtendedCategory.NewsletterCategoryID AND NewsLetterCategoryRecipientRecipientID = " & RecipientID & ") AS Selected " & " FROM NewsletterExtendedCategory"
Dim drRecipientCategory As IDataReader = cmdNewsletterExtended.ExecuteReader()							
		
Dim blnDrRecipientCategoryHasRows As Boolean = False						
Do While drRecipientCategory.Read()
	If Not blnDrRecipientCategoryHasRows Then blnDrRecipientCategoryHasRows = True
	Response.Write("<tr>")
	Response.Write("<td width='170px'>&nbsp;" & drRecipientCategory("NewsletterCategoryName") & "</td>")
	Response.Write("<td><input name=""NewsletterRecipientCategoryID"" ")
	Response.Write(drRecipientCategory("Selected"))
	Response.Write("type=""CheckBox"" class=""clean"" value=""" & drRecipientCategory("NewsletterCategoryID") & """></td>")
	Response.Write("</tr>")
Loop 
If Not blnDrRecipientCategoryHasRows Then 
	Response.Write("<tr>")
	Response.Write("<td colspan=""2"">" & Translate.Translate("Der er ikke oprettet nogen %c%", "%c%", Translate.Translate("lister")) & "!</td>")
	Response.Write("</tr>")
End If

drRecipientCategory.Dispose()
%>
						</table>
					<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
			</table>	
		</div>
<!--	XXXXXXXXXXXXXXXXXXXXXXXXXXXXX  	NYHEDSLISTER  SLUT xxxxxxxxxxxxxxxxxxxxxxxxxxxx			-->

<!--	XXXXXXXXXXXXXXXXXXXXXXXXXXXXX  	FELTER  START xxxxxxxxxxxxxxxxxxxxxxxxxxxx			-->
		<div id="Tab3" style="display:none;">
			<br>
			<table cellspacing="0" border="0" cellpadding="0" width="100%">
				<tr>
					<td colspan="2">
					<%=Gui.GroupBoxStart(Translate.Translate("Database felter"))%>
						<table cellpadding=2 cellspacing=0>
							<tr>
								<td width=170>&nbsp;<%=Translate.Translate("Felt")%></td>
								<td>
									<select  class="std" name="DBFields" class=std ID="DBFields">
									<option value="NewsletterRecipientID" selected><%=Translate.Translate("Modtagerens tabel ID")%>
									<option value="NewsletterRecipientName" selected><%=Translate.Translate("Modtagerens Navn")%>
									<option value="NewsletterRecipientPassword" selected><%=Translate.Translate("Modtagerens Password")%>
									<option value="NewsletterRecipientEmail" selected><%=Translate.Translate("Modtagerens E-mail Adresse")%>
									<option value="NewsletterRecipientFormat" selected><%=Translate.Translate("Modtagerens E-Mail format")%>
									<option value="NewsletterRecipientCategoryID" selected><%=Translate.Translate("Modtagerens liste tilmeldinger")%>

									<%
									
If blnDrDBFieldsHasRows Then
	cmdNewsletterExtended.CommandText = "SELECT * FROM NewsletterExtendedUserField"
	drDBFields = cmdNewsletterExtended.ExecuteReader()
	Do While drDBFields.Read()
		Response.Write("<option  value=""" & drDBFields("NewsletterUserFieldSystemName").ToString() & """>" & drDBFields("NewsletterUserFieldName").ToString())
	Loop 
	drDBFields.Dispose()
End If


%>
									</select>
							</tr>
							<tr>
								<td width=170>&nbsp;</td>
								</td>
								<td align="right">
									<%=Gui.Button(Translate.Translate("TilfÃ¸j"), "AddField();", 0)%>
								</td>
							</tr>
						</table>
						<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
				<tr>
					<td height=5></td>
				</tr>
				<tr>
					<td>
					<%=Gui.GroupBoxStart(Translate.Translate("Porterings Felter"))%>
					<table width="100%" cellpadding=2 cellspacing=0>
						<tr>
							<td>
								<%=varDBFieldList%>
							</td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
				<tr>
					<td height=5></td>
				</tr>
				<tr>
					<td>
					<%=Gui.GroupBoxStart(Translate.Translate("Porterings format"))%>
						<table cellpadding=2 cellspacing=0>
							<tr>
							<td>
								<%=Replace(strFieldStringOutput, ",", ", ")%>
							</td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
			</table>
		</div>
<!--	XXXXXXXXXXXXXXXXXXXXXXXXXXXXX  	FELTER  SLUT xxxxxxxxxxxxxxxxxxxxxxxxxxxx			-->

		</td>
		</form>
	</tr>
	<tr>
		<td align="right" valign="bottom">
			<%=Gui.MakeOkCancelHelp("javascript:Send();", "location='NewsletterExtended_Recipient.aspx'", True, "modules.newsletterextended.general.imexport", "newsletterV2")%>

		</td>
	</tr>
</table>
</body>
<%

htDBTypes = Nothing
htDBName = Nothing

cmdNewsletterExtended.Dispose()
cnNewsletterExtended.Dispose()

cmdNewsletter.Dispose()
cnNewsletter.Dispose()
%>

<%=Gui.SelectTab()%>
<SCRIPT LANGUAGE="JavaScript">
<!--
parent.document.getElementById("StatusFrame").setAttribute("src", "NewsletterExtended_Blank_with_color.html");
parent.updateinfo('');
//-->
</SCRIPT>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>