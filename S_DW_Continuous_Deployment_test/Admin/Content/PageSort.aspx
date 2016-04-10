<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PageSort.aspx.vb" Inherits="Dynamicweb.Admin.PageSort" %>
<%@ Import Namespace="Dynamicweb.Backend"%>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<meta http-equiv="Content-Type"  content="text/html;charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
    <title>Page sorting</title>
	<dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true" IncludeScriptaculous="true"></dw:ControlResources>
	
	<link rel="Stylesheet" href="/Admin/Images/Ribbon/UI/List/List.css" />
	<link rel="Stylesheet" href="PageSort.css" />
	<script src="PageSort.js" type="text/javascript"></script>
</head>
<body onload="sort_init();" style="overflow:hidden;">
    <dw:Toolbar ID="toolbar" runat="server" ShowEnd="false">
		<dw:ToolbarButton runat="server" Text="Gem" Image="Save" OnClientClick="save();" ID="Save" ShowWait="true" />
        <dw:ToolbarButton runat="server" Text="Save and close" Image="SaveAndClose" OnClientClick="saveAndClose();" ID="SaveAndClose" ShowWait="true" />
		<dw:ToolbarButton runat="server" Text="Annuller" Image="Cancel" OnClientClick="cancel();" ID="Cancel" ShowWait="true" />
    </dw:Toolbar>
    <h2 class="subtitle"><%=Translate.Translate("Sidesortering")%></h2>
    <div id="breadcrumb" runat="server">asdfa</div>
    <form id="form1" runat="server">
    <div id="content" style="position: fixed; top: 67px; left: 0; bottom:5px; right:0; overflow:auto;">
        <input type="hidden" id="ParentPageID" value="<%=parentPageID %>" />
        <input type="hidden" id="SelectedPageID" value="<%=selectedPageID %>" />
        <input type="hidden" id="SelectedPageParentsID" value="<%=selectedPageParentsID %>" />
        <input type="hidden" id="AreaID" value="<%=areaID %>" />
		<div class="list">
		<asp:Repeater ID="PagesRepeater" runat="server" enableviewstate="false">
			<HeaderTemplate>
			<ul>
				<li class="header">
					<span class="C1" style="padding-top: 0px;">
					</span>
					<span class="pipe"></span>
					<span class="C2" id="sort_name">
					    <a href="#" onclick="sort_name(); return false;"><%=Translate.Translate("Sidenavn")%></a>
					    <img style="display:none;" id="sort_name_up" src="/Admin/Images/ColumnSortUp.gif"/>
					    <img style="display:none;" id="sort_name_down" src="/Admin/Images/ColumnSortDown.gif"/>
					</span> 
					<span class="pipe"></span>
					<span class="C3" id="Span1"><%=Translate.Translate("Sortering")%>
					</span>
					<span class="pipe"></span>
					<span class="C4" id="sort_created">
					    <a href="#" onclick="sort_created(); return false;"><%=Translate.Translate("Oprettet")%></a>
					    <img style="display:none;" id="sort_created_up" src="/Admin/Images/ColumnSortUp.gif"/>
					    <img style="display:none;" id="sort_created_down" src="/Admin/Images/ColumnSortDown.gif"/>
					</span> 
					<span class="pipe"></span>
					<span class="C4" id="sort_updated">
					    <a href="#" onclick="sort_updated(); return false;"><%=Translate.Translate("Redigeret")%></a>
					    <img style="display:none;" id="sort_updated_up" src="/Admin/Images/ColumnSortUp.gif"/>
					    <img style="display:none;" id="sort_updated_down" src="/Admin/Images/ColumnSortDown.gif"/>
					</span> 
					<span class="pipe"></span>
				</li>
			</ul>
			<div id="_contentWrapper">
			<ul id="items">
			</HeaderTemplate>
			<ItemTemplate>
				<li id="Page_<%# Eval("ID") %>" class="Show<%#Eval("Active")%>">
					<span class="C1" style="padding-top: 2px;padding-left:5px;overflow:hidden;">
						<img src="../Images/Ribbon/Icons/Small/Document.png" /></span>
					<span class="C2"><%#Eval("MenuText")%></span> 
				    <div style="display:none;"><%#Eval("CreatedDate").Ticks%></div>
				    <div style="display:none;"><%#Eval("UpdatedDate").Ticks%></div>
				    <div style="display:none;"></div>
				    <span class="C3" id="Span1"><%#Eval("Sort")%>
					</span>
					<span class="C4">
						<%#Eval("CreatedDate", "{0:ddd, dd MMM yyyy HH':'mm':'ss}")%>
					</span>
					<span class="C4">
						<%#Eval("UpdatedDate", "{0:ddd, dd MMM yyyy HH':'mm':'ss}")%>
					</span>
				</li></ItemTemplate>
			<FooterTemplate>
				</ul>
			</div>
			</FooterTemplate>
		</asp:Repeater>
    </div>
    </form>
    
    <div id="BottomInformationBg">
	<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td rowspan="2"><img src="/Admin/Images/Ribbon/Icons/document_new.png" alt="" /></td>
			<td align="right"><span class="label"><span id="PageCount" runat="server"></span> <dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Sider" /></span></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
	</table>
	</div>
</body>
</html>
