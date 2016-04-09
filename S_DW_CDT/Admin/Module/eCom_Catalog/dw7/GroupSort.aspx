<%@ Page Language="vb" MasterPageFile="~/Admin/Module/eCom_Catalog/dw7/Main.Master"
    AutoEventWireup="false" CodeBehind="GroupSort.aspx.vb" Inherits="Dynamicweb.Admin.GroupSort" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<asp:Content ID="Header" ContentPlaceHolderID="HeadHolder" runat="server">
	<link rel="Stylesheet" href="/Admin/Images/Ribbon/UI/List/List.css" />
    <link rel="Stylesheet" href="css/GroupSort.css" />
    <script type="text/javascript" src="js/dwsort.js"></script>
    <script type="text/javascript" src="js/GroupSort.js"></script>
</asp:Content>
<asp:Content ID="Content" ContentPlaceHolderID="ContentHolder" runat="server">
    <dw:Toolbar ID="toolbar" runat="server" ShowEnd="false">
		<dw:ToolbarButton runat="server" Text="Gem" Image="Save" OnClientClick="save();" ID="Save" />
		<dw:ToolbarButton runat="server" Text="Annuller" Image="Cancel" OnClientClick="cancel();" ID="Cancel" />        
        <dw:ToolbarButton runat="server" Text="Move to top" ImagePath="/Admin/Images/Ribbon/Icons/Small/ArrowDoubleUp.png" OnClientClick="moveToTop();" ID="btnMoveToTop" />
        <dw:ToolbarButton runat="server" Text="Move to bottom" ImagePath="/Admin/Images/Ribbon/Icons/Small/ArrowDoubleDown.png" OnClientClick="moveToBottom();" ID="btnMoveToBottom" />        
    </dw:Toolbar>
    <div id="breadcrumb" class="breadcrumb" runat="server">products/prod1</div>
        <input type="hidden" id="group" value="<%=GroupID %>" />
        <input type="hidden" id="shop" value="<%=ShopID %>" />
        <input type="hidden" id="path" value="<%=HttpUtility.HtmlAttributeEncode(Path) %>" />
		<div class="list">
			<ul>
				<li class="header">
					<span class="w20px" style="padding-top: 0px;">
					</span>
					<span class="pipe"></span>
					<span>
					    <a href="#" onclick="sorter.sortBy('name'); return false;"><%=Translate.Translate("Name")%></a>
					    <img style="display:none;" id="name_up"   src="/Admin/Images/ColumnSortUp.gif"/>
					    <img style="display:none;" id="name_down" src="/Admin/Images/ColumnSortDown.gif"/>
					</span> 
				</li>
			</ul>
	    <dw:StretchedContainer ID="SortingContainer" Scroll="Auto" Stretch="Fill" Anchor="document" runat="server">
			<ul id="items">
    		    <asp:Repeater ID="GroupsRepeater" runat="server" enableviewstate="false">
	    		    <ItemTemplate>
				    <li id="Group_<%#Eval("ID")%>" class="">
                        <%If Dynamicweb.Base.HasVersion("8.4.1.0") Then%>
                        <span>
                             <input id="checkBox_<%#Eval("ID")%>" type="checkbox" name="checkBox_<%#Eval("ID")%>" onclick="handleCheckboxes(this);" />                        </span> 
                        <%End If%>
					    <span class="w20px" style="padding-top: 2px;padding-left:5px;overflow:hidden;">
						    <img src="/Admin/Images/Ribbon/Icons/Small/Document.png" />
					    </span>
					    <span><%#Eval("Name")%></span> 
				    </li></ItemTemplate>
    		    </asp:Repeater>
			</ul>
            
        </dw:StretchedContainer>
        <div id="BottomInformationBg">
        <table border="0" cellpadding="0" cellspacing="0">
	        <tr>
		        <td rowspan="2"><img src="/Admin/Images/Ribbon/Icons/document_new.png" alt="" /></td>
		        <td align="right"><span class="label"><span id="GroupsCount" style="padding:0;" runat="server"></span>&nbsp;<dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Groups" /></span></td>
	        </tr>
	        <tr>
		        <td>&nbsp;</td>
	        </tr>
        </table>
        </div>
    </div>
</asp:Content>
