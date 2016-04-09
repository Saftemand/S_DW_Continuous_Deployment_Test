<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Galleries.aspx.vb" Inherits="Dynamicweb.Admin.Galleries" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <dw:ControlResources runat="server" IncludePrototype="true" IncludeScriptaculous="true" IncludeUIStylesheet="true" />
    
    <style type="text/css">
        .MarkedModuleName 
        {
        	font-weight:bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    
        <input type="hidden" id="ActiveModuleSystemName" name="ActiveModuleSystemName" />
    
        <!-- Toolbar -->
        <dw:Toolbar runat="server" ShowEnd="false">
            <dw:ToolbarButton runat="server" Image="Undo" Text="Back" OnClientClick="javascript:location.href = '/Admin/Content/Management/Start.aspx';" />
            <dw:ToolbarButton runat="server" Image="Help" Text="Help" OnClientClick="help();" />
        </dw:Toolbar>
        
        <!-- Installed themes -->
        <dw:GroupBox runat="server" Title="Installed themes" DoTranslation="true">
            <div style="margin:10px 10px 10px 10px;">
                <table cellspacing="0" cellpadding="2">
                    <tr>
                        <th style="text-align:left;">
                            <dw:TranslateLabel runat="server" Text="Module name" />
                        </th>
                        <th>
                            <dw:TranslateLabel runat="server" Text="Installed modules" />
                        </th>
                    </tr>
                    <asp:Repeater runat="server" ID="GalleriesPerModuleRepeater">
                        <ItemTemplate>
                            <tr style="cursor:pointer;" onmouseover="this.style.backgroundColor = '#D0E1F4';" onmouseout="this.style.backgroundColor = 'white';" onclick="javascript:SwitchDiv('<%#Eval("ModuleSystemName") %>')">
                                <td style="width:250px;">
                                   <span id="ModuleName_<%#Eval("ModuleSystemName") %>"><%#Eval("ModuleName")%> </span>
                                </td>
                                <td style="text-align:right;">
                                    <asp:Literal runat="server" ID="GalleriesCount"></asp:Literal>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </div>
        </dw:GroupBox>
        
        <!-- Edit theme for module -->
        <asp:Repeater runat="server" ID="OuterEditRepeater">
            <ItemTemplate>
                <div id="modulediv_<%#Eval("ModuleSystemName") %>" style="display:none;" >
                    <dw:GroupBox runat="server" ID="EditGroupBox" DoTranslation="false">
                        <div style="margin:10px 10px 10px 10px;">
                            <table cellspacing="0" cellpadding="2">
                                <tr>
                                    <th style="text-align:left;">
                                        <dw:TranslateLabel runat="server" Text="Theme name" />
                                    </th>
                                    <th>
                                        <dw:TranslateLabel runat="server" Text="Preview" />
                                    </th>
                                    <th>
                                        <dw:TranslateLabel runat="server" Text="Download" />
                                    </th>
                                    <th>
                                        <dw:TranslateLabel runat="server" Text="Delete" />
                                    </th>
                                </tr>
                                <asp:Repeater runat="server" ID="InnerEditRepeater" OnItemDataBound="OnInnerEditRepeater_DataBound">
                                    <ItemTemplate>
                                        <tr onmouseover="this.style.backgroundColor = '#D0E1F4';" onmouseout="this.style.backgroundColor = 'white';">
                                            <td width="250px;" >
                                                <%#Eval("Title")%>
                                            </td>
                                            <td style="text-align:center;">
                                                <a runat="server" href="" id="PreviewLink"><img src="/Admin/Images/preview.gif" title="<%=Dynamicweb.Backend.Translate.Translate("Preview") %>" alt="<%=Dynamicweb.Backend.Translate.Translate("Preview") %>" style="border:none;"/></a>
                                            </td>
                                            <td style="text-align:center;">
                                                <a runat="server" href="" id="DownloadZipLink"><img src="/Admin/Images/ext/zip.gif" title="<%=Dynamicweb.Backend.Translate.Translate("Download") %>" alt="<%=Dynamicweb.Backend.Translate.Translate("Download") %>" style="border:none;"/></a>
                                            </td>
                                            <td style="text-align:center;">
                                                <a runat="server" href="" id="DeleteZipLink"><img src="/Admin/Images/delete.gif" title="<%=Dynamicweb.Backend.Translate.Translate("Slet") %>" alt="<%=Dynamicweb.Backend.Translate.Translate("Slet") %>" style="border:none;" /></a>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </table>
                        </div>
                    </dw:GroupBox>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        
        <!-- Add new theme -->
        <dw:GroupBox runat="server" Title="Install new theme" DoTranslation="true">
            <div style="margin:10px 10px 10px 10px;">
                <asp:FileUpload runat="server" ID="GalleryFileUpload" /> <br />
                <input type="submit" value="<%=Dynamicweb.Backend.Translate.Translate("Install theme") %>"  />
            </div>
        </dw:GroupBox>
        
    </form>
    
    <script type="text/javascript">
        var currentModuleSystemName = '';
        function SwitchDiv(moduleSystemName) {
            // Hide previous shown div and set module name to not bold
            if (currentModuleSystemName != '') {
                $('modulediv_' + currentModuleSystemName).style.display = 'none';
                $('ModuleName_' + currentModuleSystemName).className = '';
            }

            // If this module system name is same as previous then just unselect it
            if (currentModuleSystemName == moduleSystemName) {
                currentModuleSystemName = '';
                $('ActiveModuleSystemName').value = '';
                return;
            }

            // Check if a div with that system name exists
            if (!$('modulediv_' + moduleSystemName)) {
                return;
            }
                
            // Set current
            currentModuleSystemName = moduleSystemName;
            $('ActiveModuleSystemName').value = moduleSystemName;
            
            // Show current
            $('modulediv_' + currentModuleSystemName).style.display = 'block';
            $('ModuleName_' + currentModuleSystemName).className = 'MarkedModuleName';
        }

        function deleteZip(zipUrl, confirmText) {
            if (confirm(confirmText))
                location.href = 'Galleries.aspx?DeleteZipUrl=' + zipUrl + '&ActiveModuleSystemName=' + currentModuleSystemName;
        }

        if ('<%=ActiveModuleSystemName %>' != '')
            SwitchDiv('<%=ActiveModuleSystemName %>');

        if ('<%=message %>' != '')
            alert('<%=message %>');

        //Help window
        function help() {
        <%=Dynamicweb.Gui.Help("", "administration.managementcenter.themes") %>
        }

    </script>
</body>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()
    %>
</html>
