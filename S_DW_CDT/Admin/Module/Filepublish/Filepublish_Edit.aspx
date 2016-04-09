<%@ Page CodeBehind="Filepublish_Edit.aspx.vb" ValidateRequest="false" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Filepublish_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
Dim ParagraphID As integer
Dim sql As String

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
        If prop.Value("FilepublishSortOrder") = "" Then
            prop.Value("FilepublishSortOrder") = "ASC"
        End If
        If prop.Value("FilepublishSortBy") = "" Then
            prop.Value("FilepublishSortBy") = "Name"
        End If
    Else
        prop.Value("FilepublishFolder") = "/" & Dynamicweb.Content.Management.Installation.FilesFolderName
        prop.Value("FilepublishIconFolder") = ""
        prop.Value("FilepublishTemplate") = "FilepublishList.html"
        prop.Value("FilepublishTemplateItem") = "FilepublishListPart.html"
        prop.Value("FilepublishUploadTemplate") = ""
        prop.Value("FilepublishUploadDestination") = "Active"
        prop.Value("FilepublishDirUpText") = ".."
        prop.Value("FilepublishSortOrder") = "ASC"
        prop.Value("FilepublishSortBy") = "Name"
    End If


%>
<input type="Hidden" name="Filepublish_settings" value="FilepublishFolder, FilepublishTemplate, FilepublishTemplateItem, FilepublishForceDownload, FilepublishShowSubdirs, FilepublishIconFolder, FilepublishUploadFolder, FilepublishUploadTemplate, FilepublishUploadNotify, FilepublishUploadSubject, FilepublishUploadRecipient, FilepublishUploadRecipientCC, FilepublishUploadRecipientBCC, FilepublishUploadText, FilepublishUploadConfirm, FilepublishUploadDestination, FilepublishDirUpText, FilepublishSortOrder, FilepublishSortBy">
<TR>
	<TD>
		<%=Gui.MakeModuleHeader("Filepublish", "Fil publicering")%>
	</TD>
</TR>
<tr>
	<td>
		<%=Gui.GroupBoxStart(Translate.Translate("Visning"))%>
		<table cellpadding=2 cellspacing=0 border=0>
			<tr>
				<td width="170" valign=top><%=Translate.Translate("Mappe")%></td>
				<td valign=top><%=Gui.FolderManager(prop.Value("FilepublishFolder"), "FilepublishFolder")%></td>
			</tr>
			<tr>
				<td valign=top><%=Translate.Translate("Tving download")%></td>
				<td valign=top><%=Gui.CheckBox(prop.Value("FilepublishForceDownload"), "FilepublishForceDownload")%></td>
			</tr>
			<tr>
				<td valign=top><%=Translate.Translate("Vis undermapper")%></td>
				<td valign=top><%=Gui.CheckBox(prop.Value("FilepublishShowSubdirs"), "FilepublishShowSubdirs")%></td>
			</tr>
			<tr>
				<td valign=top><%=Translate.Translate("Ikon mappe")%></td>
				<td valign=top><%=Gui.FolderManager(prop.Value("FilepublishIconFolder"), "FilepublishIconFolder")%></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
		<%=Gui.GroupBoxStart(Translate.Translate("Sortering"))%>
		<table cellpadding=2 cellspacing=0>
			<tr>
				<td valign=top width=170><%=Translate.Translate("Sorter efter")%></td>
				<td>
					<%=Gui.RadioButton(prop.Value("FilepublishSortBy"), "FilepublishSortBy", "Name")%>&nbsp;<label for="FilepublishSortByName"><%=Translate.Translate("Navn")%></label><br>
					<%=Gui.RadioButton(prop.Value("FilepublishSortBy"), "FilepublishSortBy", "Date")%>&nbsp;<label for="FilepublishSortByDate"><%=Translate.Translate("Dato")%></label><br>
					<%=Gui.RadioButton(prop.Value("FilepublishSortBy"), "FilepublishSortBy", "Size")%>&nbsp;<label for="FilepublishSortBySize"><%=Translate.Translate("Størrelse")%></label>
				</td>
			</tr>
			<tr>
				<td valign=top><%=Translate.Translate("Sortering")%></td>
				<td>
					<%=Gui.RadioButton(prop.Value("FilepublishSortOrder"), "FilepublishSortOrder", "DESC")%>&nbsp;<label for="FilepublishSortOrderDESC"><%=Translate.Translate("Faldende")%></label><br>
					<%=Gui.RadioButton(prop.Value("FilepublishSortOrder"), "FilepublishSortOrder", "ASC")%>&nbsp;<label for="FilepublishSortOrderASC"><%=Translate.Translate("Stigende")%></label><br>
				</td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
		<%=Gui.GroupBoxStart(Translate.Translate("Upload"))%>
		<table cellpadding=2 cellspacing=0 border=0>
			<tr>
				<td valign=top width="170"><%=Translate.Translate("Mappe")%></td>
				<td valign=top><%=Gui.FolderManager(prop.Value("FilepublishUploadFolder"), "FilepublishUploadFolder")%></td>
			</tr>
			<tr>
				<td valign=top><%=Translate.Translate("Notificer")%></td>
				<td valign=top><%=Gui.CheckBox(prop.Value("FilepublishUploadNotify"), "FilepublishUploadNotify")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Emne")%></td>
				<td><input type="Text" name="FilepublishUploadSubject" value="<%=prop.Value("FilepublishUploadSubject")%>" class="std"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Modtager")%></td>
				<td><input type="Text" name="FilepublishUploadRecipient" value="<%=prop.Value("FilepublishUploadRecipient")%>" class="std"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Modtager CC")%></td>
				<td><input type="Text" name="FilepublishUploadRecipientCC" value="<%=prop.Value("FilepublishUploadRecipientCC")%>" class="std"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Modtager BCC")%></td>
				<td><input type="Text" name="FilepublishUploadRecipientBCC" value="<%=prop.Value("FilepublishUploadRecipientBCC")%>" class="std"></td>
			</tr>
			<tr>
				<td valign=top><%=Translate.Translate("Tekst")%></td>
				<td><textarea class=std name="FilepublishUploadText" rows=5><%=prop.Value("FilepublishUploadText")%></textarea></td>
			</tr>
			<tr>
				<td valign="top"><%=Translate.Translate("Side efter indsendelse")%></td>
				<td><%=Gui.LinkManager(prop.Value("FilepublishUploadConfirm"), "FilepublishUploadConfirm", "")%></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
		<%=Gui.GroupBoxStart(Translate.Translate("Brugerdefinerede tekster"))%>
		<table cellpadding=2 cellspacing=0 border=0>
			<tr>
				<td width="170"><%=Translate.Translate("Op")%></td>
				<td><input type="Text" name="FilepublishDirUpText" value="<%=prop.Value("FilepublishDirUpText")%>" class="std"></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>		
		<%=Gui.GroupBoxStart(Translate.Translate("Templates"))%>
		<table cellpadding=2 cellspacing=0 border=0>
			<tr>
				<td width="170"><%=Translate.Translate("Liste")%></td>
				<td><%=Gui.FileManager(prop.Value("FilepublishTemplate"), "Templates/Filepublish", "FilepublishTemplate")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Liste element")%></td>
				<td><%=Gui.FileManager(prop.Value("FilepublishTemplateItem"), "Templates/Filepublish", "FilepublishTemplateItem")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Upload")%></td>
				<td><%=Gui.FileManager(prop.Value("FilepublishUploadTemplate"), "Templates/Filepublish", "FilepublishUploadTemplate")%></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>		
	</td>
</tr>

<%
Translate.GetEditOnlineScript()
%>