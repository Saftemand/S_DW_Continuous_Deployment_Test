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
        prop.Value("ImageGallery_SortBy") = "PictureUpdatedDate"
        prop.Value("ImageGallery_SortOrder") = "DESC"
        prop.Value("ImageGallery_Coloumns") = 3
        prop.Value("ImageGallery_PageSize") = 4
        prop.Value("ImageGallery_ListTemplate") = "Coloumn_List.html"
        prop.Value("ImageGallery_ListElementTemplate") = "Coloumn_ListElement.html"
        prop.Value("ImageGallery_ElementTemplate") = "Coloumn_Element.html"
        prop.Value("ImageGallery_PageSizeForward") = "1"
        prop.Value("ImageGallery_PageSizeForwardText") = Translate.Translate("Frem") & "&raquo;"
        prop.Value("ImageGallery_PageSizeBack") = "1"
        prop.Value("ImageGallery_PageSizeBackText") = "&laquo;" & Translate.Translate("Tilbage")
        prop.Value("ImageGallery_FileLink") = "1"
        prop.Value("ImageGallery_FileLinkText") = Translate.Translate("Download")
        prop.Value("ImageGallery_ListTextNoImages") = Translate.Translate("Ingen billeder fundet!")
        prop.Value("ImageGallery_MaxThumbHeight") = "115"
        prop.Value("ImageGallery_MaxThumbWidth") = "200"
        prop.Value("ImageGallery_MaxPictureHeight") = "500"
		prop.Value("ImageGallery_MaxPictureWidth") = "500"
		prop.Value("ImageGallery_NoHtml") = "false"
	
    End If

If prop.Value("ImageGallery_DefaultIconFolder") = "" Then
	prop.Value("ImageGallery_DefaultIconFolder") = "/System/ext"
End If

%>
<input name="ImageGallery_settings" type="Hidden" value="ImageGallery_ListTextNoImages, ImageGallery_MaxThumbWidth, ImageGallery_MaxThumbHeight, ImageGallery_Coloumns, ImageGallery_PageSize, ImageGallery_FileLink, ImageGallery_FileLinkPicture, ImageGallery_FileLinkText, ImageGallery_PageSizeForward, ImageGallery_PageSizeForwardText, ImageGallery_PageSizeForwardPicture, ImageGallery_PageSizeBack, ImageGallery_PageSizeBackPicture, ImageGallery_PageSizeBackText, ImageGallery_ListTemplate, ImageGallery_ListElementTemplate, ImageGallery_ElementTemplate, ImageGallery_SearchTemplate, ImageGallery_SortBy, ImageGallery_SortOrder, ImageGallery_PictureFolder, ImageGallery_LightboxListTemplate, ImageGallery_LightboxListElementTemplate, ImageGallery_MaxPictureHeight, ImageGallery_MaxPictureWidth, ImageGallery_NoHtml">
<TR>
	<TD>
		<%=Gui.MakeModuleHeader("imagegallery", "Billedgalleri")%>
	</TD>
</TR>
<TR>
	<TD>
		<%=Gui.GroupBoxStart(Translate.Translate("Visning"))%>
		<table cellpadding=2 cellspacing=0 border=0>
			<tr>
				<td  valign="top" width=170><%=Translate.Translate("Kolonner")%></td>
				<td><%=Gui.SpacListExt(prop.Value("ImageGallery_Coloumns"), "ImageGallery_Coloumns", 1, 5, 1, "")%></td>
			</tr>
			<tr>
				<td height=5></td>
			</tr>
			<tr>
				<td  valign="top" width=170><%=Translate.Translate("Rækker")%></td>
				<td><%=Gui.SpacListExt(prop.Value("ImageGallery_PageSize"), "ImageGallery_PageSize", 1, 100, 1, "")%></td>
			</tr>
			<tr>
				<td height=5></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Thumbnails")%></td>
				<td><input type="Text" class="std" style="width:35px;" maxlength="4" name="ImageGallery_MaxThumbWidth" value="<%=prop.Value("ImageGallery_MaxThumbWidth")%>"><Label for "ImageGallery_MaxThumbWidth">&nbsp;<%=Translate.Translate("Max bredde (px)")%></Label></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><input type="Text" class="std" style="width:35px;" maxlength="4" name="ImageGallery_MaxThumbHeight" value="<%=prop.Value("ImageGallery_MaxThumbHeight")%>"><Label for "ImageGallery_MaxThumbHeight">&nbsp;<%=Translate.Translate("Max højde (px)")%></Label></td>
			</tr>
			<tr>
				<td valign=top><%=Translate.Translate("%% knap", "%%", "<em>" & Translate.Translate("Frem") & "</em>" )%></td>
				<td valign=top><%=Gui.ButtonText("ImageGallery_PageSizeForward", prop.Value("ImageGallery_PageSizeForward"), prop.Value("ImageGallery_PageSizeForwardPicture"), prop.Value("ImageGallery_PageSizeForwardText"))%></td>
			</tr>
			<tr>
				<td height=5></td>
			</tr>
			<tr>
				<td width="170" valign=top><%=Translate.Translate("%% knap", "%%", "<em>" & Translate.Translate("Tilbage") & "</em>" )%></td>
				<td valign=top><%=Gui.ButtonText("ImageGallery_PageSizeBack", prop.Value("ImageGallery_PageSizeBack"), prop.Value("ImageGallery_PageSizeBackPicture"), prop.Value("ImageGallery_PageSizeBackText"))%></td>
			</tr>
			<tr>
				<td height="10" colspan="2"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Billede")%></td>
				<td><input type="Text" class="std" style="width:35px;" maxlength="4" name="ImageGallery_MaxPictureWidth" value="<%=prop.Value("ImageGallery_MaxPictureWidth")%>"><Label for "ImageGallery_MaxPictureWidth">&nbsp;<%=Translate.Translate("Max bredde (px)")%></Label></td>
			</tr>
			<tr>
				<td valign=top width=170>&nbsp;</td>
				<td><input type="Text" class="std" style="width:35px;" maxlength="4" name="ImageGallery_MaxPictureHeight" value="<%=prop.Value("ImageGallery_MaxPictureHeight")%>"><Label for "ImageGallery_MaxPictureHeight">&nbsp;<%=Translate.Translate("Max højde (px)")%></Label></td>
			</tr>

			<tr>
				<td width="170" valign=top><%=Translate.Translate("Link til fil")%></td>
				<td><input type="Text" class="std" maxlength="250" name="ImageGallery_FileLinkText" value="<%=prop.Value("ImageGallery_FileLinkText")%>"></td>
				<!--<td valign=top><%=Gui.ButtonText("ImageGallery_FileLink", prop.Value("ImageGallery_FileLink"), prop.Value("ImageGallery_FileLinkPicture"), prop.Value("ImageGallery_FileLinkText"))%></td>-->
			</tr>
			<tr>
				<td height=5></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>

		<%=Gui.GroupBoxStart(Translate.Translate("Templates"))%>
		<table cellpadding=2 cellspacing=0 border=0>
			<tr>
				<td width=170><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Liste"))%></td>
				<td><%=Gui.FileManager(prop.Value("ImageGallery_ListTemplate"), "Templates/ImageGallery", "ImageGallery_ListTemplate")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Liste element"))%></td>
				<td><%=Gui.FileManager(prop.Value("ImageGallery_ListElementTemplate"), "Templates/ImageGallery", "ImageGallery_ListElementTemplate")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Vis element"))%></td>
				<td><%=Gui.FileManager(prop.Value("ImageGallery_ElementTemplate"), "Templates/ImageGallery", "ImageGallery_ElementTemplate")%></td>
			</tr>
			<tr>
				<td>
				</td>
				<td>
					<%=Gui.CheckBox(prop.Value("ImageGallery_NoHtml"), "ImageGallery_NoHtml")%>
					<label for="ImageGallery_NoHtml">
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
					<%=Gui.RadioButton(prop.Value("ImageGallery_SortBy"), "ImageGallery_SortBy", "PictureUpdatedDate")%>&nbsp;<label for="ImageGallery_SortByMediaDBMediaUpdatedDate"><%=Translate.Translate("Dato")%></label><br>
					<%=Gui.RadioButton(prop.Value("ImageGallery_SortBy"), "ImageGallery_SortBy", "PictureName")%>&nbsp;<label for="ImageGallery_SortByMediaDBMediaName"><%=Translate.Translate("Navn")%></label><br>
				</td>
			</tr>
			<tr>
				<td valign=top><%=Translate.Translate("Sortering")%></td>
				<td>
					<%=Gui.RadioButton(prop.Value("ImageGallery_SortOrder"), "ImageGallery_SortOrder", "DESC")%>&nbsp;<label for="ImageGallery_SortOrderDESC"><%=Translate.Translate("Faldende")%></label><br>
					<%=Gui.RadioButton(prop.Value("ImageGallery_SortOrder"), "ImageGallery_SortOrder", "ASC")%>&nbsp;<label for="ImageGallery_SortOrderASC"><%=Translate.Translate("Stigende")%></label><br>
				</td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>

		<%=Gui.GroupBoxStart(Translate.Translate("Mappe"))%>
		<table cellpadding=2 cellspacing=0>
			<tr>
				<td valign=top width=170><%=Translate.Translate("Mappe")%></td>
				<td><%=Gui.FolderManager(prop.Value("ImageGallery_PictureFolder"), "ImageGallery_PictureFolder")%></td>
			</tr>
			<tr>
				<td width="170" valign=top><%=Translate.Translate("Besked ved tom mappe")%></td>
				<td><input type="Text" class="std" maxlength="250" name="ImageGallery_ListTextNoImages" value="<%=prop.Value("ImageGallery_ListTextNoImages")%>"></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
	</td>
</tr>

<%
	Translate.GetEditOnlineScript()
%>