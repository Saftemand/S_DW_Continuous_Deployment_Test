<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ListUsersSorting.aspx.vb" Inherits="Dynamicweb.Admin.ListUsersSorting" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ctrlResources" runat="server" />
    <link rel="STYLESHEET" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
    <link rel="STYLESHEET" type="text/css" href="/Admin/Content/StyleSheetNewUI.css" />
    <link rel="Stylesheet" href="/Admin/Images/Ribbon/UI/List/List.css" />
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

        .w150px { width:150px; white-space:nowrap;overflow:hidden;}        


	</style>    
    <script type="text/javascript" src="/Admin/Module/eCom_Catalog/dw7/js/dwsort.js"></script>
    <script type="text/javascript" src="ListUsersSorting.js"></script>
    <script type="text/javascript">
        Position.includeScrollOffsets = true;
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <dw:Toolbar ID="toolbar" runat="server" ShowEnd="false">
		<dw:ToolbarButton runat="server" Text="Gem" Image="Save" OnClientClick="save();" ID="Save" />
		<dw:ToolbarButton runat="server" Text="Annuller" Image="Cancel" OnClientClick="cancel();" ID="Cancel" />
    </dw:Toolbar>
    <h2 class="subtitle"><%=Translate.Translate("Sort users")%></h2>
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
				<span class="w150px">
				    <a href="#" onclick="sorter.sortBy('name'); return false;"><%=Translate.Translate("Name")%></a>
				    <img style="display:none;" id="name_up"   src="/Admin/Images/ColumnSortUp.gif"/>
				    <img style="display:none;" id="name_down" src="/Admin/Images/ColumnSortDown.gif"/>
				</span>
                <span class="pipe"></span>
				<span class="w150px">
				    <a href="#" onclick="sorter.sortBy('username'); return false;"><%= Translate.Translate("UserName")%></a>
				    <img style="display:none;" id="username_up"   src="/Admin/Images/ColumnSortUp.gif"/>
				    <img style="display:none;" id="username_down" src="/Admin/Images/ColumnSortDown.gif"/>
				</span>  
				<span class="pipe"></span>
				<span class="w150px">
				    <a href="#" onclick="sorter.sortBy('email'); return false;"><%= Translate.Translate("Email")%></a>
				    <img style="display:none;" id="email_up"   src="/Admin/Images/ColumnSortUp.gif"/>
				    <img style="display:none;" id="email_down" src="/Admin/Images/ColumnSortDown.gif"/>
				</span> 
				<span class="pipe"></span>
				<span class="w150px">
				    <a href="#" onclick="sorter.sortBy('address'); return false;"><%=Translate.Translate("Address")%></a>
				    <img style="display:none;" id="address_up"   src="/Admin/Images/ColumnSortUp.gif"/>
				    <img style="display:none;" id="address_down" src="/Admin/Images/ColumnSortDown.gif"/>
				</span> 
				<span class="pipe"></span>
			</li>
		</ul>
	    <dw:StretchedContainer ID="SortingContainer" Scroll="Auto" Stretch="Fill" Anchor="document" runat="server" >
		<ul id="items">
		    <asp:Repeater ID="UsersRepeater" runat="server" enableviewstate="false">
    		    <ItemTemplate>
			    <li id="User_<%#Eval("ID")%>">
				    <span class="w20px" style="padding-top: 2px;padding-left:5px;overflow:hidden;">
					    <img src="/Admin/Images/Ribbon/Icons/Small/Document.png" /></span>
                        <span class="w150px"><%#Eval("Name")%></span>
				    <span class="w150px"><%# Eval("UserName")%></span> 				    
				    <span class="w150px"><%# Eval("Email")%></span>
				    <span class="w150px"><%#Eval("Address")%></span>
			    </li></ItemTemplate>
		    </asp:Repeater>
		</ul>
        <div id="BottomInformationBg">
        <table border="0" cellpadding="0" cellspacing="0">
	        <tr>
		        <td rowspan="2"><img src="/Admin/Images/Ribbon/Icons/document_new.png" alt="" /></td>
		        <td align="right"><span class="label"><span style="padding:0;" id="UsersCount" runat="server"></span>&nbsp;<dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Users" /></span></td>
	        </tr>
	        <tr>
		        <td>&nbsp;</td>
	        </tr>
        </table>
        </div>
        </dw:StretchedContainer>
    </div>
	
	<% Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
    </form>
</body>
</html>
