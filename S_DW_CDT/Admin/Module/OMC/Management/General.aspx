<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Content/Management/EntryContent.Master" CodeBehind="General.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Management.General" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <%=Dynamicweb.Gui.WriteFolderManagerScript()%>

    <script type="text/javascript">
        var page = SettingsPage.getInstance();

        page.onSave = function () {
            document.frmGlobalSettings.submit();
        }
    </script>

    <!--[if IE]>
    <style type="text/css">
        .omc-account select
        {
            width: 254px;
        }
    </style>
    <![endif]-->
</asp:Content>
<asp:Content  ContentPlaceHolderID="MainContent" runat="server">
    <div id="PageContent" class="omc-control-panel">
        <dw:GroupBox ID="gbEmailNotifications" Title="E-mail notification schemes" runat="server">
            <div class="omc-control-panel-conditional-hide">
                <div class="omc-cpl-hint" style="width: 750px;">
                <dw:TranslateLabel ID="lbEmailProfilesExplained" Text="Here you can configure email notification schemes used to send notifications throughout the system." runat="server" />
            </div>

            <div class="omc-control-panel-grid-container">
                <div class="omc-control-panel-serverform-container">
                    <form runat="server">
                        <dw:EditableGrid ID="gridProfiles" AllowAddingRows="true" AllowDeletingRows="true" NoRowsMessage="No schemes found" AllowSortingRows="false" runat="server">
                            <Columns>
                                <asp:TemplateField HeaderText="Sender" HeaderStyle-Width="195">
                                    <ItemTemplate>
                                        <div style="white-space: nowrap">
                                            <asp:HiddenField ID="hProfileID" Value='<%#Eval("ID")%>' runat="server" />
                                            &nbsp;<asp:TextBox id="txSender" CssClass="std" Width="180" Text='<%#Eval("Sender")%>' runat="server" />
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Subject" HeaderStyle-Width="195">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txSubject" CssClass="std" Width="180" Text='<%#Eval("Subject")%>' runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Template" HeaderStyle-Width="200">
                                    <ItemTemplate>
                                        <dw:FileManager id="fmTemplate" Folder="Templates/OMC/Notifications" FullPath="false" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Delete" HeaderStyle-Width="70">
                                    <ItemTemplate>
                                        <span class="omc-control-panel-grid-delete-offset">
                                            <a id="lnkDelete" class="omc-control-panel-grid-noselect" href="javascript:void(0);" runat="server">
                                                <img src="/Admin/Images/Ribbon/Icons/Small/Delete.png" alt="" border="0" />
                                            </a>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </dw:EditableGrid>

                        <input type="hidden" id="SaveEmailProfiles" name="SaveEmailProfiles" value="False" />
                    </form> 
                </div>
            </div>
        </dw:GroupBox>
    </div>

    <script type="text/javascript">
        <asp:Literal id="litScript" runat="server" />
    </script>

    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>

</asp:Content>