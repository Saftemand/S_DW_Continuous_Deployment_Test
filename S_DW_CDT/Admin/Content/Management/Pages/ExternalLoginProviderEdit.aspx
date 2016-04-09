<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ExternalLoginProviderEdit.aspx.vb" Inherits="Dynamicweb.Admin.ExternalLoginProviderEdit" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title><dw:TranslateLabel ID="lbTitle" Text="Edit external login provider" runat="server" /></title>
        <dw:ControlResources IncludePrototype="true" IncludeUIStylesheet="true" runat="server">
            <Items>
                <dw:GenericResource Url="/Admin/Content/Management/Pages/ExternalLoginProviderEdit.js" />
                <dw:GenericResource Url="/Admin/Module/Common/Validation.js" />
            </Items>
        </dw:ControlResources>
        
        <asp:Literal ID="addInSelectorScripts" runat="server" />
        
        <script type="text/javascript" src="/Admin/Link.js"></script>

        <script type="text/javascript">
            Dynamicweb.ExternalLogin.ProviderEdit.terminology = {
                ProviderNameRequired: '<%=Dynamicweb.Backend.Translate.JsTranslate("Please specify the name of the login provider.")%>',
                ProviderRequired: '<%=Dynamicweb.Backend.Translate.JsTranslate("Please specify the external login provider.")%>',
                DeleteConfirm: '<%=Dynamicweb.Backend.Translate.JsTranslate("Are you sure you want to delete this login provider?")%>'
            };

            Dynamicweb.ExternalLogin.ProviderEdit.help = function () {
                <%=Dynamicweb.Gui.Help("externallogin", "modules.omc.smp.channeledit")%>
            };

            document.observe("dom:loaded", function () {
                $('div_Dynamicweb.Modules.UserManagement.ExternalAuthentication.ExternalLoginProvider_parameters').observe('keydown', function (event) {
                    if (event.target.tagName === 'INPUT') {
                        $$('.notification').each(Element.hide);
                    }
                });

                $('OuterContainer').observe('keydown', function (event) {
                    Dynamicweb.ExternalLogin.ProviderEdit.showLeaveConfirmation();
                });

                $('cbProviderActive').observe('click', function (event) {
                    Dynamicweb.ExternalLogin.ProviderEdit.showLeaveConfirmation();
                });
            });
        </script>

        <style type="text/css">
            fieldset {
                width: auto !important;
            }

            .notification-box-holder .notification {
                display: none;
            }
        </style>
    </head>

    <body>
        <form id="ProviderForm" runat="server">
            <dw:Toolbar ID="Toolbar" runat="server" ShowEnd="false" ShowStart="false">
                <dw:ToolbarButton ID="cmdSave" runat="server" Disabled="false" Divide="None" Image="Save" OnClientClick="Dynamicweb.ExternalLogin.ProviderEdit.save();" Text="Save" />
                <dw:ToolbarButton ID="cmdSaveAndClose" runat="server" Disabled="false" Divide="None" Image="SaveAndClose" OnClientClick="Dynamicweb.ExternalLogin.ProviderEdit.saveAndClose();" Text="Save and close" />
                <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="None" Image="Cancel" Text="Cancel"  OnClientClick="Dynamicweb.ExternalLogin.ProviderEdit.cancel();" />
                <dw:ToolbarButton ID="cmdDelete" runat="server" Divide="Before" Image="Delete" Text="Delete"  OnClientClick="Dynamicweb.ExternalLogin.ProviderEdit.deleteProvider();" />
                <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="Dynamicweb.ExternalLogin.ProviderEdit.help();" />
            </dw:Toolbar>
        
            <input type="hidden" id="Cmd" value="" runat="server" />

            <h2 class="subtitle">
                <dw:TranslateLabel ID="lbSetup" Text="Edit provider" runat="server" />
            </h2>

            <dw:StretchedContainer ID="OuterContainer" Scroll="Auto" Stretch="Fill" Anchor="document" runat="server">
                <div style="margin-left: 5px; margin-top: 5px">                                        
                    <dw:GroupBox ID="gbGeneral" Title="General" runat="server">
                        <table class="tabTable">
                            <tr>
                                <td style="width: 170px;">
                                    <dw:TranslateLabel ID="lblProviderName" Text="Name" runat="server" />
                                </td>
                                <td>
                                    <asp:TextBox ID="txtProviderName" CssClass="std" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td>
                                    <asp:CheckBox ID="cbProviderActive" Checked="true" runat="server"  ClientIDMode="Static"/>
                                    <label for="cbProviderActive"><dw:TranslateLabel ID="lblProviderActive" Text="Active" runat="server" /></label>
                                </td>
                            </tr>
                        </table>
                    </dw:GroupBox>
                
                    <de:AddInSelector id="addInSelector" runat="server" AddInGroupName="Login Providers" UseLabelAsName="False" useNewUI="True" AddInBreakFieldsets="False"
                        AddInShowNothingSelected="true" NoParametersMessage="No provider selected." AddInParameterMargin="5px" AddInTypeName="Dynamicweb.Modules.UserManagement.ExternalAuthentication.ExternalLoginProvider" />
                </div>
            </dw:StretchedContainer>

            <dw:Overlay ID="WaitSpinner" runat="server"></dw:Overlay>
            <asp:Literal ID="addInSelectorLoadScript" runat="server"></asp:Literal>
        </form>

        <% Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
    </body>
</html>
