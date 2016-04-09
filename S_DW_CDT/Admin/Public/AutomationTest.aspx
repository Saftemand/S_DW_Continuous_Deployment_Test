<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AutomationTest.aspx.vb" Inherits="Dynamicweb.Admin.AutomationTest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Button runat="server" ID="btnCreateTest" Text="Create" /><asp:Label runat="server" ID="lblCreatedId" /><br />
        <asp:Button runat="server" ID="btnLoadTest" Text="Get" /><asp:TextBox runat="server" ID="txtLoadId" /><br />
        <asp:Button runat="server" ID="btnRunTest" Text="Run" /><asp:TextBox runat="server" ID="txtRunId" /><br />
        <asp:Button runat="server" ID="btnRunNextTest" Text="Run next" /><asp:TextBox runat="server" ID="txtRunNextId" /><br />
        <asp:Button runat="server" ID="btnActiveAutomations" Text="Get active" /><asp:Label runat="server" ID="lblActiveAutomations" /><br />
    </div>
    </form>
</body>
</html>
