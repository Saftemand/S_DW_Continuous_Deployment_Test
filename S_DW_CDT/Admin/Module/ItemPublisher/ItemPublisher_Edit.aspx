<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ItemPublisher_Edit.aspx.vb" Inherits="Dynamicweb.Admin.ItemPublisher_Edit" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Modules.ItemPublisher" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<dw:ModuleSettings ModuleSystemName="ItemPublisher" Value="ItemType, ListSourceType, ListSourceArea, ListSourcePage, SourceItemEntries, NamedListPageID, TargetNamedList, ListTemplate, ListPageSize, ItemFields, ItemFieldsList, ListOrderBy, ListOrderByDirection, ListViewMode, ListShowFrom, ListShowTo, AllowEditing, EditTemplate, DetailsTemplate, ValidationIncorrectFormat, ValidationEmptyField, IncludeParagraphItems, IncludeAllChildItems, IncludeInheritedItems, ShowSecurityItems, ItemRulesEditor_DataXML, ShowOnParagraph" runat="server" />
<dw:ModuleHeader ModuleSystemName="ItemPublisher" runat="server" />
<dw:ControlResources IncludeRequireJS="False" CombineOutput="True" runat="server">
    <Items>
        <dw:GenericResource Url="/Admin/Module/ItemPublisher/js/ItemPublisher_Edit.js"/>
        <dw:GenericResource Url="/Admin/Content/Items/css/Default.css"/>
        <dw:GenericResource Url="/Admin/Module/Common/Stylesheet_ParSet.css"/>
        <dw:GenericResource Url="/Admin/Module/ItemPublisher/css/ItemPublisher_Edit.css"/>
    </Items>
</dw:ControlResources>


<dw:GroupBox Title="Data" runat="server">
    <table border="0"> 
        <tr>
            <td class="leftColHigh"><dw:TranslateLabel Text="Item type" runat="server" /></td>
            <td><%=RenderItemTypeSelector(Base.ChkString(Properties("ItemType")))%></td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr>
            <td><dw:TranslateLabel Text="Select items from" runat="server" /></td>
            <td>
                <div class="radio-field clearfix">
                    <input type="radio" id="ListSourceArea" name="ListSourceType" value="Area" <%=If(String.Compare(Base.ChkString(Properties("ListSourceType")), "Area", StringComparison.InvariantCultureIgnoreCase) = 0, " checked=""checked""", String.Empty)%> />
                    <label for="ListSourceArea"><dw:TranslateLabel Text="Select items from the following language/area" runat="server" /></label>
                </div>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td class="list-source-type list-source-type-area"><%=RenderAreaSelector(Base.ChkNumber(Properties("ListSourceArea")))%></td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <div class="radio-field clearfix">
                    <input type="radio" id="ListSourceCurrentArea" name="ListSourceType" value="SelfArea" <%=If(String.Compare(Base.ChkString(Properties("ListSourceType")), "SelfArea", StringComparison.InvariantCultureIgnoreCase) = 0, " checked=""checked""", String.Empty)%> />
                    <label for="ListSourceCurrentArea"><dw:TranslateLabel Text="Select items from the current language/area" runat="server" /></label>
                </div>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td><dw:TranslateLabel Text="Current area: " runat="server" /><%=GetCurrentAreaName()%></td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <div class="radio-field clearfix">
                    <input type="radio" id="ListSourceTypeSelfPage" name="ListSourceType" value="SelfPage" <%=If(String.Compare(Base.ChkString(Properties("ListSourceType")), "SelfPage", StringComparison.InvariantCultureIgnoreCase) = 0, " checked=""checked""", String.Empty)%> />
                    <label for="ListSourceTypeSelfPage"><dw:TranslateLabel Text="Select items under the current page" runat="server" /></label>
                </div>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td><dw:TranslateLabel Text="Page name" runat="server" />:&nbsp;<%=GetCurrentPageName()%></td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <div class="radio-field clearfix">
                    <input type="radio" id="ListSourceTypePage" name="ListSourceType" value="Page" <%=If(String.Compare(Base.ChkString(Properties("ListSourceType")), "Page", StringComparison.InvariantCultureIgnoreCase) = 0, " checked=""checked""", String.Empty)%> />
                    <label for="ListSourceTypePage"><dw:TranslateLabel Text="Select items under the following pages" runat="server" /></label>
                </div>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td class="list-source-type list-source-type-page">
                <table id="ListSourcePage_Control">
                    <tr>
                        <td class="list-source-type-page-content">
                            <ul class="std <%=If(String.Compare(Base.ChkString(Properties("ListSourceType")), "Page", StringComparison.InvariantCultureIgnoreCase) = 0, "enabled", String.Empty)%>"><%=RenderSourcePages()%></ul>                            
                        </td>
                        <td class="list-source-type-page-toolbar">
                            <ul>
                                <li>
                                    <a href="javascript:void(0);" data-action="select"><img src="/Admin/Images/Icons/Add_vsmall.gif"/></a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" data-action="remove"><img src="/Admin/Images/Icons/Delete_vsmall.gif"/></a>
                                </li>
                            </ul>
                        </td>
                    </tr>
                </table>
                <input type="hidden" id="ListSourcePage_Selector" onchange="Dynamicweb.Items.ParagraphSettings.get_current().onPageSelect(this)" />
                <input type="hidden" id="ListSourcePage" name="ListSourcePage" value="<%=Properties.Value("ListSourcePage") %>"/>
            </td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <div class="radio-field clearfix">
                    <input type="radio" id="ListSourceTypeItemEntries" name="ListSourceType" value="ItemEntries" <%=If(String.Compare(Base.ChkString(Properties("ListSourceType")), "ItemEntries", StringComparison.InvariantCultureIgnoreCase) = 0, " checked=""checked""", String.Empty)%> />
                    <label for="ListSourceTypeItemEntries"><dw:TranslateLabel Text="Select specific items" runat="server" /></label>
                </div>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td class="list-source-type list-source-type-itementries">
                <table id="SourceItemEntries_Control">
                    <tr>
                        <td class="list-source-type-itementries-content">
                            <ul class="std <%=If(String.Compare(Base.ChkString(Properties("ListSourceType")), "ItemEntries", StringComparison.InvariantCultureIgnoreCase) = 0, "enabled", String.Empty)%>"><%=RenderSourceItemEntries()%></ul>                            
                        </td>
                        <td class="list-source-type-itementries-toolbar">
                            <ul>
                                <li>
                                    <a href="javascript:void(0);" data-action="select" data-type="page"><img src="/Admin/images/Icons/Page_int.gif"/></a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" data-action="select" data-type="paragraph"><img src="/Admin/images/Icons/Paragraph.gif"/></a>
                                </li>
                                <li>
                                    <a href="javascript:void(0);" data-action="remove"><img src="/Admin/Images/Icons/Delete_vsmall.gif"/></a>
                                </li>
                            </ul>
                        </td>
                    </tr>
                </table>
                <input type="hidden" id="SourceItemEntries_Selector" />
                <input type="hidden" id="SourceItemEntries" name="SourceItemEntries" value="<%=Properties.Value("SourceItemEntries")%>"/>
            </td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <div class="radio-field clearfix">
                    <input type="radio" id="ListSourceTypeNamedList" name="ListSourceType" value="NamedList" <%=If(String.Compare(Base.ChkString(Properties("ListSourceType")), "NamedList", StringComparison.InvariantCultureIgnoreCase) = 0, " checked=""checked""", String.Empty)%> />
                    <label for="ListSourceTypeNamedList"><dw:TranslateLabel Text="Named item list" runat="server" /></label>
                </div>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td class="list-source-type list-source-type-namedlist">
                <div class="link-manager clearfix">
                    <div id="NamedListPageID_Control">
                        <input type="text" class="std" readonly="readonly" />
                        <a href="#" title="<%Translate.Translate("Select page")%>" data-action="selectPage">
                            <img src="/Admin/images/Icons/Page_int.gif" /></a>
                        <input type="hidden" id="NamedListPageID" name="NamedListPageID" value="<%=Properties("NamedListPageID")%>" />
                        <input type="hidden" id="NamedListPageID_Selector" onchange="this.fire('link-manager:changed');" />
                    </div>
                </div>
                <select class="std" id="TargetNamedList" name="TargetNamedList">
                    <option value="<%=Properties("NamedItemList")%>"></option>
                </select>                                                
            </td>
        </tr>
        <tr><td>&nbsp;</td></tr>
        <tr>
            <td />
            <td>
                <div id="IncludeParagraphItems_Control">
                    <input type="checkbox" id="IncludeParagraphItems_View" <%=If(Base.ChkBoolean(Properties("IncludeParagraphItems")), " checked=""checked""", String.Empty)%> />
                    <input type="hidden" id="IncludeParagraphItems" name="IncludeParagraphItems" value="<%=Properties("IncludeParagraphItems")%>" />
                    <label for="IncludeParagraphItems_View"><dw:TranslateLabel Text="Include paragraph items" runat="server" /></label>
                </div>
            </td>
        </tr>
        <tr>
            <td />
            <td>
               <div id="IncludeAllChildItems_Control">
                    <input type="checkbox" id="IncludeAllChildItems_View" <%=If(Base.ChkBoolean(Properties("IncludeAllChildItems")), " checked=""checked""", String.Empty)%> />   
                    <input type="hidden" id="IncludeAllChildItems" name="IncludeAllChildItems" value="<%=Properties("IncludeAllChildItems") %>"/>
                    <label for="IncludeAllChildItems_View"><dw:TranslateLabel Text="Include all child itemss" runat="server" /></label>
                </div>
            </td>
        </tr>
        <tr>
            <td />
            <td>
               <div id="IncludeInheritedItems_Control">
                    <input type="checkbox" id="IncludeInheritedItems_View" <%=If(Base.ChkBoolean(Properties("IncludeInheritedItems")), " checked=""checked""", String.Empty)%> />   
                    <input type="hidden" id="IncludeInheritedItems" name="IncludeInheritedItems" value="<%=Properties("IncludeInheritedItems")%>"/>
                    <label for="IncludeInheritedItems_View"><dw:TranslateLabel Text="Include inherited items" runat="server" /></label>
                </div>
            </td>
        </tr>
        <tr>
            <td />
            <td>
                <div id="ShowSecurityItems_Control">
                    <input type="checkbox" id="ShowSecurityItems_View" <%=If(Base.ChkBoolean(Properties("ShowSecurityItems")), " checked=""checked""", String.Empty)%> />    
                    <input type="hidden" id="ShowSecurityItems" name="ShowSecurityItems" value="<%=Properties("ShowSecurityItems") %>"/>
                    <label for="ShowSecurityItems_View"><dw:TranslateLabel Text="Allow to show items under security" runat="server" /></label>
                </div>
            </td>
        </tr>
        <tr>
            <td valign="top"><dw:TranslateLabel Text="Item fields - list" runat="server" /></td>
            <td>
                <input type="radio" id="ItemFieldsListAll" name="ItemFieldsList" value="*" <%=If(Base.ChkString(Properties("ItemFieldsList")).StartsWith("*"), " checked=""checked""", String.Empty)%> />
                <label for="ItemFieldsListAll"><dw:TranslateLabel Text="All" runat="server" /></label> 
                <input type="radio" id="ItemFieldsListSelected"  name="ItemFieldsList" value="<%=Properties("ItemFieldsList")%>" <%=If(Not Base.ChkString(Properties("ItemFieldsList")).StartsWith("*"), " checked=""checked""", String.Empty)%> />
                <label for="ItemFieldsListSelected"><dw:TranslateLabel Text="Selected" runat="server" /></label> 
                <div id="ItemFieldsListSelectorWrapper">
                    <dw:SelectionBox runat="server" ID="ItemFieldsListSelector"  ContentChanged="Dynamicweb.Items.ParagraphSettings.get_current().onItemFieldsListChange();" CssClass="std selection-box" LeftHeader="Deselected field(s)" RightHeader="Selected field(s)"  NoDataTextLeft="Nothing selected" NoDataTextRight="Nothing selected" ShowSortRight="true" TranslateNoDataText="true" />
                </div>
            </td>
        </tr>
        <tr>
            <td valign="top"><dw:TranslateLabel Text="Item fields - details" runat="server" /></td>
            <td>
                <input type="radio" id="ItemFieldsAll" name="ItemFields" value="*" <%=If(Base.ChkString(Properties("ItemFields")).StartsWith("*"), " checked=""checked""", String.Empty)%> />
                <label for="ItemFieldsAll"><dw:TranslateLabel Text="All" runat="server" /></label> 
                <input type="radio" id="ItemFieldsSelected" name="ItemFields" value="<%=Properties("ItemFields")%>" <%=If(Not Base.ChkString(Properties("ItemFields")).StartsWith("*"), " checked=""checked""", String.Empty)%> />
                <label for="ItemFieldsSelected"><dw:TranslateLabel Text="Selected" runat="server" /></label> 
                <div id="ItemFieldsSelectorWrapper">
                    <dw:SelectionBox runat="server"  ID="ItemFieldsSelector" ContentChanged="Dynamicweb.Items.ParagraphSettings.get_current().onItemFieldsChange();"  CssClass="std selection-box" LeftHeader="Deselected field(s)" RightHeader="Selected field(s)" NoDataTextLeft="Nothing selected" NoDataTextRight="Nothing selected" ShowSortRight="true" TranslateNoDataText="true" />
                </div>
            </td>
        </tr>
    </table>
</dw:GroupBox>

<dw:GroupBox Title="List" ClassName="list-settings" runat="server">
    <table border="0">
        <tr>
            <td class="leftColHigh"><dw:TranslateLabel Text="Template" runat="server" /></td>
            <td><dw:FileManager ID="ListTemplate" Folder="Templates/ItemPublisher/List/" FullPath="True" runat="server" /></td>
        </tr>
        <tr>
            <td><dw:TranslateLabel Text="Order by" runat="server" /></td>
            <td>
               <select class="std" id="ListOrderBy" name="ListOrderBy" disabled="disabled">
                   <option value=""><dw:TranslateLabel Text="No item fields found" runat="server" /></option>
               </select> 
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <div class="radio-field clearfix">
                    <ul class="radio-field-list">
                        <li>
                            <input type="radio" id="ListOrderByDirectionAscending" name="ListOrderByDirection" value="Ascending" <%=If(String.Compare(Base.ChkString(Properties("ListOrderByDirection")), "Ascending", StringComparison.InvariantCultureIgnoreCase) = 0, " checked=""checked""", String.Empty)%> />
                            <label for="ListOrderByDirectionAscending"><dw:TranslateLabel Text="Ascending" runat="server" /></label>                            
                        </li>
                        <li>
                            <input type="radio" id="ListOrderByDirectionDescending" name="ListOrderByDirection" value="Descending" <%=If(String.Compare(Base.ChkString(Properties("ListOrderByDirection")), "Descending", StringComparison.InvariantCultureIgnoreCase) = 0, " checked=""checked""", String.Empty)%> />
                            <label for="ListOrderByDirectionDescending"><dw:TranslateLabel Text="Descending" runat="server" /></label>                            
                        </li>
                    </ul>
               </div>
            </td>
        </tr>
        <tr>
            <td>
                <dw:TranslateLabel Text="List view type" runat="server"/>
            </td>
            <td>
                <div class="radio-field clearfix">
                    <ul class="radio-field-list">
                        <li>
                            <input type="radio" id="ListViewTypePaging" name="ListViewMode" data-model="ListViewMode" value="<%=ListViewModes.Normal.ToString()%>" <%=If(String.Compare(Base.ChkString(Properties("ListViewMode")), ListViewModes.Normal.ToString(), StringComparison.InvariantCultureIgnoreCase) = 0, " checked=""checked""", String.Empty)%> />
                            <label for="ListViewTypePaging"><dw:TranslateLabel Text="Normal" runat="server" /></label>                            
                        </li>
                        <li>
                            <input type="radio" id="ListViewTypePartial" name="ListViewMode" data-model="ListViewMode" value="<%=ListViewModes.Partial.ToString() %>" <%=If(String.Compare(Base.ChkString(Properties("ListViewMode")), ListViewModes.Partial.ToString(), StringComparison.InvariantCultureIgnoreCase) = 0, " checked=""checked""", String.Empty)%> />
                            <label for="ListViewTypePartial"><dw:TranslateLabel Text="Partial" runat="server" /></label>                            
                        </li>
                    </ul>     
               </div>
            </td>
        </tr>
    </table>
    
    <div class="list-view-selected-<%=Base.ChkString(Properties("ListViewMode")).ToLower() %>" data-view="ListViewMode" data-class="list-view-selected">
        <table border="0" class="list-view-normal">
            <tr>
                <td  class="leftColHigh"><dw:TranslateLabel Text="Page size" runat="server" /></td>
                <td>
                    <input type="text" class="std" id="ListPageSize" name="ListPageSize" data-type="number" data-default-value="10" value="<%=Base.ChkNumber(Properties.Value("ListPageSize"))%>" />
                </td>
            </tr>
        </table>
    
        <table border="0" class="list-view-partial">
            <tr>
                <td  class="leftColHigh">
                    <dw:TranslateLabel Text="Item from" runat="server" />
                </td>
                <td>
                    <input type="text" class="std" id="ListShowFrom" name="ListShowFrom" data-type="number" data-min-value="1" data-max-value="#ListShowTo" data-default-value="1" value="<%=Properties("ListShowFrom")%>"/>
                </td>
            </tr>
            <tr>
                <td>
                    <dw:TranslateLabel Text="Item to" runat="server"/>
                </td>
                <td>
                    <input type="text" class="std" id="ListShowTo" name="ListShowTo" data-type="number" data-min-value="#ListShowFrom" data-default-value="5" value="<%=Properties("ListShowTo")%>"/>
                </td>
            </tr>
        </table>        
    </div>
</dw:GroupBox>

<dw:GroupBox Title="Details" runat="server">
    <table border="0">
     <tr>
        <td class="leftColHigh"><dw:TranslateLabel Text="Template" runat="server" /></td>
        <td><dw:FileManager ID="DetailsTemplate" Folder="Templates/ItemPublisher/Details/" FullPath="True" runat="server" /></td>
    </tr>
     <tr>
        <td class="leftColHigh"><dw:TranslateLabel Text="Show on paragraph" runat="server" /></td>
        <td><dw:LinkManager runat="server" id="ShowOnParagraph" EnablePageSelector="False" DisableFileArchive="True"></dw:LinkManager></td>
    </tr>
    </table>
</dw:GroupBox>

<dw:GroupBox Title="Filtering" ClassName="filtering-settings" runat="server">
    <input type="hidden" id="ItemRulesEditor_DataXML" name="ItemRulesEditor_DataXML" />
    <dw:RulesEditor ID="ItemRulesEditor" runat="server"></dw:RulesEditor>
    <table border="0">
    <tr>
        <td class="leftColHigh"><dw:TranslateLabel Text="Rules combination" runat="server" /></td>
        <td>
            <input type="radio" runat="server" id="RulesCombinationAnd" name="RulesCombination" value="AND" onchange="Dynamicweb.Items.ParagraphSettings.get_current().onRuleCombinationChanged(2);" />
            <label for="RulesCombinationAnd"><dw:TranslateLabel Text="AND" runat="server" /></label>
            <input type="radio" runat="server" id="RulesCombinationOr" name="RulesCombination" value="OR" onchange="Dynamicweb.Items.ParagraphSettings.get_current().onRuleCombinationChanged(1);" />
            <label for="RulesCombinationAnd"><dw:TranslateLabel Text="OR" runat="server" /></label>
        </td>
    </tr>
    </table>
</dw:GroupBox>

<dw:GroupBox Title="Edit" runat="server">
    <table border="0">
         <tr>
            <td class="leftColHigh"><dw:TranslateLabel Text="Access" runat="server" /></td>
            <td>
                <div class="checkbox-field clearfix">
                    <input type="checkbox" id="AllowEditing" name="AllowEditing" onclick="" value="True" <%=If(Base.ChkBoolean(Properties("AllowEditing")), " checked=""checked""", String.Empty)%> />
                    <label for="AllowEditing"><dw:TranslateLabel Text="Allow editing of items" runat="server" /></label>
                </div>
            </td>
        </tr>
        <tr>
            <td><dw:TranslateLabel Text="Template" runat="server" /></td>
            <td><dw:FileManager ID="EditTemplate" Folder="Templates/ItemPublisher/Edit" FullPath="True" runat="server" /></td>
        </tr>
    </table>
</dw:GroupBox>

<div id="errorMessages">
<dw:GroupBox Title="Error messages" runat="server">
    <table border="0">
        <tr>
            <td class="leftColHigh"><dw:TranslateLabel Text="Incorrect format" runat="server" /></td>
            <td>
                <input type="text" class="std" id="ValidationIncorrectFormat" name="ValidationIncorrectFormat" value="<%=Properties.Value("ValidationIncorrectFormat")%>" />
            </td>
        </tr>
        <tr>
            <td><dw:TranslateLabel Text="Empty field" runat="server" /></td>
            <td>
                <input type="text" class="std" id="ValidationEmptyField" name="ValidationEmptyField" value="<%=Properties.Value("ValidationEmptyField")%>" />
            </td>
        </tr>
    </table>
</dw:GroupBox>
</div>

<script type="text/javascript">
    document.observe('dom:loaded', function () {
        var instance = Dynamicweb.Items.ParagraphSettings.get_current();
        instance.set_areaId(<%=Base.ChkNumber(Request("AreaID"))%>);
        instance.set_pageId(<%=Base.ChkNumber(Request("PageID"))%>);
        instance.set_paragraphId(<%=Base.ChkNumber(Request("ID"))%>);
        instance.set_translation('Error', '<%=Translate.Translate(InternalError)%>');
        instance.set_translation('Nothing', '<%=Translate.Translate("Nothing")%>');
        instance.set_expression(<%=ItemRulesEditor.ClientInstanceName%>);
        instance.initialize({
            namedListPage: '<%=RenderPage(Base.ChkInteger(Properties("NamedListPageID")))%>'.evalJSON(),
            namedItemList: '<%=Properties("TargetNamedList")%>'
        });
    });
</script>