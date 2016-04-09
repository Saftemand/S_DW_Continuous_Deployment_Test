<%@ Page Language="vb" ValidateRequest="false" AutoEventWireup="false" Codebehind="RSSFeed_Edit.aspx.vb" Inherits="Dynamicweb.Admin.RSSFeed_Edit" %>

<%@ Import Namespace="Dynamicweb.Modules.NewsV2" %>

<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<script type="text/javascript" language="JavaScript" src="/Admin/Module/eCom_Catalog/dw7/images/functions.js"></script>
<script type="text/javascript" src="/Admin/Module/eCom_Catalog/dw7/images/AjaxAddInParameters.js"></script>

<script language="javascript" type="text/javascript">

function ShowHideTypeSettings(ListID)
{
    var pages = {
        RSSTypePage: "none",
        RSSTypeNews: "none",
        RSSTypeCalendar: "none",
        RSSTypeProduct: "none",
        RSSTypeEmployee: "none",
        RSSTypeWeblog: "none",
        RSSTypeForumV2: "none",
        RSSTypeeCommerce: "none"
    };
    
    pages["RSSType" + ListID] = "";
	
	for(var page in pages) {
	    document.getElementById(page).style.display = pages[page]
	}
}
function ShowHideContent(ListID)
{
	if(ListID == "RSSExternal")
	{
		document.all.RSSExternal.style.display = "";
		document.all.RSSInternalType.style.display = "none";
		document.all.RSSInternalSettings.style.display = "none";
		document.getElementById('rowFeedName').style.display = 'none';
	}
	else
	{
		document.all.RSSExternal.style.display = "none";
		document.all.RSSInternalType.style.display = "";
		document.all.RSSInternalSettings.style.display = "";
		document.getElementById('rowFeedName').style.display = '';
	}
}

function AddGroups() {
	var selected = 'opener.document.paragraph_edit.GroupsTmp.value';
	var caller = 'opener.document.paragraph_edit.Groups';
	//window.open("/Admin/Module/eCom_Catalog/Lists/EcomGroupTree.aspx?CMD=ShowGroupRel&SetLanguageID=<%=langId%>&grpArray="+ grpArray +"&caller="+ caller,"","displayWindow,width=460,height=400,scrollbars=no");
	window.open("/Admin/Module/eCom_Catalog/dw7/Lists/EcomGroupSelector.aspx?CMD=GetGroupRel&SetLanguageID=<%=langId%>&selectedGroupsContainer=" + selected + "&caller=" + caller + "&setGroups=True", "", "displayWindow,width=460,height=400,scrollbars=no");
}

var fetchArr;
function AddGroupRows() {
	var grpArray = document.paragraph_edit.Groups.value;
	var setArr = grpArray;

	setArr = replaceSubstring(setArr, "[", "")
	setArr = replaceSubstring(setArr, "];", ",")
	setArr = replaceSubstring(setArr, "]", "")
	setArr = replaceSubstring(setArr, " ", "")
	setArr = replaceSubstring(setArr, ";", ",")
	document.paragraph_edit.Groups.value = setArr;		
	
	fetchArr = grpArray;
	fetchGroups();
}

function fetchGroups() {
    var paragraphId = "<%=paragraphID%>";
    var pageId = "<%=pageID%>";
    var groupFetch = fetchArr;

    if (paragraphId != "" && pageId != "" && groupFetch != "") {
        getProductGroupsForParagraph(paragraphId, pageId, groupFetch);
    }
}	
	
function RemoveGroups(grpID) {
	try {
		var objIndex = document.getElementById('gRow'+ grpID).rowIndex;
		document.getElementById('DWEcomEditGroups').deleteRow(objIndex);
	} catch(e) {
		//Nothing
	}		
	
	var stdList = document.paragraph_edit.Groups.value;
	stdList = replaceSubstring(stdList, "" + grpID + ",", "");
	stdList = replaceSubstring(stdList, "," + grpID + "", "");
	stdList = replaceSubstring(stdList, "" + grpID + "", "");
	document.paragraph_edit.Groups.value = stdList;

	var tmpList = document.paragraph_edit.GroupsTmp.value;
	tmpList = replaceSubstring(tmpList, "[" + grpID + "];", "");
	tmpList = replaceSubstring(tmpList, ";[" + grpID + "]", "");
	tmpList = replaceSubstring(tmpList, "[" + grpID + "]", "");
	document.paragraph_edit.GroupsTmp.value = tmpList;
}
</script>

<input type="Hidden" name="RSSFeed_Settings" 
value="NewsShowMode, RSSFeedLink, RSSFeedTarget, RSSExtFeedName, RSSFeedNamedTarget, RSSFeedPageTemplate, RSSFeedItemTemplate, RSSFeedShow, RSSFeedShowMax, RSSFeedCache, RSSFeedCacheTime, 
	  , RSSExtContent, RSSExtType, RSSExtShowMax, RSSExtDesc, RSSExtItemDesc, RSSExtImage, RSSExtCprDesc, RSSExtCacheTime, RSSExtMasterTemplate, RSSExtItemTemplate, 
  	  , Searchv1Area, Searchv1AreaID, Searchv1PageID, Searchv1News, Searchv1NewsCategoryID, Searchv1NewsPageID, Searchv1Calender, Searchv1CalenderCategoryID, Searchv1CalenderPageID, Searchv1Shop, Searchv1ShopProductGroupID, Searchv1ShopPageID, RSSFeedRemoveM,
  	  , Searchv1Employee, Searchv1EmployeeDepartmentID, Searchv1EmployeePageID, Searchv1Weblog, Searchv1WeblogBlogID, Searchv1WeblogPageID,
  	  , Searchv1ForumV2, Searchv1ForumV2CategoryID, Searchv1ForumV2PageID, Searchv1eCommerce, Searchv1eCommercePageID, Groups, Searchv1PageUseChilds, NewsOrderBy, NewsParagraphSortOrder">
<%=Gui.MakeModuleHeader(Translate.translate("RSS"), Translate.translate("RSS"))%>
<tr>
	<td colspan="2">
		<table border="0" width="598" cellpadding="0" cellspacing="0">
  			<tr>
  				<td>
 				  <%=Gui.GroupBoxStart(Translate.Translate("Indhold"))%>
  				 <table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="170"></td>
        				<td><input type="radio" name="RSSExtContent" id="RSSExtContent1" value="RSSExternal"<%If prop.Value("RSSExtContent") = "RSSExternal" Then%> checked <%End If%> onClick="ShowHideContent(this.value);"><label for="RSSExtContent1"><%=Translate.Translate("Publicer eksternt RSS feed")%></label></td>
        			</tr>
        			<tr>
        				<td></td>
        				<td><input type="radio" name="RSSExtContent" id="RSSExtContent2" value="RSSInternal"<%If prop.Value("RSSExtContent") = "RSSInternal" Then%> checked <%End If%> onClick="ShowHideContent(this.value);"><label for="RSSExtContent2"><%=Translate.Translate("Publicer indhold til RSS feed")%></label></td>
        			</tr>
        			</table>
				  <%=Gui.GroupBoxEnd%>
        		  
				</td>
			</tr>
			
			<tr ID="RSSExternal" <%=Base.IIf(prop.Value("RSSExtContent") <> "RSSExternal", "style=""display:none;""", "")%>>
				<td>
				<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
					<table border="0" cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<br>

							<td valign="top"><%=Translate.Translate("RSS feed link")%></td>
							<td><input type="Text" name="RSSFeedLink" value="<%=prop.Value("RSSFeedLink")%>"   class="std" style="width:360px"><br><br></td>
						</tr>
						<tr>
							<td valign="top" width="170"><%=Translate.Translate("Links skal åbnes")%></td>
							<td>
							<%=Gui.RadioButton(prop.Value("RSSFeedTarget"), "RSSFeedTarget", "_blank")%>&nbsp;<%=Translate.Translate("I nyt vindue")%><br>
							<%=Gui.RadioButton(prop.Value("RSSFeedTarget"), "RSSFeedTarget", "_self")%>&nbsp;<%=Translate.Translate("I samme vindue")%><br>
							<%=Gui.RadioButton(prop.Value("RSSFeedTarget"), "RSSFeedTarget", "_parent")%>&nbsp;<%=Translate.Translate("I det umiddelbart ovenstående frameset")%><br>
							<%=Gui.RadioButton(prop.Value("RSSFeedTarget"), "RSSFeedTarget", "_top")%>&nbsp;<%=Translate.Translate("I samme vindue (_top)")%><br>
							<%=Gui.RadioButton(prop.Value("RSSFeedTarget"), "RSSFeedTarget", "named")%>&nbsp;<%=Translate.Translate("I dette vindue")%>&nbsp;<input type="Text" name="RSSFeedNamedTarget" value="<%=prop.Value("RSSFeedNamedTarget")%>" maxlength="255" class="std"><br><br>
							</td>
						</tr>
						<tr>
							<td valign="top" width="170"><%=Translate.Translate("Template til sidelayout")%></td>
							<td><%=Gui.FileManager(prop.Value("RSSFeedPageTemplate"), "Templates/RSSFeed", "RSSFeedPageTemplate")%><br><br></td>
						</tr>
						<tr>
							<td valign="top" width="170"><%=Translate.Translate("Template til emnelayout")%></td>
							<td><%=Gui.FileManager(prop.Value("RSSFeedItemTemplate"), "Templates/RSSFeed", "RSSFeedItemTemplate")%><br><br></td>
						</tr>
						<tr>
							<td valign="top" width="170"><%=Translate.Translate("Vis")%></td>
							<td>
							<%=Gui.RadioButton(prop.Value("RSSFeedShow"), "RSSFeedShow", "0")%>&nbsp;<%=Translate.Translate("Alle nyhedsemner")%><br>
							<%=Gui.RadioButton(prop.Value("RSSFeedShow"), "RSSFeedShow", "1")%>&nbsp;<%=Translate.Translate("Maksimalt de øverste")%>&nbsp;<input type="Text" name="RSSFeedShowMax" value="<%=prop.Value("RSSFeedShowMax")%>" maxlength="255" class="std" style="width:30px">&nbsp;<%=Translate.Translate("nyhedsemner")%><br><br>
							</td>
						</tr>
						<tr>
							<td valign="top" width="170"><%=Translate.Translate("Indholdet skal")%></td>
							<td>
							<%=Gui.RadioButton(prop.Value("RSSFeedCache"), "RSSFeedCache", "0")%>&nbsp;<%=Translate.Translate("Aldrig caches (længere ventetid og større serverbelastning!)")%><br>
							<%=Gui.RadioButton(prop.Value("RSSFeedCache"), "RSSFeedCache", "1")%>&nbsp;<%=Translate.Translate("Caches i")%>&nbsp;<input type="Text" name="RSSFeedCacheTime" value="<%=prop.Value("RSSFeedCacheTime")%>" maxlength="255" class="std" style="width:30px">&nbsp;<%=Translate.Translate("minutter")%><br><br>
							</td>
						</tr>
					</table>
				<%=Gui.GroupBoxEnd%>
				</td>
			</tr>
			
			<tr id="RSSInternalType" <%=Base.IIf(prop.Value("RSSExtContent") <> "RSSInternal", "style=""display:none;""", "")%>>
				<td>
				<%=Gui.GroupBoxStart(Translate.Translate("Indhold"))%>
				 <table border="0" cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<td width="170"></td>
        					<td><nobr>
        					    <input type="radio" name="RSSExtType" id="RSSExtType1" value="Page"<%If prop.Value("RSSExtType") = "Page" Then%> checked <%End If%> onClick="ShowHideTypeSettings(this.value);">
        					    <label for="RSSExtType1"><%=Translate.Translate("Sider")%></label>
        					</nobr></td>
        					</tr>
						<tr>
							<td width="170"></td>
        					<td><nobr>
        					    <input type="radio" name="RSSExtType" id="RSSExtType2" value="News"<%If prop.Value("RSSExtType") = "News" Then%> checked <%End If%> onClick="ShowHideTypeSettings(this.value);" <% if not Base.HasAccess("News", "") andalso not Base.HasAccess("NewsV2", "") then%> disabled="disabled"  <%end if %>>
        					    <label for="RSSExtType2"><%=Translate.Translate("Nyheder")%></label>
        					</nobr></td>
        					</tr>
						<tr>
							<td width="170"></td>
        					<td><nobr>
        					    <input type="radio" name="RSSExtType" id="RSSExtType3" value="Calendar"<%If prop.Value("RSSExtType") = "Calendar" Then%> checked <%End If%> onClick="ShowHideTypeSettings(this.value);" <% if not Base.HasAccess("Calender", "") andalso not Base.HasAccess("Calendar", "") then%> disabled="disabled"  <%end if %>>
        					    <label for="RSSExtType3"><%=Translate.Translate("Begivenheder")%></label>
        					</nobr></td>
        					</tr>
						<tr>
							<td width="170"></td>
        					<td><nobr>
        					    <input type="radio" name="RSSExtType" id="RSSExtType4" value="Product"<%If prop.Value("RSSExtType") = "Product" Then%> checked <%End If%> onClick="ShowHideTypeSettings(this.value);" <% if not Base.HasAccess("Shop", "") then%> disabled="disabled"  <%end if %>>
        					    <label for="RSSExtType4"><%=Translate.Translate("Produkter")%></label>
        					</nobr></td>
        				</tr>
        				<tr>
        				<td width="170"></td>
        					<td><nobr>
        					    <input type="radio" name="RSSExtType" id="RSSExtType5" value="Employee"<%If prop.Value("RSSExtType") = "Employee" Then%> checked <%End If%> onClick="ShowHideTypeSettings(this.value);" <% if not Base.HasAccess("Employee", "") then%> disabled="disabled"  <%end if %>>
        					    <label for="RSSExtType5"><%=Translate.Translate("Employees")%></label>
        					</nobr></td>
        					</tr>
						<tr>
							<td width="170"></td>
        					<td><nobr>
        					    <input type="radio" name="RSSExtType" id="RSSExtType6" value="Weblog"<%If prop.Value("RSSExtType") = "Weblog" Then%> checked <%End If%> onClick="ShowHideTypeSettings(this.value);" <% if not Base.HasAccess("Weblog", "") then%> disabled="disabled"  <%end if %>>
        					    <label for="RSSExtType6"><%=Translate.Translate("Weblog")%></label>
        					</nobr></td>
        					</tr>
						<tr>
							<td width="170"></td>
        					<td><nobr>
        					    <input type="radio" name="RSSExtType" id="RSSExtType7" value="ForumV2"<%If prop.Value("RSSExtType") = "ForumV2" Then%> checked <%End If%> onClick="ShowHideTypeSettings(this.value);" <% if not Base.HasAccess("ForumV2", "") then%> disabled="disabled"  <%end if %>>
        					    <label for="RSSExtType7"><%=Translate.Translate("ForumV2")%></label>
        					</nobr></td>
        					</tr>
						<tr>
							<td width="170"></td>
        					<td><nobr>
        					    <input type="radio" name="RSSExtType" id="RSSExtType8" value="eCommerce"<%If prop.Value("RSSExtType") = "eCommerce" Then%> checked <%End If%> onClick="ShowHideTypeSettings(this.value);" <% if Base.HasAccess("eCom_NotInstalled", "") then%> disabled="disabled"  <%end if %>>  
        					    <label for="RSSExtType8"><%=Translate.Translate("eCommerce")%></label>
        					</nobr></td>
        				</tr>
				  <%=Gui.GroupBoxEnd%>
        		  </table>
				</td>
			</tr>
		
		
			<tr id="RSSInternalSettings"  <%=Base.IIf(prop.Value("RSSExtContent") <> "RSSInternal", "style=""display:none;""", "")%>>
			  <td>
				<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
				 <table border="0" cellpadding="0" cellspacing="0">
        				<tr>
	    				   <td>
						   <table cellpadding="2" cellspacing="0" border="0">
								<tr id="rowFeedName" <%=Base.IIf(prop.Value("RSSExtContent") = "RSSExternal", "style=""display:none;""", "")%>>
									<td width="170">
										<label for="RSSExtFeedName"><%=Translate.Translate("Navn")%></label>
									</td>
									<td>
										<input type="text" name="RSSExtFeedName" maxlength="255" class="std" value="<%=prop.Value("RSSExtFeedName")%>" />
									</td>
								</tr>
	       						<tr>									
       								<td width="170"><label for="RSSExtShowMax"><%=Translate.Translate("Vis_antal")%></label></td>
        							<td><input type="Text"   name="RSSExtShowMax"  value="<%=prop.Value("RSSExtShowMax")%>" maxlength="255" class="std" style="width:30px"></td>
	       						</tr>
	       						<tr>									
       								<td width="170"><label for="RSSExtDesc"><%=Translate.Translate("Beskrivelse")%></label></td>
        							<td><TEXTAREA id="RSSExtDesc" class="std" name="RSSExtDesc"  ><%=prop.Value("RSSExtDesc")%></TEXTAREA> </td>
	       						</tr>
	       						<tr>									
       								<td width="170"><label for="RSSExtItemDesc"><%=Translate.Translate("Max længde")%></label></td>
        							<td><input type="Text"   name="RSSExtItemDesc"  value="<%=prop.Value("RSSExtItemDesc")%>" maxlength="255" class="std" style="width:30px"></td>
	       						</tr>
	       						<tr>
									<td width="170"><%=Translate.Translate("Billede")%></td>
									<td><%= Gui.FileManager(Prop.Value("RSSExtImage"), Dynamicweb.Content.Management.Installation.ImagesFolderName, "RSSExtImage")%></td>
								</tr>						
	       						<tr>									
	  								<td width="170"><label for="RSSExtCprDesc"><%=Translate.Translate("Copyright")%></label></td>
        							<td><TEXTAREA id="RSSExtCprDesc" class="std" name="RSSExtCprDesc"><%=prop.Value("RSSExtCprDesc")%></TEXTAREA></td>
	       						</tr>
	       						<tr>									
	 								<td width="170"><label for="RSSExtCacheTime"><%=Translate.Translate("Caches_i")%></label></td>
        							<td><input type="Text"   name="RSSExtCacheTime" value="<%=prop.Value("RSSExtCacheTime")%>" maxlength="255" class="std" style="width:30px"></td>
	       						</tr>
							   <tr>
								   <td>
								   </td>
								   <td>
									   <%=Gui.CheckBox(prop.value("RSSFeedRemoveM"), "RSSFeedRemoveM")%>
									   <label for="RSSFeedRemoveM">
										   <%=Translate.translate("Bevar opsætning af afsnit på side")%>
									   </label>
								   </td>
							   </tr>
	       						<tr>
									<td width="170"><%=Translate.Translate("Master template")%></td>
									<td><%=Gui.FileManager(prop.Value("RSSExtMasterTemplate"), "Templates/RSSfeed/RSSList", "RSSExtMasterTemplate")%><br><br></td>
								</tr>
								<tr>
									<td width="170"><%=Translate.Translate("Liste element")%></td>
									<td><%=Gui.FileManager(prop.Value("RSSExtItemTemplate"), "Templates/RSSfeed/RssElement", "RSSExtItemTemplate")%><br><br></td>
								</tr>

							</table>
							</td>		
        				</tr>
        				
						<tr ID="RSSTypePage"  <%=Base.IIf(prop.Value("RSSExtType") <> "Page", "style=""display:none;""", "")%>>
						<%If Base.HasVersion("18.9.1.0") Then%>						
						<td>
									<table cellpadding="2" cellspacing="0" border="0">
										<tr>
											<td width="170"><%=Translate.Translate("")%></td>
											<td><%=Gui.RadioButton(prop.value("Searchv1Area"), "Searchv1Area", "Local")%> 
												<label for="Searchv1AreaLocal"><%=Translate.Translate("Aktuelle sproglag") %></label>
											</td>
										</tr>
										<tr>
											<td></td>
											<td><%=Gui.RadioButton(prop.value("Searchv1Area"), "Searchv1Area", "Global")%> 
												<label for="Searchv1AreaGlobal"><%= Translate.Translate("Alle") %></label>
											</td>
										</tr>
										
										<tr>
											<td></td>
											<td>
												<table cellpadding="0" cellspacing="0" border="0">
													<tr>
														<td colspan="2">
															<%=Gui.RadioButton(Prop("Searchv1Area"), "Searchv1Area", "Specified")%> 
															<label for="Searchv1AreaSpecified"><%= Translate.Translate("Sproglag") %></label>
														</td>
													</tr>
													<tr>
														<td width="20"><img src="/Admin/Images/Nothing.gif" width="20" /></td>
														<td valign=top align=left>
															<%
															    SelectTypePage()
															%>
														</td>
													</tr>
												</table>
												
											</td>
										</tr>
										
										<tr>
											<td></td>
											<td>
												<table cellpadding="0" cellspacing="0" border="0">
													<tr>
														<td colspan="2">
															<%=Gui.RadioButton(prop.value("Searchv1Area"), "Searchv1Area", "Page")%> <label for="Searchv1Area"><%= Translate.Translate("Herfra og ned") %></label>
														</td>
													</tr>
													<tr>
														<td width="20"><img src="/Admin/Images/Nothing.gif" width="20" /></td>
														<td valign=top align=left><%=Gui.LinkManager(prop.value("Searchv1PageID"), "Searchv1PageID", "")%></td>
													</tr>
													<tr>
														<td width="20"><img src="/Admin/Images/Nothing.gif" width="20" /></td>
														<td valign=top align=left>
														    <%=Gui.RadioButton(Prop("Searchv1PageUseChilds"), "Searchv1PageUseChilds", "1")%>&nbsp;<%=Translate.Translate("Show subpages")%><br>
														    <%=Gui.RadioButton(Prop("Searchv1PageUseChilds"), "Searchv1PageUseChilds", "0")%>&nbsp;<%=Translate.Translate("Hide subpages")%><br>
														</td>
													</tr>
												</table>									
											</td>
										</tr>
									</table>
									
						</td>
						<%End If%>
						</tr>
						

						<tr ID="RSSTypeNews" <%=Base.IIf(prop.Value("RSSExtType") <> "News", "style=""display:none;""", "")%>>
						<%If Base.HasAccess("News", "") Or Base.HasAccess("NewsV2", "") Then%>							
        				<td>	
        						
	       						<table cellpadding="2" cellspacing="0" border="0">
    							<tr>
									<td width="170"><%=Translate.Translate("Herfra og ned")%></td>
									<td><%=Gui.Linkmanager(prop.value("Searchv1NewsPageID"), "Searchv1NewsPageID", "") %></td>
								</tr>
                                        <tr>
                                            <td class="leftColHigh">
                                                <dw:translatelabel runat="server" text="Status" />
                                            </td>
                                            <td>
                                                <label>
                                                    <%=Gui.RadioButton(Prop.Value("NewsShowMode"), "NewsShowMode", "Active")%>
                                                    <dw:translatelabel runat="server" text="Aktiv" />
                                                </label>
                                                &nbsp;
                                                <label>
                                                    <%=Gui.RadioButton(Prop.Value("NewsShowMode"), "NewsShowMode", "Archive")%>
                                                    <dw:translatelabel runat="server" text="Arkiverede" />
                                                </label>
                                                &nbsp;
                                                <label>
                                                    <%=Gui.RadioButton(prop.Value("NewsShowMode"), "NewsShowMode", "All")%>
                                                    <dw:translatelabel runat="server" text="Alle" />
                                                </label>
                                            </td>
                                        </tr>
								<tr>
									<td width="170"><%=Translate.translate("")%></td>
									<td><%=Gui.RadioButton(prop.value("Searchv1News"), "Searchv1News", "All")%> <label for="Searchv1NewsAll"><%= Translate.Translate("Alle kategorier") %></label></td>
								</tr>
								<tr>
									<td></td>
									<td>
										<table cellpadding="0" cellspacing="0" border="0">
											<tr>
												<td colspan="2">
													<%=Gui.RadioButton(prop.value("Searchv1News"), "Searchv1News", "Specified")%> <label for="Searchv1NewsSpecified"><%= Translate.Translate("Kategorier") %></label>
												</td>
											</tr>
											<tr>
												<td width="20"><img src="/Admin/Images/Nothing.gif" width="20" /></td>
												<td valign=top align=left>
													<%
													    SelectTypeNews()
													%>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>

                            <table cellpadding="2" cellspacing="0">
                            <tr>
                                <td  width="170" class="leftColHigh">
                                    <dw:TranslateLabel runat="server" Text="Order by" />
                                </td>
                                <td valign="top">
                                    <label>
                                        <%= CustomRadioButton(Prop.Value("NewsOrderBy"), "NewsOrderBy", "NewsDate", "")%>
                                        <dw:TranslateLabel runat="server" Text="News date" />
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td class="leftColHigh">
                                </td>
                                <td valign="top">
                                    <label>
                                        <%= CustomRadioButton(Prop.Value("NewsOrderBy"), "NewsOrderBy", "NewsCreatedDate", "")%>
                                        <dw:TranslateLabel runat="server" Text="Creation date" />
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td class="leftColHigh">
                                </td>
                                <td valign="top">
                                    <label>
                                        <%= CustomRadioButton(Prop.Value("NewsOrderBy"), "NewsOrderBy", "NewsHeading", "")%>
                                        <dw:TranslateLabel runat="server" Text="News header" />
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td class="leftColHigh">
                                    <dw:TranslateLabel  runat="server" Text="Sortering" />
                                </td>
                                <td>
                                    <label>
                                        <%=Gui.RadioButton(prop.Value("NewsParagraphSortOrder"), "NewsParagraphSortOrder", "DESC")%>
                                        <dw:TranslateLabel  runat="server" Text="Descending" />
                                    </label>
                                    &nbsp;
                                    <label>
                                        <%=Gui.RadioButton(prop.Value("NewsParagraphSortOrder"), "NewsParagraphSortOrder", "ASC")%>
                                        <dw:TranslateLabel  runat="server" Text="Ascending" />
                                    </label>
                                </td>
                            </tr>
                        </table>
        				</td>		
						<%End If%> 									        				
        				</tr>
        				
        				<tr ID="RSSTypeCalendar" <%=Base.IIf(prop.Value("RSSExtType") <> "Calendar", "style=""display:none;""", "")%>>
        				<%If Base.HasAccess("Calender", "") OrElse Base.HasAccess("Calendar", "") Then%>
        				<td>
								<table cellpadding="2" cellspacing="0" border="0">
									<tr>
										<td width="170"><%=Translate.Translate("From page")%></td>
										<td><%=Gui.Linkmanager(prop.value("Searchv1CalenderPageID"), "Searchv1CalenderPageID", "") %></td>
									</tr>

									<tr>
										<td width="170"><%=Translate.translate("")%></td>
										<td><%=Gui.RadioButton(prop.value("Searchv1Calender"), "Searchv1Calender", "All")%> <label for="Searchv1CalenderAll"><%= Translate.Translate("Alle kategorier") %></label></td>
									</tr>
									<tr>
										<td></td>
										<td>
											<table cellpadding="0" cellspacing="0" border="0">
												<tr>
													<td colspan="2">
														<%=Gui.RadioButton(prop.value("Searchv1Calender"), "Searchv1Calender", "Specified")%> <label for="Searchv1CalenderSpecified"><%= Translate.Translate("Kategorier") %></label>
													</td>
												</tr>
												<tr>
													<td width="20"><img src="/Admin/Images/Nothing.gif" width="20" /></td>
													<td valign=top>
														<%
														    SelectTypeCalendar()
														%>
													</td>
												</tr>
											</table>
										</td>
									</tr>

							</table>
        				</td>
        				<%End If%>								
        				</tr>
        	
        				<tr ID="RSSTypeProduct" <%=Base.IIf(prop.Value("RSSExtType") <> "Product", "style=""display:none;""", "")%>>
        				<%If Base.HasAccess("Shop", "") Then%>
        				<td>
        					
        					<table cellpadding="2" cellspacing="0" border="0">
								<tr>
									<td width="170"><%=Translate.Translate("Herfra og ned")%></td>
									<td><%=Gui.Linkmanager(prop.value("Searchv1ShopPageID"), "Searchv1ShopPageID", "") %></td>
								</tr>
								<tr>
									<td width="170"><%=Translate.translate("")%></td>
									<td><%=Gui.RadioButton(prop.value("Searchv1Shop"), "Searchv1Shop", "All")%> <label for="Searchv1ShopAll"><%= Translate.Translate("Alle kategorier") %></label></td>
								</tr>
								<tr>
									<td></td>
									<td>
										<table cellpadding="0" cellspacing="0" border="0">
											<tr>
												<td colspan="2">
													<%=Gui.RadioButton(prop.value("Searchv1Shop"), "Searchv1Shop", "Specified")%> <label for="Searchv1ShopSpecified"><%=Translate.Translate("Kategorier")%></label>
												</td>
											</tr>
											<tr>
												<td width="20"><img src="/Admin/Images/Nothing.gif" width="20" /></td>
												<td valign=top>
													<%
													    SelectTypeProduct()
													%>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								
							</table>
        				</td>
						<%End If%>        					
        				</tr>
        				
        				<tr ID="RSSTypeEmployee" <%=Base.IIf(prop.Value("RSSExtType") <> "Employee", "style=""display:none;""", "")%>>
        				<%If Base.HasAccess("Employee", "") Then%>
        				<td>
        					<table cellpadding="2" cellspacing="0" border="0">
								<tr>
									<td width="170"><%=Translate.Translate("Employees")%></td>
									<td><%=Gui.LinkManager(Prop.Value("Searchv1EmployeePageID"), "Searchv1EmployeePageID", "")%></td>
								</tr>
								<tr>
									<td width="170"><%=Translate.translate("")%></td>
									<td><%=Gui.RadioButton(Prop.Value("Searchv1Employee"), "Searchv1Employee", "All")%> <label for="Searchv1EmployeeAll"><%=Translate.Translate("All Departments")%></label></td>
								</tr>
								<tr>
									<td></td>
									<td>
										<table cellpadding="0" cellspacing="0" border="0">
											<tr>
												<td colspan="2">
													<%=Gui.RadioButton(Prop.Value("Searchv1Employee"), "Searchv1Employee", "Specified")%> <label for="Searchv1EmployeeSpecified"><%=Translate.Translate("Department")%></label>
												</td>
											</tr>
											
										</table>
									</td>
								</tr>
								
							</table>
        				</td>
						<%End If%>        					
        				</tr>
        				
        				<tr ID="RSSTypeWeblog" <%=Base.IIf(prop.Value("RSSExtType") <> "Weblog", "style=""display:none;""", "")%>>
        				<%If Base.HasAccess("Weblog", "") Then%>
        				<td>
        					<table cellpadding="2" cellspacing="0" border="0">
								<tr>
									<td width="170"><%=Translate.Translate("Weblog")%></td>
									<td><%=Gui.LinkManager(Prop.Value("Searchv1WeblogPageID"), "Searchv1WeblogPageID", "")%></td>
								</tr>
								<tr>
									<td width="170"><%=Translate.translate("")%></td>
									<td><%=Gui.RadioButton(Prop.Value("Searchv1Weblog"), "Searchv1Weblog", "All")%> <label for="Searchv1WeblogAll"><%=Translate.Translate("All blogs")%></label></td>
								</tr>
								<tr>
									<td></td>
									<td>
										<table cellpadding="0" cellspacing="0" border="0">
											<tr>
												<td colspan="2">
													<%=Gui.RadioButton(Prop.Value("Searchv1Weblog"), "Searchv1Weblog", "Specified")%> <label for="Searchv1WeblogSpecified"><%=Translate.Translate("Blog")%></label>
												</td>
											</tr>
											<tr>
												<td width="20"><img src="/Admin/Images/Nothing.gif" width="20" /></td>
												<td valign=top>
													<%
													    SelectTypeWeblog()
													%>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								
							</table>
        				</td>
						<%End If%>        					
        				</tr>


        				<tr ID="RSSTypeForumV2" <%=Base.IIf(prop.Value("RSSExtType") <> "ForumV2", "style=""display:none;""", "")%>>
        				<%If Base.HasAccess("ForumV2", "") Then%>
        				<td>
        					<table cellpadding="2" cellspacing="0" border="0">
								<tr>
									<td width="170"><%=Translate.Translate("ForumV2")%></td>
									<td><%=Gui.LinkManager(Prop.Value("Searchv1ForumV2PageID"), "Searchv1ForumV2PageID", "")%></td>
								</tr>
								<tr>
									<td width="170"><%=Translate.translate("")%></td>
									<td><%=Gui.RadioButton(Prop.Value("Searchv1ForumV2"), "Searchv1ForumV2", "All")%> <label for="ForumV2All"><%=Translate.Translate("All categories")%></label></td>
								</tr>
								<tr>
									<td></td>
									<td>
										<table cellpadding="0" cellspacing="0" border="0">
											<tr>
												<td colspan="2">
													<%=Gui.RadioButton(Prop.Value("Searchv1ForumV2"), "Searchv1ForumV2", "Specified")%> <label for="Searchv1ForumV2Specified"><%=Translate.Translate("Category")%></label>
												</td>
											</tr>
											<tr>
												<td width="20"><img src="/Admin/Images/Nothing.gif" width="20" /></td>
												<td valign=top>
													<%
													    SelectTypeForumV2()
													%>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								
							</table>
        				</td>
						<%End If%>        					
        				</tr>


        				<tr ID="RSSTypeeCommerce" <%=Base.IIf(prop.Value("RSSExtType") <> "eCommerce", "style=""display:none;""", "")%>>
        				<td>
        					<table cellpadding="2" cellspacing="0" border="0">
								<tr>
									<td width="170"><%=Translate.Translate("eCommerce")%></td>
									<td><%=Gui.LinkManager(Prop.Value("Searchv1eCommercePageID"), "Searchv1eCommercePageID", "")%></td>
								</tr>
								<tr>
									<td width="170"><%=Translate.translate("")%></td>
									<td><%=Gui.RadioButton(Prop.Value("Searchv1eCommerce"), "Searchv1eCommerce", "All")%> <label for="Searchv1eCommerceAll"><%=Translate.Translate("All products")%></label></td>
								</tr>
								<tr>
									<td width="170"><%=Translate.translate("")%></td>
									<td>
										<%=Gui.RadioButton(Prop.Value("Searchv1eCommerce"), "Searchv1eCommerce", "Specified")%> <label for="Searchv1eCommerceSpecified"><%=Translate.Translate("Group")%></label>
									</td>
								</tr>
				                <tr id="GroupSelector">
					                <td valign="top" width="170"><%=Translate.Translate("Varegrupper")%></td>
					                <td>
						                <div class=stdnowidth style="border:#cccccc 1px solid; PADDING-RIGHT:3px; OVERFLOW-Y:auto; PADDING-LEFT:3px; PADDING-BOTTOM:3px; PADDING-TOP:3px; HEIGHT:200px; WIDTH:250px;">
							                <div id="GroupListLayer">
							                <asp:Literal id="GroupList" runat="server"></asp:Literal><br />
							                </div>
						                </div>
						                <div id="AddGroupsButton" >
						                <button onClick="AddGroups();"><%=Translate.Translate("Tilf&oslash;j")%></button>
						                </div>
						                <div id="LoadingGroupsAdding" style="display:none;">
						                <asp:Literal id="GroupLoader" runat="server"></asp:Literal>
						                </div>
				   </td>        				
				                </tr>
							</table>
        				</td>
        				</tr>

				  <%=Gui.GroupBoxEnd%>
        		 </table>
				</td>
			 </tr>
			
		</table>
	</td>
</tr>
<% 
	Translate.GetEditOnlineScript()
%>