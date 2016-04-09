<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="HostHeaders_cpl.aspx.vb" Inherits="Dynamicweb.Admin.HostHeaders_cpl" %>
<%@ Register TagPrefix="management" TagName="ImpersonationDialog" Src="/Admin/Content/Management/ImpersonationDialog/ImpersonationDialog.ascx" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
        <title></title>
        <dw:ControlResources ID="ctrlResources" IncludePrototype="true" runat="server" />
        
        <style type="text/css">
            .removeCmd
            {
            	margin-left: 2px;
            	cursor: pointer;
            }
            
            .removeCmdDisabled
            {
            	margin-left: 2px;
            	cursor: default;
            }
            .textmiddle {vertical-align:middle;}
        </style>
        
        <script language="javascript" type="text/javascript">
            if (<% = ToLogOff %>){
                setTimeout('top.location = "/Admin/Access/Access_Logoff.aspx";', 500);
            }
            
            function help() {
		        <%=Dynamicweb.Gui.help("","administration.managementcenter.hostheaders") %>
            }
            
            function resetChecking(func) {
                $('CheckBeforeUnload').value = '';
                
                if (func) {
                    func();
                }   
            }
            
            function request(params, onSuccess, onFailure) {
                if (!params) {
                    return;
                }
                
                params.IsAjax = true;
                if (typeof(params.Async) === 'undefined') {
                    params.Async = true;
                }

                new Ajax.Request('/Admin/Content/Management/Pages/HostHeaders_cpl.aspx', {
                    method: 'get',
                    asynchronous: params.Async,
                    parameters: params,
                    onSuccess: function(response) {
                        if (onSuccess) {
                            onSuccess(response.responseText);
                        }
                    },
                    onFailure: function() {
                        if (onFailure) {
                            onFailure();
                        }
                    }
                });
            }
	        
            var hosts = new Array();
            <%= InitHostsJS() %>

            function getAlternativeHost(hostName){
                var result = '';

                if (hostName && hostName!='') {
                    hostName = hostName.replace(/^\s+|\s+$/g, '').toLowerCase();
                    var isFound = false, isHaveW3Preffix = (hostName.indexOf('www.') != -1);
                    var findPattern = isHaveW3Preffix ? hostName.replace('www.', '') : ('www.'+hostName);
                    
                    if  (hosts.length > 0) {
                        for (var i=0;i<hosts.length; i++) {
                            isFound =  (hosts[i].replace(/^\s+|\s+$/g, '').indexOf(findPattern) == 0);
                            if (isFound) break;
                        }
                    }

                    if (!isFound) result = findPattern;
                }

                return result;
            }

	        function openEditDialog(dialogID, host, address, port) {
	            $$('input.addHeaderHost')[0].value = host;
	            $$('input.addHeaderPort')[0].value = port;
	            $($$('select.addHeaderAddress')[0]).setValue(address);
	            
	            setEditingTarget(host, address, port);
	            
	            dialog.show(dialogID);
	        }
	        
	        function setEditingTarget(host, address, port) {
	            document.getElementById('OriginalHost').value = host;
	            document.getElementById('OriginalAddress').value = address;
	            document.getElementById('OriginalPort').value = port;
	        }
	        
	        function showWait(){
				var o = new overlay('wait');
				o.show();
	        }
	        
	        function isFormValid() {
                var result;
                var elHost = document.getElementById('txHostName');

                elHost.value = elHost.value.length > 0 ? elHost.value.replace(/^\s+|\s+$/g, '') : '';
                result = (elHost.value.length > 0);
                
                if (!result) {
                    alert('<%=  Dynamicweb.Backend.Translate.Translate("Please input host header name!") %>');
                    elHost.focus();
                }
                
                if (result) {
                    var elPort = document.getElementById('txPort');
                    result = (elPort.value.length > 0);

                    if (!result) {
                        alert('<%=  Dynamicweb.Backend.Translate.Translate("Please input port!") %>');
                        elPort.focus();
                    }
                }

                return result;
            }

            function onDlgOkAction(){
                if (isFormValid()) {
                    var tx = document.getElementById('txHostName');
                    var altHost = getAlternativeHost(tx.value);
                    document.getElementById('altHostName').value = '';

                    if (altHost!='') {
                        if (tx.value.indexOf('www.') != -1) {
                            var msg = '<%= Dynamicweb.Backend.Translate.Translate("Should we also create the %host% (without WWW) and with the same settings as the one that you typed in?\nClick OK to create both host headers.\nClick Cancel to create only the one that was typed in.")%>'.replace('%host%', altHost);
                            if (confirm(msg))  document.getElementById('altHostName').value = altHost;
                        } else {
                            var msg = '<%= Dynamicweb.Backend.Translate.Translate("Should we also create the %host% (with WWW) and with the same settings as the one that you typed in?\nClick OK to create both host headers.\nClick Cancel to create only the one that was typed in.")%>'.replace('%host%', altHost);
                            if (confirm(msg))  document.getElementById('altHostName').value = altHost;
                        }
                    }

                    if (document.getElementById('OriginalHost').value) {
                        showWait();
                        <%= DlgOkPostBackJs(1)%>;
                    } else {
                        showWait();
                        <%= DlgOkPostBackJs(0)%>;
                    }
               }

                return false;
            }

            function onCmdImpersonate(){
                <%= dlgImpersonation.ClientInstanceName %>.show();
                return false;
            }

            function onCmdCancel(){
                showWait();
                <%= Page.ClientScript.GetPostBackEventReference(cmdCancel, "CancelChanges") %>;
            }

            function onCmdAdd(){
                if(!Toolbar.buttonIsDisabled('<%= cmdAdd.ID %>'))
                    openEditDialog('<%= dlgAddHeader.ID %>', '', '0', '80');
               return false;
            }

           function onCmdApply(){
                if(!Toolbar.buttonIsDisabled('<%= cmdApply.ID %>')) {
                    if (confirm('<%= Dynamicweb.Backend.Translate.Translate("After applying you will be logged out! Apply changes?")%>'))
                        <%= Page.ClientScript.GetPostBackEventReference(cmdApply, "ApplyChanges") %>;
                }

                return false;
           }

            document.observe("dom:loaded", function() {
                var check = $('CheckBeforeUnload');
                var handle = $('HandleOnUnload');

                document.on('click', 'button.dialog-button-ok, img.removeCmd', resetChecking);
                
                window.onbeforeunload = function(e) {
                    if (check.value === 'true') {
                        handle.value = 'true';
                       
                        var message = '<%= Dynamicweb.Backend.Translate.JsTranslate("Do you want to leave and discard your changes? (all host header changed will be lost and not applied to the server!)")%>';
                       (e || window.event).returnValue = message; //Gecko + IE

                       //Webkit, Safari, Chrome etc.
                       return message; 
                   }
               };

                window.onunload = function() {
                    if (handle.value === 'true') {
                        request({ Action: 'CancelChanges', Async: false });
                    }
                };
           });

        </script>
    </head>
    <body>
        <form id="MainForm" runat="server">
            <dw:Toolbar ID="ToolbarButtons" runat="server" ShowEnd="false">
	            <dw:ToolbarButton ID="cmdAdd" runat="server" Disabled="true" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/earth_add.png" Text="Add" OnClientClick="resetChecking(onCmdAdd);" />
                <dw:ToolbarButton ID="cmdApply" runat="server" Disabled="true" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/SaveAndApply.png" Text="Save and apply" OnClientClick="resetChecking(onCmdApply);" />
	            <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="None" Image="Cancel" Text="Cancel" OnClientClick="resetChecking(onCmdCancel);" />
	            <dw:ToolbarButton ID="cmdImpersonate" runat="server" Divide="Before" ImagePath="/Admin/Images/Ribbon/Icons/Small/user_preferences.png" Text="Impersonation" OnClientClick="onCmdImpersonate();" />              
	            <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="help();" />
	        </dw:Toolbar>
	        <h2 class="subtitle">
	            <dw:TranslateLabel ID="lbSetup" Text="Host headers" runat="server" />
	        </h2>
	        
	        <asp:Panel ID="pNoAccess" runat="server">
	            <dw:TranslateLabel ID="lbNoAccess" Text="Du har ikke de nødvendige rettigheder til denne funktion." runat="server" />
	        </asp:Panel>
 
	        <asp:Panel ID="pHasAccess" runat="server">
                <dw:List ID="lstHeaders" ShowPaging="true" NoItemsMessage="No host headers found" ShowTitle="false" runat="server" pagesize="25">
                    <Columns>
                        <dw:ListColumn ID="colHostName" Name="Hostname" Width="300" runat="server" />
                        <dw:ListColumn ID="colIPAddr" Name="IP address" Width="150" runat="server" />
                        <dw:ListColumn ID="colPort" Name="Port" Width="75" runat="server" />
                        <dw:ListColumn ID="colRemove" Name="Remove" Width="75" runat="server" /> 
                        <dw:ListColumn ID="colState" Name="State" Width="300" runat="server" /> 
                    </Columns>
                </dw:List>
                <dw:Infobar ID="infoResult" Visible="false" runat="server" />
	            <management:ImpersonationDialog id="dlgImpersonation" DefaultType="BackendUser" runat="server" />
	        </asp:Panel>
	        
	        <dw:Dialog ID="dlgAddHeader" FinalizeActions="false" Title="Edit host header" ShowOkButton="true" Width="500" ShowCancelButton="true" runat="server">
	            <table border="0" cellspacing="2" cellpadding="2" width="500">
		            <tr>
			            <td width="150" valign="top">
			                <dw:TranslateLabel ID="lbHostname" Text="Hostname" runat="server" />
			            </td>
			            <td width="250" valign="top">
                            <asp:HiddenField ID="altHostName" runat="server" Value="" /> 
			                <asp:TextBox Width="250" CssClass="addHeaderHost std" ID="txHostName" runat="server" /><br />
			                <small>
			                    <dw:TranslateLabel ID="lbExample" Text="Eksempel" runat="server" />: www.dynamicweb-cms.com
                            </small>
			            </td>
		            </tr>
		            <tr>
			            <td valign="top">
			                <dw:TranslateLabel ID="lbIPAddress" Text="IP_address" runat="server" />
			            </td>
			            <td valign="top">
				            <asp:DropDownList ID="lstAddresses" CssClass="addHeaderAddress std" Width="250" runat="server" />
			            </td>
		            </tr>
		            <tr>
			            <td valign="top">
			                <dw:TranslateLabel ID="lbPort" Text="Port" runat="server" />
			            </td>
			            <td valign="top">
			                <asp:TextBox ID="txPort" CssClass="addHeaderPort std" Width="250" runat="server" Text="80" />
			            </td>
		            </tr>
		        </table>
		        <br />
	        </dw:Dialog>
	        
	        
	        
	        <input type="hidden" id="OriginalHost" name="OriginalHost" />
	        <input type="hidden" id="OriginalAddress" name="OriginalAddress" />
	        <input type="hidden" id="OriginalPort" name="OriginalPort" />
            <input type="hidden" id="HandleOnUnload" name="HandleOnUnload" />
            <input type="hidden" id="CheckBeforeUnload" name="CheckBeforeUnload" runat="server"/>
        </form>
        <dw:Overlay ID="wait" runat="server" Message="" ShowWaitAnimation="True">
		<dw:TranslateLabel ID="TranslateLabel9" runat="server" Text="Opdatering" />...
	</dw:Overlay>
    </body>
    
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
