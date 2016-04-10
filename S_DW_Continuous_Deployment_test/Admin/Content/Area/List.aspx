<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="List.aspx.vb" Inherits="Dynamicweb.Admin.List3" %>
<%@ Import Namespace="Dynamicweb.Backend"%>
<%@ Import Namespace="Dynamicweb"%>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    
    <dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true" IncludeScriptaculous="true"></dw:ControlResources>
    
    <link rel="Stylesheet" href="/Admin/Images/Ribbon/UI/List/List.css" />
	<link rel="Stylesheet" href="List.css" />

    <asp:Literal ID="litPermissionsScript" runat="server" />

	<script src="List.js" type="text/javascript"></script>
    <script type="text/javascript">
         allowedPageCount = <%=GetMaxNumberOfPages()%>;
         numberOfPagesInSolution = <%=GetNumberOfPages()%>;
    </script>
</head>
<body style="overflow:hidden;">
	<dw:RibbonBar ID="areaRibbon" runat="server">
		<dw:RibbonBarTab ID="RibbonBarTab1" runat="server" Name="Website">
			<dw:RibbonBarGroup ID="RibbonbarGroup1" runat="server" Name="Website">
			
				<dw:RibbonBarButton ID="btnNewWebsite" runat="server" OnClientClick="newAreaDialog();" Imagepath="/Admin/Images/Ribbon/Icons/small/earth_new.png" Disabled="false" Size="Small" Text="New website">
				</dw:RibbonBarButton>
				<dw:RibbonBarButton ID="btnNewLanguage" runat="server" OnClientClick="newLanguageDialog();" Imagepath="/Admin/Images/Ribbon/Icons/small/earth_add.png" Disabled="false" Size="Small" Text="Nyt sprog" Visible="false">
				</dw:RibbonBarButton>
				<dw:RibbonBarButton ID="cmdShowWebsite" runat="server" Imagepath="/Admin/Images/Ribbon/Icons/earth_view.png" Size="Large" Text="Vis" OnClientClick="showBtn();">
				</dw:RibbonBarButton>
			</dw:RibbonBarGroup>
				
			<dw:RibbonBarGroup ID="RibbonbarGroup2" runat="server" Name="Tools">
				<dw:RibbonBarButton ID="cmdSortAreas" runat="server" OnClientClick="location='Sort.aspx';" Imagepath="/Admin/Images/Ribbon/Icons/Small/sort_ascending.png" Size="Small" Text="Sort">
				</dw:RibbonBarButton>
				<dw:RibbonBarButton ID="cmdEditArea" runat="server" Active="false" Disabled="false" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/earth_edit.png" Text="Rediger" OnClientClick="edit();">
				</dw:RibbonBarButton>
				<dw:RibbonBarButton ID="cmdDeleteArea" runat="server" Imagepath="/Admin/Images/Ribbon/Icons/Small/earth_delete.png" Size="Small" Text="Delete" OnClientClick="deleteAreaBtn();">
				</dw:RibbonBarButton>
				<dw:RibbonBarButton ID="cmdCopyArea" runat="server" Image="Copy" Size="Small" Text="Kopier" OnClientClick="copyDialog();">
				</dw:RibbonBarButton>
				<dw:RibbonBarButton ID="cmdExportArea" runat="server" Active="false" Disabled="false" Size="Small" Text="Eksporter" Imagepath="/Admin/Images/Ribbon/Icons/Small/export1.png" OnClientClick="showExportAreaDialog();">
				</dw:RibbonBarButton>
				<dw:RibbonBarButton ID="cmdImportArea" runat="server" Active="false" Disabled="false" Size="Small" Text="Import" Imagepath="/Admin/Images/Ribbon/Icons/Small/import1.png" OnClientClick="importArea();">
				</dw:RibbonBarButton>
				
			</dw:RibbonBarGroup>
			<dw:RibbonBarGroup ID="RibbonbarGroup3" runat="server" Name="Help">
			    <dw:RibbonBarButton ID="RibbonbarButton10" runat="server" Size="Large" Image="Help" Text="Help" OnClientClick="help();">
			    </dw:RibbonBarButton>
			</dw:RibbonBarGroup>
		</dw:RibbonBarTab>
	</dw:RibbonBar>
	
    <form id="form1" runat="server">
   
		<div class="list">
		<asp:Repeater ID="PagesRepeater" runat="server" enableviewstate="false">
			<HeaderTemplate>
			<div id="_contentWrapper">
			<ul>
				<li class="header">
					<span class="C0" style="padding-top: 0px; ">
					    
					</span>
					<span class="pipe"></span>
					<span class="C1"><%=Translate.Translate("ID")%></span>
					<span class="pipe"></span>
					<span class="C2"><%=Translate.Translate("Website")%></span> 
					<span class="pipe"></span>
					<span class="C3_1"><%=Translate.Translate("Sprog")%></span>
					<span class="pipe"></span>
					<span class="C3"><%=Translate.Translate("Sider")%></span>
					<span class="pipe"></span>
					<span class="C3"><%=Translate.Translate("Aktiv")%></span>
					<span class="pipe"></span>
					<span class="C3"><%=Translate.Translate("Domains")%></span>
					<span class="pipe"></span>
					<span class="C4"><dw:TranslateLabel ID="tl5" runat="server" Text="Primær domæne" /></span> 
					<span class="pipe"></span>
					<span class="C4"><%=Translate.Translate("Redigeret")%></span> 
					<span class="pipe"></span>
				</li>
			</ul>
			
			<ul id="items">
			</HeaderTemplate>
			<ItemTemplate>
				<li id="Area_<%# Eval("ID") %>" oncontextmenu="<%#ContextAction(CType(Container.DataItem, Dynamicweb.Content.Area)) %>" onclick="<%#ClickAction(CType(Container.DataItem, Dynamicweb.Content.Area))%>" class="<%#GetItemCssClass(CType(Container.DataItem, Dynamicweb.Content.Area))%>">
					<span class="C0" style="padding: 0px;padding-top:2px;padding-left:5px;overflow:hidden;">
						<span style="padding: 0px;padding-top:1px;" class="Show<%#Eval("Active")%>"><a href="/Default.aspx?AreaID=<%#Eval("ID")%>" target="_blank" style="height:16px;width:16px;"><img src="/Admin/Images/Ribbon/Icons/Small/earth.png" alt="<%#Eval("ID")%>" width="16" height="16" class="Hide<%#CType(Container.DataItem, Dynamicweb.Content.Area).IsLanguage %>" /><img src="/x.gif" alt="<%#Eval("ID")%>" width="16" height="16" class="Show<%#CType(Container.DataItem, Dynamicweb.Content.Area).IsLanguage %>" /></a>&nbsp;</span>
						<input id="A<%# Eval("ID") %>" type="radio" <%#IIf(CType(Container.DataItem, Dynamicweb.Content.Area).id=1, "checked='checked'", "") %> name="Area" value="<%# Eval("ID") %>" <%#IIf(Not IsAccessibleArea(CType(Container.DataItem, Dynamicweb.Content.Area)), " disabled='disabled' ", "")%> />
					</span>
					<span class="C1 Show<%#Eval("Active")%>"><%# Eval("ID") %></span>
					<span class="C2 Show<%#Eval("Active")%>">
						<a <%#EditAction(CType(Container.DataItem, Dynamicweb.Content.Area)) %>><font>
						<img src="/Admin/Images/Ins.gif" style="vertical-align:middle;margin-left:12px;" alt="" class="Show<%#CType(Container.DataItem, Dynamicweb.Content.Area).LanguageDepth > 1 %>" /> 
						<img src="/Admin/Images/Ins.gif" style="vertical-align:middle;margin-left:3px;" alt="" class="Show<%#CType(Container.DataItem, Dynamicweb.Content.Area).LanguageDepth = 1 %>" />
						<font id="AreaName<%# Eval("ID") %>"><%#Eval("Name")%></font></font></a>
					</span>
					<span class="C3_1 Show<%#Eval("Active")%>" id="AreaCulture<%# Eval("ID") %>"><img style="padding-left: 2px" src="<%#Eval("Flag16x16") %>" align="absmiddle" /> <%#Eval("Culture")%></span>
					<span class="C3 Show<%#Eval("Active")%>" id="AreaPagecount<%# Eval("ID") %>">
						<%#Eval("PageCount")%>
					</span>
					<span class="C3">
						<a href="javascript:toggleActive(<%# Eval("ID") %>, '<%# Eval("Active") %>');" class="browseHide"><%# ActiveGif(CType(Container.DataItem, Dynamicweb.Content.Area))%></a>
						<span id="AreaActive<%# Eval("ID") %>" style="display:none;"><%#Eval("Active")%></span>
					</span> 
					<span class="C3 Show<%#Eval("Active")%>" title="<%#DomainList(CType(Container.DataItem, Dynamicweb.Content.Area), False)%>">
						<%#DomainCount(CType(Container.DataItem, Dynamicweb.Content.Area))%>
					</span>
					<span class="C4 Show<%#Eval("Active")%>" style="padding-left: 12px">
						<%#Eval("DomainLock")%>
					</span>
					<span class="C4 Show<%#Eval("Active")%>" title="<%=Translate.Translate("Oprettet")%>: <%#Eval("CreatedDate", "{0:ddd, dd MMM yyyy HH':'mm}")%>">
						<%#Eval("UpdatedDate", "{0:ddd, dd MMM yyyy HH':'mm}")%>
					</span>
					<span id="IsLanguage<%# Eval("ID") %>" style="display:none;"><%#Eval("IsLanguage")%></span>
                    <span id="LanguageDepth<%# Eval("ID") %>" style="display:none;"><%#Eval("LanguageDepth")%></span>
                    
					<span id="UserPermissions<%# Eval("ID") %>" style="display:none;"><%#Eval("UserPermissions")%></span>
				</li>
			</ItemTemplate>
			<FooterTemplate>
				</ul>
				</div>
			</FooterTemplate>
		</asp:Repeater>
        <dw:Infobar ID="infoNoPermissions" Visible="false" Type="Error" Message="You do not have access to this functionality" runat="server" /> 

		</div>
    
    </form>
    
	<dw:Dialog ID="dialogDelete" runat="server" Title="Slet" TranslateTitle="false" ShowOkButton="true" ShowCancelButton="true" OkAction="deleteArea();" CancelAction="dialog.hide('dialogDelete');">
		<img src="/Admin/Images/Ribbon/Icons/warning.png" alt="" style="vertical-align:middle;" />
		<%=Translate.JsTranslate("Slet %%?", "%%", Translate.JsTranslate("website"))%>
		<br />
		<b id="areaNameb" style="display:block;text-align:center;"></b>
		<br /><br />
		<b><%=Translate.JsTranslate("ADVARSEL!")%><br /></b>
		<div id="multipleLanguageVersionsWarning" style="display:none;"><%=Translate.JsTranslate("Alle sprog %% vil blive slettet!", "%%", Translate.JsTranslate("websites"))%></div>
        <div><%=Translate.JsTranslate("Alle %% og indhold vil blive slettet!", "%%", Translate.JsTranslate("sider"))%></div>
	</dw:Dialog>

	<dw:Dialog ID="dialogImport" runat="server" Title="Import" ShowClose="true" isiframe="True" width="500">
	
	</dw:Dialog>

	<dw:Dialog ID="dialogNewWebsite" runat="server" Title="New website" CancelAction="dialog.hide('dialogNewWebsite');" ShowOkButton="true" ShowCancelButton="true" OkAction="newArea();" HidePadding="false">
		<form id="newWebsiteForm" onsubmit="newArea();return false;">
		<dw:GroupBox ID="GroupBox3" runat="server" Title="Settings">
		    <table>
			    <tr><td valign="top" width="170" class="nobr"><dw:TranslateLabel ID="TranslateLabel10" runat="server" Text="Name" /></td><td>
				    <input type="text" id="NewWebsiteName" maxlength="255" class="NewUIinput" />
				</td></tr>
			    <tr><td valign="top" class="nobr"><dw:TranslateLabel ID="TranslateLabel11" runat="server" Text="Regionale indstillinger" /></td><td>
				    <%=Dynamicweb.Gui.CultureList("", "NewWebsiteCulture")%>
				</td></tr>
		    </table>
		</dw:GroupBox>
		</form>
	</dw:Dialog>
	
	<dw:Dialog ID="dialogCopy" runat="server" Title="Copy website?" CancelAction="dialog.hide('dialogCopy');" ShowOkButton="true" ShowCancelButton="true" OkAction="copy();" HidePadding="false">
	<form id="copyform">
	<input type="hidden" name="isLanguage" id="isLanguage" value="false" />
	<dw:GroupBox ID="GbSettings" runat="server" Title="Settings">
		    <table>
				<tr><td valign="top" width="170" class="nobr"><dw:TranslateLabel ID="TranslateLabel12" runat="server" Text="Kopier fra" /></td><td>
				    <input type="text" id="areaNamebCopy" maxlength="255" class="NewUIinput" readonly="readonly" disabled="disabled" />
				</td></tr>
			    <tr id="NewAreaNameRow"><td valign="top" width="170" class="nobr"><dw:TranslateLabel ID="tl1" runat="server" Text="Name" /></td><td>
				    <input type="text" id="AreaName" maxlength="255" class="NewUIinput" />
				</td></tr>
			    <tr><td valign="top" class="nobr"><dw:TranslateLabel ID="tl2" runat="server" Text="Regionale indstillinger" /></td><td>
				    <%=Dynamicweb.Gui.CultureList("", "AreaCulture")%>
				</td></tr>
		    </table>
		</dw:GroupBox>
		<div id="copySettings">
		<dw:GroupBox ID="GroupBox1" runat="server" Title="Kopier" DoTranslation="true">
		<table>
			<tr>
				<td>
					<dw:RadioButton runat="server" FieldName="CopyWhat" FieldValue="2" SelectedFieldValue="2" /> <label for="CopyWhat2"><dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="Structure and paragraphs" /></label>
				</td>
			</tr>
			<tr>
				<td>
					<dw:RadioButton runat="server" FieldName="CopyWhat" FieldValue="1" /><label for="CopyWhat1"> <dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Structure only" /></label>
				</td>
			</tr>
			<tr>
				<td>
					<dw:RadioButton runat="server" FieldName="CopyWhat" FieldValue="3" /><label for="CopyWhat3"> <dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Website settings" /></label>
				</td>
			</tr>
		</table>
		</dw:GroupBox>
		<dw:GroupBox ID="updateLinksGroup" runat="server" Title="Links" DoTranslation="true">
		<table>
			<tr>
				<td>
					<dw:CheckBox ID="updateContentLinks" runat="server" Value="1" FieldName="updateContentLinks" SelectedFieldValue="1" /> <label for="updateContentLinks"><dw:TranslateLabel ID="TranslateLabel13" runat="server" Text="Indhold" /></label>
				</td>
			</tr>
			<tr>
				<td>
					<dw:CheckBox ID="updateShortcuts" runat="server" Value="1" FieldName="updateShortcuts" SelectedFieldValue="1" /> <label for="updateShortcuts"><dw:TranslateLabel ID="TranslateLabel14" runat="server" Text="Genvej" /></label>
				</td>
			</tr>
			<tr>
				<td>
					<dw:CheckBox ID="updateGlobalparagraphs" runat="server" Value="1" FieldName="updateGlobalparagraphs" SelectedFieldValue="1" /> <label for="updateGlobalparagraphs"><dw:TranslateLabel ID="TranslateLabel15" runat="server" Text="Global element" /></label>
				</td>
			</tr>
		</table>
		</dw:GroupBox>
		</div>
		<dw:GroupBox ID="GroupBox2" runat="server" Title="Rettigheder" DoTranslation="true">
		<table>
			<tr>
				<td>
					<dw:CheckBox ID="CopyPermissions" runat="server" Value="1" FieldName="CopyPermissions" SelectedFieldValue="1" /> <label for="CopyPermissions"><%=Translate.JsTranslate("Kopier %%?", "%%", Translate.JsTranslate("rettigheder"))%></label>
				</td>
			</tr>
		</table>
		</dw:GroupBox>
	
	</form>
	</dw:Dialog>

    <dw:Dialog ID="ExportAreaDialog" Width="200" runat="server" Title="Select export mode" ShowOkButton="true" ShowCancelButton="true" ShowClose="false" CancelAction="dialog.hide('ExportAreaDialog');" OkAction="exportArea();">
		<table cellpadding="1" cellspacing="1">
            <tr>
				<td>
					<input type="radio" id="chkFullExport" name="RenamedFile" disabled="disabled" />
                    <label for="chkFullExport" style="color: #999999"><%= Translate.Translate("Full export")%></label>
				</td>
            </tr>
            <tr>
				<td>
					<input type="radio" id="chkTranslationExport" name="RenamedFile" checked="checked" />
                    <label for="chkTranslationExport"><%= Translate.Translate("Translation export")%></label>
				</td>
            </tr>
		</table>
	</dw:Dialog>
	
    <div id="BottomInformationBg">
	<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td rowspan="2"><img src="/Admin/Images/Ribbon/Icons/document_new.png" alt="" /></td>
			<td align="right"><span id="AreaCount" runat="server" class="label"></span></td><td><span class="label"><dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Items" /></span></td>
		</tr>
		<tr>
			<td align="right"><span id="PageCount" runat="server" class="label"></span></td><td><span class="label"><dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Sider" /></span></td>
		</tr>
	</table>
	</div>
	
	<dw:ContextMenu ID="AreaContext" OnClientSelectView="onContextMenuSelectView" runat="server">
		<dw:ContextMenuButton ID="cmdView" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/earth_view.png" Text="Vis" OnClientClick="showC();" />
		<dw:ContextMenuButton ID="cmdEdit" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/earth_edit.png" Text="Rediger" OnClientClick="edit();" />
		<dw:ContextmenuButton ID="cmdActive" runat="server" Divide="None" Image="Check" Text="Aktiv" OnClientClick="toggleActive(ContextMenu.callingID, 'False');" />
		<dw:ContextmenuButton ID="cmdInactive" runat="server" Divide="None" Image="Delete" Text="Exclude" OnClientClick="toggleActive(ContextMenu.callingID, 'True');" />
		<dw:ContextmenuButton ID="cmdCopy" runat="server" Divide="Before" Image="Copy" Text="Kopier" OnClientClick="copyDialog();" />
		<dw:ContextmenuButton ID="cmdExport" runat="server" Divide="None" Text="Eksporter" Imagepath="/Admin/Images/Ribbon/Icons/Small/export1.png" OnClientClick="showExportAreaDialog();" />
		<dw:ContextMenuButton ID="cmdDelete" runat="server" Divide="Before" ImagePath="/Admin/Images/Ribbon/Icons/Small/earth_delete.png" Text="Slet" OnClientClick="deleteAreaDialog();" />
	</dw:ContextMenu>

	<span style="display:none">
	<span id="CantDisplayNoPagesMessage"><dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="A website with no pages cannot be shown." /></span>
	<span id="CantDisplayNotActiveMessage"><dw:TranslateLabel ID="TranslateLabel7" runat="server" Text="Inactive websites cannot be shown" /></span>
	<span id="CopyDialogTitle"><dw:TranslateLabel ID="TranslateLabel213" runat="server" Text="Kopier sproglaget?" /></span>
	<span id="NewLanguageDialogTitle"><dw:TranslateLabel ID="TranslateLabel212" runat="server" Text="Nyt sprog" /></span>
	<span id="CopyText"><dw:TranslateLabel ID="TranslateLabel8" runat="server" Text="Kopi" /></span>
	<span id="CopySpecifyName"><%=Translate.JSTranslate("Der skal angives en værdi i: %%", "%%", Translate.Translate("Navn"))%></span>
	<span id="CopySpecifyCulture"><%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.Translate("Regionale indstillinger"))%></span>
    <span id="ExceedAllowedPageCount"><%= Translate.JsTranslate("This will exceed the allowed number of pages! Allowed number of page is - %%", "%%", GetMaxNumberOfPages().ToString())%></span>
	
	
	</span>
	<script type="text/javascript">
		selectRow(1);
	</script>
	
	<dw:Overlay ID="copyWait" runat="server" Message="" ShowWaitAnimation="True">
		<dw:TranslateLabel ID="TranslateLabel9" runat="server" Text="Kopierer" />...
	</dw:Overlay>
	<iframe src="about:blank" id="copyframe" style="display:none;position:fixed;bottom:0px;right:0px;width:500px;z-index:10000;">
	</iframe>
	<%Translate.GetEditOnlineScript()%>
	
<!-- Help button start-->
	<script type="text/javascript">
	function help(){
		<%=Dynamicweb.Gui.Help("", "modules.area.general") %>
	}
	</script>
<!-- Help button end-->
</body>
</html>
