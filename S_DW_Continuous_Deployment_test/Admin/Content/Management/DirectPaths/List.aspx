<%@ Page Title="" Language="vb" AutoEventWireup="false" CodeBehind="List.aspx.vb" Inherits="Dynamicweb.Admin.DirectPaths_List" %>
<%@ Register TagPrefix="dw" Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head id="PageHeader" runat="server">
        <title><dw:TranslateLabel ID="lbDirectPaths" Text="Direkte_stier" runat="server" /></title>
        
        <dw:ControlResources ID="ctrlResources" IncludePrototype="true" CombineOutput="true" runat="server">
            <Items>
                <dw:GenericResource Url="/Admin/Content/Management/DirectPaths/List.js" />
            </Items>
        </dw:ControlResources>
        
        <style type="text/css">
            div.link-field img.H
            {
            	position: static !important;
            }
            
            img.arrow_icon
            {
            	width: 4px !important;
            	height: 8px !important;
            	margin-top: 6px !important;
            	margin-right: 2px;
            }
        </style>
    </head>
    <body>
        <form id="MainForm" runat="server">
            <dw:Toolbar ID="ToolbarButtons" runat="server" ShowEnd="false">
	            <dw:ToolbarButton ID="cmdAdd" runat="server" Disabled="true" Divide="None" Image="Form_Add" OnClientClick="if(!Toolbar.buttonIsDisabled('cmdAdd')) {{ DirectPaths.editItem(0); }}" Text="Add" />
	            <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="None" Image="Cancel" Text="Cancel" ShowWait="true" />
	            <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="DirectPaths.help();" />
	        </dw:Toolbar>
	        <h2 class="subtitle">
	            <dw:TranslateLabel ID="lbSetup" Text="Direkte_stier" runat="server" />
	        </h2>   
	        
	        <dw:TranslateLabel ID="lbNoAccess" Text="Du har ikke de nødvendige rettigheder til denne funktion." runat="server" />
            <dw:List ID="lstPaths" AllowMultiSelect="true" ShowPaging="true" ShowTitle="false" runat="server" pagesize="25" HandleSortingManually="True">
                <Filters>
                    <dw:ListAutomatedSearchFilter ID="sFilter" runat="server" />
                </Filters>
                <Columns>
                    <dw:ListColumn ID="colPath" EnableSorting="true" Name="Path" Width="175" runat="server" />
                    <dw:ListColumn ID="colLink" EnableSorting="true" Name="Link" Width="300" runat="server" />
                    <dw:ListColumn ID="colArea" EnableSorting="true" Name="Area" Width="125" runat="server" />
                    <dw:ListColumn ID="colStatus" ItemAlign="Center" HeaderAlign="Right" EnableSorting="true" Name="Status" Width="75" runat="server" />
                    <dw:ListColumn ID="colRemove" ItemAlign="Center" HeaderAlign="Center" EnableSorting="false" Name="Remove" Width="75 " runat="server" /> 
                </Columns>
            </dw:List>
	        
	        <dw:Dialog ID="dlgEditPath" UseTabularLayout="true" Width="540" 
	            OkAction="DirectPaths.saveItem(this);" ShowOkButton="true" ShowCancelButton="true" Title="Rediger" TranslateTitle="true" runat="server">
	            
		        <dw:GroupBox runat="server" Title="Properties" id="gbEdit">
		            <input type="hidden" id="ItemID" value="" />
		            
		            <table>
			            <tr>
				            <td style="width: 170px"><dw:TranslateLabel ID="lbPath" Text="Sti" runat="server" /></td>
				            <td><input id="ItemPath" name="ItemPath" type="text" class="std" /></td>
			            </tr>
			            <tr>
				            <td><dw:TranslateLabel ID="lbLink" Text="Link" runat="server" /></td>
				            <td>
				                <div class="link-field">
				                    <dw:LinkManager runat="server" ID="ItemRedirect" />
				                </div>
				            </td>
			            </tr>
			            <tr>
			                <td><dw:TranslateLabel ID="lbItemArea" Text="Area" runat="server" /></td>
			                <td id="rowAreaID">
			                    <asp:DropDownList CssClass="std" ID="ddArea" runat="server" />
			                </td>
			            </tr>
			            <tr>
				            <td valign="top"><dw:TranslateLabel ID="lbStatus" Text="Status" runat="server" /></td>
				            <td>
				                <input type="radio" id="rd200" name="ItemStatus" value="200" />
				                <label for="rd200"><dw:TranslateLabel ID="lbStatus200" Text="Behold sti (200 OK)" runat="server" /></label><br />
				                
				                <input type="radio" id="rd301" name="ItemStatus" value="301" />
				                <label for="rd301"><dw:TranslateLabel ID="lbStatus301" Text="Vidersend til link (301 Moved Permanently)" runat="server" /></label><br />
				                
				                <input type="radio" id="rd302" name="ItemStatus" value="302" />
				                <label for="rd302"><dw:TranslateLabel ID="lbStatus302" Text="Vidersend til link (302 Moved Temporarily)" runat="server" /></label><br />
				            </td>
			            </tr>
			            <tr>
			                <td>&nbsp;</td>
				            <td>
				                <input id="ItemActive" name="ItemActive" type="checkbox" value="True" />
				                <label for="ItemActive"><dw:TranslateLabel ID="lbItemActive" Text="Aktiv" runat="server" /></label>
				            </td>
			            </tr>
			            <tr>
                            <td colspan="2">
                                <div style="height: 32px; min-height: 32x; max-height: 32px; vertical-align: top">
                                    <div id="errorPathRequired" style="display: none">
                                        <dw:Infobar ID="infoPathRequred" Type="Error" Message="Please specify the path" runat="server" />
                                    </div>
                                    <div id="errorLinkRequired" style="display: none">
                                        <dw:Infobar ID="infoLinkRequired" Type="Error" Message="Please specify the target link" runat="server" />
                                    </div>
                                    <div id="errorPathIsPhysical" style="display: none">
                                        <dw:Infobar ID="infoLinkPhysical" Type="Error" Message="Path is invalid because it exists physically on the disk" runat="server" />
                                    </div>
                                    <div id="errorPathAlreadyExists" style="display: none">
                                        <dw:Infobar ID="errorPathAlreadyExists" Type="Error" Message="The path already exist" runat="server" />
                                    </div>
                                </div>
                            </td>
			            </tr>
		            </table>
		        </dw:GroupBox>
				       
            </dw:Dialog>
            
            <dw:ContextMenu ID="cmItem" OnClientSelectView="DirectPaths.onSelectItemContextMenuView" runat="server">
                <dw:ContextMenuButton ID="cmdEdit" Views="SingleActiveItem, SingleInactiveItem, MultipleActiveItems, MultipleInactiveItems, MixedItems" Image="EditDocument" Text="Edit" OnClientClick="DirectPaths.editItem(ContextMenu.callingID);" runat="server" />
                
                <dw:ContextMenuButton ID="cmdActivate" Views="SingleInactiveItem" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_ok.png" Text="Activate" OnClientClick="DirectPaths.activateItems();" runat="server" />
                <dw:ContextMenuButton ID="cmdActivateSelected" Views="MultipleInactiveItems, MixedItems" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_ok.png" Text="Activate selected" OnClientClick="DirectPaths.activateItems();" runat="server" />
                <dw:ContextMenuButton ID="cmdDeactivate" Views="SingleActiveItem" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_forbidden.png" Text="Deactivate" OnClientClick="DirectPaths.deactivateItems();" runat="server" />
                <dw:ContextMenuButton ID="cmdDeactivateSelected" Views="MultipleActiveItems, MixedItems" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_forbidden.png" Text="Deactivate selected" OnClientClick="DirectPaths.deactivateItems();" runat="server" />
                <dw:ContextMenuButton ID="cmdSetStatus" ArrowImagePath="/Admin/Images/pil_h.gif" Views="SingleActiveItem, SingleInactiveItem, MultipleActiveItems, MultipleInactiveItems, MixedItems" Text="Status" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_out.png" runat="server">
                    <dw:ContextMenuButton ID="cmdSetStatus200" Text="200 OK" DoTranslate="False" ImagePath="/Admin/Images/Ribbon/Icons/Small/document.png" OnClientClick="DirectPaths.setItemsStatus(200);" runat="server" />
                    <dw:ContextMenuButton ID="cmdSetStatus301" Text="301 Moved Permanently" DoTranslate="False" ImagePath="/Admin/Images/Ribbon/Icons/Small/document.png" OnClientClick="DirectPaths.setItemsStatus(301);" runat="server" />
                    <dw:ContextMenuButton ID="cmdSetStatus302" Text="302 Moved Temporarily" DoTranslate="False" ImagePath="/Admin/Images/Ribbon/Icons/Small/document.png" OnClientClick="DirectPaths.setItemsStatus(302);" runat="server" />
                </dw:ContextMenuButton>
                
                <dw:ContextMenuButton ID="cmdDelete" Views="SingleActiveItem, SingleInactiveItem" Image="DeleteDocument" Text="Delete" Divide="Before" OnClientClick="DirectPaths.deleteItems();" runat="server" />
                <dw:ContextMenuButton ID="cmdDeleteSelected" Views="MultipleActiveItems, MultipleInactiveItems, MixedItems" Image="DeleteDocument" Text="Delete selected" OnClientClick="DirectPaths.deleteItems();" runat="server" />
            </dw:ContextMenu>
            
        <input type="hidden" id="PostBackAction" name="PostBackAction" value="" />
        
        <span id="jsHelp" style="display: none"><%=Dynamicweb.Gui.help("", "modules.urlpath.general.list.item") %> </span>
        <span id="confirmDelete" style="display: none"><dw:TranslateLabel id="lbDelete" Text="Slet?" runat="server" /></span>
	    </form>
    </body>
</html>
