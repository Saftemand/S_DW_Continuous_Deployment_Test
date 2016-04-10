<%@ Page CodeBehind="Ecards_Edit.aspx.vb" Language="vb" ValidateRequest="false" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Ecards_Edit" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			23-05-2002
'	Last modfied:		23-05-2002
'
'	Purpose: File to edit ecards-paragraphs
'
'	Revision history:
'		1.0 - 23-05-2002 - GK
'		First version.
'**************************************************************************************************
Dim ParagraphID As Integer

If Request("ID") <> "" Then
	ParagraphID = Base.Chknumber(request("ID"))
Elseif Request("ParagraphID") <> "" Then
	ParagraphID = Base.Chknumber(request("ParagraphID"))
Else
	ParagraphID = 0
End If

Dim prop As new Properties

    If Base.ChkString(Request.QueryString("ParagraphModuleSystemName")) = "" Then 'ParagraphID > 0 Then
        prop = Base.GetParagraphModuleSettings(ParagraphID, True)
    Else
        prop.Value("Ecards_Dir") = "/" & Dynamicweb.Content.Management.Installation.ImagesFolderName
        prop.Value("Ecards_ListMode") = "0"

        prop.Value("Ecards_TxtSenderName") = Translate.Translate("Navn på afsender")
        prop.Value("Ecards_TxtRecipientEmail") = Translate.Translate("Modtagerens E-mail Adresse")
        prop.Value("Ecards_TxtSenderEmail") = Translate.Translate("Afsenderens E-mail Adresse")
        prop.Value("Ecards_TxtSelectImage") = Translate.Translate("Vælg billede")
        prop.Value("Ecards_TxtSendCopy") = Translate.Translate("Send kopi")
        prop.Value("Ecards_TxtText") = Translate.Translate("Tekst")
	
        prop.Value("Ecards_TxtEnterYourName") = Translate.Translate("Feltet %% skal udfyldes!", "%%", Translate.Translate("Navn"))
        prop.Value("Ecards_TxtEnterValidEmail") = Translate.Translate("Feltet %% skal udfyldes!", "%%", Translate.Translate("E-mail"))
	
        'todo
    End If

If prop.Value("Ecards_EncodingUsed") = "" Then
	prop.Value("Ecards_EncodingUsed") = "utf-8"
End If 
%>
<input type="Hidden" name="Ecards_Settings" value="Ecards_ListMode, Ecards_Dir, Ecards_Button, Ecards_ReturnPage, Ecards_DefaultSenderMail, Ecards_TextOnEmail, Ecards_TxtSenderName, Ecards_TxtRecipientEmail, Ecards_TxtSenderEmail, Ecards_TxtSelectImage, Ecards_TxtSendCopy, Ecards_TxtText, Ecards_TxtEnterYourName, Ecards_TxtEnterValidEmail, EcardSubject, Ecards_EncodingUsed">
<TR>
	<TD>
		<%=Gui.MakeModuleHeader("ecards", "Postkort")%>
	</TD>
</TR>

<tr>
	<td>
	<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
			<tr>
				<td width="170"><%=Translate.Translate("%% knap", "%%", "<em>" & Translate.Translate("Send") & "</em>" )%></td>
				<td align="left"><%= Gui.FileManager(prop.Value("Ecards_Button"), Dynamicweb.Content.Management.Installation.ImagesFolderName, "Ecards_Button")%></td>
			</tr>
			<tr>
				<td width="170"><%=Translate.Translate("Side efter afsendelse")%></td>
				<td><%=Gui.LinkManager(prop.value("Ecards_ReturnPage"), "Ecards_ReturnPage", "")%></td>
			</tr>
		</table>
	<%=Gui.GroupBoxEnd()%>
	<%=Gui.GroupBoxStart(Translate.Translate("E-mail"))%>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
			<tr>
				<td width="170"><%=Translate.Translate("Emne")%></td>
				<td><input type="Text" maxlength="255" name="EcardSubject" value="<%=prop.value("EcardSubject")%>" class="std"></td>
			</tr>
			<tr valign="top">
				<td width="170"><%=Translate.Translate("Standard afsender e-mail")%></td>
				<td><input type="Text" maxlength="255" name="Ecards_DefaultSenderMail" value="<%=prop.value("Ecards_DefaultSenderMail")%>" class="std"></td>
			</tr>
			<tr valign="top">
				<td><%=Translate.Translate("Tekst på email")%></td>
				<td><textarea name="Ecards_TextOnEmail" class="std" style="height:50px;"><%=prop.value("Ecards_TextOnEmail")%></textarea></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Encoding")%></td>
				<td><%=Gui.EncodingList(prop.Value("Ecards_EncodingUsed"), "Ecards_EncodingUsed", True)%></td>
			</tr>
		</table>
	<%=Gui.GroupBoxEnd()%>
	</td>
</tr>
<tr>
	<td>
	<%=Gui.GroupBoxStart(Translate.Translate("Billeder"))%>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
			<tr valign="top">
				<td width="170"><%=Translate.Translate("Mappe")%></td>
				<td><%
					If len(prop.value("Ecards_Dir"))<1 Then
				            prop.Value("Ecards_Dir") = "/" & Dynamicweb.Content.Management.Installation.ImagesFolderName
					End If%>
					<%=Gui.FolderManager(prop.value("Ecards_Dir"), "Ecards_Dir")%></td>
			</tr>
			<tr valign="top">
				<td width="170"><%=Translate.Translate("Vis")%></td>
				<td><INPUT type="radio" class="clean" value="0" <%= Base.IIf(prop.value("Ecards_ListMode")<>"1","checked","") %> name="Ecards_ListMode" id="Ecards_ListMode"><%=Translate.Translate("Dropdown")%></td>
			</tr>
			<tr valign="top">
				<td width="170"></td>
				<td><INPUT type="radio" class="clean" value="1" <%= Base.IIf(prop.value("Ecards_ListMode")="1","checked","") %> name="Ecards_ListMode" id="Ecards_ListMode"><%=Translate.Translate("Billedgalleri")%></td>
			</tr>
		</table>
	<%=Gui.GroupBoxEnd()%>
	</td>
</tr>
<tr>
	<td>
	<%=Gui.GroupBoxStart(Translate.Translate("Brugerdefinerede tekster"))%>
		<table border="0" cellpadding="2" cellspacing="0" width="100%">
			<tr>
				<td width="170"><%=Translate.Translate("Navn på afsender")%></td>
				<td><input type="Text" maxlength="255" name="Ecards_TxtSenderName" value="<%=prop.value("Ecards_TxtSenderName")%>" class="std"></td>
			</tr>
			<tr>
				<td width="170"><%=Translate.Translate("Modtagerens E-mail Adresse")%></td>
				<td><input type="Text" maxlength="255" name="Ecards_TxtRecipientEmail" value="<%=prop.value("Ecards_TxtRecipientEmail")%>" class="std"></td>
			</tr>
			<tr>
				<td width="170"><%=Translate.Translate("Afsenderens E-mail Adresse")%></td>
				<td><input type="Text" maxlength="255" name="Ecards_TxtSenderEmail" value="<%=prop.value("Ecards_TxtSenderEmail")%>" class="std"></td>
			</tr>
			<tr>
				<td width="170"><%=Translate.Translate("Vælg billede")%></td>
				<td><input type="Text" maxlength="255" name="Ecards_TxtSelectImage" value="<%=prop.value("Ecards_TxtSelectImage")%>" class="std"></td>
			</tr>
			<tr>
				<td width="170"><%=Translate.Translate("Send kopi")%></td>
				<td><input type="Text" maxlength="255" name="Ecards_TxtSendCopy" value="<%=prop.value("Ecards_TxtSendCopy")%>" class="std"></td>
			</tr>
			<tr>
				<td width="170"><%=Translate.Translate("Tekst")%></td>
				<td><input type="Text" maxlength="255" name="Ecards_TxtText" value="<%=prop.value("Ecards_TxtText")%>" class="std"></td>
			</tr>
			<tr>
				<td width="170"><%=Translate.Translate("Feltet %% skal udfyldes!","%%","<em>" & Translate.Translate("Navn")& "</em>")%></td>
				<td><input type="Text" maxlength="255" name="Ecards_TxtEnterYourName" value="<%=prop.value("Ecards_TxtEnterYourName")%>" class="std"></td>
			</tr>
			<tr>
				<td width="170"><%=Translate.Translate("Feltet %% skal udfyldes!","%%","<em>" & Translate.Translate("E-mail")& "</em>")%></td>
				<td><input type="Text" maxlength="255" name="Ecards_TxtEnterValidEmail" value="<%=prop.value("Ecards_TxtEnterValidEmail")%>" class="std"></td>
			</tr>
		</table>
	<%=Gui.GroupBoxEnd()%>
	</td>
</tr>

<%
Translate.GetEditOnlineScript()
%>