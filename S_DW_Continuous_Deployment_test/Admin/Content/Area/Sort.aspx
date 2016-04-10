<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sort.aspx.vb" Inherits="Dynamicweb.Admin.AreaSort" %>
<%@ Import Namespace="Dynamicweb.Backend"%>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    
    <dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true" IncludeScriptaculous="true"></dw:ControlResources>
    
    <link rel="Stylesheet" href="/Admin/Images/Ribbon/UI/List/List.css" />
	<link rel="Stylesheet" href="Sort.css" />
	<script src="Sort.js" type="text/javascript"></script>
</head>
<body onload="sort_init();" style="overflow:hidden;">
	
	
    <form id="form1" runat="server">
		<dw:Toolbar ID="Toolbar1" runat="server">
			<dw:ToolbarButton ID="ToolbarButton2" runat="server" Divide="None" Image="Save" Text="Gem" OnClientClick="sortSave();" ShowWait="true">
			</dw:ToolbarButton>
			<dw:ToolbarButton ID="ToolbarButton1" runat="server" Divide="None" Image="Cancel" Text="Annuller" OnClientClick="location='List.aspx';" ShowWait="true">
			</dw:ToolbarButton>
		</dw:Toolbar>
		<h2 class="subtitle">
			<dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Sort" />
		</h2>
		<div class="list">
		<asp:Repeater ID="PagesRepeater" runat="server" enableviewstate="false">
			<HeaderTemplate>
			<ul>
				<li class="header">
					<span class="C0">
					    
					</span>
					<span class="pipe"></span>
					<span class="C1"><%=Translate.Translate("ID")%></span>
					<span class="pipe"></span>
					<span class="C2"><%=Translate.Translate("Sprog",9)%></span> 
					<span class="pipe"></span>
					<span class="C3"><%=Translate.Translate("Sider")%></span>
					<span class="pipe"></span>
					<span class="C3"><%=Translate.Translate("Aktiv")%></span>
					<span class="pipe"></span>
					<span class="C3"><%=Translate.Translate("Domæne")%></span>
					<span class="pipe"></span>
					<span class="C4"><dw:TranslateLabel ID="tl5" runat="server" Text="Primær domæne" /></span> 
					<span class="pipe"></span>
					<span class="C4"><%=Translate.Translate("Redigeret")%></span> 
					<span class="pipe"></span>
				</li>
			</ul>
			<div id="_contentWrapper">
			<ul id="items">
			</HeaderTemplate>
			<ItemTemplate>
				<li id="Area_<%# Eval("ID") %>">
					<span class="C0" style="padding: 0px;padding-top:2px;padding-left:5px;overflow:hidden;">
						<span style="padding: 0px;padding-top:1px;" class="Show<%#Eval("Active")%>"><a href="/Default.aspx?AreaID=<%#Eval("ID")%>" target="_blank" style="height:16px;width:16px;"><img src="/Admin/Images/Ribbon/Icons/Small/earth.png" alt="<%#Eval("ID")%>" width="16" height="16" /></a>&nbsp;</span>
						
					</span>
					<span class="C1 Show<%#Eval("Active")%>"><%# Eval("ID") %></span>
					<span class="C2 Show<%#Eval("Active")%>" style="padding-left: 2px">
						<a href="<%#GetOnclickAction(Dynamicweb.Base.Chknumber(Eval("ID")))%>" class="Show<%#Eval("Active")%>"><%#Eval("Name")%></a>
					</span>
					<span class="C3 Show<%#Eval("Active")%>">
						<%#Eval("PageCount")%>
					</span>
					<span class="C3">
						<%#ActiveGif(CType(Container.DataItem, Dynamicweb.Content.Area).Active)%>
					</span> 
					<span class="C3 Show<%#Eval("Active")%>">
						<%#DomainCount(CType(Container.DataItem, Dynamicweb.Content.Area))%>
					</span>
					<span class="C4 Show<%#Eval("Active")%>" style="padding-left: 12px">
						<%#Eval("DomainLock")%>
					</span>
					<span class="C4 Show<%#Eval("Active")%>" style="padding-left: 4px" title="<%=Translate.Translate("Oprettet")%>: <%#Eval("CreatedDate", "{0:ddd, dd MMM yyyy HH':'mm}")%>">
						<%#Eval("UpdatedDate", "{0:ddd, dd MMM yyyy HH':'mm}")%>
					</span>					
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
	
    <div id="BottomInformationBg">
	<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td rowspan="2"><img src="/Admin/Images/Ribbon/Icons/document_new.png" alt="" /></td>
			<td align="right"><span class="label"><span id="AreaCount" runat="server"></span> <dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Items" /></span></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
	</table>
	</div>
</body>
</html>
