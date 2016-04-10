<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ScheduledTasks_cpl.aspx.vb" Inherits="Dynamicweb.Admin.ScheduledTasks_cpl" %>
<%@ Register TagPrefix="management" TagName="ImpersonationDialog" Src="/Admin/Content/Management/ImpersonationDialog/ImpersonationDialog.ascx" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
        <title></title>
        <dw:ControlResources ID="ctrlResources" IncludePrototype="true" runat="server" />
        <link rel="stylesheet" type="text/css" href="/Admin/Module/eCom_Catalog/dw7/css/ToolTip.css" />
        <script type="text/javascript" src="/Admin/FileManager/FileManager_browse2.js"></script>
        <style type="text/css">
            .removeCmd, .activeCmd
            {
            	cursor: pointer;
            }
            
            .removeCmdDisabled, .aciveCmdDisabled
            {
            	cursor: default;
            }
            .schedule_editor
            {
                border: solid 1px #ccc;
                width: 510px;
            }
            .schedule_editor div
            {
                float: left;
            }
            .editor_ctrl
            {
                width: 300px;
            }
            .editor_lbl
            {
                width: 50px;
            }
            .editor_delim
            {
                width: 100%;
                margin: 1px 0 1px 0;
            }
            .repeat
            {
                width: 90px;
            }
            span.repeat input
            {
                position: relative;
                top: 2px;
            }
            
            img.H
            {
	            position: inherit;
            }
            
            div#addInSelectorDiv > span.selector-pane,
            div#addInSelectorDiv > span.params-pane,
            div#erpAddInSelectorDiv > span.selector-pane,
            div#erpAddInSelectorDiv > span.params-pane
            {
                margin: 0 !important;
            }
        </style>
        
        <script language="javascript" type="text/javascript">
            function help() {
		        <%=Dynamicweb.Gui.Help("", "administration.managementcenter.system.scheduledtasks")%>
	        }
	        
	        function openEditDialog(dialogID, id, name, type, target, repeat, from, to) {                
                $('hdIsErpAddInTask').value = '';
                if(id > 0){	            
                    //document.getElementById('MainForm').action = 'ScheduledTasks_cpl.aspx?TaskID=' + id;
                    //document.getElementById('MainForm').submit();
                }else{                    
                    $$('input.addTaskName')[0].value = name;
                    switch (type) {
                        case 3: {
                            //task type = URL
                            $$('input.addTaskUrl')[0].value = target;
                            $('UrlActivation').click();
                            break;
                        }
                        case 4: {
                            //task type = ClassMethod
                            $$('input.addTaskClassMethod')[0].value = target;
                            $('ClassMethodActivation').click();
                            break;
                        }
                        case 6: {
                            //task type = AddIn
                            $('AddInActivation').click();
                            break;
                        }
                        default: {
                            //default
                            $('UrlActivation').click();
                        }
                    }
                    setDate('dtFrom', from);
                    setDate('dtTo', to);
                    $$("#ddRepeat")[0].value = repeat >= 0 ? repeat : 60;
	                $$('#hdTaskId')[0].value = id;                    
                    dialog.show(dialogID);
                }
	        }

	        function openActivationClipboardDialog(activationUrl) {
	            dialog.show("activation_dialog");

	        }
	        
	        function showExistingTaskEditDialog(id, name, type, target, repeat, from, to, isErpAddInTask) {
                $$('input.addTaskName')[0].value = name;
                setDate('dtFrom', from);
                setDate('dtTo', to);
                $$("#ddRepeat")[0].value = repeat >= 0 ? repeat : 60;
	            $$('#hdTaskId')[0].value = id;
	            if (target && target != "") {
	                switch (type) {
	                    case 3: {
	                        //task type = URL
	                        $('UrlActivation').click();
	                        $$('input.addTaskUrl')[0].value = target;
	                        break;
	                    }
	                    case 4: {
	                        //task type = ClassMethod
	                        $('ClassMethodActivation').click();
	                        $$('input.addTaskClassMethod')[0].value = target;
	                        break;
	                    }
	                    case 6: {
	                        //task type = AddIn
	                        break;
	                    }
	                    default: {
	                        //
	                    }
	                }
	            } else {
	                $('AddInActivation').click();
	            }
              
                Page_ClientValidate();
                if(isErpAddInTask){
                    $('addInSelectorDiv').style.display = 'none';
                    $('erpAddInSelectorDiv').style.display = '';
                    $('hdIsErpAddInTask').value = 'true';
                    $('scheduledTaskActivationType').hide();
                }else{
                    $('addInSelectorDiv').style.display = '';
                    $('erpAddInSelectorDiv').style.display = 'none';
                    $('hdIsErpAddInTask').value = '';
                    $('scheduledTaskActivationType').show();
                }
	            dialog.show("dlgAddTask");
	        }

            function setDate(id, sdate) {
                var dt;
                var ar0 = sdate.split(' ');
                if (ar0.length < 2) {
                    dt = new Date();
                }
                else {
                    var ar01 = ar0[0].split('-');
                    var ar02 = ar0[1].split(':');
                    dt = new Date(ar01[0], ar01[1]-1, ar01[2], ar02[0], ar02[1]);
                }

                var year = dt.getFullYear();
                $$("#" + id + "_year")[0].value = dt.getFullYear();
                $$("#" + id + "_month")[0].value = year < 2999 ?  dt.getMonth() + 1 : 1;
                $$("#" + id + "_day")[0].value = year < 2999 ? dt.getDate() : 1;
                $$("#" + id + "_hour")[0].value = year < 2999 ? dt.getHours() : 0;
                $$("#" + id + "_minute")[0].value = year < 2999 ? (dt.getMinutes() - dt.getMinutes() % 5) : 0;
            }

	        function showWait(){
				var o = new overlay('wait');
				o.show();
	        }
	        
            function hideValidators()
            {
                for (var i = 0; i < Page_Validators.length; i++) {
                    $$('#' + Page_Validators[i].id)[0].style.visibility = 'hidden';
                }
            }  
            
            function toggleShow() {        
                if ($('UrlActivation').checked) {
                    $('urlDiv').style.display = 'block';
                    $('addInDiv').style.display = 'none';
                    $('classMethodDiv').style.display = 'none';
                    ValidatorEnable(document.getElementById('<%= valTaskUrl.ClientID %>'), true);
                    ValidatorEnable(document.getElementById('<%= valTaskFormat.ClientID%>'), true);
                    ValidatorEnable(document.getElementById('<%= valTaskClassMethod.ClientID%>'), false);
                } else if ($('AddInActivation').checked) {
                    $('urlDiv').style.display = 'none';
                    $('addInDiv').style.display = 'block';
                    $('classMethodDiv').style.display = 'none';
                    ValidatorEnable(document.getElementById('<%= valTaskUrl.ClientID %>'), false);
                    ValidatorEnable(document.getElementById('<%= valTaskFormat.ClientID%>'), false);
                    ValidatorEnable(document.getElementById('<%= valTaskClassMethod.ClientID%>'), false);
                } else {                            
                    $('urlDiv').style.display = 'none';
                    $('addInDiv').style.display = 'none';
                    $('classMethodDiv').style.display = 'block';
                    ValidatorEnable(document.getElementById('<%= valTaskUrl.ClientID %>'), false);
                    ValidatorEnable(document.getElementById('<%= valTaskFormat.ClientID%>'), false);
                    ValidatorEnable(document.getElementById('<%= valTaskClassMethod.ClientID%>'), true);
                }
            }
                
         </script>
    </head>
    <body>
        <form id="MainForm" runat="server">
            <dw:Toolbar ID="ToolbarButtons" runat="server" ShowEnd="false">
	            <dw:ToolbarButton ID="cmdAdd" runat="server" Disabled="true" Divide="None" Image="Form_Add" Text="Add" />
	            <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="None" Image="Cancel" Text="Cancel" OnClientClick="location='/Admin/Content/Management/Start.aspx';" />
	            <dw:ToolbarButton ID="cmdImpersonate" runat="server" Divide="Before" ImagePath="/Admin/Images/Ribbon/Icons/Small/user_preferences.png" Text="Impersonation" />
	            <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="help();" />
	        </dw:Toolbar>
	        <h2 class="subtitle">
	            <dw:TranslateLabel ID="lbSetup" runat="server" />
	        </h2>
	        
	        <asp:Panel ID="pNoAccess" runat="server">
	            <dw:TranslateLabel ID="lbNoAccess" Text="Du har ikke de nødvendige rettigheder til denne funktion." runat="server" />
	        </asp:Panel>
	        
	        <asp:Panel ID="pHasAccess" runat="server">
                <dw:Infobar ID="infWarning" runat="server" Type="Warning" Visible="False" Message="In the NLB setup, all operations should be performed only on the main server."></dw:Infobar>
                <dw:List ID="lstTasks" ShowPaging="true" NoItemsMessage="No scheduled tasks found" ShowTitle="false" runat="server" pagesize="25">
                    <Columns>
                        <dw:ListColumn ID="colTaskName" Name="Task name" Width="200" runat="server" />
                        <dw:ListColumn ID="colSchedule" Name="Schedule" Width="200" runat="server" />
                        <dw:ListColumn ID="colLastRun" Name="Last run" Width="120" runat="server" />
                        <dw:ListColumn ID="colNextRun" Name="Next run" Width="120" runat="server" />
                        <dw:ListColumn ID="colActive" Name="Active" Width="50" runat="server" ItemAlign="Center" /> 
                        <dw:ListColumn ID="colRemove" Name="Remove" Width="50" runat="server" ItemAlign="Center" /> 
                        <dw:ListColumn ID="colRunNow" Name="Run now" Width="50" runat="server" ItemAlign="Center" /> 
                    </Columns>
                </dw:List>
                <dw:Infobar ID="infoResult" Visible="false" runat="server" />
	            <management:ImpersonationDialog id="dlgImpersonation" runat="server" />
                <dw:ContextMenu runat="server" ID="lstTasksContextMenu">                                    
                    <dw:ContextMenuButton runat="server" ID="addInLogButton" Text="Log" Image="Information">
                    </dw:ContextMenuButton>                    
                </dw:ContextMenu>
                <dw:PopUpWindow ID="historyLogPopup" AutoReload="true" Width="800" Height="560" ShowCancelButton="false" ShowOkButton="false" ShowClose="True" Title="Scheduled add-in task log" runat="server" IsModal="False" AutoCenterProgress="True" UseTabularLayout="True" HidePadding="True" />
	        </asp:Panel>
	        
	        <dw:Dialog ID="dlgAddTask" FinalizeActions="false" Title="Edit scheduled task" ShowOkButton="true" Width="600" ShowCancelButton="true" runat="server">
	            <table border="0" cellspacing="2" cellpadding="2" width="500">
		            <tr>
			            <td width="170px" valign="top">
			                <dw:TranslateLabel ID="lbTaskname" Text="Task name" runat="server" />
			            </td>
			            <td width="300px" valign="top">
			                <asp:TextBox Width="250" CssClass="addTaskName std" ID="txTaskName" runat="server" />
                            <br />
			            </td>
			            <td valign="top">
			                &nbsp;<asp:RequiredFieldValidator runat="server" ID="valTaskName" ControlToValidate="txTaskName" ErrorMessage="*" Display="Dynamic" />
			            </td>
                    </tr>                    		            
                    <tr>
			            <td valign="top">
			                <dw:TranslateLabel Text="Begin" runat="server" />
			            </td>
			            <td width="500" valign="top" colspan="2">
			                <dw:DateSelector runat="server" ID="dtFrom" AllowNeverExpire="false" />
			            </td>
                    </tr>
                    <tr>
			            <td valign="top">
			                <dw:TranslateLabel Text="End" runat="server" />
			            </td>
			            <td width="500" valign="top" colspan="2">
			                <dw:DateSelector runat="server" ID="dtTo" />
			            </td>
                    </tr>
                    <tr>
			            <td valign="top">
			                <dw:TranslateLabel Text="Repeat every" runat="server" />
			            </td>
			            <td width="500" valign="top" colspan="2">
			                <asp:DropDownList runat="server" ID="ddRepeat" CssClass="std repeat"/>
			            </td>
                    </tr>
                    <tr>
                        <td width="100" valign="top">
                            <dw:TranslateLabel ID="activationurl_lbl" Text="Activation URL" runat="server" />
                        </td>
                        <td>
                            <asp:TextBox ID="activationUrl_txt" ReadOnly="true" CssClass="addTaskName std" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                     <tr id="scheduledTaskActivationType">
                        <td width="100" valign="top">
			                Activation
			            </td>
			            <td width="300" valign="top">
			                <input type="radio" runat="server" name="Activation" id="UrlActivation" value="UrlActivation" onclick="javascript: toggleShow();" checked="true" />
                            <label for="UrlActivation"><dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Url" /></label>
			                <input type="radio" runat="server" name="Activation" id="ClassMethodActivation" value="ClassMethodActivation" onclick="javascript: toggleShow();"/>
                            <label for="ClassMethodActivation"><dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Method" /></label>
                            <input type="radio" runat="server" name="Activation" id="AddInActivation" value="AddInActivation" onclick="javascript: toggleShow();"/>
                            <label for="AddInActivation"><dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Add-in" /></label>
                            <br />
                            <div id="urlDiv"><asp:TextBox Width="250" CssClass="addTaskUrl std" ID="txTaskUrl" runat="server" /></div>
                            <div id="classMethodDiv"><asp:TextBox Width="250" CssClass="addTaskClassMethod std" ID="txTaskClassMethod" runat="server" /></div>
			            </td>                        
                        <td valign="top">
			                &nbsp;<asp:RequiredFieldValidator runat="server" ID="valTaskUrl" ControlToValidate="txTaskUrl" ErrorMessage="*" Display="Dynamic" />
                            <asp:RequiredFieldValidator runat="server" ID="valTaskClassMethod" ControlToValidate="txTaskClassMethod" ErrorMessage="*" Display="Dynamic" />
                            <asp:RegularExpressionValidator runat="server" ID="valTaskFormat" ControlToValidate="txTaskUrl" ErrorMessage="*" ValidationExpression="((https?|ftp|gopher|telnet|file|notes|ms-help):((//)|(\\\\))+[\w\d:#@%/;$()~_?\+-=\\\.&]*)" />
			            </td>
                    </tr>                    
		        </table>
                <div id="addInDiv" style="display:none;">                        
                    <div id="addInSelectorDiv">
                        <asp:Literal ID="addInSelectorScripts" runat="server"></asp:Literal>
                        <de:AddInSelector ID="addInSelector" runat="server" AddInShowParameters="true" UseLabelAsName="True" AddInShowNothingSelected="false"
                            AddInTypeName="Dynamicweb.Extensibility.ScheduledTaskAddins.BaseScheduledTaskAddIn" AddInShowFieldset="false" useNewUI="True"
                            AddInIgnoreTypeNames="Dynamicweb.Data.Integration.Interfaces.IERPIntegration,Dynamicweb.eCommerce.CalculatedFields.CalculatedFieldsScheduledTaskAddIn" />
                        <asp:Literal ID="addInSelectorLoadScript" runat="server"></asp:Literal>                        
                    </div>
                    <div id="erpAddInSelectorDiv" style="display:none;">                        
                        <asp:Literal ID="erpAddInSelectorScripts" runat="server"></asp:Literal>
                        <de:AddInSelector ID="erpAddInSelector" runat="server" AddInShowParameters="true" UseLabelAsName="True" AddInShowNothingSelected="false"
                            AddInTypeName="Dynamicweb.Data.Integration.Interfaces.IERPIntegration"
                            AddInShowFieldset="false" useNewUI="True" TakeAddInSelectedTypeFromPost="false" />                        
                        <asp:Literal ID="erpAddInSelectorLoadScript" runat="server"></asp:Literal> 
                    </div>
                </div>
		        <br />
                <asp:HiddenField runat="server" ID="hdTaskId" />
                <asp:HiddenField runat="server" ID="hdIsErpAddInTask" />
	        </dw:Dialog>
        </form>
        <dw:Overlay ID="wait" runat="server" Message="Please wait" ShowWaitAnimation="True">		    
	    </dw:Overlay>
    </body>
    
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
