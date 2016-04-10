<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" Codebehind="DealerSearch_Edit.aspx.vb" Inherits="Dynamicweb.Admin.DealerSearch.Backend.DealerSearch_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<input type="hidden" name="DealerSearch_Settings" value="SortBy, SortOrder, SearchTemplate, ListTemplate, ListElementTemplate, ElementTemplate, CategoryID1, CategoryID2, presentation, DealerSearchUserListSelect, ListTemplateUserList, ListElementTemplateUserList, ElementTemplateUserList, SortByUserList, SortOrderUserList, ZoomActive, ZoomQuality, ZoomLegend, AnimateDots, DealerSearchShowPage, ZoomShowDealerLabel, ZoomBackLabel">
<script>
	function choosetype(){
		if(document.getElementById("presentationID2").checked)
		{
			document.getElementById("list").style.display = "";
			document.getElementById("picture").style.display = "none";	
			document.getElementById("presentation2_1").style.display = "block";
			document.getElementById("presentation2_2").style.display = "block";
			document.getElementById("presentation2_3").style.display = "block";
			document.getElementById("presentation1").style.display = "block";
			document.getElementById("presentation3").style.display = "none";	
			document.getElementById("ZoomFunctions").style.display = "none";			
			
		}
		else if (document.getElementById("presentationID3").checked)
		{
			document.getElementById("presentation2_1").style.display = "none";
			document.getElementById("presentation2_2").style.display = "none";
			document.getElementById("presentation2_3").style.display = "none";
			document.getElementById("presentation1").style.display = "none";
			document.getElementById("presentation3").style.display = "";
			document.getElementById("ZoomFunctions").style.display = "none";		
			
		}
		else
		{
			document.getElementById("ZoomFunctions").style.display = "block";		
			document.getElementById("list").style.display = "none";		
			document.getElementById("picture").style.display = "block";			
			document.getElementById("presentation2_1").style.display = "none";
			document.getElementById("presentation2_2").style.display = "block";
			document.getElementById("presentation2_3").style.display = "none";
			document.getElementById("presentation1").style.display = "";
			document.getElementById("presentation3").style.display = "none";
		}
	}
</script>

	<tr>
		<td>
			<%=Gui.MakeModuleHeader("Nozebra.Isv.DealerSearch", "Forhandlersøgning")%>
		</td>
	</tr>
	<tr>
		<td>
			<%=Gui.GroupBoxStart(Translate.Translate("Visning"))%>
			<table cellpadding="2" cellspacing="0" border="0">
				<tr>
					<td width="170" valign="top"><%=Translate.Translate("Visning")%></td>
					<td>
						<div><input type="radio" id="presentationID1" name="presentation" onclick="choosetype();" value="1" <%=presentation1%>><label for="presentationID1"><%=Translate.Translate("Kort / billede")%></label></div>
						<div><input type="radio" id="presentationID2" name="presentation" onclick="choosetype();" value="2" <%=presentation2%>><label for="presentationID2"><%=Translate.Translate("Liste")%></label></div>
						<div><input type="radio" id="presentationID3" name="presentation" onclick="choosetype();" value="3" <%=presentation3%>><label for="presentationID3"><%=Translate.Translate("Brugerdefineret liste")%></label></div>
					</td>
				</tr>
			</table>
			<%=Gui.GroupBoxEnd%>			
			
			
			<span id="presentation1">
			<%=Gui.GroupBoxStart(Translate.Translate("Kategorier"))%>
			<table cellpadding="2" cellspacing="0" border="0">
				<tr>
					<td width="170" valign="top"><%=Translate.Translate("Medtag følgende kategorier")%></td>
					<td id=list><%=GetCatsAsCheckBoxes()%></td>
					<td id=picture style="display: none;"><%=GetCatsAsRadioButtons()%></td>
				</tr>
			</table>
			<%=Gui.GroupBoxEnd%>
			</span>
			
			<span id="ZoomFunctions">
			<%=Gui.GroupBoxStart(Translate.Translate("Kort funktioner"))%>
			<table cellpadding="2" cellspacing="0" border="0">
				<tr>
					<td width="170" valign="top"><%=Translate.Translate("Aktivér Zoom")%></td>
					<td><%=Gui.CheckBox(Properties.Value("ZoomActive"), "ZoomActive")%>&nbsp;<label for="ZoomActive"><%=Translate.Translate("Ja")%></label></td>
					<td></td>
				</tr>
				<tr>
					<td width="170" valign="top"><%=Translate.Translate("Vis forhandlere knap")%></td>
					<td><input type="text" class="ZoomShowDealerLabel" id="ZoomShowDealerLabel" name="ZoomShowDealerLabel" value="<%=properties.Value("ZoomShowDealerLabel")%>"></td>
					<td></td>
				</tr>
				<tr>
					<td width="170" valign="top"><%=Translate.Translate("Zoom tilbage knap")%></td>
					<td><input type="text" class="ZoomBackLabel" id="ZoomBackLabel" name="ZoomBackLabel" value="<%=properties.Value("ZoomBackLabel")%>"></td>
					<td></td>
				</tr>				
				<tr>
					<td width="170" valign="top"><%=Translate.Translate("Zoom tilbage i trin")%></td>
					<td><%=Gui.CheckBox(Properties.Value("ZoomLegend"), "ZoomLegend")%>&nbsp;<label for="ZoomLegend"><%=Translate.Translate("Ja")%></label></td>
					<td></td>
				</tr>
				<tr>
					<td width="170" valign="top"><%=Translate.Translate("Flash kvalitet under zoom")%></td>
					<td><%=Gui.CheckBox(Properties.Value("ZoomQuality"), "ZoomQuality")%>&nbsp;<label for="ZoomLegend"><%=Translate.Translate("Lav")%></label></td>
					<td></td>
				</tr>
				<tr>
					<td width="170" valign="top"><%=Translate.Translate("Animer placeringer")%></td>
					<td><%=Gui.CheckBox(Properties.Value("AnimateDots"), "AnimateDots")%>&nbsp;<label for="ZoomLegend"><%=Translate.Translate("Ja")%></label></td>
					<td></td>
				</tr>
				<!-- Not before next version
				<tr>
					<td width="170" valign="top"><%=Translate.Translate("Zoom beskrivelse")%></td>
					<td><input type="text" class="ZoomDescription" id="ZoomDescription" name="ZoomDescription" value="<%=properties.Value("ZoomDescription")%>"></td>
					<td></td>
				</tr>
				-->
			</table>
			<%=Gui.GroupBoxEnd%>
			</span>
			
			<span id="presentation3">
			<%=Gui.GroupBoxStart(Translate.Translate("Kategorier"))%>
			<table cellpadding="2" cellspacing="0" border="0">
				<tr>
					<td width="170" valign="top"><%=Translate.Translate("Medtag følgende kategorier / forhandlere")%></td>
					<td>
						<select multiple class="std" id="DealerSearchUserListSelect" name="DealerSearchUserListSelect" style="height: 150px" >
						<%=makeDealerCategoryList%>
						</select>
					</td>
					<td></td>
				</tr>
			</table>
			<%=Gui.GroupBoxEnd%>
			<%=Gui.GroupBoxStart(Translate.Translate("Templates"))%>
			<table cellpadding="2" cellspacing="0" border="0">
				<tr>
					<td width="170"><%=Translate.Translate("Liste")%></td>
					<td><%=Gui.FileManager(Properties.Value("ListTemplateUserList"), "Templates/Dealersearch", "ListTemplateUserList", "htm,html")%></td>
				</tr>
				<tr>
					<td><%=Translate.Translate("Liste element")%></td>
					<td><%=Gui.FileManager(Properties.Value("ListElementTemplateUserList"), "Templates/Dealersearch", "ListElementTemplateUserList", "htm,html")%></td>
				</tr>
				<tr>
					<td><%=Translate.Translate("Vis element")%></td>
					<td><%=Gui.FileManager(Properties.Value("ElementTemplateUserList"), "Templates/Dealersearch", "ElementTemplateUserList", "htm,html")%></td>
				</tr>
			</table>
			<%=Gui.GroupBoxEnd%>
			<%=Gui.GroupBoxStart(Translate.Translate("Sortering"))%>
			<table cellpadding="2" cellspacing="0" border="0">
				<tr>
					<td width="170" valign="top"><%=Translate.Translate("Sorter efter")%></td>
					<td>
						<%=Gui.RadioButton(Properties.Value("SortByUserList"), "SortByUserList", "DealerSearchDealerName")%>&nbsp;<label for="SortByDealerSearchDealerNameUserList"><%=Translate.Translate("Navn")%></label><br>
						<%=Gui.RadioButton(Properties.Value("SortByUserList"), "SortByUserList", "DealerSearchDealerAdress")%>&nbsp;<label for="SortByDealerSearchDealerAdressUserList"><%=Translate.Translate("Adresse")%></label><br>
						<%=Gui.RadioButton(Properties.Value("SortByUserList"), "SortByUserList", "DealerSearchDealerZip")%>&nbsp;<label for="SortByDealerSearchDealerZipUserList"><%=Translate.Translate("Postnummer")%></label><br>
						<%=Gui.RadioButton(Properties.Value("SortByUserList"), "SortByUserList", "DealerSearchDealerCity")%>&nbsp;<label for="SortByDealerSearchDealerCityUserList"><%=Translate.Translate("By")%></label><br>
						<%=Gui.RadioButton(Properties.Value("SortByUserList"), "SortByUserList", "DealerSearchDealerCountry")%>&nbsp;<label for="SortByDealerSearchDealerCountryUserList"><%=Translate.Translate("Land")%></label>
					</td>
				</tr>
				<tr>
					<td valign="top"><%=Translate.Translate("Sortering")%></td>
					<td>
						<%=Gui.RadioButton(Properties.Value("SortOrderUserList"), "SortOrderUserList", "ASC")%>&nbsp;<label for="SortOrderASC"><%=Translate.Translate("Stigende")%></label><br>
						<%=Gui.RadioButton(Properties.Value("SortOrderUserList"), "SortOrderUserList", "DESC")%>&nbsp;<label for="SortOrderDESC"><%=Translate.Translate("Faldende")%></label>
					</td>
				</tr>
			</table>
			<%=Gui.GroupBoxEnd%>		
			</span>
			
			<span id="presentation2_1">
			
			<%=Gui.GroupBoxStart(Translate.Translate("Templates"))%>
			<table cellpadding="2" cellspacing="0" border="0">
				<tr>
					<td width="170"><%=Translate.Translate("Søg")%></td>
					<td><%=Gui.FileManager(Properties.Value("SearchTemplate"), "Templates/Dealersearch", "SearchTemplate", "htm,html")%></td>
				</tr>
				<tr>
					<td><%=Translate.Translate("Liste")%></td>
					<td><%=Gui.FileManager(Properties.Value("ListTemplate"), "Templates/Dealersearch", "ListTemplate", "htm,html")%></td>
				</tr>
				<tr>
					<td><%=Translate.Translate("Liste element")%></td>
					<td><%=Gui.FileManager(Properties.Value("ListElementTemplate"), "Templates/Dealersearch", "ListElementTemplate", "htm,html")%></td>
				</tr>
				<tr>
					<td><%=Translate.Translate("Vis element")%></td>
					<td><%=Gui.FileManager(Properties.Value("ElementTemplate"), "Templates/Dealersearch", "ElementTemplate", "htm,html")%></td>
				</tr>
				
			</table>
			
			
			
			<%=Gui.GroupBoxEnd%>
			</span>
			<span id="presentation2_2">
			
			<%=Gui.GroupBoxStart(Translate.Translate("Visning"))%>
			<table cellpadding="2" cellspacing="0" border="0">
				<tr>
					<td width="170"><%=Translate.Translate("Visningsside")%></td>
					<td><%=Dynamicweb.Gui.LinkManager(Properties.Value("DealerSearchShowPage"), "DealerSearchShowPage", "_top")%><br /></td>
				</tr>
			</table>
			
			<%=Gui.GroupBoxEnd%>
			</span>
			<span id="presentation2_3">
			
			<%=Gui.GroupBoxStart(Translate.Translate("Sortering"))%>
			<table cellpadding="2" cellspacing="0" border="0">
				<tr>
					<td width="170" valign="top"><%=Translate.Translate("Sorter efter")%></td>
					<td>
						<%=Gui.RadioButton(Properties.Value("SortBy"), "SortBy", "DealerSearchDealerName")%>&nbsp;<label for="SortByDealerSearchDealerName"><%=Translate.Translate("Navn")%></label><br>
						<%=Gui.RadioButton(Properties.Value("SortBy"), "SortBy", "DealerSearchDealerAdress")%>&nbsp;<label for="SortByDealerSearchDealerAdress"><%=Translate.Translate("Adresse")%></label><br>
						<%=Gui.RadioButton(Properties.Value("SortBy"), "SortBy", "DealerSearchDealerZip")%>&nbsp;<label for="SortByDealerSearchDealerZip"><%=Translate.Translate("Postnummer")%></label><br>
						<%=Gui.RadioButton(Properties.Value("SortBy"), "SortBy", "DealerSearchDealerCity")%>&nbsp;<label for="SortByDealerSearchDealerCity"><%=Translate.Translate("By")%></label><br>
						<%=Gui.RadioButton(Properties.Value("SortBy"), "SortBy", "DealerSearchDealerCountry")%>&nbsp;<label for="SortByDealerSearchDealerCountry"><%=Translate.Translate("Land")%></label>
					</td>
				</tr>
				<tr>
					<td valign="top"><%=Translate.Translate("Sortering")%></td>
					<td>
						<%=Gui.RadioButton(Properties.Value("SortOrder"), "SortOrder", "ASC")%>&nbsp;<label for="SortOrderASC"><%=Translate.Translate("Stigende")%></label><br>
						<%=Gui.RadioButton(Properties.Value("SortOrder"), "SortOrder", "DESC")%>&nbsp;<label for="SortOrderDESC"><%=Translate.Translate("Faldende")%></label>
					</td>
				</tr>
			</table>
			<%=Gui.GroupBoxEnd%>
			</span>
		</td>
	</tr>

<script>
	choosetype();
</script>
<%
Translate.GetEditOnlineScript()
%>



