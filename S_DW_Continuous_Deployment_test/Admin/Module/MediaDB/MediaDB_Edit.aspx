<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
Dim ParagraphID As Integer
Dim ParagraphModuleSettings As String
Dim ShopParagraphShowProductNumber As String
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
        prop.Value("MediaDB_SortBy") = "MediaDBMediaUpdatedDate"
        prop.Value("MediaDB_SortOrder") = "DESC"
        prop.Value("MediaDB_Coloumns") = 3
        prop.Value("MediaDB_PageSize") = 12
        prop.Value("MediaDB_ListTemplate") = "List.html"
        prop.Value("MediaDB_ListElementTemplate") = "ListElement.html"
        prop.Value("MediaDB_ElementTemplate") = "Element.html"
        prop.Value("MediaDB_SearchTemplate") = "Search.html"
        prop.Value("MediaDB_PageSizeForward") = "1"
        prop.Value("MediaDB_PageSizeForwardText") = Translate.Translate("Næste") & "&raquo;"
        prop.Value("MediaDB_PageSizeBack") = "1"
        prop.Value("MediaDB_PageSizeBackText") = "&laquo;" & Translate.Translate("Forrige")
        prop.Value("MediaDB_FileLink") = "1"
        prop.Value("MediaDB_FileLinkText") = "Download"
        prop.Value("MediaDB_DefaultIconFolder") = "/System/ext"
        prop.Value("MediaDB_DefaultIcon") = ""
        prop.Value("MediaDB_NoHtml") = "false"
    End If

If prop.Value("MediaDB_DefaultIconFolder") = "" Then
	prop.Value("MediaDB_DefaultIconFolder") = "/System/ext"
End If

%>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<input type="Hidden" name="MediaDB_settings" value="MediaDB_DefaultIconFolder, MediaDB_DefaultIcon, MediaDB_Coloumns, MediaDB_PageSize, MediaDB_FileLink, MediaDB_FileLinkPicture, MediaDB_FileLinkText, MediaDB_PageSizeForward, MediaDB_PageSizeForwardText, MediaDB_PageSizeForwardPicture, MediaDB_PageSizeBack, MediaDB_PageSizeBackPicture, MediaDB_PageSizeBackText, MediaDB_ListTemplate, MediaDB_ListElementTemplate, MediaDB_ElementTemplate, MediaDB_SearchTemplate, MediaDB_SortBy, MediaDB_SortOrder, MediaDB_GroupByGroup, MediaDB_Groups, MediaDB_GroupsSearch, MediaDB_GroupsDontShow, MediaDB_LightboxListTemplate, MediaDB_LightboxListElementTemplate, MediaDB_NoHtml">
<TR>
	<TD>
		<%=Gui.MakeModuleHeader("mediadb", "Medie database")%>
	</TD>
</TR>
<TR>
	<TD>
		<%=Gui.GroupBoxStart(Translate.Translate("Visning"))%>
		<table cellpadding=2 cellspacing=0 border=0>
			<tr>
				<td  valign="top" width=170><%=Translate.Translate("Kolonner")%></td>
				<td><%=Gui.SpacListExt(prop.Value("MediaDB_Coloumns"), "MediaDB_Coloumns", 1, 5, 1, "")%></td>
			</tr>
			<tr>
				<td height=5></td>
			</tr>
			<tr>
				<td  valign="top" width=170><%=Translate.Translate("Billeder pr. side")%></td>
				<td><%=Gui.SpacListExt(prop.Value("MediaDB_PageSize"), "MediaDB_PageSize", 1, 100, 1, "")%></td>
			</tr>
			<tr>
				<td height=5></td>
			</tr>
			<tr>
				<td valign=top><%=Translate.Translate("%% knap", "%%", "<em>" & Translate.Translate("Næste") & "</em>" )%></td>
				<td valign=top><%=Gui.ButtonText("MediaDB_PageSizeForward", prop.Value("MediaDB_PageSizeForward"), prop.Value("MediaDB_PageSizeForwardPicture"), prop.Value("MediaDB_PageSizeForwardText"))%></td>
			</tr>
			<tr>
				<td height=5></td>
			</tr>
			<tr>
				<td width="170" valign=top><%=Translate.Translate("%% knap", "%%", "<em>" & Translate.Translate("Forrige") & "</em>" )%></td>
				<td valign=top><%=Gui.ButtonText("MediaDB_PageSizeBack", prop.Value("MediaDB_PageSizeBack"), prop.Value("MediaDB_PageSizeBackPicture"), prop.Value("MediaDB_PageSizeBackText"))%></td>
			</tr>
			<tr>
				<td height=5></td>
			</tr>
			<tr>
				<td width="170" valign=top><%=Translate.Translate("Link til fil")%></td>
				<td valign=top><%=Gui.ButtonText("MediaDB_FileLink", prop.Value("MediaDB_FileLink"), prop.Value("MediaDB_FileLinkPicture"), prop.Value("MediaDB_FileLinkText"))%></td>
			</tr>
			<tr>
				<td height=5></td>
			</tr>
			<tr>
				<td width="170" valign=top><%=Translate.Translate("Thumbnail mappe")%></td>
				<td><%=Gui.FolderManager(prop.Value("MediaDB_DefaultIconFolder"), "MediaDB_DefaultIconFolder")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Standard thumbnail")%></td>
				<td><%=Gui.FileManager(prop.Value("MediaDB_DefaultIcon"), Dynamicweb.Content.Management.Installation.ImagesFolderName , "MediaDB_DefaultIcon")%></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>

		<%=Gui.GroupBoxStart(Translate.Translate("Templates"))%>
		<table cellpadding=2 cellspacing=0 border=0>
			<tr>
				<td width=170><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Liste"))%></td>
				<td><%=Gui.FileManager(prop.Value("MediaDB_ListTemplate"), "Templates/MediaDB", "MediaDB_ListTemplate")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Liste element"))%></td>
				<td><%=Gui.FileManager(prop.Value("MediaDB_ListElementTemplate"), "Templates/MediaDB", "MediaDB_ListElementTemplate")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Vis element"))%></td>
				<td><%=Gui.FileManager(prop.Value("MediaDB_ElementTemplate"), "Templates/MediaDB", "MediaDB_ElementTemplate")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Søgeboks"))%></td>
				<td><%=Gui.FileManager(prop.Value("MediaDB_SearchTemplate"), "Templates/MediaDB", "MediaDB_SearchTemplate")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Lysbord"))%></td>
				<td><%=Gui.FileManager(prop.Value("MediaDB_LightboxListTemplate"), "Templates/MediaDB", "MediaDB_LightboxListTemplate")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Lysbord element"))%></td>
				<td><%=Gui.FileManager(prop.Value("MediaDB_LightboxListElementTemplate"), "Templates/MediaDB", "MediaDB_LightboxListElementTemplate")%></td>
			</tr>
            <tr>
				<td>
				</td>
				<td>
					<%= Gui.CheckBox(prop.Value("MediaDB_NoHtml"), "MediaDB_NoHtml")%>
					<label for="MediaDB_NoHtml">
						<%=Translate.Translate("Do not insert column html")%>
					</label>
				</td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>

		<%=Gui.GroupBoxStart(Translate.Translate("Sortering"))%>
		<table cellpadding=2 cellspacing=0>
			<tr>
				<td valign=top width=170><%=Translate.Translate("Sorter efter")%></td>
				<td>
					<%=Gui.RadioButton(prop.Value("MediaDB_SortBy"), "MediaDB_SortBy", "MediaDBMediaUpdatedDate")%>&nbsp;<label for="MediaDB_SortByMediaDBMediaUpdatedDate"><%=Translate.Translate("Dato")%></label><br>
					<%=Gui.RadioButton(prop.Value("MediaDB_SortBy"), "MediaDB_SortBy", "MediaDBMediaName")%>&nbsp;<label for="MediaDB_SortByMediaDBMediaName"><%=Translate.Translate("Navn")%></label><br>
					<!--<%=Gui.RadioButton(prop.Value("MediaDB_SortBy"), "MediaDB_SortBy", "MediaDBMediaSort")%>&nbsp;<label for="MediaDB_SortByMediaDBMediaSort"><%=Translate.Translate("Sortering")%></label><br>-->
				</td>
			</tr>
			<tr>
				<td valign=top><%=Translate.Translate("Sortering")%></td>
				<td>
					<%=Gui.RadioButton(prop.Value("MediaDB_SortOrder"), "MediaDB_SortOrder", "DESC")%>&nbsp;<label for="MediaDB_SortOrderDESC"><%=Translate.Translate("Faldende")%></label><br>
					<%=Gui.RadioButton(prop.Value("MediaDB_SortOrder"), "MediaDB_SortOrder", "ASC")%>&nbsp;<label for="MediaDB_SortOrderASC"><%=Translate.Translate("Stigende")%></label><br>
				</td>
			</tr>
			<tr>
				<td></td>
				<td><%=Gui.CheckBox(prop.Value("MediaDB_GroupByGroup"), "MediaDB_GroupByGroup")%><label for="MediaDB_GroupByGroup"> <%=Translate.Translate("Grupper efter gruppe")%></label><br></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>

		<%=Gui.GroupBoxStart(Translate.Translate("Vis"))%>
		<table cellpadding=2 cellspacing=0>
			<tr>
				<td valign=top width=170><%=Translate.Translate("Grupper")%></td>
				<td><%=Gui.MediaDBGroupList("MediaDB_Groups", prop.Value("MediaDB_Groups"), True, 10)%></td>
			</tr>
			<tr>
				<td></td>
				<td><%=Gui.CheckBox(prop.Value("MediaDB_GroupsSearch"), "MediaDB_GroupsSearch")%><label for="MediaDB_GroupsSearch"> <%=Translate.Translate("Begræns søgning til valgte grupper")%></label><br></td>
			</tr>
			<tr>
				<td></td>
				<td><%=Gui.CheckBox(prop.Value("MediaDB_GroupsDontShow"), "MediaDB_GroupsDontShow")%><label for="MediaDB_GroupsDontShow"> <%=Translate.Translate("Vis kun søgeresultat")%>.</label><br></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
	</td>
</tr>

<%
	Translate.GetEditOnlineScript()
%>