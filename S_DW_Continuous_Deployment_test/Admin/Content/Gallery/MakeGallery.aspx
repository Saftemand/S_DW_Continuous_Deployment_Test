<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MakeGallery.aspx.vb" Inherits="Dynamicweb.Admin.MakeGallery" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title><%=Dynamicweb.Backend.Translate.Translate("Theme")%></title>
    <dw:ControlResources runat="server" IncludeUIStylesheet="true" IncludePrototype="true" IncludeScriptaculous="true" />
</head>
<body>
    <form id="GalleryForm" runat="server" target="_self">
    
        <div id="MainDiv">
        
            <!-- Toolbar -->
            <dw:Toolbar runat="server" ShowEnd="false">
                <dw:ToolbarButton runat="server" Image="Save" Text="Save" OnClientClick="submit();" />
                <dw:ToolbarButton runat="server" image="Cancel" Text="Cancel" OnClientClick="window.close();"/>
                <dw:ToolbarButton runat="server" Image="Help" Text="Help" OnClientClick="help();" />
            </dw:Toolbar>
            
            <!-- Subtitle -->
            <h2 class="subtitle">
                <dw:TranslateLabel runat="server" Text="New theme" />
            </h2>
            
            <!-- Settings -->
            <dw:GroupBox runat="server" Title="Settings" DoTranslation="true">
                <table>
                    <colgroup>
                        <col style="width:170px; white-space:nowrap; "/>
                        <col />
                    </colgroup>
                    
                    <!-- Title -->
                    <tr>
                        <td>
                            <dw:TranslateLabel runat="server" Text="Title" />
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="Title" CssClass="NewUIinput" />
                        </td>
                    </tr>
                    
                    <!-- Description -->
                    <tr>
                        <td style="vertical-align:top;">
                            <dw:TranslateLabel runat="server" Text="Description" />
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="Description" Rows="2" CssClass="NewUIinput" TextMode="MultiLine" />
                        </td>
                    </tr>
                    
                    <!-- Help text -->
                    <tr>
                        <td style="vertical-align:top;">
                            <dw:TranslateLabel runat="server" Text="Instructions" />
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="HelpText" Rows="3" CssClass="NewUIinput" TextMode="MultiLine" />
                        </td>
                    </tr>
                    
                    <!-- Preview image -->
                    <tr>
                        <td style="vertical-align:top;">
                            <dw:TranslateLabel runat="server" Text="Preview image" />
                        </td>
                        <td>
                            <asp:FileUpload runat="server" ID="PreviewImage" CssClass="NewUIinput" />
                        </td>
                    </tr>
                    
                    <!-- PrivateFlag -->
                    <tr runat="server" id="PrivateRow">
                        <td style="vertical-align:top;">
                            <dw:TranslateLabel runat="server" Text="Access" />
                        </td>
                        <td>
                            <asp:RadioButton runat="server" ID="AccessPublic" GroupName="Access" />
                            <asp:RadioButton runat="server" ID="AccessPrivate" GroupName="Access"/>
                        </td>
                    </tr>
                
                </table>
                
            </dw:GroupBox>
            
            <!-- List of options -->
            <dw:GroupBox runat="server" Title="Module settings" DoTranslation="true">
                <table class="ModuleSettingsList" cellspacing="0">
                    <colgroup>
                        <col style="white-space:nowrap" />
                        <col style="white-space:nowrap" />
                        <col style="white-space:nowrap" />
                    </colgroup>
                    <tr>
                        <th>
                            <dw:TranslateLabel runat="server" Text="Select" />
                        </th>
                        <th>
                            <dw:TranslateLabel runat="server" Text="Option name" />
                        </th>
                        <th>
                            <dw:TranslateLabel runat="server" Text="Value" />
                        </th>
                    </tr>

                    <asp:Repeater runat="server" ID="OptionRepeater">
                        <ItemTemplate>
                            <tr>
                                <td class="SettingsListCheckbox">
                                    <input type="checkbox" name="OptionSelection" checked="checked" value="<%# DataBinder.Eval(Container.DataItem, "Key") %>" />
                                </td>
                                <td class="SettingsListPadding">
                                    <%# DataBinder.Eval(Container.DataItem, "Key") %>
                                </td>
                                <td class="SettingsListPadding">
                                    <%#DataBinder.Eval(Container.DataItem, "Value")%>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </dw:GroupBox>
            
            <!-- List of templates -->
            <dw:GroupBox runat="server" Title="Templates" DoTranslation="true">
                <table class="ModuleSettingsList" cellspacing="0">
                    <colgroup>
                        <col style="white-space:nowrap" />
                        <col style="white-space:nowrap" />
                        <col style="white-space:nowrap" />
                        <col style="white-space:nowrap" />
                    </colgroup>
                    <tr>
                        <th>
                            <dw:TranslateLabel runat="server" Text="Select" />
                        </th>
                        <th>
                            <dw:TranslateLabel runat="server" Text="Option name" />
                        </th>
                        <th>
                            <dw:TranslateLabel runat="server" Text="File" />
                        </th>
                        <th>
                            <dw:TranslateLabel runat="server" Text="Size" />
                        </th>
                    </tr>

                    <asp:Repeater runat="server" ID="TemplateRepeater">
                        <ItemTemplate>
                            <tr>
                                <td class="SettingsListCheckbox">
                                    <input type="checkbox" name="OptionSelection" checked="checked" value="<%# SettingName(Container)%>" />
                                </td>
                                <td class="SettingsListPadding">
                                    <%# SettingName(Container)%>
                                </td>
                                <td class="SettingsListPadding">
                                    <a href="<%#Path(Container)%>" target="_blank" >
                                        <%# Path(Container)%>
                                    </a>
                                </td>
                                <td class="SettingsListPadding">
                                    <%# FileSizeFormatted(Container)%>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </dw:GroupBox>
            
            <!-- List of other files -->
            <dw:GroupBox runat="server" Title="Other files" DoTranslation="true">

                <asp:Repeater runat="server" ID="FilesRepeater">
                    <HeaderTemplate>
                        <table class="ModuleSettingsList" id="OtherFilesTable" cellspacing="0">
                            <colgroup>
                                <col style="white-space:nowrap" />
                                <col style="white-space:nowrap" />
                                <col style="white-space:nowrap" />
                                <col style="white-space:nowrap" />
                            </colgroup>
                            <tr>
                                <th>
                                    <dw:TranslateLabel runat="server" Text="Select" />
                                </th>
                                <th>
                                    <dw:TranslateLabel runat="server" Text="File" />
                                </th>
                                <th>
                                    <dw:TranslateLabel runat="server" Text="Size" />
                                </th>
                            </tr>
                    </HeaderTemplate>
                    
                    <ItemTemplate>
                        <tr>
                            <td class="SettingsListCheckbox">
                                <input type="checkbox" name="OptionSelection" checked="checked" value="file_<%# Path(Container)%>" />
                            </td>
                            <td class="SettingsListPadding">
                                <a href="<%#Path(Container)%>" target="_blank" >
                                    <%# Path(Container)%>
                                </a>
                            </td>
                            <td class="SettingsListPadding">
                                <%# FileSizeFormatted(Container)%>
                            </td>
                        </tr>
                    </ItemTemplate>
                    
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
                <dw:TranslateLabel runat="server" Text="Add file:" />
                <dw:FileManager runat="server" id="AddOtherFile" FullPath="true" FixFieldName="true" Folder="/Files" />
                <input type="button" value="<%=Dynamicweb.Backend.Translate.Translate("Add") %>" onclick="javascript:AddOtherFileAJAX();" />
            </dw:GroupBox>
            
        </div>
        
        <div id="ConfirmDiv" style="display:none;">
            <!-- Toolbar -->
            <dw:Toolbar runat="server" ShowEnd="false">
                <dw:ToolbarButton runat="server" Image="Cancel" Text="Close" OnClientClick="window.close();" />
            </dw:Toolbar>
            
            <dw:GroupBox runat="server" Title="Theme created" DoTranslation="true">
                <div style="margin:10px 10px 10px 10px;">
                    <p>
                        <%=Dynamicweb.Backend.Translate.Translate("The theme was succesfully created as")%> <%=zipFilePath %>
                    </p>
                    <a href="<%=zipFilePath %>">Download</a>
                </div>
            </dw:GroupBox>
        </div>

    </form>
    
    <script type="text/javascript">
        if ('<%=zipFilePath %>' != '') {
            $('MainDiv').style.display = 'none';
            $('ConfirmDiv').style.display = 'block';
        }

        function submit() {
            if ($('Title').value == '') {
                alert('<%=Dynamicweb.Backend.Translate.JsTranslate("You must enter a title") %>');
                $('Title').focus();
            }
            else {
                $('GalleryForm').submit();
            }
        }
        function AddOtherFileAJAX() {
            if ($('AddOtherFile_path').value == '')
                return;

            document.forms[0].request({
                method: 'post',
                parameters: {
                    action: 'AddFile'
                },

                onComplete: function(response) {
                    var responseSplit = response.responseText.split(';');
                    var path = responseSplit[0];
                    var size = responseSplit[1];

                    var table = $('OtherFilesTable');
                    var row = table.insertRow(table.rows.length);

                    var selectCell = row.insertCell(0);
                    selectCell.className = 'SettingsListCheckbox';
                    selectCell.innerHTML = '<input type="checkbox" name="OptionSelection" checked="checked" value="file_' + path + '" />';

                    var pathCell = row.insertCell(1);
                    pathCell.className = 'SettingsListPadding';
                    pathCell.innerHTML = '<a href="' + path + '" target="_blank">' + path + '</a>';

                    var sizeCell = row.insertCell(2);
                    sizeCell.className = 'SettingsListPadding';
                    sizeCell.innerHTML = size;

                    $('AddOtherFile_path').value = '';
                    $('FM_AddOtherFile').value = '';
                }
            });
        }

        //Help window
        function help() {
        <%=Dynamicweb.Gui.Help("", "page.paragraph.themes.new") %>
        }
            
    </script>
</body>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>