<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ItemFieldTranslationsEdit.aspx.vb" Inherits="Dynamicweb.Admin.ItemFieldTranslationsEdit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1" runat="server">
        <meta http-equiv="X-UA-Compatible" content="IE=8" />

        <dw:ControlResources ID="ControlResources1" CombineOutput="false" IncludePrototype="true" IncludeScriptaculous="true" runat="server">
            <Items>
                <dw:GenericResource Url="/Admin/Content/Items/js/ItemFieldTranslationsEdit.js" />
            </Items>
        </dw:ControlResources>
    </head>

    <style type="text/css">
        ​.dic_header {
            height:116px;
        }
        .translations_list {
            position: absolute;
            top: 126px;
            bottom: 0px;
            left:0px;
            right:0px;
            padding-bottom: 15px;
        }
    </style>

    <body>
        <form id="MainForm" runat="server">
            <div class="dic_header">
                <dw:Toolbar ID="ToolbarButtons" runat="server" ShowEnd="false">
                    <dw:ToolbarButton ID="cmdAdd" runat="server" Image="AddDocument" Divide="None" Text="Add custom translation" OnClientClick="Dynamicweb.Items.ItemFieldTranslationsEdit.prototype.addNewTranslation();" />
	                <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="" />
	            </dw:Toolbar>

                <div id="SelectItemType" style="display:none;">
                    <dw:Infobar ID="wrnSelectItemType" Type="Error" runat ="server" Message="Select item type first"/>
                </div>
            
                <dw:GroupBox ID="gItemTypeOptions" Title="Item type options" runat="server">
                    <table border="0" style="margin: 5px">
                        <tr>
                            <td style="width: 172px" valign="top">
                                <dw:TranslateLabel id="tLabelName" Text="Item type" runat="server"  />
                            </td>
                            <td>
                                <asp:DropDownList id="dItemList" onchange="Dynamicweb.Items.ItemFieldTranslationsEdit.prototype.itemTypeChange();" CssClass="NewUIinput" runat="server" />
                            </td>
                        </tr>
                    
                        <tr>
                            <td style="width: 172px" valign="top"></td>
                            <td>
                                <asp:Button id="bAddMissingTranslations" UseSubmitBehavior="true" runat="server" CssClass="NewUIinput"></asp:Button>
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
            </div>

            <dw:GroupBox ClassName="translations_list" ID="gItemTypeTranslations" Title="Fields translations" runat="server">
                <iframe id="ItemTypeTranslations" style="border:0px; height:100%; width:100%;" scrolling="no" src="../../Management/Dictionary/TranslationKey_List.aspx?HideToolbar=True&IsItemType=True&ItemTypeName=<%=ItemType %>"></iframe>
            </dw:GroupBox>  
        </form>

        <script type="text/javascript">
            Dynamicweb.Items.ItemFieldTranslationsEdit.get_current().initialize();
        </script>

        <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
    </body>
</html>
