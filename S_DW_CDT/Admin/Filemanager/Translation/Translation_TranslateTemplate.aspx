<%@ Page Language="vb" ValidateRequest="false" AutoEventWireup="false" CodeBehind="Translation_TranslateTemplate.aspx.vb" Inherits="Dynamicweb.Admin.Translation_TranslateTemplate" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="translation" TagName="CultureList" Src="Translation_CultureList.ascx" %>
<%@ Register TagPrefix="translation" TagName="ViewKeys" Src="Translation_ViewKeys.ascx" %>
<%@ Register TagPrefix="translation" TagName="TableHeader" Src="Translation_TableHeader.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
	<dw:ControlResources runat="server">
	</dw:ControlResources>
    <link href="Translation_TranslateTemplate.css" rel="Stylesheet" type="text/css" />
    
    <script type="text/javascript" src="../FileEditor/jquery/jquery.js"></script>
    <script type="text/javascript" src="Translation_TranslateTemplate.js"></script>
 
</head>
<body style="overflow: hidden; background: #ECF4FC" onload="Page.onLoad();" onresize="Page.onResize();">

    <!-- Start: Form -->

    <form id="MainForm" runat="server">
        <table id="MainTable" border="0">
            <tr id="rowRibbon">
                <td>
                    <dw:Ribbonbar ID="Toolbar" runat="server">
                        <dw:RibbonbarTab ID="tabTranslate" Active="true" Name="Translate" runat="server" OnClientClick="ViewKeysDialog.close(); Page.toggleContent('divContent');">
                            <dw:RibbonbarGroup ID="groupFile" Name="File" runat="server">
                                <dw:RibbonbarButton ID="cmdSave" Text="Save" Size="Large" Image="Save" runat="server" OnClientClick="Page.save();">
                                </dw:RibbonbarButton>
                            </dw:RibbonbarGroup>
                            <dw:RibbonbarGroup ID="groupEdit" Name="Edit" runat="server">
                                <dw:RibbonbarButton ID="cmdEditTemplate" Text="Edit template" Size="Small" Image="EditDocument" runat="server" OnClientClick="Page.editTemplate();" />
                            </dw:RibbonbarGroup>
                            <dw:RibbonbarGroup ID="groupView" Name="View" runat="server">
                                <dw:RibbonbarButton ID="cmdViewCultures" Text="Cultures" Size="Large" Image="FolderComponents" runat="server" OnClientClick="CultureListDialog.toggle();">
                                    <div>
							            <img id="imgCulturesArrow" src="/Admin/Images/ColumnSortUp.gif" alt="" />
						            </div>
                                </dw:RibbonbarButton>
                            </dw:RibbonbarGroup>
                            <dw:RibbonbarGroup ID="groupHelpEdit" runat="server" Name="Help">
					            <dw:RibbonbarButton ID="cmdHelpEdit" runat="server" Text="Help" Image="Help" OnClientClick="Page.help();">
					            </dw:RibbonbarButton>
				            </dw:RibbonbarGroup>
                        </dw:RibbonbarTab>
                        <dw:RibbonbarTab ID="tabSearch" Name="Browse keys" runat="server" OnClientClick="CultureListDialog.close(); Page.toggleContent('divBrowse');">
                            <dw:RibbonbarGroup ID="groupFilter" Name="Filter" runat="server">
                               <dw:RibbonbarButton ID="cmdViewKeys" Text="Keys" Size="Large" Image="FolderGear" runat="server" OnClientClick="ViewKeysDialog.toggle();">
                                    <div>
							            <img id="imgViewKeysArrow" src="/Admin/Images/ColumnSortUp.gif" alt="" />
						            </div>
                                </dw:RibbonbarButton> 
                            </dw:RibbonbarGroup>
                            <dw:RibbonbarGroup ID="groupSearch" Name="Search" runat="server">
                                <dw:RibbonbarPanel ID="cmdSearch" runat="server">
                                    <br />
                                    <input type="text" id="txSearch" onkeyup="Page.onSearch(this);" name="txSearch" class="std" runat="server" />
                                </dw:RibbonbarPanel>
                            </dw:RibbonbarGroup>
                            <dw:RibbonbarGroup ID="groupHelpView" runat="server" Name="Help">
					            <dw:RibbonbarButton ID="cmdHelpView" runat="server" Text="Help" Image="Help" OnClientClick="Page.help();">
					            </dw:RibbonbarButton>
				            </dw:RibbonbarGroup>
                        </dw:RibbonbarTab>
                    </dw:Ribbonbar>
                </td>
            </tr>
            <tr valign="top">
                <td height="100%">
                
                    <!-- 'Translate' page -->
                
                    <div id="divContent" class="grid" style="display:">
                        <div id="contentRow" runat="server">
                            <table id="tbTranslate" border="0" cellspacing="0" cellpadding="0" class="contentTable" width="100%">
                                <translation:TableHeader id="HeaderTranslate" ShowLocation="true" runat="server" />
                                
                                <!-- Start: rows -->
                                
                                <asp:Repeater ID="repKeys" runat="server">
                                    <ItemTemplate>
                                        <tr class="keyTableRow" 
                                            onmouseover="javascript:Page.toggleTableRow(this, true);" 
                                            onmouseout="javascript:Page.toggleTableRow(this, false);">
                                            
                                            <td width="200px">
                                                <input type="hidden" id="txKeyName" value='<%#Eval("Name")%>' runat="server" />
                                                &nbsp;<%#Eval("Name")%>&nbsp;
                                            </td>
                                            <td align="center" width="30px">
                                                <img src="/Admin/Images/Check.gif" align="middle" width="9" height="9" border="0" id="imgGlobal" alt="" runat="server" />
                                            </td>
                                            <td align="center" width="30px">
                                                <img src="/Admin/Images/Check.gif" align="middle" width="9" height="9" border="0" id="imgLocal" alt="" runat="server" />
                                            </td>
                                            <td align="left" width="200px">
                                                <span style="color: #ababab;">
                                                    <%#Base.ChkString(Eval("DefaultValue")).Replace("<", "&lt;").Replace(">", "&gt;")%> 
                                                </span>
                                            </td>
                                            
                                            <asp:Repeater ID="repTranslations" runat="server">
                                                <ItemTemplate>
                                                    <td width="250px">
                                                        <input type="hidden" id="txTranslationCulture" value='<%#Eval("Value.CultureName")%>' runat="server" />
                                                        <input type="text" id="txTranslation" class="std" value='<%#Eval("Value.Value")%>' runat="server" />
                                                    </td>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                                
                                <!-- End: rows -->
                                
                            </table>
                        </div>
                    </div>
                    
                    <!-- End: 'Translate' page -->
                                        
                    <!-- 'Browse keys' page -->
                    
                    <div id="divBrowse" class="grid" style="display:none">
                        <table id="tbBrowse" border="0" cellspacing="0" cellpadding="0" class="contentTable" width="100%">
                            <translation:TableHeader id="HeaderBrowse" ShowLocation="True" ShowDefaultText="False" runat="server" />
                            
                            <asp:Repeater ID="repBrowseKeys" runat="server">
                                <ItemTemplate>
                                    <tr class='BrowseKey_<%#Eval("Scope")%> keyTableRow'
                                        style='display: <%#GetKeyVisibility(Container.DataItem)%>'
                                        onmouseover="javascript:Page.toggleTableRow(this, true);" 
                                        onmouseout="javascript:Page.toggleTableRow(this, false);">
                                        
                                        <td class="searchable" width="200px">
                                            &nbsp;<%#Eval("Name")%>&nbsp;
                                        </td>
                                        <td align="center" width="30px">
                                            <img src="/Admin/Images/Check.gif" align="middle" width="9" height="9" border="0" id="imgGlobal" alt="" runat="server" />
                                        </td>
                                        <td align="center" width="30px">
                                            <img src="/Admin/Images/Check.gif" align="middle" width="9" height="9" border="0" id="imgLocal" alt="" runat="server" />
                                        </td>
                                        
                                        <asp:Repeater ID="repBrowseKeyTranslations" runat="server">
                                            <ItemTemplate>
                                                <td width="220px">
                                                    <input type="text" class="std" disabled="disabled" value='<%#Eval("Value.Value")%>' />
                                                </td>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                            
                            <tr ID="phNoKeyFound" runat="server">
                                <td class="bigText" colspan="10" width="100%">
                                    <nobr>
                                        <dw:TranslateLabel ID="lbNoKeysFound" Text="No keys found" runat="server" />
                                    </nobr>
                                </td>
                            </tr>
                        </table>
                    </div>
                    
                    <!-- End: 'Browse keys' page -->
                    
                </td>
            </tr>
        </table>
        
        <!-- 'Culture list' dialog -->
        
        <span id="CultureListDialog" type="dialog" style="position: absolute; left: 30px; top: 30px; display: none">
            <translation:CultureList id="CultureList" runat="server" />
        </span>
        
        <!-- 'View keys' dialog -->
        
        <span id="ViewKeysDialog" type="dialog" style="position: absolute; left: 30px; top: 30px; display: none">
            <translation:ViewKeys id="ViewKeys" runat="server" />
        </span>
        
        <span id="scriptHelp" style="display: none">
            <%=Gui.Help("", "template.translate")%>
        </span>
        
        <input type="hidden" id="saveFlag" name="saveFlag" value="false" runat="server" />
        
        <!-- Settings for 'Edit template' action -->
        
        <input type="hidden" id="TemplateFile" name="TemplateFile" value="" runat="server" />
        <input type="hidden" id="TemplateFolder" name="TemplateFolder" value="" runat="server" />
        <input type="hidden" id="UseNewEditor" name="UseNewEditor" value="false" runat="server" />
        <input type="hidden" id="WindowCaller" name="WindowCaller" value="" runat="server" />
    </form>
    
    <!-- End: Form -->
    
</body>
</html>

<% Translate.GetEditOnlineScript() %>