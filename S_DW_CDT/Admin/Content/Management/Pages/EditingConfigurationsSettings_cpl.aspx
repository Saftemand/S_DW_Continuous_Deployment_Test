<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EditingConfigurationsSettings_cpl.aspx.vb" Inherits="Dynamicweb.Admin.EditingConfigurationsSettings" %>

<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title><%=Translate.JsTranslate("Editor configurations")%></title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" runat="server" />
    
    <script type="text/javascript">
        function confirmDeleteEditorConfiguration(configurationID, warningMsg) {            
            if (confirm(warningMsg))
                location = 'EditingConfigurationsSettings_cpl.aspx?deleteConfig=' + configurationID;            
        }

        function editEditorConfiguration(configurationID) {
            location = '/Admin/Access/EditorConfiguration/Configuration_Edit.aspx?ConfigurationID=' + configurationID + '&ReturnURL=/Admin/Content/Management/Pages/EditingConfigurationsSettings_cpl.aspx';
        }

        function newEditorConfiguration() {
            location = '/Admin/Access/EditorConfiguration/Configuration_Edit.aspx?ReturnURL=' + encodeURIComponent('/Admin/Content/Management/Pages/EditingConfigurationsSettings_cpl.aspx');
        }

        function help() {
		    <%=Dynamicweb.Gui.Help("", "administration.managementcenter.editing.editorconfiguration")%>
		}
    </script>
</head>

<body>
    <form id="MainForm" runat="server">    
	<dw:Toolbar ID="ToolbarButtons" runat="server" ShowEnd="false">        
        <dw:ToolbarButton ID="cmdNewConfiguration" runat="server" Divide="None" ImagePath="/Admin/Images/Icons/Add_vsmall.gif" Text="New editor configuration" OnClientClick="newEditorConfiguration(); return false;" />
        <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="None" Image="Help" Text="Help" OnClientClick="help();" />        
    </dw:Toolbar>
    <h2 class="subtitle">
        <dw:TranslateLabel ID="lbSetup" Text="Editor configurations" runat="server" />
    </h2>
        <asp:Panel ID="MainContent" runat="server">		    
            <dw:List ID="configurationsList" runat="server" Title="" ShowTitle="false" StretchContent="true"  PageSize="25" NoItemsMessage="Der er endnu ikke oprettet nogle konfigurationer">
                <Filters></Filters>
                <Columns>
			        <dw:ListColumn ID="colName" runat="server" Name="Name" EnableSorting="true" Width="300" />			                    
			        <dw:ListColumn ID="colIsDefault" runat="server" Name="Default" EnableSorting="true" />
                    <dw:ListColumn ID="colDelete" runat="server" Name="Delete" EnableSorting="true" />
                </Columns>
            </dw:List>            
        </asp:Panel>
        <asp:Panel ID="pNoAccess" runat="server">
            <table border="0" cellpadding="6" cellspacing="6">
				<tr>
					<td>
                        <dw:TranslateLabel ID="lbNoAccess" Text="Du har ikke de nødvendige rettigheder til denne funktion." runat="server" />
                        <script type="text/javascript">
                            Toolbar.setButtonIsDisabled('cmdSave', true);
                            Toolbar.setButtonIsDisabled('cmdSaveAndClose', true);
                        </script>
                    </td>
                </tr>
            </table>
        </asp:Panel>
	</form>	
</body>
</html>

<%  Translate.GetEditOnlineScript()%>
