<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Extensibility_cpl.aspx.vb" Inherits="Dynamicweb.Admin.Extensibility_cpl" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title></title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <dw:ControlResources runat="server">
        </dw:ControlResources>
        <script type="text/javascript">
            if (!Dynamicweb){
                Dynamicweb = {};
            }

            if (!Dynamicweb.Modules) {
                Dynamicweb.Modules = {};
            }

            if (!Dynamicweb.Modules.Extensibility) {
                Dynamicweb.Modules.Extensibility = {};
            }

            Dynamicweb.Modules.Extensibility.AddIns = Class.create({
                initialize: function () {
                    var self = this;

                    self._translates = $H();

                    self._controls = {
                        form: $('MainForm')
                    };

                    self._methods = {
                        action: function (name, parameters) {
                            var params = '', prop;

                            if (parameters) {
                                for (prop in parameters) {
                                    params += '&' + prop + '=' + parameters[prop];
                                }
                            }

                            window.location.href = window.location.protocol + '//' + window.location.host + window.location.pathname + '?action=' + name + params
                        }
                    }
                },
                set_translate: function (key, value) {
                    if (key && value) {
                        this._translates.set(key, value);
                    }
                },
                get_translate: function (key) {
                    if (key) {
                        return this._translates.get(key);
                    }
                },
                download: function (fileName) {
                    var self = this;

                    self._methods.action('Download', { file: fileName });
                },
                toggleAllowance: function () {
                    var self = this;

                    if (confirm(self.get_translate('recycle'))) {
                        self._methods.action('ToggleAllowance');
                    }
                },
                help: function () {
                     <%=Gui.Help("extensibility", "modules.extensibility")%>
                }
            });

            Dynamicweb.Modules.Extensibility.AddIns._instance = null;
            Dynamicweb.Modules.Extensibility.AddIns.get_current = function () {
                if (!Dynamicweb.Modules.Extensibility.AddIns._instance) {
                    Dynamicweb.Modules.Extensibility.AddIns._instance = new Dynamicweb.Modules.Extensibility.AddIns();
                }

                return Dynamicweb.Modules.Extensibility.AddIns._instance;
            }

        </script>
    </head>
    <body>
        <form id="MainForm" name="MainForm" runat="server">
            <dw:StretchedContainer Scroll="Auto" Stretch="Fill" Anchor="document" runat="server">
                <dw:Toolbar ID="Buttons" runat="server" ShowEnd="false">
                    <dw:ToolbarButton ID="btnToggleAllowance" Visible="false" runat="server" Divide="None" OnClientClick="Dynamicweb.Modules.Extensibility.AddIns.get_current().toggleAllowance();">
                    </dw:ToolbarButton>
                    <dw:ToolbarButton runat="server" Divide="None" Image="Help" Text="Help" OnClientClick="Dynamicweb.Modules.Extensibility.AddIns.get_current().help();">
                    </dw:ToolbarButton>
                </dw:Toolbar>
            <dw:List ID="AssemblyList" StretchContent="true" Title="Assemblies" runat="server" AllowMultiSelect="false" ShowTitle="True" ShowPaging="false">
                <Columns>
                    <dw:ListColumn ID="Name" runat="server" EnableSorting="true" WidthPercent="90" Name="Name">
                    </dw:ListColumn>
                    <dw:ListColumn ID="Allowed" ItemAlign="Center" runat="server" Name="Allowed" EnableSorting="true">
                    </dw:ListColumn>
                </Columns>
            </dw:List>

            <dw:ContextMenu ID="cmFile" runat="server">
                <dw:ContextMenuButton ID="Download" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/Save.png"
                Text="Download" OnClientClick="Dynamicweb.Modules.Extensibility.AddIns.get_current().download(ContextMenu.callingItemID);">
                </dw:ContextMenuButton>
            </dw:ContextMenu>
            </dw:StretchedContainer>
            <input type="hidden" id="Alert" runat="server" />
        </form>
        <script>
            document.observe('dom:loaded', function () {
                var alertMessage = $('Alert');
                Dynamicweb.Modules.Extensibility.AddIns.get_current().set_translate('recycle', '<%= Backend.Translate.JsTranslate("This operation will initiate recycle app pool. Continue?") %>');
                Dynamicweb.Modules.Extensibility.AddIns.get_current().set_translate('error', '<%= Backend.Translate.JsTranslate("Unexpected internal error. Try again later.") %>');

                if (alertMessage && alertMessage.value) {
                    alert(alertMessage.value);
                }
            });
        </script>
    </body>
</html>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()%>