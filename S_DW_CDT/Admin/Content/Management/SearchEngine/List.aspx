<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="List.aspx.vb" Inherits="Dynamicweb.Admin.Index_List" %>
<%@ Register TagPrefix="dw" Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title><dw:TranslateLabel ID="lbTitle" Text="Search engine index" runat="server" /></title>
        
        <dw:ControlResources ID="ctrlResources" CombineOutput="true" runat="server">
            <Items>
                <dw:GenericResource Url="/Admin/Content/Management/SearchEngine/List.css" />
            </Items>
        </dw:ControlResources>

        <script type="text/javascript">
            var SearchEngineIndex = new Object();

            SearchEngineIndex.help = function () {
                <%=Dynamicweb.Gui.help("", "modules.searchengine.list") %>
            }

            SearchEngineIndex.setIndexState = function(index, cssClass, isActive) {
                var r = null;
                var c = null;
                var rows = $$('div.list tr.listRow');

                if(rows && rows.length > 0) {
                    for(var i = 0; i < rows.length; i++) {
                        r = $(rows[i]);

                        if(r.readAttribute('itemid') == index) {
                            if(isActive) {
                                r.removeClassName('dis');
                            } else {
                                r.addClassName('dis');
                            }

                            c = r.select('div.indexer-master');
                            if(c != null && c.length > 0) {
                                c = $(c[0]);
                                c.removeClassName('indexer-new');
                                c.removeClassName('indexer-normal');
                                c.removeClassName('indexer-locked');

                                c.addClassName(cssClass);
                            }

                            break;
                        }
                    }
                }
            }

            SearchEngineIndex.showLogsMenu = function(e) {
                ContextMenu.show(e, 'cmLogs', '', '', 'BottomLeft', document.getElementById('cmdViewLogs'));
            }

            SearchEngineIndex.setLogsMenuActive = function(isActive) {
                Toolbar.setButtonIsActive('cmdViewLogs', isActive);
            }

            SearchEngineIndex.showManageDialog = function(path, dialogInstance) {
                if(!dialogInstance && typeof(managePopUp_wnd) != 'undefined') {
                    dialogInstance = managePopUp_wnd;
                }

                if(dialogInstance) {
                    dialogInstance.hide();
                    dialogInstance.get_okButton().hide();
                    dialogInstance.get_cancelButton().show();
                    dialogInstance.set_height(475);

                    dialogInstance.set_title(document.getElementById('spPropertiesTitle').innerHTML);
                    dialogInstance.set_contentUrl('/Admin/Content/Management/SearchEngine/Manage.aspx?Path=' + encodeURIComponent(path));
                    dialogInstance.show();
                }
            }

            SearchEngineIndex.viewLogs = function(provider, dialogInstance) {
                if(!dialogInstance && typeof(managePopUp_wnd) != 'undefined') {
                    dialogInstance = managePopUp_wnd;
                }

                if(dialogInstance) {
                    dialogInstance.hide();
                    dialogInstance.get_okButton().hide();
                    dialogInstance.get_cancelButton().show();
                    dialogInstance.set_height(475);

                    dialogInstance.set_title(document.getElementById('spLogsTitle').innerHTML);
                    dialogInstance.set_contentUrl('/Admin/Content/Management/SearchEngine/LogView.aspx?Provider=' + encodeURIComponent(provider));
                    dialogInstance.show();
                }
            }

            SearchEngineIndex.showScheduledUpdatesDialog = function(path, dialogInstance) {
                if(!dialogInstance && typeof(managePopUp_wnd) != 'undefined') {
                    dialogInstance = managePopUp_wnd;
                }

                if(dialogInstance) {
                    dialogInstance.hide();
                    dialogInstance.get_okButton().disabled = false;
                    dialogInstance.get_okButton().show();
                    dialogInstance.get_cancelButton().show();
                    dialogInstance.set_height(475);

                    dialogInstance.set_title(document.getElementById('spScheduledUpdatesTitle').innerHTML + ' - ' + path);
                    dialogInstance.set_contentUrl('/Admin/Content/Management/SearchEngine/ScheduledUpdatesEdit.aspx?Path=' + encodeURIComponent(path));
                    dialogInstance.show();
                }
            }

            SearchEngineIndex.showEmailSettings = function () {
                if (managePopUp_wnd) {
                    managePopUp_wnd.hide();
                    managePopUp_wnd.get_okButton().hide();
                    managePopUp_wnd.get_cancelButton().hide();
                    managePopUp_wnd.set_height(330);

                    managePopUp_wnd.set_title(document.getElementById('spEmailSettings').innerHTML);
                    managePopUp_wnd.set_contentUrl('/Admin/Content/Management/SearchEngine/AlertEmailSettings.aspx');
                    managePopUp_wnd.show();
                }
            }

            SearchEngineIndex.showAdvancedSettings = function () {
                if (managePopUp_wnd) {
                    managePopUp_wnd.hide();
                    managePopUp_wnd.get_okButton().hide();
                    managePopUp_wnd.get_cancelButton().hide();
                    managePopUp_wnd.set_height(286);

                    managePopUp_wnd.set_title('<%= Dynamicweb.Backend.Translate.JsTranslate("Advanced settings")%>');
                    managePopUp_wnd.set_contentUrl('/Admin/Content/Management/SearchEngine/AdvancedSettings.aspx');
                    managePopUp_wnd.show();
                }
            }
        </script>
    </head>
    <body>
        <form id="MainForm" runat="server">
            <dw:Toolbar ID="ToolbarButtons" ShowStart="false" ShowEnd="false" runat="server">
                <dw:ToolbarButton ID="cmdViewLogs" runat="server" Divide="None" ImagePath="/Admin/Images/Icons/Module_eCom_Search_small.gif" Text="Logs" ShowOptions="true" ShowOptionsSeparator="false" Visible="false" />
                <dw:ToolbarButton ID="cmdShowEmailSettings" runat="server" Divide="Before" ImagePath="/Admin/Images/Ribbon/Icons/Small/mail.png" Text="Alert e-mail" OnClientClick="SearchEngineIndex.showEmailSettings();"/>
                <dw:ToolbarButton ID="cmdShowAdvancedSettings" runat="server" Divide="Before" ImagePath="/Admin/Images/Ribbon/Icons/Small/data_find.png" Text="Advanced" OnClientClick="SearchEngineIndex.showAdvancedSettings();"/>
                <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="Before" Image="Cancel" OnClientClick="location.href = '/Admin/Content/Management/Start.aspx';" Text="Cancel" />
	            <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="SearchEngineIndex.help();" />
            </dw:Toolbar>
            <h2 class="subtitle">
	            <dw:TranslateLabel ID="lbSetup" Text="Search engine index list" runat="server" />
	        </h2> 

            <dw:TranslateLabel ID="lbNoAccess" Text="Du har ikke de nødvendige rettigheder til denne funktion." runat="server" />
            <dw:Infobar ID="infWarning" runat="server" Type="Warning" Visible="False" Message="In the NLB setup, all operations should be performed only on the main server."></dw:Infobar>
                
            <dw:List ID="lstIndexes" ShowPaging="true" ShowTitle="false" runat="server" pagesize="25">
                <Columns>
                    <dw:ListColumn ID="colPath" EnableSorting="false" Name="Index" Width="550" runat="server" />
                </Columns>
            </dw:List>

            <dw:PopUpWindow ID="managePopUp" Title="Properties" UseTabularLayout="true" ShowOkButton="True" ShowCancelButton="true" AllowDrag="true" ShowClose="true" 
                AllowContentTransparency="true" TranslateTitle="true" AutoReload="true" runat="server" Width="600" Height="475" />
            
            <dw:ContextMenu ID="cmLogs" OnShow="SearchEngineIndex.setLogsMenuActive(true);" OnHide="SearchEngineIndex.setLogsMenuActive(false);" runat="server"></dw:ContextMenu>

            <dw:ContextMenu ID="cmIndex" runat="server">
                <dw:ContextMenuButton ID="cmdManage" Text="Properties" ImagePath="/Admin/Images/Ribbon/Icons/Small/data_preferences.png" OnClientClick="SearchEngineIndex.showManageDialog(ContextMenu.callingItemID);" runat="server" />
                <dw:ContextMenuButton ID="cmdScheduledUpdate" Divide="Before" Text="Scheduled updates" ImagePath="/Admin/Images/Ribbon/Icons/Small/data_clock.png"  OnClientClick="SearchEngineIndex.showScheduledUpdatesDialog(ContextMenu.callingItemID);" runat="server" />
            </dw:ContextMenu>
        </form>

        <span id="spPropertiesTitle" style="display: none"><dw:TranslateLabel ID="lbPropertiesTitle" Text="Properties" runat="server" /></span>
        <span id="spLogsTitle" style="display: none"><dw:TranslateLabel ID="lbLogsTitle" Text="Logs" runat="server" /></span>
        <span id="spScheduledUpdatesTitle" style="display: none"><dw:TranslateLabel id="lbScheduledUpdatesTitle" Text="Scheduled updates" runat="server" /></span>
        <span id="spEmailSettings" style="display: none"><dw:TranslateLabel id="lbEmailSettings" Text="Email settings" runat="server" /></span>

        <%Translate.GetEditOnlineScript()%>
    </body>
</html>
