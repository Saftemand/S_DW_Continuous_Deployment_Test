<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EmailMarketing.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Management.EmailMarketing" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true" IncludeScriptaculous="true"></dw:ControlResources>
    <script language="javascript" type="text/javascript" >
        function save(cmd) {
            $('cmdSave').value = cmd;
            $('form1').submit();
        }

        function cancel() {
            window.location = "/Admin/Content/Management/Start.aspx";
        }
    </script>
</head>

<body style="overflow:auto;">
    <dw:Toolbar ID="toolbar" runat="server" ShowEnd="false">
		<dw:ToolbarButton runat="server" Text="Save" Image="Save" OnClientClick="save('cmdSave');" ID="btnSave" ShowWait="true" />
        <dw:ToolbarButton runat="server" Text="Save And Close" Image="SaveAndClose" OnClientClick="save('cmdSaveAndClose');" ID="btnSaveAndClose" ShowWait="true" />
		<dw:ToolbarButton runat="server" Text="Cancel" Image="Cancel" OnClientClick="cancel();" ID="btnCancel" ShowWait="true" />
    </dw:Toolbar>
    <h2 class="subtitle"><%= Translate.Translate("Email Marketing")%></h2>
    <form id="form1" runat="server">
    <input type="hidden" id="cmdSave" name="cmdSave" value="" />
    <div id="content" style="overflow:auto;">

    <dw:GroupBox ID="GroupBoxRecipientsList" runat="server" Title="Settings for recipient list in statistics">
        <table cellpadding="2" cellspacing="0">
            <tr>
                <td style="width: 170px">
                    <dw:TranslateLabel ID="RecipientsListMaxCountTitle" Text="Count" runat="server"/>
                </td>
                <td>
                    <asp:DropDownList runat="server" ID="RecipientsListMaxCount" CssClass="std"/>
                </td>
            </tr>
            <tr>
                <td style="width: 170px">
                    <dw:TranslateLabel ID="RecipientsListDefaultSortTitle" Text="Sort by" runat="server"/>
                </td>
                <td>
                    <asp:DropDownList runat="server" ID="RecipientsListDefaultSort" CssClass="std"/>
                </td>
            </tr>
        </table> 
    </dw:GroupBox>

    </div> 
    </form> 
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</body>
</html> 
