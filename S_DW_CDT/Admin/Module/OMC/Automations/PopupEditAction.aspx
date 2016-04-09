<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PopupEditAction.aspx.vb" Inherits="Dynamicweb.Admin.PopupEditAction" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources runat="server" IncludeUIStylesheet="true"></dw:ControlResources>
    <%=ActionAddin.Jscripts%>
</head>
<body>
    <form id="Form1" runat="server">
        <div class="omc-control-panel-grid-container" style="width: 485px; margin-left:10px;">
            <dw:GroupBox runat="server" ID="grpDelay" Title="Delay">
                <table>
                    <tr>
                        <td style="width: 170px;">Days</td>
                        <td><asp:TextBox runat="server" ID="txtDays" CssClass="std"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td style="width: 170px;">Hours</td>
                        <td><asp:TextBox runat="server" ID="txtHours" CssClass="std"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td style="width: 170px;">Minutes</td>
                        <td><asp:TextBox runat="server" ID="txtMinutes" CssClass="std"></asp:TextBox></td>
                    </tr>
                </table>
            </dw:GroupBox>

            <asp:Panel runat="server" ID="Actions" Width="470">
			    <br />
                <de:AddInSelector 
				    runat="server" 
				    ID="ActionAddin" 
                    useNewUI="true" 
                    AddInShowNothingSelected="false" 
				    AddInGroupName="Select action"
                    AddInParameterName="Action settings" 
				    AddInTypeName="Dynamicweb.Content.Workflow.Campaign.Action"
				    />
            </asp:Panel>

            <asp:Literal runat="server" ID="LoadParametersScript"></asp:Literal>
        </div>
        <br />
        <div class="footer" style="text-align: right; margin-right: 15px;">
            <asp:Button Text="OK" ID="btnOk" runat="server" Width="60px" />
        </div>

        <input type="hidden" name="ActionIndex" value="<%=_actionIndex%>" />
    </form>
</body>
</html>
