<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PopupEditTrigger.aspx.vb" Inherits="Dynamicweb.Admin.PopupEditTrigger" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources runat="server" IncludeUIStylesheet="true"></dw:ControlResources>
    <%= TriggerProviderAddin.Jscripts%>
</head>
<body>
    <form id="form1" runat="server">
        <div class="omc-control-panel-grid-container" style="width: 485px; margin-left:10px;">
            <asp:Panel runat="server" ID="Triggers">
			    <br />
                <de:AddInSelector 
				    runat="server" 
				    ID="TriggerProviderAddin" 
                    useNewUI="true" 
                    AddInShowNothingSelected="false" 
				    AddInGroupName="Select trigger type"
                    AddInParameterName="Trigger settings" 
				    AddInTypeName="Dynamicweb.Content.Workflow.Automation.Trigger"
				    />
            </asp:Panel>

            <asp:Literal runat="server" ID="LoadParametersScript"></asp:Literal>
        </div>
        <br />
        <div class="footer" style="text-align: right; margin-right: 15px;">
            <asp:Button Text="OK" ID="btnOk" runat="server" Width="60px" />
        </div>
    </form>
</body>
</html>
