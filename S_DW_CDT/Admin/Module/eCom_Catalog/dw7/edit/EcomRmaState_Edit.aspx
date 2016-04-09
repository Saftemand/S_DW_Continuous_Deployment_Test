<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EcomRmaState_Edit.aspx.vb" Inherits="Dynamicweb.Admin.EcomRmaState_Edit" %>

<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<link rel="stylesheet" type="text/css" href="/Admin/Stylesheet.css" />
		<link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
		
        <script type="text/javascript" src="/Admin/Module/eCom_Catalog/dw7/images/layermenu.js"></script>

		<dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
		
        <title>Edit RMA states</title>

        <script type="text/javascript">
            var delocalizeMessage = "<%=delocalizeMessage %>";
            var deleteMessage = "<%=deleteMessage %>";

            function save(close) {
                if (close)
                    $('SaveClose').value = 'True';
                else
                    $('Save').value = 'True';
                
                submit();
            }

            function deleteState(deleteAll) {
                var message;
                if (deleteAll) {
                    $('DeleteState').value = 'True';
                    message = deleteMessage;
                } else {
                    $('Delete').value = 'True';
                    message = delocalizeMessage;
                }

                if (confirm(message))
                    submit();
            }

            function submit() {
                document.Form1.submit();
            }
        </script>
	</head>
	
	<body>
		<form id="Form1" method="post" runat="server">
		    <dw:Toolbar runat="server" ID="Toolbar" ShowStart="true" ShowEnd="false">
            </dw:Toolbar>
            <h2 class="subtitle"><asp:Literal runat="server" ID="Header"></asp:Literal></h2>
            <dw:Infobar runat="server" ID="StateStatus" Visible="false" />

            <asp:HiddenField runat="server" ID="StateID" />

            <dw:GroupBox runat="server" Title="State settings">
                <table>
                    <tr>
                        <td style="width: 170px;"><dw:TranslateLabel runat="server" Text="Name" /></td>
                        <td><asp:TextBox runat="server" ID="Name" CssClass="NewUIinput" /></td>
                    </tr>
                    <tr>
                        <td style="width: 170px;"><dw:TranslateLabel runat="server" Text="Description" /></td>
                        <td><asp:TextBox runat="server" ID="Description" TextMode="MultiLine" Height="50" CssClass="NewUIinput" /></td>
                    </tr>
                    <tr>
                        <td style="width: 170px;"></td>
                        <td><label><asp:CheckBox runat="server" ID="DefaultForNewRMA" Checked="false" /><dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Default for new RMAs" /></label></td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top; width: 170px;"><dw:TranslateLabel runat="server" Text="Active for" /></td>
                        <td><asp:Literal runat="server" ID="TypeSelector" /></td>
                    </tr>
                </table>
            </dw:GroupBox>

            <input type="hidden" name="Save" id="Save" value="" />
            <input type="hidden" name="SaveClose" id="SaveClose" value="" />
            <input type="hidden" name="Delete" id="Delete" value="" />
            <input type="hidden" name="DeleteState" id="DeleteState" value="" />
        </form>
		<asp:Literal id="BoxEnd" runat="server"></asp:Literal>

		<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
	</body>
</html>
