<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Start.aspx.vb" Inherits="Dynamicweb.Admin.Start" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
        <title></title>
	    <dw:ControlResources ID="ctrlResources" runat="server" />
	    
	    <link href="Start.css" rel="stylesheet" type="text/css" />
	    
        <script type="text/javascript" language="javascript" src="/admin/content/management/start.js"></script>
        
    </head>
    <body>
	    <h1 class="title">
		    <dw:TranslateLabel ID="lbManagement" runat="server" Text="Management" />
	    </h1>
	    <h2 class="subtitle">&nbsp;</h2>
        <div runat="server" id="myContent">
            <table>
                <asp:Repeater ID="repRootNodes" OnItemDataBound="repRootNodes_ItemDataBound" runat="server">
                    <ItemTemplate>
                        <tr id="rowSection" onmouseover="over(this)" onmouseout="out(this)" runat="server">
                            <td>
                                <div class="hover">
                                    <table>
                                        <tr>
                                            <td valign="top">
                                                <img id="imgIcon" alt="" runat="server" />
                                            </td>
                                            <td valign="top">
                                                <h1 id="sHeader" runat="server"></h1>
                                                <asp:Repeater ID="repSectionNodes" runat="server">
                                                    <ItemTemplate>
                                                        <h2>
                                                            <a id="lnkNode" runat="server"></a>
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
    </body>
    
    <%  
        Dynamicweb.Backend.Translate.GetEditOnlineScript()
    %>
</html>
