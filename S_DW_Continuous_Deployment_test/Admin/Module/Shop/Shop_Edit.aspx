<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
'**************************************************************************************************
'	Current version:	1.1
'	Created:			08-01-2002
'	Last modfied:		12-02-2002
'
'	Purpose: File to edit Shop paragraphs
'
'	Revision history:
'		1.0 - 06-12-2001 - Nicolai
'		First version.
'**************************************************************************************************
Dim ParagraphID As integer
Dim ParagraphModuleSettings As String


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
        prop.Value("ShopParagraphShowProductNumber") = "1"
        prop.Value("ShopParagraphShowProductImageSmall") = "1"
        prop.Value("ShopParagraphShowProductDescription") = "None"
        prop.Value("ShopParagraphShowXCharacters") = 150
        prop.Value("ShopParagraphShowPageSize") = 20
        prop.Value("ShopParagraphSortBy") = "ShopProductSort"
        prop.Value("ShopParagraphSortOrder") = "ASC"
        prop.Value("ShopParagraphShowProductText") = Translate.Translate("Vis mere") & "..."
        prop.Value("ShopParagraphThumbsFolder") = "/" & Dynamicweb.Content.Management.Installation.ImagesFolderName
        prop.Value("ShopParagraphImageFolder") = "/" & Dynamicweb.Content.Management.Installation.ImagesFolderName
        prop.Value("ShopParagraphShowPageSizeForward") = "1"
        prop.Value("ShopParagraphShowPageSizeForwardText") = Translate.Translate("Frem") & "&raquo;"
        prop.Value("ShopParagraphShowPageSizeBack") = "1"
        prop.Value("ShopParagraphShowPageSizeBackText") = "&laquo;" & Translate.Translate("Tilbage")
        prop.Value("ShopParagraphShowCartLink") = "1"
        prop.Value("ShopParagraphShowCartLinkText") = Translate.Translate("Læg i kurv")
        prop.Value("ShopParagraphListTemplate") = "ShowProductListPart.html"
        prop.Value("ShopParagraphProductListTemplate") = "ShowProductList.html"
        prop.Value("ShopParagraphProductTemplate") = "ShowProduct.html"
        prop.Value("ShopParagraphProductSearchTemplate") = "ShowProductSearch.html"
        prop.Value("ShopParagraphProductTemplateCustomFieldList") = "ShopCustomFieldsList.html"
        prop.Value("ShopParagraphProductTemplateCustomFieldListElement") = "ShopCustomFieldsListElement.html"
        prop.Value("ShopParagraphCurrencyPickerList") = "ShowCurrencyPickerList_Char.html"
        prop.Value("ShopParagraphCurrencyPickerListElement") = "ShowCurrencyPickerListElement_Char.html"
    End If

%>
<input type="Hidden" name="Shop_settings" value="ShopParagraphProductListTemplate, ShopParagraphProductSearchTemplate, ShopParagraphProducts, ShopParagraphColoumns, ShopParagraphShowPageSize, ShopParagraphShowPageSizeBack, ShopParagraphShowPageSizeBackText, ShopParagraphShowPageSizeBackPicture, ShopParagraphShowPageSizeForwardPicture, ShopParagraphShowPageSizeForwardText, ShopParagraphShowPageSizeForward, ShopParagraphShowProduct, ShopParagraphListTemplate, ShopParagraphShowProductPicture, ShopParagraphShowGroupByGroup, ShopParagraphShowProductText, ShopParagraphGroups, ShopParagraphShowProductNumber, ShopParagraphShowProductImageSmall, ShopParagraphShowProductDescription, ShopParagraphShowXCharacters, ShopParagraphSortBy, ShopParagraphSortOrder, ShopParagraphThumbsFolder, ShopParagraphProductTemplate, ShopParagraphImageFolder, ShopParagraphShowCartLink, ShopParagraphShowCartLinkPicture, ShopParagraphShowCartLinkText, ShopParagraphProductTemplateCustomFieldList, ShopParagraphProductTemplateCustomFieldListElement, ShopParagraphCurrencyCharacter, ShopParagraphCurrencyPickerList, ShopParagraphCurrencyPickerListElement, ShopParagraphHideCustomFields, ShopParagraphShowAll, ShopParagraphProductSearchSelectedOnly, ShopParagraphImageExtension, ShopParagraphDropColoumnSpace, ShopParagraphFixMissingTD">
<TR>
	<TD>
		<%=Gui.MakeModuleHeader("shop", "Varekatalog")%>
	</TD>
</TR>
<tr>
	<td>
		<%=Gui.GroupBoxStart(Translate.Translate("Vareliste"))%>
		<table cellpadding=2 cellspacing=0 border=0>
			<tr>
				<td  valign="top" width=170><%=Translate.Translate("Kolonner")%></td>
				<td><%=Gui.SpacListExt(prop.Value("ShopParagraphColoumns"), "ShopParagraphColoumns", 1, 5, 1, "")%></td>
			</tr>
			<tr>
				<td></td>
				<td><%=Gui.CheckBox(prop.Value("ShopParagraphDropColoumnSpace"), "ShopParagraphDropColoumnSpace")%><label for="ShopParagraphDropColoumnSpace"><%=Translate.Translate("Ingen kolonnemellemrum")%></label><br /></td>
			</tr>
			<tr>
			    <td></td>
			    <td><%=Gui.CheckBox(prop.Value("ShopParagraphFixMissingTD"), "ShopParagraphFixMissingTD") %><label for="ShopParagraphFixMissingTD"><%=Translate.Translate("Fix manglende %%", "%%", "&lt;td&gt;&lt;/td&gt;")%></label></td>
			</tr>
			<tr>
				<td height=5></td>
			</tr>
			<tr>
				<td  valign="top"></td>
				<td>
					<%=Gui.CheckBox(prop.Value("ShopParagraphShowProductNumber"), "ShopParagraphShowProductNumber")%><label for="ShopParagraphShowProductNumber"><%=Translate.Translate("Vis varenummer")%></label><br>
					<%=Gui.CheckBox(prop.Value("ShopParagraphShowProductImageSmall"), "ShopParagraphShowProductImageSmall")%><label for="ShopParagraphShowProductImageSmall"><%=Translate.Translate("Vis lille billede")%></label><br>
					<%=Gui.CheckBox(prop.Value("ShopParagraphHideCustomFields"), "ShopParagraphHideCustomFields")%><label for="ShopParagraphHideCustomFields"><%=Translate.Translate("Skjul generelle felter og produktfelt grupper")%></label><br>
				</td>
			</tr>
			<tr>
				<td height=5></td>
			</tr>
			<tr>
				<td  valign="top"><%=Translate.Translate("Beskrivelse")%></td>
				<td>	
					<%=Gui.RadioButton(prop.Value("ShopParagraphShowProductDescription"), "ShopParagraphShowProductDescription", "None")%>&nbsp;<label for="ShopParagraphShowProductDescriptionNone"><%=Translate.Translate("Ingen beskrivelse")%></label><br>
					<%=Gui.RadioButton(prop.Value("ShopParagraphShowProductDescription"), "ShopParagraphShowProductDescription", "FirstXChars")%>&nbsp;<label for="ShopParagraphShowProductDescriptionFirstXChars"><%=Translate.Translate("Vis de første %% tegn", "%%", "<input type='text' name='ShopParagraphShowXCharacters' size='4' maxlength='255' class='std' value='" & prop.Value("ShopParagraphShowXCharacters") & "' style='width:35px;'>")%></label>
<br>
				</td>
			</tr>
			<tr>
				<td height=5></td>
			</tr>
			<tr>
				<td width="170"><%=Translate.Translate("Billed mappe")%></td>
				<td><%=Gui.FolderManager(prop.Value("ShopParagraphThumbsFolder"), "ShopParagraphThumbsFolder")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Varenummer extension, billeder")%></td>
				<td><input type="text" name="ShopParagraphImageExtension" maxlength="255" class="std" value="<%=prop.Value("ShopParagraphImageExtension")%>"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Liste"))%></td>
				<td><%=Gui.FileManager(prop.Value("ShopParagraphProductListTemplate"), "Templates/Shop", "ShopParagraphProductListTemplate")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Vare"))%></td>
				<td><%=Gui.FileManager(prop.Value("ShopParagraphListTemplate"), "Templates/Shop", "ShopParagraphListTemplate")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Søg"))%></td>
				<td><%=Gui.FileManager(prop.Value("ShopParagraphProductSearchTemplate"), "Templates/Shop", "ShopParagraphProductSearchTemplate")%></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
	</td>
</tr>
<tr>
	<td colspan=2>
		<%=Gui.GroupBoxStart(Translate.Translate("Sideopdeling"))%>
		<table cellpadding=2 cellspacing=0>
			<tr>
				<td  valign="top" width=170><%=Translate.Translate("Varer pr. side")%></td>
				<td><%=Gui.SpacListExt(prop.Value("ShopParagraphShowPageSize"), "ShopParagraphShowPageSize", 1, 200, 1, "")%></td>
			</tr>
			<tr>
				<td width="170" valign=top><%=Translate.Translate("%% knap", "%%", "<em>" & Translate.Translate("Frem") & "</em>" )%></td>
				<td valign=top><%=Gui.ButtonText("ShopParagraphShowPageSizeForward", prop.Value("ShopParagraphShowPageSizeForward"), prop.Value("ShopParagraphShowPageSizeForwardPicture"), prop.Value("ShopParagraphShowPageSizeForwardText"))%></td>
			</tr>
			<tr>
				<td height=5></td>
			</tr>
			<tr>
				<td width="170" valign=top><%=Translate.Translate("%% knap", "%%", "<em>" & Translate.Translate("Tilbage") & "</em>" )%></td>
				<td valign=top><%=Gui.ButtonText("ShopParagraphShowPageSizeBack", prop.Value("ShopParagraphShowPageSizeBack"), prop.Value("ShopParagraphShowPageSizeBackPicture"), prop.Value("ShopParagraphShowPageSizeBackText"))%></td>
			</tr>
			<tr>
				<td height=5></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
	</td>
</tr>
<tr>
	<td colspan=2>
		<%=Gui.GroupBoxStart(Translate.Translate("Sortering"))%>
		<table cellpadding=2 cellspacing=0>
			<tr>
				<td valign=top width=170><%=Translate.Translate("Sorter efter")%></td>
				<td>
					<%=Gui.RadioButton(prop.Value("ShopParagraphSortBy"), "ShopParagraphSortBy", "ShopProductSort")%>&nbsp;<label for="ShopParagraphSortByShopProductSort"><%=Translate.Translate("Sortering")%></label><br>
					<%=Gui.RadioButton(prop.Value("ShopParagraphSortBy"), "ShopParagraphSortBy", "ShopProductNumber")%>&nbsp;<label for="ShopParagraphSortByShopProductNumber"><%=Translate.Translate("Varenummer")%></label><br>
					<%=Gui.RadioButton(prop.Value("ShopParagraphSortBy"), "ShopParagraphSortBy", "ShopProductName")%>&nbsp;<label for="ShopParagraphSortByShopProductName"><%=Translate.Translate("Varenavn")%></label><br>
					<%=Gui.RadioButton(prop.Value("ShopParagraphSortBy"), "ShopParagraphSortBy", "ShopProductPrice1")%>&nbsp;<label for="ShopParagraphSortByShopProductPrice1"><%=Translate.Translate("Pris")%></label><br>
				</td>
			</tr>
			<tr>
				<td valign=top><%=Translate.Translate("Sortering")%></td>
				<td>
					<%=Gui.RadioButton(prop.Value("ShopParagraphSortOrder"), "ShopParagraphSortOrder", "ASC")%>&nbsp;<label for="ShopParagraphSortOrderASC"><%=Translate.Translate("Stigende")%></label><br>
					<%=Gui.RadioButton(prop.Value("ShopParagraphSortOrder"), "ShopParagraphSortOrder", "DESC")%>&nbsp;<label for="ShopParagraphSortOrderDESC"><%=Translate.Translate("Faldende")%></label><br>
				</td>
			</tr>
			<tr>
				<td></td>
				<td><%=Gui.CheckBox(prop.Value("ShopParagraphShowGroupByGroup"), "ShopParagraphShowGroupByGroup")%><label for="ShopParagraphShowGroupByGroup"><%=Translate.Translate("Grupper efter varegruppe")%></label><br></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
	</td>
</tr>
<tr>
	<td colspan=2>
		<%=Gui.GroupBoxStart(Translate.Translate("Varevisning"))%>
		<table cellpadding=2 cellspacing=0>
			<tr>
				<td width="170" valign=top><%=Translate.Translate("Link til vare")%></td>
				<td valign=top><%=Gui.ButtonText("ShopParagraphShowProduct", prop.Value("ShopParagraphShowProduct"), prop.Value("ShopParagraphShowProductPicture"), prop.Value("ShopParagraphShowProductText"))%></td>
			</tr>
			<tr>
				<td height=5></td>
			</tr>
			<tr>
				<td width="170" valign=top><%=Translate.Translate("Link til Læg i kurv")%></td>
				<td valign=top><%=Gui.ButtonText("ShopParagraphShowCartLink", prop.Value("ShopParagraphShowCartLink"), prop.Value("ShopParagraphShowCartLinkPicture"), prop.Value("ShopParagraphShowCartLinkText"))%></td>
			</tr>
			<tr>
				<td width="170"><%=Translate.Translate("Billed mappe")%></td>
				<td><%=Gui.FolderManager(prop.Value("ShopParagraphImageFolder"), "ShopParagraphImageFolder")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Vare template")%></td>
				<td><%=Gui.FileManager(prop.Value("ShopParagraphProductTemplate"), "Templates/Shop", "ShopParagraphProductTemplate")%></td>
			</tr>
		<%If Base.HasVersion("18.5.1.0") Then%>
			<tr>
				<td><%=Translate.Translate("Varefelter liste")%></td>
				<td><%=Gui.FileManager(prop.Value("ShopParagraphProductTemplateCustomFieldList"), "Templates/Shop", "ShopParagraphProductTemplateCustomFieldList")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Varefelter elementer")%></td>
				<td><%=Gui.FileManager(prop.Value("ShopParagraphProductTemplateCustomFieldListElement"), "Templates/Shop", "ShopParagraphProductTemplateCustomFieldListElement")%></td>
			</tr>
		<%End If%>
		</table>
		<%=Gui.GroupBoxEnd%>
	</td>
</tr>
<tr>
	<td colspan=2>
		<%=Gui.GroupBoxStart(Translate.Translate("Varer"))%>
		<table cellpadding=2 cellspacing=0>
			<tr>
				<td valign=top width=170><%=Translate.Translate("Vis")%></td>
				<td>
				<input type=radio name=ShowWhat ID=ShowWhat1 value="Products" <%=IIf(prop.Value("ShopParagraphProducts") <> "", "Checked", "")%> onClick="document.all.ShopParagraphGroupsRow.style.display='none';document.all.ShopParagraphProductsRow.style.display='';"><label for="ShowWhat1"><%=Translate.Translate("Varer")%></label><br>
				<input type=radio name=ShowWhat ID=ShowWhat2 value="Groups" <%=IIf(prop.Value("ShopParagraphProducts") <> "", "", "Checked")%> onClick="document.all.ShopParagraphGroupsRow.style.display='';document.all.ShopParagraphProductsRow.style.display='none';"><label for="ShowWhat2"><%=Translate.Translate("Varegrupper")%></label><br>
				</td>
			</tr>
			<tr ID="ShopParagraphProductsRow" <%=IIf(prop.Value("ShopParagraphProducts") = "", "style=""display:none;""", "")%>>
				<td valign=top><%=Translate.Translate("Varer")%></td>
				<td><%=Gui.ChooseProducts("ShopParagraphProducts", prop.Value("ShopParagraphProducts"), 0)%></td>
			</tr>
			<tr ID="ShopParagraphGroupsRow" <%=IIf(prop.Value("ShopParagraphProducts") = "", "", "style=""display:none;""")%>>
				<td valign=top><%=Translate.Translate("Grupper")%></td>
				<td><%=Gui.ShopGroupList("ShopParagraphGroups", prop.Value("ShopParagraphGroups"), True, 10)%></td>
			</tr>
			<% If Base.HasVersion("18.8.1.0") Then %>
				<tr>
					<td></td>
					<td><%=Gui.CheckBox(prop.Value("ShopParagraphShowAll"), "ShopParagraphShowAll")%><label for="ShopParagraphShowAll"><%=Translate.Translate("Vis ikke varer inden søgning")%></label><br></td>
				</tr>
				<tr>
					<td></td>
					<td><%=Gui.CheckBox(prop.Value("ShopParagraphProductSearchSelectedOnly"), "ShopParagraphProductSearchSelectedOnly")%><label for="ShopParagraphProductSearchSelectedOnly"><%=Translate.Translate("Søg kun i valgte grupper")%></label><br></td>
				</tr>
			<% End If %>
		</table>
		<%=Gui.GroupBoxEnd%>
	</td>
</tr>
<%If Base.HasVersion("18.5.1.0") Then%>
<tr>
	<td colspan=2>
		<%=Gui.GroupBoxStart(Translate.Translate("Valuta"))%>
		<table cellpadding=2 cellspacing=0>
			<tr>
				<td width=170><%=Translate.Translate("Valuta")%></td>
				<td><%=Gui.CurrencyList(prop.Value("ShopParagraphCurrencyCharacter"), "ShopParagraphCurrencyCharacter")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Valuta liste"))%></td>
				<td><%=Gui.FileManager(prop.Value("ShopParagraphCurrencyPickerList"), "Templates/Shop", "ShopParagraphCurrencyPickerList")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Valuta element"))%></td>
				<td><%=Gui.FileManager(prop.Value("ShopParagraphCurrencyPickerListElement"), "Templates/Shop", "ShopParagraphCurrencyPickerListElement")%></td>
			</tr>	
		</table>
		<%=Gui.GroupBoxEnd%>
	</td>
</tr>
<%End If%>

<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>