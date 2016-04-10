<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ChannelEdit.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Management.ChannelEdit" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title><dw:TranslateLabel ID="lbTitle" Text="Edit channel" runat="server" /></title>
        <dw:ControlResources IncludePrototype="true" IncludeUIStylesheet="true" runat="server">
            <Items>
                <dw:GenericResource Url="/Admin/Module/OMC/js/ChannelEdit.js" />
                <dw:GenericResource Url="/Admin/Module/Common/Validation.js" />
            </Items>
        </dw:ControlResources>
        
        <asp:Literal ID="addInSelectorScripts" runat="server" />

        <script type="text/javascript">
            Dynamicweb.SMP.ChannelEdit.terminology = {
                ChannelNameRequired: '<%=Dynamicweb.Backend.Translate.JsTranslate("Please specify the name of the channel.")%>',
                ProviderRequired: '<%=Dynamicweb.Backend.Translate.JsTranslate("Please specify the social media provider.")%>',
                DeleteConfirm: '<%=Dynamicweb.Backend.Translate.JsTranslate("Are you sure you want to delete this channel?")%>'
            };
            
            Dynamicweb.SMP.ChannelEdit.help = function () {
                <%=Dynamicweb.Gui.Help("socialmedia", "modules.omc.smp.channeledit")%>
            };

            document.observe("dom:loaded", function () {
                $('div_Dynamicweb.Content.Social.Adapter_parameters').observe('keydown', function (event) {
                    if (event.target.tagName === 'INPUT') {
                        $$('.notification').each(Element.hide);
                    }
                });

                $('OuterContainer').observe('keydown', function (event) {
                    Dynamicweb.SMP.ChannelEdit.showLeaveConfirmation();
                });

                $('ckChannelActive').observe('click', function (event) {
                    Dynamicweb.SMP.ChannelEdit.showLeaveConfirmation();
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
        <form id="ChannelForm" runat="server">
            <dw:Toolbar ID="Toolbar" runat="server" ShowEnd="false" ShowStart="false">
                <dw:ToolbarButton ID="cmdSave" runat="server" Disabled="false" Divide="None" Image="Save" OnClientClick="Dynamicweb.SMP.ChannelEdit.save();" Text="Save" />
                <dw:ToolbarButton ID="cmdSaveAndClose" runat="server" Disabled="false" Divide="None" Image="SaveAndClose" OnClientClick="Dynamicweb.SMP.ChannelEdit.saveAndClose();" Text="Save and close" />
                <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="None" Image="Cancel" Text="Cancel"  OnClientClick="Dynamicweb.SMP.ChannelEdit.cancel();" />
                <dw:ToolbarButton ID="cmdDelete" runat="server" Divide="Before" Image="Delete" Text="Delete"  OnClientClick="Dynamicweb.SMP.ChannelEdit.deleteChannel();" />
                <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="Dynamicweb.SMP.ChannelEdit.help();" />
            </dw:Toolbar>
        
            <input type="hidden" id="Cmd" value="" runat="server" />

            <h2 class="subtitle">
                <dw:TranslateLabel ID="lbSetup" Text="Edit channel" runat="server" />
            </h2>

            <dw:StretchedContainer ID="OuterContainer" Scroll="Auto" Stretch="Fill" Anchor="document" runat="server">
                <div style="margin-left: 5px; margin-top: 5px">
                    <div class="notification-box-holder">
                        <div class="notification notification-success">
                            <dw:Infobar ID="infoSuccess" Type="Information" Message="Authorization successful" runat="server" />
                        </div>
                        <div class="notification notification-error">
                            <dw:Infobar ID="infoFailure" Type="Error" Message="The channel is not authorized, please authorize again or change the parameters" runat="server" />
                        </div>
                    </div>
                    
                    <dw:GroupBox ID="gbGeneral" Title="General" runat="server">
                        <table class="tabTable">
                            <tr>
                                <td style="width: 170px;">
                                    <dw:TranslateLabel ID="lbChannelname" Text="Name" runat="server" />
                                </td>
                                <td>
                                    <asp:TextBox ID="txChannelName" CssClass="std" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td>
                                    <asp:CheckBox ID="ckChannelActive" Checked="true" runat="server"  ClientIDMode="Static"/>
                                    <label for="ckChannelActive"><dw:TranslateLabel ID="lbChannelActive" Text="Active" runat="server" /></label>
                                </td>
                            </tr>
                        </table>
                    </dw:GroupBox>
                
                    <de:AddInSelector id="addInSelector" runat="server" AddInGroupName="Providers" UseLabelAsName="False" useNewUI="True" AddInBreakFieldsets="False"
                        AddInShowNothingSelected="true" NoParametersMessage="No provider selected." AddInParameterMargin="5px" AddInTypeName="Dynamicweb.Content.Social.Adapter" />
                </div>
            </dw:StretchedContainer>

            <dw:Overlay ID="WaitSpinner" runat="server"></dw:Overlay>
            <asp:Literal ID="addInSelectorLoadScript" runat="server"></asp:Literal>
        </form>

        <% Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
    </body>
</html>
