<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ItemCreator_Edit.aspx.vb" Inherits="Dynamicweb.Admin.Admin.Module.ItemCreator.ItemCreator_Edit" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<dw:ModuleHeader ModuleSystemName="ItemCreator" runat="server" />
<dw:ModuleSettings ID="Settings" ModuleSystemName="ItemCreator" Value="" runat="server" />
<dw:ControlResources ID="ControlResources1" IncludeRequireJS="False" CombineOutput="False" runat="server">
    <Items>
        <dw:GenericResource Url="/Admin/Module/Common/Stylesheet_ParSet.css" />
        <dw:GenericResource Url="/Admin/Content/Items/css/Default.css" />
        <dw:GenericResource Url="/Admin/Content/JsLib/dw/Utilities.js" />
        <dw:GenericResource Url="/Admin/Content/JsLib/dw/Validation.js" />
        <dw:GenericResource Url="/Admin/Module/ItemCreator/css/ItemCreatorEdit.css" />
        <dw:GenericResource Url="/Admin/Module/ItemCreator/js/ItemCreatorEdit.js" />
    </Items>
</dw:ControlResources>

<dw:GroupBox Title="Data" runat="server">
    <table>
        <tr>
            <td class="left-column-fix leftCol">
                <dw:TranslateLabel Text="Target page" runat="server" />
            </td>
            <td>
                <div class="link-manager clearfix">
                    <div id="TargetPageID_Control">
                        <input type="text" class="std" readonly="readonly" />
                        <a href="#" title="<%Translate.Translate("Select page")%>" data-action="selectPage">
                            <img src="/Admin/images/Icons/Page_int.gif" /></a>
                        <a href="#" title="<%Translate.Translate("Remove page")%>" data-action="clear">
                            <img src="/Admin/images/Icons/Delete_small.gif" /></a>
                        <input type="hidden" id="TargetPageID" name="TargetPageID" value="<%=Properties("TargetPageID")%>" />
                        <input type="hidden" id="TargetPageID_Selector" onchange="this.fire('link-manager:changed');" />
                        <div>
                            <span class="disableText">
                                <dw:TranslateLabel Text="Current page is default" runat="server" />
                            </span>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <dw:TranslateLabel Text="Content structure" runat="server" />
            </td>
            <td>
                <div class="radio-field clearfix">
                    <input type="radio" id="ContentStructurePage"name="ContentStructure" data-change-action="onStructureTypeChange"  value="0" <%=If(Base.ChkInteger(Me.Properties("ContentStructure")) = 0, " checked=""checked""", String.Empty)%> />
                    <label for="ContentStructurePage">
                        <dw:TranslateLabel Text="Create item as page" runat="server" />
                    </label>
                </div>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <div class="radio-field clearfix">
                    <input type="radio" id="ContentStructureParagraph" name="ContentStructure" data-change-action="onStructureTypeChange"  value="1" <%=If(Base.ChkInteger(Me.Properties("ContentStructure")) = 1, " checked=""checked""", String.Empty)%> />
                    <label for="ContentStructureParagraph">
                        <dw:TranslateLabel Text="Create item as paragraph" runat="server" />
                    </label>
                </div>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <div class="radio-field clearfix">
                    <input type="radio" id="ContentStructureNamedList" name="ContentStructure" data-change-action="onStructureTypeChange"  value="2" <%=If(Base.ChkInteger(Me.Properties("ContentStructure")) = 2, " checked=""checked""", String.Empty)%> />
                    <label for="ContentStructureNamedList">
                        <dw:TranslateLabel Text="Create item in named list" runat="server" />
                    </label>
                </div>
            </td>
        </tr>
        <tr <%=If(Base.ChkInteger(Me.Properties("ContentStructure")) = 1, String.Empty, "style=""display:none;""")%>>
            <td style="padding-top: 5px;">
                <dw:TranslateLabel Text="Content placeholder" runat="server" />
            </td>
            <td>
                <div class="clearfix" style="padding-top: 5px;">
                    <%=RenderPagePlaceholders(Base.ChkInteger(Me.Properties("TargetPageID")), Me.Properties("TargetPagePlaceholder"))%>
                </div>
            </td>
        </tr>
        <tr <%=If(Base.ChkInteger(Me.Properties("ContentStructure")) = 2, String.Empty, "style=""display:none;""")%>>
            <td style="padding-top: 5px;">
                <dw:TranslateLabel Text="Named item list" runat="server" />
            </td>
            <td>
                <div class="clearfix" style="padding-top: 5px;">
                     <%=RenderNamedListSelector(Base.ChkInteger(Me.Properties("TargetPageID")), Base.ChkString(Properties("ItemType")), Base.ChkString(Properties("TargetNamedList")))%>
                </div>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr <%=If(Base.ChkInteger(Me.Properties("ContentStructure")) <> 2, String.Empty, " style=""display:none;""")%>>
            <td class="leftColHigh">
                <dw:TranslateLabel Text="Item type" runat="server" />
            </td>
            <td>
                <%=RenderItemTypeSelector(Base.ChkString(Properties("ItemType")))%>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>

        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>

        <tr>
            <td>
                <dw:TranslateLabel Text="Publish state on create" runat="server" />
            </td>
            <td>
                <div class="radio-field clearfix">
                    <input type="radio" id="ContentCreationStatusPublished" name="ContentCreationStatus" value="0" <%=If(Base.ChkInteger(Me.Properties("ContentCreationStatus")) = 0, " checked=""checked""", String.Empty)%> />
                    <label for="ContentCreationStatusPublished">
                        <dw:TranslateLabel Text="Published" runat="server" />
                    </label>
                </div>
            </td>
        </tr>
        <tr <%=If(Base.ChkInteger(Me.Properties("ContentStructure")) <> 2, String.Empty, " style=""display:none;""")%>>
            <td>&nbsp;</td>
            <td>
                <div class="radio-field clearfix">
                    <input type="radio" id="ContentCreationStatusUnpublished" name="ContentCreationStatus" value="1" <%=If(Base.ChkInteger(Me.Properties("ContentCreationStatus")) = 1, " checked=""checked""", String.Empty)%> />
                    <label for="ContentCreationStatusUnpublished">
                        <dw:TranslateLabel Text="Unpublished" runat="server" />
                    </label>
                </div>
            </td>
        </tr>
        <tr <%=If(Base.ChkInteger(Me.Properties("ContentStructure")) = 0, String.Empty, " style=""display:none;""")%>>
            <td>&nbsp;</td>
            <td>
                <div class="radio-field clearfix">
                    <input type="radio" id="ContentCreationStatusHidden" name="ContentCreationStatus" value="2" <%=If(Base.ChkInteger(Me.Properties("ContentCreationStatus")) = 2, " checked=""checked""", String.Empty)%> />
                    <label for="ContentCreationStatusHidden">
                        <dw:TranslateLabel Text="Hidden" runat="server" />
                    </label>
                </div>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <dw:TranslateLabel Text="New item add" runat="server" />
            </td>
            <td>
                <div class="radio-field clearfix">
                    <input type="radio" id="ContentOrderDirectionAscending" name="ContentOrderDirection" value="0" <%=If(String.Compare(Base.ChkString(Me.Properties("ContentOrderDirection")), "0", StringComparison.InvariantCultureIgnoreCase) = 0, " checked=""checked""", String.Empty)%> />
                    <label for="ContentOrderDirectionAscending">
                        <dw:TranslateLabel Text="First" runat="server" />
                    </label>
                </div>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <div class="radio-field clearfix">
                    <input type="radio" id="ContentOrderDirectionDescending" name="ContentOrderDirection" value="1" <%=If(String.Compare(Base.ChkString(Me.Properties("ContentOrderDirection")), "1", StringComparison.InvariantCultureIgnoreCase) = 0, " checked=""checked""", String.Empty)%> />
                    <label for="ContentOrderDirectionDescending">
                        <dw:TranslateLabel Text="Last" runat="server" />
                    </label>
                </div>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <dw:TranslateLabel Text="Confirm page" runat="server" />
            </td>
            <td>
                <div class="link-manager clearfix">
                    <div id="ConfirmPageID_Control">
                        <input type="text" class="std" value="" readonly="readonly" />
                        <a href="#" title="<%Translate.Translate("Select page")%>" data-action="selectPage">
                            <img src="/Admin/images/Icons/Page_int.gif" /></a>
                        <a href="#" title="<%Translate.Translate("Remove page")%>" data-action="clear">
                            <img src="/Admin/images/Icons/Delete_small.gif" /></a>
                        <input type="hidden" id="ConfirmPageID" name="ConfirmPageID" value="<%=Properties("ConfirmPageID")%>" />
                        <input type="hidden" id="ConfirmPageID_Selector" onchange="this.fire('link-manager:changed');" runat="server" />
                    </div>
                </div>
            </td>
        </tr>
    </table>
</dw:GroupBox>

<dw:GroupBox Title="Templates" runat="server">
    <table border="0">
        <tr>
            <td class="leftColHigh">
                <dw:TranslateLabel Text="Create" runat="server" />
            </td>
            <td>
                <dw:FileManager ID="CreateTemplate" Folder="Templates/ItemCreator/Create/" FullPath="True" runat="server" />
            </td>
        </tr>
    </table>
</dw:GroupBox>

<%=RenderProviders()%>

<script type="text/javascript">
    document.observe('dom:loaded', function () {
        Dynamicweb.Items.ParagraphSettings._instance = new Dynamicweb.Items.ParagraphSettings({
            areaId: <%=Base.ChkInteger(Base.Request("AreaID"))%>,
            pageId: <%=Base.ChkInteger(Base.Request("PageID"))%>,
            paragraphId: <%=Base.ChkInteger(Base.Request("ID"))%>,
            translations: {
                Error: '<%=Translate.Translate(InternalError)%>',
                NothingSelected: '<%=Translate.Translate("Nothing selected")%>',
                Nothing: '<%=Translate.Translate("Nothing")%>'
            },
            targetPage: '<%=RenderPage(Base.ChkInteger(Properties("TargetPageID")))%>'.evalJSON(),
            confirmPage: '<%=RenderPage(Base.ChkInteger(Properties("ConfirmPageID")))%>'.evalJSON()
        });
    });
</script>
