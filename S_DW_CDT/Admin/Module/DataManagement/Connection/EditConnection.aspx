<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EditConnection.aspx.vb" Inherits="Dynamicweb.Admin.EditConnection" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link rel="Stylesheet" href="/Admin/Content/StyleSheetNewUI.css" />
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" runat="server" />
    <style type="text/css">
        .sql-settings
        {
        }
        .access-settings
        {
        }
        .crm4-settings
        {
        }
        .validation-error
        {
            background-color: #FFAAAA;
        }
    </style>

    <script type="text/javascript">
        var id = <%=ItemID%>;
        var cmd = "<%=CMD%>";
        var helpLang = "<%=helpLang %>";
        
        function validateField(name) {
            var elemGet = $(name);
            var elemSet = $(name);
            if (elemGet === null) {
                // assume the FM
                elemGet = $(name + '_path');
                elemSet = $('FM_' + name);
            }
            
            if (elemGet.getValue() === '') {
                elemSet.addClassName('validation-error');
                return false;
            } else {
                elemSet.removeClassName('validation-error');
                return true;
            }
        }

        function checkFields() {
            var type = $F("radio_csType_selected");
            var fields = [];
            var isClean = validateField('csName');
            switch(type) {
                case 'csType_sql':
                case 'csType_crm4':
                    isClean = isClean && validateField('csServer');
                    isClean = isClean && validateField('csDBName');
                break;
                case 'csType_access':
                    var fmValid = validateField('csLocalPath');
                    isClean = isClean && fmValid;
                break;
            }
            return isClean;
        }
        
        function save() {
            if(!checkFields())
                return false;
            document.getElementById('form1').action = "EditConnection.aspx?ID=" + id + "&CMD=SAVE_CONNECTION&OnSave=Nothing";
            document.getElementById('form1').submit();
        }
        function saveAndClose() {
            if(!checkFields())
                return false;
            document.getElementById('form1').action = "EditConnection.aspx?ID=" + id + "&CMD=SAVE_CONNECTION&OnSave=Close";
            document.getElementById('form1').submit();
        }
        function cancel() {
            document.getElementById('form1').target = '';
            document.getElementById('form1').action = "EditConnection.aspx?CMD=CANCEL";
            document.getElementById('form1').submit();
        }
        function help() {
            window.open('http://manual.net.dynamicweb.dk/Default.aspx?ID=1&m=keywordfinder&keyword=modules.datamanagement.general.connection.edit&LanguageID=' + helpLang, 'dw_help_window', 'location=no,directories=no,menubar=no,toolbar=yes,top=0,width=1024,height=' + (screen.availHeight-100) + ',resizable=yes,scrollbars=yes');
        }
        
        function ChangeFieldLayout(type) {
            $$('.sql-settings').each(Element.hide);
            $$('.access-settings').each(Element.hide);
            $$('.crm4-settings').each(Element.hide);
            $$('.' + type + '-settings').each(Element.show);
            if (type == "crm4") {
                $("tlDatabaseName").innerHTML = '<%=Translate.JsTranslate("Organization") %>';
                $$("#settingsDiv legend")[0].innerHTML = 'Microsoft CRM 4';
            } else {
                $("tlDatabaseName").innerHTML = '<%=Translate.JsTranslate("Database name") %>';
                $$("#settingsDiv legend")[0].innerHTML = '<%=Translate.JsTranslate("Database") %>&nbsp;';
            }
        }
        
        function toggleTrusted(obj) {
            var pass = $("csPassword");
            var user = $("csUserId");
            
            if (obj.checked) {
                pass.disabled = true;
                user.disabled = true;    
            }else{
                pass.disabled = false;
                user.disabled = false;    
            }
        }
        
        Event.observe(window, "load", function() {
            ChangeFieldLayout('<%=GetTypeString()%>');
            
            ['csName', 'csServer', 'csDBName'].each(function(e){
                $(e).observe("change", function() {
                    validateField(e);
                });
            });
        });
    </script>

</head>
<body class="edit" style="border-bottom: 1px solid #6593CF;" onload="document.body.style.height = parent.getContentFrameHeight() - 1 + 'px';">
    <form id="form1" runat="server">
        <dw:RibbonBar ID="Ribbon" runat="server">
            <dw:RibbonBarTab ID="RibbonbarTab1" runat="server" Active="true" Name="Connection">
                <dw:RibbonBarGroup ID="RibbonbarGroup1" runat="server" Name="Funktioner">
                    <dw:RibbonBarButton runat="server" Text="Gem" Size="Small" Image="Save" OnClientClick="save();" ID="Save" EnableServerClick="false" />
                    <dw:RibbonBarButton runat="server" Text="Gem og luk" Size="Small" Image="SaveAndClose" OnClientClick="saveAndClose();" ID="SaveAndClose" EnableServerClick="false" />
                    <dw:RibbonBarButton runat="server" Text="Annuller" Size="Small" Image="Cancel" OnClientClick="cancel();" ID="Cancel" EnableServerClick="false" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="rgButtons" runat="server" Name="Connection type">
                    <dw:RibbonBarRadioButton OnClientClick="ChangeFieldLayout('sql');" ID="csType_sql" Group="csType" Text="SQL" RenderAs="Default" Value="0" Checked="true" runat="server" Size="Large" Image="Connection" />
                    <dw:RibbonBarRadioButton OnClientClick="ChangeFieldLayout('access');" ID="csType_access" Group="csType" Text="MS Access" RenderAs="Default" Value="1" runat="server" Size="Large" Image="Connection_Access" />
                    <dw:RibbonBarRadioButton OnClientClick="ChangeFieldLayout('crm4');" ID="csType_crm4" Group="csType" Text="MS CRM 4" RenderAs="Default" Value="2" runat="server" Size="Large" Image="Connection_CRM" DoTranslate="False" ModuleSystemName="CRMIntegration" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonbarGroup2" runat="server" Name="Help">
                    <dw:RibbonBarButton ID="HelpBut" runat="server" Text="Help" Image="Help" Size="Large" OnClientClick="help();" />
                </dw:RibbonBarGroup>
            </dw:RibbonBarTab>
        </dw:RibbonBar>
        <dw:GroupBox ID="gbName" runat="server" DoTranslation="true" Title="Indstillinger">
            <table cellpadding="1" cellspacing="1">
                <tr>
                    <td style="width: 170px;">
                        <div class="nobr">
                            <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Name" />
                        </div>
                    </td>
                    <td>
                        <input type="text" name="csName" id="csName" runat="server" maxlength="255" class="NewUIinput" />
                    </td>
                </tr>
            </table>
        </dw:GroupBox>
        <div id="settingsDiv">
            <dw:GroupBox ID="gbSettings" runat="server" DoTranslation="true" Title="Database">
                <table cellpadding="1" cellspacing="1">
                    <tr id="sql_1" class="sql-settings crm4-settings">
                        <td style="width: 170px;">
                            <div class="nobr">
                                <dw:TranslateLabel runat="server" Text="Server name" />
                            </div>
                        </td>
                        <td>
                            <input type="text" name="csServer" id="csServer" runat="server" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr id="sql_2" class="sql-settings crm4-settings">
                        <td style="width: 170px;">
                            <div class="nobr" id="tlDatabaseName">
                                <dw:TranslateLabel runat="server" Text="Database name" />
                            </div>
                        </td>
                        <td>
                            <input type="text" name="csDBName" id="csDBName" runat="server" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr id="sql_3" class="sql-settings crm4-settings">
                        <td style="width: 170px;">
                            <div class="nobr">
                                <dw:TranslateLabel runat="server" Text="User name" />
                            </div>
                        </td>
                        <td>
                            <input type="text" name="csUserId" id="csUserId" runat="server" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr id="sql_4" class="sql-settings crm4-settings">
                        <td style="width: 170px;">
                            <div class="nobr">
                                <dw:TranslateLabel runat="server" Text="Password" />
                            </div>
                        </td>
                        <td>
                            <input type="text" name="csPassword" id="csPassword" runat="server" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr id="sql_5" class="sql-settings crm4-settings">
                        <td style="width: 170px;">
                            <div class="nobr">
                                <dw:TranslateLabel runat="server" Text="Use trusted connection" />
                            </div>
                        </td>
                        <td>
                            <input type="checkbox" name="csTrusted" id="csTrusted" runat="server" class="NewUIcheckbox" onclick="toggleTrusted(this);" />
                        </td>
                    </tr>
                    <tr id="access_1" class="access-settings">
                        <td style="width: 170px;">
                            <div class="nobr">
                                <dw:TranslateLabel runat="server" Text="Choose file" />
                            </div>
                        </td>
                        <td>
                            <dw:FileManager runat="server" Name="csLocalPath" ID="csLocalPath" Extensions="mdb" Folder="Files/" ShowPreview="false" CssClass="NewUIinput" FullPath="true" ShowOnlyAllowedExtensions="True" />
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
        </div>
    </form>
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</body>
</html>
