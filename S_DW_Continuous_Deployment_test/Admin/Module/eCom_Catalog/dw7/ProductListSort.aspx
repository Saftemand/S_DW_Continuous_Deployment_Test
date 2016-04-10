﻿<%@ Page Language="vb" MasterPageFile="~/Admin/Module/eCom_Catalog/dw7/Main.Master"
AutoEventWireup="false" CodeBehind="ProductListSort.aspx.vb" Inherits="Dynamicweb.Admin.ProductListSort" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<asp:Content ID="Header" ContentPlaceHolderID="HeadHolder" runat="server">
	<link rel="Stylesheet" href="/Admin/Images/Ribbon/UI/List/List.css" />
    <script type="text/javascript" src="js/dwsort.js"></script>
    <script type="text/javascript" src="js/ProductListSort.js"></script>
	<style type="text/css">
        .list ul {
	        min-width:640px;
        }
        
        #items li {
	        cursor:default;
	        border-bottom:1px solid #BDCCE0;
        }

        .list li.header {
	        border-top:0px solid #BDCCE0;
	        min-width:640px;
        }

        #breadcrumb
        {
            border-bottom: #9faec2 1px solid;
            line-height: 18px;
            background-color: #ffffff;
            padding-left: 10px;
            display: inherit;
            height: 20px;
            vertical-align: middle;
        }

        #BottomInformationBg {
	        height:53px;
	        width:100%;
	        min-width:818px;
	        background-image:url('/Admin/Images/BottomInformationBg.png');
	        background-repeat:repeat-x;
	        position:fixed;
	        bottom:0px;
        }

        #BottomInformationBg img { margin:10px; }

        #BottomInformationBg .label {
	        color: #5A6779;
	        padding-left:5px;
	        padding-right:5px;
        }

        .w20px {
	        vertical-align:middle;
	        padding:0px;
	        width:20px;
	        white-space:nowrap;
	        overflow:hidden;
        }
        	
        .w225px {
	        white-space:nowrap;
	        overflow:hidden;
	        width:225px;
        }

        .w140px { width:140px; white-space:nowrap;overflow:hidden;}
        .w340px { width:340px; white-space:nowrap;overflow:hidden;}
        .w80px { width:80px; white-space:nowrap;overflow:hidden; }
        
        #items li.selected {
            background-color: #FFF8DC !important;
        }

	</style>
</asp:Content>
<asp:Content ID="Content" ContentPlaceHolderID="ContentHolder" runat="server">
    <dw:Toolbar ID="toolbar" runat="server" ShowEnd="false">
		<dw:ToolbarButton runat="server" Text="Gem" Image="Save" OnClientClick="save();" ID="Save" />
		<dw:ToolbarButton runat="server" Text="Annuller" Image="Cancel" OnClientClick="cancel();" ID="Cancel" />        
        <dw:ToolbarButton runat="server" Text="Move to top" ImagePath="/Admin/Images/Ribbon/Icons/Small/ArrowDoubleUp.png" OnClientClick="moveToTop();" ID="btnMoveToTop" />
        <dw:ToolbarButton runat="server" Text="Move to bottom" ImagePath="/Admin/Images/Ribbon/Icons/Small/ArrowDoubleDown.png" OnClientClick="moveToBottom();" ID="btnMoveToBottom" />        
    </dw:Toolbar>
    <h2 class="subtitle"><%=Translate.Translate("Sort products")%></h2>
    <div id="breadcrumb">
        <asp:Literal ID="Breadcrumb" runat="server"></asp:Literal>
    </div>
    <input type="hidden" id="GroupID" value="<%=GroupID %>" />
	<div class="list">
		<ul>
			<li class="header">
				<span class="w20px" style="padding-top: 0px;">
				</span>
				<span class="pipe"></span>
				<span class="w140px">
				    <a href="#" onclick="sorter.sortBy('id'); return false;"><%=Translate.Translate("Number")%></a>
				    <img style="display:none;" id="id_up"   src="/Admin/Images/ColumnSortUp.gif"/>
				    <img style="display:none;" id="id_down" src="/Admin/Images/ColumnSortDown.gif"/>
				</span> 
				<span class="pipe"></span>
				<span class="w340px">
				    <a href="#" onclick="sorter.sortBy('name'); return false;"><%=Translate.Translate("Name")%></a>
				    <img style="display:none;" id="name_up"   src="/Admin/Images/ColumnSortUp.gif"/>
				    <img style="display:none;" id="name_down" src="/Admin/Images/ColumnSortDown.gif"/>
				</span> 
				<span class="pipe"></span>
				<span class="w80px">
				    <a href="#" onclick="sorter.sortBy('stock'); return false;"><%=Translate.Translate("Stock")%></a>
				    <img style="display:none;" id="stock_up"   src="/Admin/Images/ColumnSortUp.gif"/>
				    <img style="display:none;" id="stock_down" src="/Admin/Images/ColumnSortDown.gif"/>
				</span> 
				<span class="pipe"></span>
				<span class="w80px">
				    <a href="#" onclick="sorter.sortBy('price'); return false;"><%=Translate.Translate("Price")%></a>
				    <img style="display:none;" id="price_up"   src="/Admin/Images/ColumnSortUp.gif"/>
				    <img style="display:none;" id="price_down" src="/Admin/Images/ColumnSortDown.gif"/>
				</span> 
				<span class="pipe"></span>
			</li>
		</ul>
	    <dw:StretchedContainer ID="SortingContainer" Scroll="Auto" Stretch="Fill" Anchor="document" runat="server">
		<ul id="items">
		    <asp:Repeater ID="ProductsRepeater" runat="server" enableviewstate="false">
    		    <ItemTemplate>
			    <li id="Product_<%#Eval("ID")%>">
                    <%If Dynamicweb.Base.HasVersion("8.4.1.0") Then%>
                    <span>
                       <input id="checkBox_<%#Eval("ID")%>" type="checkbox" name="checkBox_<%#Eval("ID")%>" onclick="handleCheckboxes(this);" />                    </span> 
                    <%End If%>
				    <span class="w20px" style="padding-top: 2px;padding-left:5px;overflow:hidden;">
					    <img src="/Admin/Images/Ribbon/Icons/Small/Document.png" /></span>
				    <span class="w140px"><%#Eval("Number")%></span> 
				    <span class="w340px"><%#Eval("Name")%></span>
				    <span class="w80px"><%#Eval("Stock")%></span>
				    <span class="w80px"><%#Eval("Price")%></span>
			    </li></ItemTemplate>
		    </asp:Repeater>
		</ul>
        </dw:StretchedContainer>
        <div id="BottomInformationBg">
        <table border="0" cellpadding="0" cellspacing="0">
	        <tr>
		        <td rowspan="2"><img src="/Admin/Images/Ribbon/Icons/document_new.png" alt="" /></td>
		        <td align="right"><span class="label"><span style="padding:0;" id="ProductsCount" runat="server"></span>&nbsp;<dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Products" /></span></td>
	        </tr>
	        <tr>
		        <td>&nbsp;</td>
	        </tr>
        </table>
        </div>
    </div>
	
	<% Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
	    
</asp:Content>
