<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="NavigationXml.aspx.vb"
    Inherits="Dynamicweb.Admin.NavigationXml" %>
<%@ Import namespace="System.Data" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Navigation XML</title>
    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" runat="server" />
    <link href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET" />
    <link href="/Admin/Module/Common/Stylesheet.css" type="text/css" rel="stylesheet" />
    <script src="/Admin/Content/JsLib/prototype-1.6.0.2.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">

        function hideSubitem() {
            $('ParentTypesCell').select('[name="ParentType"]').each(function (s) {
                if (s.checked && s.value == "2") {
                    $('TemplateMenuParentIDRow').style.display = '';
                }
                else {
                    $('TemplateMenuParentIDRow').style.display = 'none';
                }
            });
        };

        function saveAndClose() {
            $('DoSaveAndClose').value = 'True';
            document.getElementById('form1').submit();
        }

        function save() {
            $('DoSave').value = 'True';
            document.getElementById('form1').submit();
        }

        function showStartFrame() {
            location = '/Admin/Content/Management/Start.aspx';
        }

        function help() {
            <%=Gui.Help("", "administration.managementcenter.designer.navigationxml") %>
        }

        function setParentType(obj){
            hideSubitem();
            $('ParentType').value = obj.value ;
        }

        function setMenuThreadID(obj){
            $('MenuThreadID').value = obj.value;
        }

        function generateXML(){
            $('DoGenerateXML').value = 'True';
            document.getElementById('form1').submit();
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <input type="hidden" id="DoSaveAndClose" name="DoSaveAndClose" />
    <input type="hidden" id="DoSave" name="DoSave" />
    <input type="hidden" id="DoGenerateXML" name="DoGenerateXML" />
    <dw:Toolbar ID="Toolbar" runat="server" ShowEnd="false">
        <dw:ToolbarButton ID="ButtonSave" runat="server" Image="Save" Text="Save" OnClientClick="save();" />
        <dw:ToolbarButton ID="ButtonSaveAndClose" runat="server" Image="SaveAndClose" Text="Save and close"
            OnClientClick="saveAndClose();" />
        <dw:ToolbarButton ID="ButtonCancel" runat="server" Image="Cancel" Text="Cancel" OnClientClick="showStartFrame();" />
        <dw:ToolbarButton ID="ButtonHelp" runat="server" Image="Help" Text="Help" OnClientClick="help();" />
    </dw:Toolbar>
    <h2 class="subtitle">
        <dw:TranslateLabel ID="TranslateLabel1" Text="Navigation XML" runat="server" />
    </h2>
    <div>
    </div>
    <dw:GroupBoxStart doTranslation="False" ID="GroupBoxStart1" Title="Settings" runat="server" />
    <table >
        <tr>
            <td  width="150">
                <dw:TranslateLabel ID="TranslateLabel8" Text="Website" runat="server" />
            </td>
            <td>
                <asp:DropDownList ID="Website" CssClass="std" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr >
            <td valign="top" width="150"><%=Translate.Translate("Fold ud")%></td>
            <td id="TemplateMenuThreadsCell" runat="server"></td>
            <input type="hidden" id="MenuThreadID" name="MenuThreadID" />
        </tr>
        <tr>
            <td valign="top" id="TemplateMenuThreadParentTxt" width="150"><%=Translate.Translate("Overmenu")%></td>
            <td id="ParentTypesCell" runat="server"> </td>
        </tr>
        <tr id="TemplateMenuParentIDRow" >
            <td width="150">
                <%= Translate.Translate("Underpunkter til side")%>
            </td>
            <td><%=Gui.LinkManager(TemplateMenuParentID, "TemplateMenuParentID", "")%></td>
        </tr>
        <tr id="TemplateMenuStartLevelRow" >
            <td width="150">
                <%=Translate.Translate("Første niveau")%>
            </td>
            <td>
                <%=Gui.SpacListExt(TemplateMenuStartLevel, "TemplateMenuStartLevel", 1, 15, 1, "", False, 95, 999, "")%>
            </td>
        </tr>
        <tr id="TemplateMenuStopLevelRow">
            <td width="150">
                <%=Translate.Translate("Sidste niveau")%>
            </td>
            <td>
                <%=Gui.SpacListExt(TemplateMenuStopLevel, "TemplateMenuStopLevel", 1, 15, 1, "", False, 95, 999, Translate.Translate("Ikke valgt"))%>
            </td>
        </tr>
        <tr id="TemplateMenuXSLTTemplateRow">
            <td  width="150">
                <%=Translate.Translate("XSLT")%>
            </td>
            <td>
                <%=Gui.Filemanager(TemplateMenuXSLTTemplate, "Templates/Navigation", "TemplateMenuXSLTTemplate", "xsl,xslt")%>
            </td>
        </tr>
    </table>
    <dw:GroupBoxEnd ID="GroupBoxEnd1" runat="server" />
    <dw:GroupBoxStart doTranslation="False" ID="gbMiscOptionsStart" Title="XML output"
        runat="server" />
    <table width="100%">
        <tr>
            <td>
                <dw:Button ID="PreviewXMLOutputBtn" runat="server" Name="Generate XML" OnClick="generateXML();" />
            </td>
        </tr>
    </table>
    <dw:GroupBoxEnd ID="gbMiscOptionsEnd" runat="server" />
    </form>
    <% Translate.GetEditOnlineScript()%>
    <script type="text/javascript">
        // Do close?
        if ('<%=DoClose %>' == 'True')
            showStartFrame();

        // Init the save-flag
        $('DoSaveAndClose').value = 'False';
        $('DoSave').value = 'False';
        $('DoGenerateXML').value = 'False';

        $('TemplateMenuThreadsCell').select('[name="TemplateMenuThread"]').each(function (s) {
            if (s.checked) {
                $('MenuThreadID').value = s.value;
            }
        });

        hideSubitem();
    </script>
</body>
</html>
