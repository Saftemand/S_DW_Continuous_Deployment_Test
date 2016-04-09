<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ModulesList_cpl.aspx.vb" Inherits="Dynamicweb.Admin.ModulesList_cpl" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="Stylesheet" href="ModulesList.css" />
    <link rel="Stylesheet" href="/Admin/Images/Ribbon/UI/List/List.css" />
    <dw:ControlResources runat="server" IncludePrototype="true" IncludeScriptaculous="true"></dw:ControlResources>
    <script language="javascript" type="text/javascript" >
        var moduleWillBeRemovedMessage = "<%= Translate.JSTranslate("The module will be removed from the list.")%>";
    </script>
    <script type="text/javascript" language="javascript" src="ModulesList.js" ></script>
</head>

<body onload="sort_init();" style="overflow:hidden;">
    <dw:Toolbar ID="toolbar" runat="server" ShowEnd="false">
		<dw:ToolbarButton runat="server" Text="Gem" Image="Save" OnClientClick="save();" ID="btnSave" ShowWait="true" />
		<dw:ToolbarButton runat="server" Text="Annuller" Image="Cancel" OnClientClick="cancel();" ID="btnCancel" ShowWait="true" />
        <dw:ToolbarButton runat="server" Text="Add Module" Image="Form_add" OnClientClick="dialog.show('dlgChooseModule');" ID="btnAddModule" />
    </dw:Toolbar>
    <h2 class="subtitle"><%= Translate.Translate("My modules list")%></h2>
    <form id="form1" runat="server">
    <div id="content" style="overflow:auto;">
		<div class="list">
		<asp:Repeater ID="modulesRepeater" runat="server" enableviewstate="false">
			<HeaderTemplate>
                <ul>
				    <li class="header">
                    <span class="C1" style="padding-top: 0px;"></span>
                    <span class="pipe"></span>
                    <span class="C2"><%= Translate.Translate("My Modules")%></span>
                    <span class="pipe"></span>
                    <span class="C3"><%= Translate.Translate("Remove")%></span>
                    <span class="pipe"></span>
                </ul>
            <ul id="items">
	        </HeaderTemplate>
			        <ItemTemplate>
				        <li id="Module_<%# Eval("ModuleID") %>" >
					        <span class="C1" style="padding-top: 2px;padding-left:5px;"><img src='<%# Eval("ImagePath")%>' /></span>
					        <span class="C2"><%# Eval("ModuleName")%></span>
                            <span class="C3" style="cursor:pointer;" ><img src="/Admin/Images/Icons/Delete.png" onclick="removeModule('<%# Eval("ModuleID") %>');" /></span>
				        </li>
                    </ItemTemplate>
			<FooterTemplate>
				    </ul>
			</FooterTemplate>
		</asp:Repeater>
    </div>
    </form>
    <dw:Dialog ID="dlgChooseModule" FinalizeActions="false" Title="Choose module" Width="800" ShowCancelButton="true" runat="server" AdditionalStyle="background-color:white;" >
        <div runat="server" id="myContent" style="height:500px; overflow-y:auto;">
            <table>
                <asp:Repeater ID="repRootNodes" OnItemDataBound="repRootNodes_ItemDataBound" runat="server">
                    <ItemTemplate>
                        <tr id="rowSection" runat="server">
                            <td>
                                <div id="myContent">
                                    <table>
                                        <tr >
                                            <td style="width:40px;" valign="top">
                                                <img id="imgIcon" src="" alt="" runat="server" style="margin:0px;" />
                                            </td>
                                            <td valign= "top" >
                                                <h1 id="sHeader" runat="server" style="margin:0px;"></h1>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width:40px;" valign="top"></td>
                                            <td valign="top" style="padding-bottom: 15px;">
                                                <asp:Repeater ID="repSectionNodes" runat="server">
                                                    <ItemTemplate>
                                                        <div class="cell"><img src="" id="imgModule" runat="server" alt="Module" /><a id="lnkNode" runat="server"></a></div>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
        </div>
    </dw:Dialog>
</body>
  <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
