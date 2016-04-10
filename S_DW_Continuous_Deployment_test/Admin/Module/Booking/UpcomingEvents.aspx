<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="UpcomingEvents.aspx.vb" Inherits="Dynamicweb.Admin.UpcomingEvents" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" runat="server"></dw:ControlResources>

	<link href="CSS/UpcomingEvents.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">

        function help() {
		    <%=Gui.Help("modules", "modules")%>
	    }

        function over(row) {
            row.className = 'over';
        }
        function out(row) {
            row.className = '';
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">

        <dw:Toolbar ID="Toolbar1" runat="server" ShowStart="true" ShowEnd="false">
        </dw:Toolbar>
	    <h2 class="subtitle"><dw:TranslateLabel runat="server" Text="Upcoming events" /></h2>

        <div runat="server" id="myContent">
            <table>
                <asp:Repeater ID="EventTypes" runat="server">
                    <ItemTemplate>
                        <tr id="rowSection" onmouseover="over(this)" onmouseout="out(this)" runat="server">
                            <td>
                                <div class="hover">
                                    <table>
                                        <tr>
                                            <td valign="top">
                                                <img id="imgIcon" src="" alt="" runat="server" />
                                            </td>
                                            <td valign="top">
                                                <h1 id="sHeader" runat="server"></h1>
                                                <h2 id="uHeader" runat="server"></h2>
                                                <asp:Repeater ID="Events" runat="server">
                                                    <ItemTemplate>
                                                        <h2>
                                                            <a id="lnkNode" runat="server">
                                                                <span id="dateLabel" runat="server"></span><br />
                                                                <span id="nameLabel" runat="server" class="name"></span> (<span id="itemLabel" runat="server"></span>)
                                                            </a>
                                                        </h2>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
        </div>
    </form>
</body>
</html>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()%>