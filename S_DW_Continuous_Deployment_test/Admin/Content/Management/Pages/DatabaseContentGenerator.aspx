<%@ Page Title="" Language="vb" AutoEventWireup="false" CodeBehind="DatabaseContentGenerator.aspx.vb" Inherits="Dynamicweb.Admin.DatabaseContentGenerator" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <dw:ControlResources runat="server" IncludeUIStylesheet="true" IncludePrototype="true"></dw:ControlResources>

    <%=ContentAddin.Jscripts%>
</head>
<body>
    <form id="form1" runat="server">
        <dw:Toolbar runat="server" ID="Toolbar1" ShowEnd="false">
            <dw:ToolbarButton runat="server" ID="btnClose" Image="Cancel" Text="Close" OnClientClick="location.href = '/Admin/Content/Management/Start.aspx';" />
        </dw:Toolbar>
        <h2 class="subtitle">
	        <dw:TranslateLabel ID="TranslateLabel1" Text="Data generation" runat="server" />
        </h2>

        <div style="margin-left: 5px; width: 585px;">
            <asp:Panel runat="server" ID="ContentProviders">
		        <br />
                <de:AddInSelector 
			        runat="server" 
			        ID="ContentAddin" 
                    useNewUI="true" 
                    AddInShowNothingSelected="true" 
			        AddInGroupName="Select content provider"
                    AddInParameterName="Settings" 
			        AddInTypeName="Dynamicweb.Content.DatabaseContentProvider"
			        />
            </asp:Panel>

            <asp:Literal runat="server" ID="LoadParametersScript"></asp:Literal>
        </div>

        <table style="width: 585px; margin-left: 5px;">
            <tr>
                <td><asp:Button runat="server" ID="btnCount" CssClass="std" Text="Get count" style="width: 150px; float: right;" /></td>
            </tr>
            <tr>
                <td><asp:Button runat="server" ID="btnOk" CssClass="std" Text="Generate content" style="width: 150px; float: right;" /></td>
            </tr>
            <tr>
                <td><asp:Label runat="server" ID="lblCount" style="width: 250px; float: right; text-align: right;" /></td>
            </tr>
            <tr>
                <td><asp:Label runat="server" ID="lblResult" style="float: right; text-align: right;" /></td>
            </tr>
        </table>
    </form>
</body>
</html>
