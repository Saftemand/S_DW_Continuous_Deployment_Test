<%@ Page CodeBehind="Menu.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Menu4" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Register TagPrefix="Accordion" TagName="Accordion" Src="/Admin/Content/Accordion/Accordion.ascx" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%= GetDocType()%>
<html>

<head>
	<title><%=Translate.JsTranslate("Menu")%></title>
    <link rel="STYLESHEET" type="text/css" href="Stylesheet.css" />
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
	<dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true" IncludeScriptaculous="false" ></dw:ControlResources>

    <script type="text/javascript"> 
     <%=GetUMPagePermissionJS() %>
    </script>
    
    <script type="text/javascript" src="/Admin/Menu.js"></script>

    <script type="text/javascript">
    function initVars(){
        gVars.AreaID = <%=AreaID%>;
        gVars.MasterAreaID = <%=MasterAreaID%>;
        gVars.NumberOfPages = <%=NumberOfPages%>;
        gVars.SelectedPageID = <%=SelectedPageID%>;
        gVars.MoveFromPageID = <%=Base.ChkNumber(Request.QueryString.GetValues("MoveFromPageID"))%>;
        gVars.LeftHeight = <%=LeftHeight %>;
    
        gVars.Action = '<%= Action%>';
        gVars.UserID = '<%=UserID%>';
        gVars.AreaName = '<%=Base.JSEnable(AreaName)%>';
        gVars.CopyID = '<%=CopyID%>';
        gVars.MoveID = '<%=MoveID%>';
        gVars.InternalAllID = '<%=Request.Item("Caller")%>';
        gVars.InternalCallback = '<%=Request.Item("Callback")%>';
        gVars.InternalItemType= '<%=Request.Item("ItemType")%>';
        gVars.ShowParagraphs = '<%=showparagraphs%>';
        gVars.ShowTrashBin = '<%=ShowTrashBin%>';
        gVars.ShowParagraphsOption = '<%=strShowParagraphsOption%>';

        gVars.IsFirefox = <%= isFirefox.ToString().ToLower()%>;
        gVars.IsNewGUI = <%= Gui.NewUI().ToString().ToLower()%>;
        gVars.IsShowParagraphs = <%= IIf(strShowParagraphsOption = "on", "true", "false")%>;
        gVars.IsMasterArea =  <%= IIf((MasterAreaID > 0 OrElse (Dynamicweb.Content.Area.GetAreaById(AreaID) IsNot Nothing AndAlso Dynamicweb.Content.Area.GetAreaById(AreaID).IsMaster)), "true", "false")%>;
        gVars.IsCreateLightVersionPages = <%= CanCreateLightVersionPages.ToString().ToLower()%>;
        gVars.IsNotAllowNewPages = <%= IIf((Not Base.ChkBoolean(Base.GetGs("/Globalsettings/Modules/LanguageManagement/AllowNewPages")) AndAlso MasterAreaID > 0), "true", "false")%>;
        gVars.IsAllowNewPages = <%= IIf((Base.ChkBoolean(Base.GetGs("/Globalsettings/Modules/LanguageManagement/AllowNewPages")) OrElse MasterAreaID = 0), "true", "false")%>;
        gVars.IsAllowNewParagraphs =  <%= IIf((Base.ChkBoolean(Base.GetGs("/Globalsettings/Modules/LanguageManagement/AllowNewParagraphs")) Or MasterAreaID = 0), "true", "false")%>;
        gVars.IsInstalledOMC = <%= Base.IsModuleInstalled("OMC").ToString().ToLower() %>;
        gVars.IsInstalledWorkflow = <%= Base.IsModuleInstalled("Workflow").ToString().ToLower() %>;
        gVars.IsAccessSeo = <%= Base.HasAccess("Seo", "").ToString().ToLower() %>;
        gVars.IsEditor =  <%= IIf((Request.QueryString.Item("Caller") = "editor"), "true", "false")%>;
        gVars.ShowSortingWarning = <%= IIf(ShowSortingWarning(), "true", "false") %>;
        gVars.SortingWarning = '<%=Translate.JsTranslate("Sorting pages of master will sort the language versions too. Continue?")%>';
        gVars.LinkManagerSettings = <%=LinkManagerSettings%>;        

        MenuTexts['Warning'] = '<%=Translate.JsTranslate("ADVARSEL!")%>';
        MenuTexts['Notice'] = '<%=Translate.JsTranslate("NOTICE!")%>';
        MenuTexts['AllPagesWillDeleted'] = '<%=GetDeletePageWarningMessage()%>';
        MenuTexts['NewPage'] = '<%=Translate.JSTranslate("Ny side")%>';
        MenuTexts['OpenNewWnd'] = '<%=Translate.JSTranslate("Open in new window")%>';
        MenuTexts['NewSubSite'] = '<%=Translate.JSTranslate("Ny underside")%>';
        MenuTexts['NewName'] = '<%=Translate.Translate("Nyt afsnit")%>';
        MenuTexts['Properties'] = '<%=Translate.Translate("Egenskaber")%>';
        MenuTexts['ViewPage'] = '<%=Translate.Translate("Vis side")%>';
        MenuTexts['ViewJournal'] = '<%=Translate.Translate("Vis kladde")%>';
        MenuTexts['ShowAsProfile'] = '<%=Translate.Translate("Show as profile")%>';
        MenuTexts['CopyPage'] = '<%=Translate.Translate("Kopier side")%>';
        MenuTexts['CopyTemplate'] = '<%=Translate.Translate("Kopier Template")%>';
        MenuTexts['CopyHere'] = '<%=Translate.JsTranslate("Kopier hertil")%>';
        MenuTexts['DeletePage'] = '<%=Translate.Translate("Slet %%", "%%", Translate.Translate("side"))%>';
        MenuTexts['DeleteTemplate'] = '<%=Translate.Translate("Slet %%", "%%", Translate.Translate("template"))%>';
        MenuTexts['Refresh'] = '<%=Translate.Translate("Opdater",1)%>';
        MenuTexts['CreatePageStructure'] = '<%=Translate.JSTranslate("Opret %%", "%%", Translate.JSTranslate("sidestruktur"))%>';
        MenuTexts['EditPage'] = '<%=Translate.Translate("Ret side")%>';
        MenuTexts['Preview'] = '<%=Translate.Translate("Preview")%>';
        MenuTexts['Optimize'] = '<%=Translate.JSTranslate("Optimer")%>';
        MenuTexts['MovePage'] = '<%=Translate.Translate("Flyt side")%>';
        MenuTexts['MoveTemplate'] = '<%=Translate.Translate("Flyt Template")%>';
        MenuTexts['MoveHere'] = '<%=Translate.Translate("Flyt hertil")%>';
        MenuTexts['RestoreTo'] = '<%=Translate.JsTranslate("Gendan hertil")%>';
        MenuTexts['Sort'] = '<%=Translate.JsTranslate("Sorter")%>';
        MenuTexts['NewFolder'] = '<%=Translate.JSTranslate("New folder")%>';
        MenuTexts['NewSubFolder'] = '<%=Translate.JSTranslate("New sub folder")%>';
        MenuTexts['RenameFolder'] = '<%=Translate.JSTranslate("Rename folder")%>';
        MenuTexts['DeleteFolder'] = '<%=Translate.JSTranslate("Delete folder")%>';
        if (!gVars.SelectedPageID || gVars.SelectedPageID === 0) {
            NewSelectedPageID = getCookie("selectedPageId");
            gVars.SelectedPageID = NewSelectedPageID || 0;
            if (gVars.SelectedPageID) {
                setTimeout("MoveMenuEntry(gVars.SelectedPageID);", 1000);
            }
        }
    }

	<% If Request("Action") <> "InternalEcom" AndAlso Not HasAccess Then%>
        document.oncontextmenu = function() { return false; }
	<%End If%>

	    areaid = '<%=AreaID%>';
        AreaID = '<%=AreaID%>';
	</script>

    <link rel="Stylesheet" href="/Admin/Menu.css" />
	<link rel="Stylesheet" href="/Admin/Images/Ribbon/UI/Accordion/Accordion.css" />

	<style type="text/css">
	    #MenuTable{
		    height:100%;max-height:100%;border-spacing: 0px 0px;
		    <%If isFirefox Then %>
		    border-left:1px solid <%=Gui.NewUIborderColor()%>;
		    <%End if%>
	    }
	</style>
</head>

<% Response.Flush()%>
<body onmouseover="document.body.style.cursor = 'default';" ondcontextmenu="<%=Base.IIf(Session("DW_Admin_UserID") = 1, "", "return false;")%>" onclick="hideNow();">
<script type="text/javascript">
    initVars();
</script>
<dw:Overlay ID="wait" runat="server" Message="" ShowWaitAnimation="True" />
<% If(LCase(Action) = LCase("InternalEditContent")) Then %>
<div id="menucontainerdiv" style="height:100%;">
<%Else%>
<div id="menucontainerdiv">
<%End If%>
<table cellspacing="0" cellpadding="0" border="0" id="MenuOpen" style="display:none;" height="100%" width="22">
	<tr height="3">
		<td></td>
	</tr>
	<tr height="17">
		<td align="center"><img src="images/OpenTreeView_off.gif" title=<%=Translate.JSTranslate("Vis")%> onmouseover="this.src='images/OpenTreeView_on.gif'" onmouseout="this.src='images/OpenTreeView_off.gif'" onmousedown="this.src='images/OpenTreeView_press.gif'" onmouseup="this.src='images/OpenTreeView_on.gif'" onClick="openMenu();"></td>
	</tr>
	<tr id="NavigationClosed" style="display:none;">
		<td valign="top"><div>&nbsp;</div></td>
	</tr>
	<tr id="SearchClosed" style="display:none;">
		<td valign="top"><br></td>
	</tr>
</table>
<% If(LCase(Action) = LCase("InternalEditContent")) Then %>
<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%" id="Table1">
<% Else %>
<table cellspacing="0" cellpadding="0" border="0" width=<%=IIf(LCase(Action) = "copy" Or LCase(Action) = "move" Or LCase(Action) = "moveparagraph" Or LCase(Action) = "copyparagraph", 245, LeftHeight+5)%> id="MenuTable">
<% End If %>
	<tr>
		<td valign="top" bgcolor="#FFFFFF" class="tr" style="padding-bottom:0px;<%=IIf(LCase(Action) = LCase("InternalEditContent"), "display:none;", "") %>">

		<span id="_statusPageId" style="position:absolute;right:18px;top:45px;color:#c1c1c1;padding:1px;"></span>

			<table cellspacing="0" cellpadding="0" border="0" id="TreeBox" width="<%=LeftHeight+1 %>">
				<tr class="tdb" id="TreeStart">
					<td>
						<table cellspacing="0" cellpadding="0" border="0" width="100%" style="border-bottom: solid 1px <%=Gui.NewUIborderColor()%>;">
							<tr class="title">
                                <%If HasAccess Then %>
                                <td class="title">&nbsp;<strong><%=Translate.JSTranslate("Navigation") & " (<span id=""numberofpages"">" & NumberOfPages & "</span>)"%></strong></td>
                                <% Else %>
                                <td class="title">&nbsp;<strong><%=Translate.JSTranslate("Navigation")%><span id="numberofpages" style="display: none">0</span></strong></td>
                                <% End If %>

								<%If Gui.NewUI Then %>
									<%If Action = "" Then%>
                                        <% If HasAccess Then %>
                                            <td align="right" width="20" valign="middle" class="title"><img style="cursor: pointer" title="<%=Translate.JSTranslate("Opdater",1)%>" src="images/RefreshMenu_off.gif" onclick="location.href='Menu.aspx?AreaID=' + gVars.AreaID;" alt="" /></td>    
                                            <td align="right" width="20" valign="middle" class="title"><img style="cursor: pointer" title="<%=Translate.JsTranslate("Søg")%>" src="images/SearchTreeView_off.gif" onclick="ShowSearchBox();" alt="" /></td>
                                        <% Else %>
                                            <td align="right" width="20" valign="middle" class="title"><img style="opacity: 0.4; -moz-opacity: 0.4; filter: alpha(opacity = 40)" title="<%=Translate.JSTranslate("Opdater",1)%>" src="images/RefreshMenu_off.gif" onclick="return false;" alt="" /></td>    
                                            <td align="right" width="20" valign="middle" class="title"><img style="opacity: 0.4; -moz-opacity: 0.4; filter: alpha(opacity = 40)" title="<%=Translate.JsTranslate("Søg")%>" src="images/SearchTreeView_off.gif" onclick="return false;" alt="" /></td>
                                        <% End If %>
									
									    <td align="right" width="20" valign="middle" class="title"><img style="cursor: pointer" title="<%=Translate.JSTranslate("Skjul")%>" src="images/CloseTreeView_off.gif" onclick="<%If Action = "" Then%>closeMenu('Navigation');<%Else%>self.close();<%End If%>" alt="" /></td>
									<%Else%>
									    <td align="right" width="20" valign="middle" class="title"><img style="cursor: pointer" title="<%=Translate.JSTranslate("Skjul")%>" src="images/Close_off.gif" onclick="<%If Action = "" Then%>closeMenu('Navigation');<%Else%>self.close();<%End If%>" alt="" /></td>
									<%End If%>

								<%Else%>
									<%If Action = "" Then%>
									<td align="right" width="20" valign="middle"><img style="cursor: pointer" title="<%=Translate.JSTranslate("Opdater",1)%>" src="images/RefreshMenu_off.gif" onmouseover="this.src='images/RefreshMenu_on.gif'" onmouseout="this.src='images/RefreshMenu_off.gif'" onmousedown="this.src='images/RefreshMenu_press.gif'" onmouseup="this.src='images/RefreshMenu_on.gif'" onclick="location.href='Menu.aspx?AreaID=' + gVars.AreaID;" alt="" /></td>
									<td align="right" width="20" valign="middle"><img style="cursor: pointer" title="<%=Translate.JsTranslate("Søg")%>" src="images/SearchTreeView_off.gif" onmouseover="this.src='images/SearchTreeView_on.gif'" onmouseout="this.src='images/SearchTreeView_off.gif'" onmousedown="this.src='images/SearchTreeView_press.gif'" onmouseup="this.src='images/SearchTreeView_on.gif'" onclick="ShowSearchBox();" alt="" /></td>
									<td align="right" width="20" valign="middle"><img style="cursor: pointer" title="<%=Translate.JSTranslate("Skjul")%>" src="images/CloseTreeView_off.gif" onmouseover="this.src='images/CloseTreeView_on.gif'" onmouseout="this.src='images/CloseTreeView_off.gif'" onmousedown="this.src='images/CloseTreeView_press.gif'" onmouseup="this.src='images/CloseTreeView_on.gif'" onclick="<%If Action = "" Then%>closeMenu('Navigation');<%Else%>self.close();<%End If%>" alt="" /></td>
									<%Else%>
									<td align="right" width="20" valign="middle"><img style="cursor: pointer" title="<%=Translate.JSTranslate("Skjul")%>" src="images/Close_off.gif" onmouseover="this.src='images/Close_on.gif'" onmouseout="this.src='images/Close_off.gif'" onmousedown="this.src='images/Close_press.gif'" onmouseup="this.src='images/Close_on.gif'" onclick="<%If Action = "" Then%>closeMenu('Navigation');<%Else%>self.close();<%End If%>" alt="" /></td>
									<%End If%>
								<%End If%>
							</tr>
						</table>
						<%If Gui.NewUI Then %>
                            <% if HasAccess Then %>
						        <div id="AreaName" oncontextmenu="<%=Dynamicweb.Controls.Contextmenu.GetContextMenuAction("AreaContext", AreaID) %>" onclick="<%=Dynamicweb.Controls.Contextmenu.GetContextMenuAction("AreaSelector", AreaID, "", Dynamicweb.Controls.Contextmenu.Position.BottomRight) %>" title="<%=AreaName %>">
						            <%=AreaName %>
						        </div>
                            <% Else %>
                                <div id="AreaName" oncontextmenu="return false;" onclick="return false;" title="" style="display: none">
                                </div>
                            <% End If %>
						<%End If%>
					</td>
				</tr>
				<tr onclick="hideMenu();">
					<td height="100%" nowrap="nowrap" valign="top">
                        <div id="TreeContainer" style="width:<%=TreeContainerWidth%>px; height:100%; overflow:auto;padding-left:2px;">
							<span id="mySpan" style="width:100%; display: <%=Dynamicweb.Base.IIf(HasAccess, "" ,"none")%>"></span>
                            <% If Not HasAccess %>
                                <div style="padding: 10px; color: #c3c3c3; margin: 0px auto; text-align: center; width: 90%; font-style: italic">
                                    <dw:TranslateLabel ID="lbNoAccess" Text="Access denied" runat="server" />
                                </div>
                            <% End If %>
							    
							<%if ShowTrashBin <> "no" and Action <> "InternalEcom" then%>
							<div nowrap="nowrap" class='myMenu' ID='TrashBin' style="display: <%=Dynamicweb.Base.IIf(HasAccess, "", "none")%>">
	                            <img src='images/nothing.gif' width='0' height='13'> 
	                            <img src='images/nothing.gif' name='img_1' width='9' height='13'> 
                                <span id='TrashBinSpan' class='H pagef' onmouseout='MenuActivator(null,null,null);this.style.textDecoration="";' onmouseover='MenuActivator(0,null,null);this.style.textDecoration=" underline";' onclick='ShowTrashBin();'>
                                <img src='/Admin/Images/Ribbon/Icons/Small/garbage.png' align='absMiddle' ><%=Translate.Translate("Papirkurv")%></span>
                            </div>
                                
                            <%end if%>
						</div>
					</td>
				</tr>
			</table>
			<!-- / SEARCH -->
			<table id="SearchBox" cellpadding="0" border="0" cellspacing="0" width="<%=LeftHeight+2 %>" style="display:none;height:100%;overflow:auto;">
				<tr class="title" style="border-bottom: solid 1px <%=Gui.NewUIborderColor()%>;">
					<td width="170">&nbsp;<strong><%=Translate.Translate("Søg")%></strong></td>
					<td align="right" valign="middle"><img src="images/NavigationTreeView_off.gif" title=<%=Translate.Translate("Navigation")%> onmouseover="this.src='images/NavigationTreeView_on.gif'" onmouseout="this.src='images/NavigationTreeView_off.gif'" onmousedown="this.src='images/NavigationTreeView_press.gif'" onmouseup="this.src='images/NavigationTreeView_on.gif'" onclick="ShowSearchBox();"></td>
					<td align="right" valign="middle"><img style="cursor: pointer" title=<%=Translate.JSTranslate("Skjul")%> src="images/CloseTreeView_off.gif" onmouseover="this.src='images/CloseTreeView_on.gif'" onmouseout="this.src='images/CloseTreeView_off.gif'" onmousedown="this.src='images/CloseTreeView_press.gif'" onmouseup="this.src='images/CloseTreeView_on.gif'" onclick="<%If Action = "" Then%>closeMenu('Search');<%Else%>self.close();<%End If%>"></td>
				</tr>
				<tr bgcolor="#ACA899" height="1">
					<td colspan="3"></td>
				</tr>
				<tr bgcolor="#FFFFFF">
					<td colspan="3" align="center" valign="top" width="100%">
						<form method="post" action="page_search.aspx" target="right" name="Searchform">
                            <fieldset style="padding: 3px 5px 5px; margin: 10px 4px 10px 4px;width:<%=LeftHeight-22%>px;">
                            <legend style="font-size:10px;font-weight:bold;color:#15428B;">Action</legend>
						    <table width="100%" cellspacing="2" cellpadding="0" border="0" style="overflow:auto;">
							<tr height="20">
                                <td><%=Translate.Translate("Side-ID:")%></td>
								<td align="right">
									<input type="text" onchange="PageSearchID_OnChange('PageSearchID');" maxlength="255" class="std" name="PageSearchID" value="" style="width:120px" />
								</td>
							</tr>
							<tr height="25">
                                <td><%=Translate.Translate("Paragraph ID")%>:</td>
								<td align="right">
									<input type="text" onchange="PageSearchID_OnChange('PageSearchParagraphID');" maxlength="255" class="std" name="PageSearchParagraphID" value="" style="width:120px" />
								</td>
							</tr>
							<tr height="25">
                                <td><%=Translate.Translate("Tekststreng")%>:</td>
								<td align="right">
									<input type="text" maxlength="255" class="std" name="PageSearchText" value="" style="width:120px" />
								</td>
							</tr>
							<tr>
								<td width="100%" align="right" colspan="2">
									<%=Gui.Button(Translate.Translate("Søg"), "DoSearch()", Nothing)%>
								</td>
							</tr>
                            </table>
                            </fieldset>
							<%If Action = "" Then%>
                            <fieldset style="padding: 3px 5px 5px; margin: 10px 4px 10px 4px;width:<%=LeftHeight-22%>px;">
                                <legend style="font-size:10px;font-weight:bold;color:#15428B;">Settings</legend>
                                <table width="100%" cellspacing="0" cellpadding="0" border="0" style="height:100;overflow:auto;">
							    <tr>
								    <td width="100%">
                                        <table border="0" cellspacing="0" cellpadding="0" width="100%">
										    <tr>
											    <td colspan="2" height="25"><b><%=Translate.Translate("Søg i")%></b></td>
										    </tr>
										    <tr><td colspan="2" height="1" bgcolor="#ACA899"><img src="images/nothing.gif"></td></tr>
										    <tr><td colspan="2" height="1" bgcolor="white"><img src="images/nothing.gif"></td></tr>
										    <tr>
											    <td width="25"><input type="checkbox" name="PageSearchIn" id="PageSearchIn_Page" value="page" checked="checked" /></td>
											    <td><label for="PageSearchIn_Page"><%=Translate.Translate("Sider")%></label></td>
										    </tr>
										    <tr>
											    <td width="25"><input type="checkbox" name="PageSearchIn" id="PageSearchIn_Paragraph" value="paragraph" checked="checked" /></td>
											    <td><label for="PageSearchIn_Paragraph"><%=Translate.Translate("Afsnit")%></label></td>
										    </tr>
										    <tr>
											    <td width="25"><input type="checkbox" name="PageSearchIn" id="PageSearchIn_WebsiteOnly" value="website" checked="checked" /></td>
											    <td><label for="PageSearchIn_WebsiteOnly"><%=Translate.Translate("Search this website only")%></label></td>
										    </tr>
										    <tr>
											    <td colspan="2" height="25"><B><%=Translate.Translate("Med modul")%></B></td>
										    </tr>
										    <tr>
											    <td colspan="2">
												    <select name="PageSearch_Modules" id="PageSearch_Modules" class="std" style="width:210px">
													    <option value=""><%=Translate.Translate("Alle")%></option>
													    <%=GetModuleNameOptions()%>
												    </select>
											    </td>
										    </tr>
									    </table>
								    </td>
							    </tr>
							    </table>
                            </fieldset>

							<%End If%>
                            <table width="90%" cellspacing="2" cellpadding="0" border="0" style="height:100;overflow:auto;">
							<tr>
								<td colspan="2">
								&nbsp;
								</td>
							</tr>
							<%If Base.IsModuleInstalled("UsersExtended") AndAlso Base.HasAccess("Corporate", "") AndAlso Action = "" Then%>
							<tr>
								<td>
									<table border="0" cellspacing="0" cellpadding="0" width="100%">
										<tr>
											<td colspan="2" height="25"><b><%=Translate.Translate("Deltagere")%></b></td>
										</tr>
										<tr><td colspan="2" height="1" bgcolor="#ACA899"><img src="images/nothing.gif" alt="" /></td></tr>
										<tr><td colspan="2" height="1" bgcolor="white"><img src="images/nothing.gif" alt="" /></td></tr>
										<tr><td colspan="2">&nbsp;</td></tr>
										<tr>
											<td height="20" colspan="2">
												<%=Translate.Translate("Bruger")%>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<%=GetUserList()%>
											</td>
										</tr>
										<tr>
											<td colspan="2" height="20"><%=Translate.Translate("Afdeling")%></td>
										</tr>
										<tr>
											<td colspan="2">
												<select name="SearchSelectDepartment" id="SearchSelectDepartment" class="std" style="width:<%=LeftHeight%>px">
													<option value=""><%=Translate.JSTranslate("Alle")%></option>
													<%=GetDepartmentList()%>
												</select>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<%End If%>
						</table>
							</form>
					</td>
				</tr>
			</table>
			<!-- SEARCH / -->
		</td>
        <% If(LCase(Action) <> LCase("InternalEditContent")) Then %>
		<td  class="tdb" valign="top" width="5"><img src="images/Nothing.gif" width="5"></td>
        <% End If %>
		<td  class="tdb" valign="top" width="100%" style="height:100%;">
			<%if Base.ChkNumber(trim(Request.QueryString.Item("id")))>0 then%>
			    <% If(LCase(Action) = LCase("InternalEditContent")) Then %>
      			    <iframe src="Content/ParagraphList.aspx?PageID=<%=Request.QueryString.Item("id")%>&caller=<%=Request.QueryString.Item("Caller")%>" frameborder="0" name="ParagraphList" id="ParagraphList" width="100%" height="100%"></iframe>
                <% Else %>
                    <iframe src="Paragraph/Paragraph_List.aspx?ID=<%=Request.QueryString.Item("id")%>&mode=browse&caller=<%=Request.QueryString.Item("Caller")%>" frameborder="0" name="ParagraphList" id="ParagraphList" width="620" height="100%"></iframe>
		        <% End If %>
            <%else%>
			    <iframe src="" frameborder="0" name="ParagraphList" id="ParagraphList" width="650" style="left: 255px; top: 0px; height: 100%; position: absolute;"></iframe>
			<%end if%>
		</td>
	</tr>
		<%If Gui.NewUI Then%>
        <% If(LCase(Action) = LCase("InternalEditContent")) Then %>
			<tr id="TreeEnd" style="display: none;">
            <% Else %>
    		<tr id="TreeEnd" onclick="hideMenu();" onmouseout="MenuActivator(null,null,null);" onmouseover="MenuActivator(0,null,null);" style="height:124px;">
            <% End If %>
				<td valign="bottom" colspan="2" style="height:124px;">
					<table cellpadding="0" cellspacing="0" border="0" style="height:124px;width:<%=LeftHeight-2%>;border-right:1px solid <%=Gui.NewUIborderColor()%>;border-spacing: 0px 0px;">
						<tr>
							<td valign="top">
								<div style="display:none"><%=Area.ToString()%></div>
								<%If Action = "" Then%>
								<Accordion:Accordion id="Accordion" runat="server" />
								<%end if %>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		<%else %>
			<tr id="Tr1" onclick="hideMenu();" onmouseout="MenuActivator(null,null,null);" onmouseover="MenuActivator(0,null,null);">
				<td valign="bottom" colspan="2">
					<table cellpadding="0" cellspacing="0" border="0" width="100%">
						<tr style="display:inline;">
							<% If Action = "" Then
							        If CanCreateLightVersionPages Then
							            Response.Write("<td width=""170"">" & Gui.Button(Translate.JsTranslate("Ny side"), "NewPage();", 0) & "</td>")
							        End If
							        Response.Write("<td align=left>" & Gui.HelpIcon("", "Navigation", "gui.navigation") & "</td>")
							    ElseIf Action = "Internal" And Request.QueryString.Item("strShowParagraphsOption") = "on" Then
							        Response.Write("<td>" & Gui.Button(Translate.Translate("Vis afsnit"), "ToggleShowParagraphs();", 0) & "</td>")
							    End If
							%>
						</tr>
						<tr><td><img src="images/Nothing.gif" height="6"></td></tr>
					</table>
					<%=Area.ToString()%>
				</td>
			</tr>
		<%end if %>
		
</table>
	<dw:Contextmenu ID="AreaSelector" runat="server" Translate="false" MaxHeight="300" width="218">
	</dw:Contextmenu>
<dw:Contextmenu ID="AreaContext" runat="server" Translate="false">
	<dw:ContextmenuButton ID="cmdPreviewArea" runat="server" Text="Preview" Image="Preview" OnClientClick="previewArea(ContextMenu.callingID);"></dw:ContextmenuButton>
	</dw:Contextmenu>
<iframe style="display:none;" height="250" width="250" id="MenuData" src="MenuData.aspx?AreaID=<%=AreaID%>&update=3<%=String.Concat("&", Dynamicweb.Gui.LinkManagerSettings.ToQuery(Dynamicweb.Gui.LinkManagerSettings.FromJson(LinkManagerSettings))).TrimEnd("&"c)%>"></iframe>
<div id="Rmenu" class="altMenu" style="display:none;"></div>
<script type="text/javascript">
    SetTreeContainerHeight();
    addResizeEvent(SetTreeContainerHeight);

    if (gVars.Action == "AddPage") 
        document.getElementById("ParagraphList").style.display = "none";

    <% Translate.GetEditOnlineScript()  %>
    <% If IsNumeric(SelectedPageID) AndAlso SelectedPageID <> 0 Then  %>
	    setTimeout("MoveMenuEntry(<%=SelectedPageID%>);", 1000)
    <% End If %>

    <% If HasAccess Then %>
    document.getElementById('TreeContainer').oncontextmenu = setRightClick;
    var buttons = new Array('Page', 'Filemanager', 'UserManagement', 'Ecom', 'OMC', 'Modules', 'managementcenter');
    for (var i = 0; i < buttons.length; i++) {
        var btnId = 'Accordion_btn' + buttons[i];
        var btn = document.getElementById(btnId);
        if (btn != null)
            btn.oncontextmenu = setAccordionRightClick;
    }
    
    if (window.parent.accordionActionEnable)
    {
        window.parent.accordionActionEnable=false;
        
        var phref = window.parent.location.href;
        var index = phref.indexOf("accordionAction=");
        if (index > 0){
            var action = phref.substr(index + "accordionAction=".length, phref.length - index);
            eval(action);
        }
    }

    if (top.MainFrame.cols=='20,*' || top.MainFrame.cols=='22,*'){
        closeMenu()
    }

    <% End If %>
</script>
</div>
<%Translate.GetEditOnlineScript()%>
</body>
</html>