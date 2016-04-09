<%@ Page Codebehind="Page_Edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Page_Edit" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb.SystemTools.Inherit" %>

<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<html>
<head>
    <title></title>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />

	<link rel="STYLESHEET" type="text/css" href="Stylesheet.css" />
    <link rel="Stylesheet" type="text/css" href="/Admin/Module/eCom_Catalog/images/ObjectSelector.css" />
	<script type="text/javascript" src="/Admin/Module/Metadata/Metadata_page.js?"></script>

	<script language="JavaScript" type="text/javascript">
		<%
		'Call Custom_Page_ExtendJSBlock()
		'Try
		'	errorString = myModule.loadAssembly("Custom_Admin", Server.MapPath("\Files\Custom_Admin.vb"), "")
		'	Dim loCodeParms() As Object

		'	myModule.CallFunction("Custom_Admin", "Custom_Page_ExtendJSBlock", loCodeParms)
		'Catch ex As Exception
		'	'txtOutput.Text = txtOutput.Text & "Some error " & vbNewLine
		'End Try
		%>
		//<!--
		function PageInit() {
			AttachOnChangeHandler('side', PageHasChanged_Event);
			PageHasChanged = true;
		}

        function cancelEditing() {
            var pageID = parseInt('<%=SideID%>');
            var parentPageID = parseInt('<%=PageParentPageID%>');
            var redirectTo = location = 'Paragraph/Paragraph_List.aspx?ID=' + pageID;

            if (pageID <= 0) {
                redirectTo = location = 'Paragraph/Paragraph_List.aspx?ID=' + parentPageID;
                if (parentPageID <= 0) {
                    redirectTo = '/Admin/MyPage/Default.aspx';
                }
            }

            location = redirectTo;
        }

		// Attaches an eventhandler (onchange) to a given form-page.
		// Ex. AttachOnChangeWatch('side', EventChanger);
		function AttachOnChangeHandler(formname, eventfunction) {
			var formCollection = document.forms[formname];

			for (i = 0; i < formCollection.elements.length; i++) {
				if (formCollection.elements[i].onchange) {
					var theObject			= formCollection.elements[i];
					var oldHandler			= theObject.onchange;
					theObject.onchangeOLD	= oldHandler;
					theObject.onchange		= function () { eventfunction();this.onchangeOLD(); };
				}
				else {
					formCollection.elements[i].onchange = eventfunction;
				}
			}
		}

		var PageHasChanged = false;
		function PageHasChanged_Event() {
			PageHasChanged = true;
		}
		
		var submittet = false;
		
					// WORKFLOW
		function Send(FileToHandle) {
			tekst = document.forms['side'].menutekst.value;
			
			if (PageHasChanged) {				
				if (tekst.length < 1) {
					alert("<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>");
				} else if (submittet==false) { //checkes if page has been submittet more than once (problems with Enter-key-submit
					submittet = true
					////////////////////////////////////////////////////////////////////
					//alert(FileToHandle);
					
				
					<% If Base.chkboolean(Base.GetGs("/Globalsettings/Modules/Users/UseExtendedComponent")) = false Then %>
					if (document.getElementById('PagePermission')) {
						for (i = 0; i < document.getElementById('PagePermission').options.length; i++) {
							document.getElementById('PagePermission').options[i].selected = true;
						}
					}
					<% End If %>
					
					<%
					'Call Custom_Page_ExtendSendJS()
					
					'Try
					'	Dim loCodeParms() as object 
					'	errorString = myModule.loadAssembly("Custom_Admin", Server.MapPath("\Files\Custom_Admin.vb"), "")
					'	myModule.CallFunction("Custom_Admin", "Custom_Page_ExtendSendJS", loCodeParms)
					'Catch ex As Exception
						'txtOutput.Text = txtOutput.Text & "Some error " & vbNewLine
					'End Try 
					%>

					//alert(FileToHandle);
					///////////////////////////////////////////////////////////////////
					if (IsValidMetadata())
					{
						document.side.action = FileToHandle;
						document.side.submit();
					}
					else
					{
						submittet = false;
						TabClick(document.getElementById('Tab4'));
					}
				}
			}
			else {			
			<% If Request("Audit") = "true" Then %>
				location.href = '/Admin/module/Audit/Audit_list.aspx?<%="Audit&=true&AuditUserID=" & Request("AuditUserID") & "&AuditDateTimeFrom=" & Request("AuditDateTimeFrom") & "&AuditDateTimeTo=" & Request("AuditDateTimeTo") & "&AuditType=" & Request("AuditType") & "&SortOrder=" & Request("SortOrder") & "&SortField=" & Request("SortField")%>';
			<%Else%>
				location.href = 'Paragraph/Paragraph_List.aspx?ID=<%= Request.QueryString("ID") %>';
			<%End If%>
			}
		}
		
		function mouseOverText(){
			if (document.forms['side'].elements['onMouseOver'].value.length == 0){
				document.forms['side'].onMouseOver.value = document.side.menutekst.value;
			}
		}

		function addLink(FormName, FieldName){
			InterntLink = window.open("Pagelink.aspx?formnavn=" + FormName + "&field=" + FieldName, "InterntLink", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=200,height=350,screenX=0,screenY=0");
			InterntLink.focus();
		}

		function catchThatEnter(e){
			var evt = (window.event)?window.event:e;
			if (evt.keyCode == 13){
				Send("Page_save.aspx");
			}
		}

		function AddPage(ID, AreaID, Name){
			movepageWindow = window.open("/Admin/Menu.aspx?ID=" + ID + "&Action=AddPage&Caller="+ Name + "&AreaID=" + AreaID, "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=200,height=350,top=155,left=402");
		}
		
        function getActiveTab(){
        //Saving activeTab index in hidden variable 'Tab' 
	        counter = 1;
	        activeTab = null;
	        while (activeTab < 100){
		        if (document.getElementById("Tab" + counter)){			        
			        if (document.getElementById("Tab" + counter).style.display != "none"){
				        activeTab = counter;
				        break;
		            }
	            }
	            counter ++;
            }
            return counter;
        }
        
        function Save(FileToHandle){	        
            document.side.Tab.value = getActiveTab();
            Send(FileToHandle);
        }
        
        
        function updateNavigationDivs() {
            // Set the div be visible if the checkbox is checked
            if (document.getElementById('NavigationTypesProductGroup').checked) {
                document.getElementById('NavigationDivProductGroup').style.display = '';
                
                if (document.getElementById('NavigationProductGroupParentGroups').checked) {
                    document.getElementById('NavigationDivProductGroup_GroupSelector').style.display = '';
                    document.getElementById('NavigationDivProductGroup_ShopSelector').style.display = 'none';
                }
                else if (document.getElementById('NavigationProductGroupParentShop').checked) {
                    document.getElementById('NavigationDivProductGroup_GroupSelector').style.display = 'none';
                    document.getElementById('NavigationDivProductGroup_ShopSelector').style.display = '';
                }
                else {
                    document.getElementById('NavigationDivProductGroup_GroupSelector').style.display = 'none';
                    document.getElementById('NavigationDivProductGroup_ShopSelector').style.display = 'none';
                }
            }
            else
                document.getElementById('NavigationDivProductGroup').style.display = 'none';
        }
        
	//-->
	</script>
</head>

<%  If Not IsNothing(Request.QueryString("Tab")) Then%>
    <body onload="PageInit();">
<%	Else%>
	<body onload="PageInit();document.side.menutekst.focus();">
<%	End If%>
    <span class="body">
			<%
			    'Call MakeHeaders(PageMenuText & "&nbsp;" & PageMenuVersionText, Tabs, "all")
				Response.Write(Gui.MakeHeaders(Translate.Translate("Rediger side - %%", "%%", PageMenuText), Tabs, "all"))
			%>
			<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
				<form method="post" id="Form1" name="side">
					<tr>
						<td valign="top">
							<input type="hidden" name="SideID" value="<%=SideID%>">
							<input type="hidden" name="PageParentPageID" value="<%=PageParentPageID%>">
							<input type="hidden" name="AreaID" value="<%=AreaID%>">
							<input type="hidden" name="ChangeField" value="" id="ChangeField">
							<input type="hidden" name="Audit" value="<%=request.Item("Audit")%>" id="Audit">
							<input type="hidden" name="AuditUserID" value="<%=request.Item("AuditUserID")%>" id="AuditUserID">
							<input type="hidden" name="AuditDateTimeFrom" value="<%=request.Item("AuditDateTimeFrom")%>" id="AuditDateTimeFrom">
							<input type="hidden" name="AuditDateTimeTo" value="<%=request.Item("AuditDateTimeTo")%>" id="AuditDateTimeTo">
							<input type="hidden" name="AuditType" value="<%=request.Item("AuditType")%>" id="AuditType">
							<input type="hidden" name="SortOrder" value="<%=request.Item("SortOrder")%>" id="SortOrder">
							<input type="hidden" name="SortField" value="<%=request.Item("SortField")%>" id="SortField">
							<input type="hidden" name="Tab" value="" id="Tab" />
							<div id="Tab1" style="display:inherit;">
								<br>
								<table border="0" cellpadding="0" width="598">
									<tr>
										<td colspan="2">
											<%= Gui.GroupBoxStart(Translate.Translate("Menupunkt"))%>
											<table cellpadding="2" cellspacing="0">
												<tr>
													<td width="170">
														<%=Translate.Translate("Sidenavn")%>
													</td>
													<td>
														<input type="text" name="menutekst" size="30" maxlength="255" value="<%=PageMenuText%>"
															onchange="mouseOverText();" onkeydown="catchThatEnter(event);" class="std"></td>
												</tr>
												<tr>
													<td>
														<%=Translate.Translate("Statuslinje tekst")%>
													</td>
													<td>
														<input type="text" name="onMouseOver" size="30" maxlength="255" value="<%=PageMouseOver%>"
															class="std"></td>
												</tr>
											</table>
											<%=Gui.GroupBoxEnd%>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<%=Gui.GroupBoxStart(Translate.Translate("Grafisk navigation"))%>
											<table cellpadding="2" cellspacing="0">
												<tr>
													<td width="170">
														<%=Translate.Translate("Grafik")%>
													</td>
													<td>
														<%= Gui.FileManager(PageImageMouseOut, "Navigation", "MouseOutBillede")%>
													</td>
												</tr>
												<tr>
													<td>
														<%=Translate.Translate("MouseOver grafik")%>
													</td>
													<td>
														<%= Gui.FileManager(PageImageMouseOver, "Navigation", "MouseOverBillede")%>
													</td>
												</tr>
												<tr>
													<td>
														<%=Translate.Translate("Valgt grafik")%>
													</td>
													<td>
														<%= Gui.FileManager(PageImageActivePage, "Navigation", "SelBillede")%>
													</td>
												</tr>
												<tr>
													<td>
														<%=Translate.Translate("Medtag tekst")%>
													</td>
													<td>
														<input type="checkbox" name="KeepText" <%=KeepTextVal%>></td>
												</tr>
											</table>
											<%=Gui.GroupBoxEnd%>
										</td>
									</tr>
									<%		If Base.IsModuleInstalled("Corporate", True) Then%>
									<tr>
										<td colspan="2">
											<%=Gui.GroupBoxStart(Translate.Translate("Ansvarlig"))%>
											<table cellpadding="2" cellspacing="0">
												<tr>
													<td width="170">
														<%=Translate.Translate("Ansvarlig")%>
													</td>
													<td>
														<%= Gui.UserList("PageManager", PageManager)%>
													</td>
												</tr>
												<tr>
													<td>
														<%=Translate.Translate("Opdater")%>
													</td>
													<td>
														<select class="std" name="PageManageFrequence">
															<option value="0">
																<%=Translate.Translate("Intet valgt")%>
															</option>
															<option value="1" <%=Base.IIf(PageManageFrequence = "1", "selected", "")%>>
																<%=Translate.Translate("Hver dag")%>
															</option>
															<option value="2" <%=Base.IIf(PageManageFrequence = "2", "selected", "")%>>
																<%=Translate.Translate("Hver 2. dag")%>
															</option>
															<option value="14" <%=Base.IIf(PageManageFrequence = "14", "selected", "")%>>
																<%=Translate.Translate("Hver 14. dag")%>
															</option>
															<option value="30" <%=Base.IIf(PageManageFrequence = "30", "selected", "")%>>
																<%=Translate.Translate("Hver måned")%>
															</option>
															<option value="60" <%=Base.IIf(PageManageFrequence = "60", "selected", "")%>>
																<%=Translate.Translate("Hver 2. måned")%>
															</option>
															<option value="90" <%=Base.IIf(PageManageFrequence = "90", "selected", "")%>>
																<%=Translate.Translate("Hver 3. måned")%>
															</option>
															<option value="180" <%=Base.IIf(PageManageFrequence = "180", "selected", "")%>>
																<%=Translate.Translate("Hver 6. måned")%>
															</option>
															<option value="360" <%=Base.IIf(PageManageFrequence = "360", "selected", "")%>>
																<%=Translate.Translate("Hvert år")%>
															</option>
														</select>
													</td>
												</tr>
											</table>
											<%=Gui.GroupBoxEnd%>
										</td>
									</tr>
									<%	End If%>
									<tr>
										<td colspan="2">
											<%= Gui.GroupBoxStart(Translate.Translate("Tilgængelighed"))%>
											<table cellpadding="2" cellspacing="0" border="0">
												<%
													Dim myDisplay As String = ""
													If (Session("DW_Admin_UserType") = 5) And ((Base.ChkNumber(Base.GetGs("Access_UseApproval")) = True) Or (Base.GetGs("Access_UseApproval") = "True")) Then
														myDisplay = "none"
													End If
												%>
												<tr style="display: <%=myDisplay%>;">
													<td width="170">
														<%=Translate.Translate("Medtag i menu")%>
													</td>
													<%
														If (Session("DW_Admin_UserType") = 5) And SideID = 0 And (Base.GetGs("Access_UseApproval") = "True" Or Base.ChkNumber(Base.GetGs("Access_UseApproval")) = True) Then
															myDisplay = ""
														Else
															myDisplay = MedtagVal
														End If
													%>
													<td>
														<input type="checkbox" name="Medtag" <%=MedtagVal%>>
												</tr>
												<%
													Dim strHideSearch As String = ""
													If Base.HasAccess("Search", "") Or Base.HasAccess("Searchv1", "") Then
													Else
														strHideSearch = " style=""display:none;"""
													End If
												%>
												<tr<%=strHideSearch%>>
								<td><%=Translate.Translate("Medtag i søgning")%></td>
						      	<td><input type="checkbox" name="Allowsearch" <%=AllowsearchVal%>> </td>
									</tr>
									<%	If Base.HasAccess("Sitemap", "") Or Base.HasAccess("SitemapV2", "") Then%>
									<tr>
										<td>
											<%=Translate.Translate("Medtag i sitemap")%>
										</td>
										<td>
											<input type="checkbox" name="PageShowInSitemap" <%=PageShowInSitemap%>>
										</td>
									</tr>
									<%	End If%>
									<tr>
										<td>
											<%=Translate.Translate("Klikbar")%>
										</td>
										<td>
											<input type="checkbox" name="Allowclick" <%=AllowclickVal%>>
										</td>
									</tr>
									<%	If Base.HasVersion("18.4.1.0") Then%>
									<tr>
										<td>
											<%=Translate.Translate("Vis i brødkrummesti")%>
										</td>
										<td>
											<%= Gui.CheckBox(PageShowInLegend, "PageShowInLegend")%>
										</td>
									</tr>
									<%	End If%>
									<%	If Base.HasVersion("18.2.1.1") Then%>
									<tr>
										<td>
											<%=Translate.Translate("Vis sidst opdateret")%>
										</td>
										<td>
											<input type="checkbox" name="PageShowUpdateDate" <%=PageShowUpdateDate%>>
										</td>
									</tr>
									<%	End If%>
									<%	If Base.HasAccess("Personalize", "") Then%>
									<tr>
										<td>
											<%=Translate.Translate("Vis favoritter")%>
										</td>
										<td>
											<%= Gui.CheckBox(PageShowFavorites, "PageShowFavorites")%>
										</td>
									</tr>
									<%	End If%>
								</table>
								<%= Gui.GroupBoxEnd%>
						</td>
					</tr>
					<%
						Dim myCustom_Page_ShowCustomGroup As Object
						Dim Custom_Page_ShowCustomGroupName As Object
						'Try
						'	errorString = myModule.loadAssembly("Custom_Admin", Server.MapPath("\Files\Custom_Admin.vb"), "")
						'	myCustom_Page_ShowCustomGroup = myModule.GetField("Custom_Admin", "Custom_Page_ShowCustomGroup", myCustom_Page_ShowCustomGroup)
						'	Custom_Page_ShowCustomGroupName = myModule.GetField("Custom_Admin", "Custom_Page_ShowCustomGroupName", Custom_Page_ShowCustomGroupName)
						'Catch ex As Exception
						'txtOutput.Text = txtOutput.Text & "Some error " & vbNewLine
						'End Try 
					
						If myCustom_Page_ShowCustomGroup Then%>
					<tr>
						<td colspan="2">
							<%	'= Gui.GroupBoxStart(Custom_Page_ShowCustomGroupName)%>
							<%	
						
								'Try
								'	Dim loCodeParms() As Object

								'	myModule.CallFunction("Custom_Admin", "Custom_Page_CustomGroup", loCodeParms)
								'Catch ex As Exception
								'	'txtOutput.Text = txtOutput.Text & "Some error " & vbNewLine
								'End Try 
								'Call Custom_Page_CustomGroup()%>
							<%	'= Gui.GroupBoxEnd%>
						</td>
					</tr>
					<%	End If%>
			</table>
			</div>
			<div id="Tab2" style="display: none;">
				<br>
				<table cellpadding="0" border="0" width="598">
					<tr>
						<td colspan="2">
							<%= Gui.GroupBoxStart(Translate.Translate("Layout"))%>
							<table cellpadding="2" cellspacing="0">
								<tr>
									<td>
										<%=Translate.Translate("Logo")%>
									</td>
									<td>
										<%= Gui.FileManager(PageTopLogoImage, "System", "Toplogo")%>
									</td>
								</tr>
								<tr>
									<td width="170">
										<%=Translate.Translate("Topgrafik")%>
									</td>
									<td>
										<%= Gui.FileManager(PageTopImage, "System", "Topgrafik")%>
									</td>
								</tr>
								<tr>
									<td>
										<%=Translate.Translate("Vis topgrafik")%>
									</td>
									<td>
										<input type="checkbox" name="MedtagTopGrafik" <%=MedtagTopGrafikVal%>></td>
								</tr>
								<tr>
									<td>
										<%=Translate.Translate("Menulogo")%>
									</td>
									<td>
										<%= Gui.FileManager(PageMenuLogoImage, "System", "Menulogo")%>
									</td>
								</tr>
								<%	If Base.ChkBoolean(Base.GetGs("/Globalsettings/Settings/Page/Edit/ShowLogoAlt")) Then%>
								<tr>
									<td>
										<%=Translate.Translate("Logo")%> (alt)
									</td>
									<td>
										<input class="std" maxlength="255" name="PageTopLogoImageAlt" size="30" type="text"
											value="<%=PageTopLogoImageAlt%>">
									</td>
								</tr>
								<%End If %>
								<tr>
									<td>
										<%=Translate.Translate("Baggrund")%>
									</td>
									<td>
										<%= Gui.FileManager(PageBackgroundImage, "System", "Baggrundsbillede")%>
									</td>
								</tr>
								<tr>
									<td>
										<%=Translate.Translate("Sidefod")%>
									</td>
									<td>
										<%= Gui.FileManager(PageFooterImage, "System", "PageFooter")%>
									</td>
								</tr>
								<tr>
									<td>
										<%=Translate.Translate("Stylesheet")%>
									</td>
									<td>
										<%= Gui.StylesheetList(Stylesheet, "Stylesheet")%>
									</td>
								</tr>
							</table>
							<%= Gui.GroupBoxEnd%>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<%= Gui.GroupBoxStart(Translate.Translate("Genvej"))%>
							<table cellpadding="2" cellspacing="0">
								<tr>
									<td width="170" valign="top">
										<%=Translate.Translate("Genvej")%>
									</td>
									<%	strShowParagraphsOption = "off"%>
									<td>
										<%= Gui.LinkManager(PageShortCut, "PageShortCut", "")%>
									</td>
								</tr>
								<tr>
									<td>
										<%=Translate.Translate("Videresend")%>
									</td>
									<td>
										<input type="checkbox" name="PageShortCutRedirect" <%=PageShortCutRedirectVal%>></td>
								</tr>
							</table>
							<%= Gui.GroupBoxEnd%>
						</td>
					</tr>
					<tr <%=Base.HasAccessHIDE("Password", "")%>>
						<td colspan=2>
							<%= Gui.GroupBoxStart(Translate.Translate("Kodeord"))%>
							<table cellpadding=2 cellspacing=0>
								<tr height=25>
									<td width=170><%=Translate.Translate("Kodeordsbeskyttelse")%></td>
									<td>
										<script>
									  	function showOrHide(boks){
									  		if(!boks.checked){
												document.all("pwd").style.display = "none";
												document.all("kodeord").value = "";
											}else{
												document.all("pwd").style.display = "";
											}
									  	}
									  	</script>
									  	<input onClick="showOrHide(this);" type="checkbox" name="Beskyt" <%=BeskytVal%>>
										<span id=pwd <%
													If Not BeskytVal <> "" Then
														Response.Write(" style=""display:none;""")
													End If
													%>>
													<%=Translate.Translate("Kodeord")%>: 
													<input type="text" name="kodeord" size="30" maxlength="255" value="<%=kodeordVal%>" style="width: 120px;" class=std>
										</span>
									</td>
							    </tr>
							</table>
							<%= Gui.GroupBoxEnd%>
						</td>
					</tr>
					<tr <%=Base.HasAccessHIDE("Publish", "")%>>
						<td colspan=2>
						<%= Gui.GroupBoxStart(Translate.Translate("Publicering"))%>
							<table cellpadding=2 cellspacing=0 border=0>
								<tr>
									<td width=170><%=Translate.Translate("Gyldig fra")%></td>
									<td><%= Dates.DateSelect(DateFrom, True, False, False, "selfrom")%></td>
								</tr>
								<tr>
									<td valign=top><%=Translate.Translate("Gyldig til")%></td>
									<td><%= Dates.DateSelect(DateTo, True, False, True, "selto")%></td>
								</tr>
							</table>
						<%= Gui.GroupBoxEnd%>
						</td>
					</tr>
					<tr>
						<td colspan=2>
							<%= Gui.GroupBoxStart(Translate.Translate("Cache"))%>
							<table cellpadding=2 cellspacing=0>
								<tr>
									<td width="170" valign="top"><%=Translate.Translate("Type")%></td>
									<td><%= Gui.RadioButton(PageCacheMode, "PageCacheMode", "1")%> <label for="PageCacheMode1"><%=Translate.Translate("Ingen")%></label></td>
							    </tr>
								<tr>
									<td></td>
									<td><%= Gui.RadioButton(PageCacheMode, "PageCacheMode", "2")%> <label for="PageCacheMode2"><%=Translate.Translate("Standard")%></label></td>
							    </tr>
								<%	If Base.HasVersion("18.8.1.0") Then%>
								<tr>
									<td></td>
									<td><%= Gui.RadioButton(PageCacheMode, "PageCacheMode", "3")%> <label for="PageCacheMode3"><%=Translate.Translate("Hele siden")%></label></td>
							    </tr>
								<%	End If%>

								<tr<%=Base.IIf(PageCacheMode = "3", "", " style=""display:none;""")%> id="CacheWarning">
									<td></td>
									<td>
									<%	If Session("DW_Language") = 1 Then%>
									<%= Gui.GroupBoxStart(Translate.Translate("Information"))%>
									<img src="images/infoicon.gif" width="14" height="16" align="left">
									<%=Server.HtmlEncode("Du har valgt at cache hele siden. Det betyder, at hele siden caches i den valgte tid, og ændringer derfor kan være op til den valgte tid om at slå igennem. Cachen kan nulstilles ved at højreklikke på siden i menuen til højre og vælge ""Vis side"".")%>
									<p>
									<%=Server.HtmlEncode("Denne funktion bør kun bruges på udvalgte sider for at opnå bedre performance. Websitets forside(r) er gode eksempler.")%>
									<p>
									<%=Server.HtmlEncode("Vær desuden opmærksom på følgende:")%>
									<ul>
									<li><%=Server.HtmlEncode("Cachen slettes automatisk hvis du ændrer indholdet i afsnit")%>
									<li><%=Server.HtmlEncode("Alle moduler på afsnit caches")%>
									<li><%=Server.HtmlEncode("Skal ikke bruges hvis siden har tilknyttet ekstranet eller rotation")%>
									</ul>
									<%=Server.HtmlEncode("Er du i tvivl vælg da standard cache.")%>
									<%= Gui.GroupBoxEnd%>
									<%	End If%>
									</td>
								</tr>
								<tr>
									<td valign=top><%=Translate.Translate("Gyldig")%></td>
									<td><%= CacheFrequence(PageCacheFrequence, "PageCacheFrequence")%></td>
								</tr>
				</table>

				<script type="text/javascript" language="javascript" for="PageCacheMode1" event="onclick">chooseCache();</script>
				<script type="text/javascript" language="javascript" for="PageCacheMode2" event="onclick">chooseCache();</script>
				<script type="text/javascript" language="javascript" for="PageCacheMode3" event="onclick">chooseCache();</script>
				<script type="text/javascript">
					function chooseCache(){
						if(document.side.PageCacheMode[2].checked){
							document.getElementById("CacheWarning").style.display = "";
						}
						else{
							document.getElementById("CacheWarning").style.display = "none";
						}
						//alert(document.side.PageCacheMode[1].checked);
						//alert(document.side.PageCacheMode[0].value);
					}
				</script>

				<%= Gui.GroupBoxEnd%>
				</td> </tr> </table>
			</div>
			
			<!-- Navigation tab -->
			<%	If Base.HasAccess("eCom_Catalog", "") Then%>
			<div id="Tab3" style="display:none">
			    <br />
			    <table border="0" cellpadding="0" width="598"><tr><td>
                    <%=Gui.GroupBoxStart(Translate.Translate("Content"))%>
                        <span style="color:Gray">
                            <%=Translate.Translate("Select the content you want to be displayed under this page in the standard XML menu")%>
                        </span><br />
                        <br />
                        <div style="margin-left:170px">
                            <input type="checkbox" name="NavigationTypesProductGroup" ID="NavigationTypesProductGroup" onclick="javascript:updateNavigationDivs()"  value="ProductGroup" <%=IIf(Navigation_UseEcomGroups, "checked", "").ToString() %>/>
                            <label for="NavigationTypesProductGroup"><%=Translate.Translate("eCom groups")%></label>
                        </div>
                        <br />
                    <%=Gui.GroupBoxEnd()%>
                    
                    <div id="NavigationDivProductGroup">
                        <%=Gui.GroupBoxStart(String.Format("{0} - {1}", Translate.Translate("Settings"), Translate.Translate("eCom groups")))%>
                            <dw:Infobar ID="infoAssortments" Type="Information" Message="Assortments are enabled" UseInlineStyles="false" Visible="false" runat="server" />
                            <!-- Parent selector -->
                            <table cellpadding="2" cellspacing="0">
                                <tr>
                                    <td style="width:170px" valign="top">
                                        <%=Translate.Translate("Group parent")%>
                                    </td>
                                    <td>
                                        <input type="radio" value="Groups" name="NavigationProductGroupParent" id="NavigationProductGroupParentGroups" onclick="javascript:updateNavigationDivs()" <%=IIf(NavigationParentType = "Groups", "checked", "").ToString() %>/>
                                        <label for="NavigationProductGroupParentGroups"><%=Translate.Translate("Groups")%></label>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <input type="radio" value="Shop" name="NavigationProductGroupParent" id="NavigationProductGroupParentShop" onclick="javascript:updateNavigationDivs()" <%=IIf(NavigationParentType = "Shop", "checked", "").ToString() %>/>
                                        <label for="NavigationProductGroupParentShop"><%=Translate.Translate("Shop")%></label>
                                    </td>
                                </tr>
                            </table>
                                                      
                            <!-- Group selector -->
                            <div id="NavigationDivProductGroup_GroupSelector">
                                <table cellpadding="2" cellspacing="0">
                                    <tr>
                                        <td style="width:170px" valign="top">
                                            <%=Translate.Translate("Groups")%>
                                        </td>
                                        <td>
                                            <de:ProductsAndGroupsSelector runat="server" OnlyGroups="true" ID="NavigationGroupSelector" Width="150px" Height="100px" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            
                            <!-- Shop selector -->
                            <div id="NavigationDivProductGroup_ShopSelector">
                                <table cellpadding="2" cellspacing="0">
                                    <tr>
                                        <td style="width:170px" valign="top">
                                            <%=Translate.Translate("Shop")%>
                                        </td>
                                        <td>
                                            <de:ShopDropDown ID="NavigationShopSelector" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            
                            <!-- Maxlevel selector -->
                            <table cellpadding="2" cellspacing="0">
                                <tr>
                                    <td style="width:170px" valign="top">
                                        <%=Translate.Translate("Max levels")%>
                                    </td>
                                    <td>
                                        <%=MakeNavigationLevelSelector()%>
                                    </td>
                                </tr>
                            </table>
                            
                            <!-- Productpage selector -->
                            <table cellpadding="2" cellspacing="0">
                                <tr>
                                    <td style="width:170px" valign="top">
                                        <%=Translate.Translate("Product page")%>
                                    </td>
                                    <td>
                                        <%=Gui.LinkManager(NavigationProductPage, "NavigationProductPage", False, True)%>
                                    </td>
                                </tr>
                            </table>

                        <%=Gui.GroupBoxEnd()%>
                    </td></tr></table>
                </div>
                <script type="text/javascript">
                    updateNavigationDivs();
                </script>
			</div>
			<%End If%>
			
			<div id="Tab4" style="display: None;">
				<br>
				<table border="0" cellpadding="0" width="598">
					<tr>
						<td colspan="2">
							<%= Gui.GroupBoxStart(Translate.Translate("Detaljer"))%>
							<table cellpadding="2" cellspacing="0">
								<tr>
									<td valign="top" width="170">
										<%=Translate.Translate("Titel")%>
									</td>
									<td>
										<input type="text" name="PageDublincoreTitle" size="30" maxlength="255" value="<%=PageDublincoreTitle%>"
											class="std" style="width: 350px;"></td>
								</tr>
								<tr>
									<td valign="top">
										<%=Translate.Translate("Beskrivelse")%>
									</td>
									<td>
										<textarea name="PageDescription" cols="30" rows="3" wrap="on" style="width: 350px;
											height: 80px;" class="std"><%=PageDescription%></textarea></td>
								</tr>
								<tr>
									<td valign="top">
										<%=Translate.Translate("Nøgleord")%>
									</td>
									<td>
										<textarea name="PageKeywords" cols="30" rows="3" wrap="on" style="width: 350px; height: 80px;"
											class="std"><%=PageKeywords%></textarea></td>
								</tr>
							</table>
							<%= Gui.GroupBoxEnd%>
						</td>
					</tr>
					<input type="hidden" name="PageDublincore" value="PageDublincoreTitle, PageDublincoreSubject, PageDublincoreCopyright, PageDublincorePublisher, PageDublincoreRights, PageDublincoreCreator, PageDublincoreAuthor">
					<%	If Base.HasVersion("18.1.1.0") Then%>
					<%		If Base.GetGs("/Globalsettings/Settings/Performance/ActivateDublinCore") = "True" Then%>
					<tr>
						<td colspan="2">
							<%= Gui.GroupBoxStart(Translate.Translate("Dublin core"))%>
							<table cellpadding="2" cellspacing="0">
								<tr>
									<td valign="top" width="170">
										<%=Translate.Translate("Emne")%>
									</td>
									<td>
										<input type="text" name="PageDublincoreSubject" size="30" maxlength="255" value="<%=PageDublincoreSubject%>"
											class="std"></td>
								</tr>
								<tr>
									<td valign="top">
										<%=Translate.Translate("Forfatter")%>
									</td>
									<td>
										<input type="text" name="PageDublincoreAuthor" size="30" maxlength="255" value="<%=PageDublincoreAuthor%>"
											class="std"></td>
								</tr>
								<tr>
									<td valign="top">
										<%=Translate.Translate("Oprettet af")%>
									</td>
									<td>
										<input type="text" name="PageDublincoreCreator" size="30" maxlength="255" value="<%=PageDublincoreCreator%>"
											class="std"></td>
								</tr>
								<tr>
									<td valign="top">
										<%=Translate.Translate("Rettigheder")%>
									</td>
									<td>
										<input type="text" name="PageDublincoreRights" size="30" maxlength="255" value="<%=PageDublincoreRights%>"
											class="std"></td>
								</tr>
								<tr>
									<td valign="top">
										<%=Translate.Translate("Udgiver")%>
									</td>
									<td>
										<input type="text" name="PageDublincorePublisher" size="30" maxlength="255" value="<%=PageDublincorePublisher%>"
											class="std"></td>
								</tr>
								<tr>
									<td valign="top">
										<%=Translate.Translate("Copyright")%>
									</td>
									<td>
										<input type="text" name="PageDublincoreCopyright" size="30" maxlength="255" value="<%=PageDublincoreCopyright%>"
											class="std"></td>
								</tr>
							</table>
							<%= Gui.GroupBoxEnd%>
						</td>
					</tr>
					<%		End If%>
					<%	End If%>
				</table>
			</div>
			<div id="Tab5" style="display: None;">
				<br>
				<table border="0" cellpadding="0" width="598">
					<tr>
						<td colspan="2">
							<%= Gui.GroupBoxStart(Translate.Translate("Rettigheder"))%>
							<%
								Dim tmpArray() As String
							%>
							<%= Gui.UserGroupManager("PagePermission", "Grupper", "side", -1, PagePermissionArray, tmpArray)%>
							<%= Gui.GroupBoxEnd%>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<%= Gui.GroupBoxStart(Translate.Translate("Login"))%>
							<table cellpadding="2" cellspacing="0" border="0">
								<tr>
									<td width="170">
										<%=Translate.Translate("Vis i menu")%>
									</td>
									<td>
										<%= Gui.RadioButton(PagePermissionType, "PagePermissionType", "2")%>
										&nbsp;<%=Translate.Translate("Kun for brugere med adgang")%></td>
								</tr>
								<tr>
									<td>
									</td>
									<td>
										<%= Gui.RadioButton(PagePermissionType, "PagePermissionType", "1")%>
										&nbsp;<%=Translate.Translate("For alle brugere")%></td>
								</tr>
								<tr>
									<td>
										<%=Translate.Translate("Template - %%", "%%", Translate.Translate("Login"))%>
									</td>
									<td>
										<%= Gui.FileManager(PagePermissionTemplate, "Templates/Extranet", "PagePermissionTemplate")%>
									</td>
								</tr>
							</table>
							<%= Gui.GroupBoxEnd%>
						</td>
					</tr>
				</table>
			</div>
			<div id="Tab6" style="display: None;">
				<br />
				<table border="0" cellpadding="0" width="598">
					<tr>
						<td colspan="2">
							<%= Gui.GroupBoxStart(Translate.Translate("Rotationssider"))%>
							<table border="0" cellpadding="0" width="570">
								<%= getRotation() %>
								<tr>
									<td>
										<br />
									</td>
								</tr>
								<tr>
									<td colspan="2" align="right">
										<table cellpadding="0" cellspacing="0">
											<tr>
												<td>
													<%= Gui.Button(Translate.Translate("Tilføj side"), "Javascript:AddPage(" & SideID & ", " & AreaID & ", '');", 0)%>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
							<%= Gui.GroupBoxEnd%>
							<%	If Base.HasVersion("18.11.1.0") Then%>
							<%= Gui.GroupBoxStart(Translate.Translate("Type"))%>
							<table border="0" cellpadding="0" width="570">
								<tr>
									<td width="170">
									</td>
									<td>
										<%= Gui.RadioButton(PageRotationType, "PageRotationType", "0")%>
										<label for="PageRotationType0">
											<%=Translate.Translate("Afsnit")%>
										</label>
									</td>
								</tr>
								<tr>
									<td>
									</td>
									<td>
										<%= Gui.RadioButton(PageRotationType, "PageRotationType", "1")%>
										<label for="PageRotationType1">
											<%=Translate.Translate("Hele siden")%>
										</label>
									</td>
								</tr>
							</table>
							<%= Gui.GroupBoxEnd%>
							<%	End If%>
						</td>
					</tr>
				</table>
			</div>
			<div id="Tab7" style="display: None;">
				<br>
				<% 	If Base.HasAccess("Inherit", "") Then%>
				<table border="0" cellpadding="0" width="598">
					<tr>
						<td colspan="2">
							<%		If Base.ChkNumber(PageInheritID) > 0 Then%>
							<%= Gui.GroupBoxStart(Translate.Translate("Nedarves fra"))%>
							<table cellpadding="2" cellspacing="0">
								<tr>
									<td width="170" valign="top">
										<%=Translate.Translate("Side")%>
									</td>
									<td><%=GetInheritName(PageInheritID) %></td>
								</tr>
								<tr>
									<td valign="top">
										<%=Translate.Translate("Status")%>
									</td>
									<td>
										<%=Base.IIf(PageInheritStatus = 1, "<img src=""Images/infoicon.gif"" align=""absmiddle""> " & Translate.Translate("Skal tjekkes"), Translate.Translate("Alt i orden"))%>
									</td>
								</tr>
								<%			If IsDate(PageInheritUpdateDate) Then%>
								<tr>
									<td valign="top">
										<%=Translate.Translate("Sidste ændring")%>
									</td>
									<td>
										<%= Dates.ShowDate(CDate(PageInheritUpdateDate), Dates.DateFormat.Short, True)%>
									</td>
								</tr>
								<%			End If%>
							</table>
							<%= Gui.GroupBoxEnd%>
							<%		End If%>
							<%= Gui.GroupBoxStart(Translate.Translate("Nedarv til"))%>
							<table cellpadding="2" cellspacing="0">
								<tr>
									<td width="170" valign="top">
										<%=Translate.Translate("Sprog")%>
									</td>
									<td>
										<%=GetInheritArea(SideID, PageParentPageID, AreaID)%>
									</td>
								</tr>
							</table>
							<%= Gui.GroupBoxEnd%>
						</td>
					</tr>
				</table>
				<% 	End If%>
			</div>
			<div id="Tab8" style="display: none;">
				<br>
				<table cellspacing="0" border="0" cellpadding="0" width="598">
					<tr>
						<td>
							<%=Gui.GroupBoxStart(Translate.Translate("Godkendelse"))%>
							<table cellpadding="2" cellspacing="0">
								<tr>
									<td width="170" valign="top">
										<%=Translate.Translate("Versionsstyrings type")%>
									</td>
									<td>
										<%=Gui.ApprovalTypeBox(PageApprovalType, PageApprovalState) %>
									</td>
								</tr>
							</table>
							<%=Gui.GroupBoxEnd%>
						</td>
					</tr>
				</table>
			</div>
			<%
				'**** Inserting custom tab form Custom_Admin.asp
				'ToDo hvad var denne til. Tom??
				'If Custom_Page_ShowCustomTab Then
				'End If
			%>
			</td> </tr>
			<tr>
				<td align="right">
					<table>
						<tr>
							<td>
								<%
									If CanCreateLightVersionPages Then
										If Base.HasVersion("18.14.0.0") Then
											Response.Write(Gui.Button(Translate.Translate("Gem og luk"), "Send('Page_save.aspx');", 0))
											Response.Write(Gui.Button(Translate.Translate("Gem"), "Save('Page_Save.aspx?ID=" & SideID & "');", 0))
										Else
											Response.Write(Gui.Button(Translate.Translate("Gem"), "Send('Page_save.aspx');", 0))
										End If
									Else
										If Base.HasVersion("18.14.0.0") Then
											Response.Write(Gui.Button(Translate.Translate("Gem og luk"), "Send('Page_save.aspx');", 0, True))
											Response.Write(Gui.Button(Translate.Translate("Gem"), "Save('Page_Save.aspx?ID=" & SideID & "');", 0, True))
										Else
											Response.Write(Gui.Button(Translate.Translate("Gem"), "Send('Page_save.aspx');", 0, True))
										End If
									End If
								%>
							</td>
							<td>
								<%
									If Request.Item("Audit") = "true" Then
										Dim strAuditData As String = "Audit&=true&AuditUserID=" & Request.Item("AuditUserID") & "&AuditDateTimeFrom=" & Request.Item("AuditDateTimeFrom") & "&AuditDateTimeTo=" & Request.Item("AuditDateTimeTo") & "&AuditType=" & Request.Item("AuditType") & "&SortOrder=" & Request.Item("SortOrder") & "&SortField=" & Request.Item("SortField")
										Response.Write(Gui.Button(Translate.Translate("Annuller"), "location='/Admin/module/Audit/Audit_list.aspx?" & strAuditData & "';", 0))
									ElseIf Request.Item("NewsletterSubscription") = "true" Then
										'Dim strAuditData as string = "NewsletterSubscription&=true&AuditUserID=" & Request.Item("AuditUserID") & "&AuditDateTimeFrom=" & Request.Item("AuditDateTimeFrom") & "&AuditDateTimeTo=" & Request.Item("AuditDateTimeTo") & "&AuditType=" & Request.Item("AuditType") & "&SortOrder=" & Request.Item("SortOrder") & "&SortField=" & Request.Item("SortField")
										Response.Write(Gui.Button(Translate.Translate("Annuller"), "location='/admin/module/NewsletterSubscription/Subscription_Mail_Edit.aspx" & "';", 0))
									ElseIf Request.Item("NewsletterSubscription") = "false" Then
										Dim strAuditData As String = "NewsletterSubscription&=true&AuditUserID=" & Request.Item("AuditUserID") & "&AuditDateTimeFrom=" & Request.Item("AuditDateTimeFrom") & "&AuditDateTimeTo=" & Request.Item("AuditDateTimeTo") & "&AuditType=" & Request.Item("AuditType") & "&SortOrder=" & Request.Item("SortOrder") & "&SortField=" & Request.Item("SortField")
										Response.Write(Gui.Button(Translate.Translate("Annuller"), "location='/admin/module/NewsletterSubscription/Subscription_Search.aspx?" & strAuditData & "';", 0))
									Else
								        Response.Write(Gui.Button(Translate.Translate("Annuller"), "cancelEditing();", 0))
									End If
								%>
							</td>
							<%
								Dim Custom_Page_CustomButton As Boolean
								Dim Custom_Page_CustomButtonText As String
								Dim Custom_Page_CustomButtonAction As String
					 
								'Try
								'	Dim loCodeParms() As Object
								'	Custom_Page_CustomButton = myModule.CallFunction("Custom_Admin", "Custom_Page_CustomButton", loCodeParms)
								'	Custom_Page_CustomButtonText = myModule.CallFunction("Custom_Admin", "Custom_Page_CustomButtonText", loCodeParms)
								'	Custom_Page_CustomButtonAction = myModule.CallFunction("Custom_Admin", "Custom_Page_CustomButtonAction", loCodeParms)
								'Catch ex As Exception
								'	'txtOutput.Text = txtOutput.Text & "Some error " & vbNewLine
								'End Try 
								If Custom_Page_CustomButton Then%>
							<td>
								<%	'= Gui.Button(Custom_Page_CustomButtonText, Custom_Page_CustomButtonAction, 0)%>
							</td>
							<%	End If%>
							<%=Gui.HelpButton("Page_Edit", "page.edit")%>
						</tr>
						<tr height="5">
							<td>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			</form> </table>
			<%  
				Response.Write(Gui.SelectTab(Base.Request("Tab")))

				Translate.GetEditOnlineScript()
			%>
	</body>
</html>
