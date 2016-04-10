<%@ Page Language="vb" ValidateRequest="false" AutoEventWireup="false" CodeBehind="EcomCalcField_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomCalcField_Edit" %>

<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title></title>
    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
    <link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
    <%= CalculatedFieldAddIn.Jscripts%>

    <script type="text/javascript" src="../images/AjaxAddInParameters.js"></script>

    <script type="text/javascript" src="/Admin/Extensibility/JavaScripts/ProductsAndGroupsSelector.js"></script>

    <script type="text/javascript" src="/Admin/FormValidation.js"></script>

    <script type="text/javascript">
        $(document).observe('dom:loaded', function () {
            window.focus(); // for ie8-ie9 
            document.getElementById('NameStr').focus();
        });

        function checkfield(field) {
            var result = true;
            var fieldTmp = field.toLowerCase();
            var validChars = "0123456789abcdefghijklmnopqrstuvwxyz";

            for(var i = 0; i < fieldTmp.length; i++) {
                if(validChars.indexOf(fieldTmp.charAt(i)) == -1) {
                    result = false;
                }
            }

            return result;
        }

        function ddPresentations_dataExchange(sender, args) {
            if(args.dataSource && args.dataDestination) {
                args.dataDestination.innerHTML = $(args.dataSource).select('.p-title')[0].innerHTML;
            }
        }

        function disposeNumberCtrl() {
            if (typeof Update_period_value_NumberSelector != 'undefined')
                Update_period_value_NumberSelector.reset();
        }

        function save(close) {
            document.getElementById("Close").value = close ? 1 : 0;
            document.getElementById('Form1').SaveButton.click();
        }
    </script>

</head>
<body>
    <asp:Literal ID="BoxStart" runat="server"></asp:Literal>
    <form id="Form1" method="post" runat="server">
        <input id="Close" type="hidden" name="Close" value="0" />
        <asp:Literal ID="TableIsBlocked" runat="server"></asp:Literal>
        <dw:TabHeader ID="TabHeader1" runat="server" TotalWidth="100%"></dw:TabHeader>
        <div id="Tab1">
            <table border="0" cellpadding="0" cellspacing="0" width='95%' style='width: 95%'>
                <tr>
                    <td>
                        <fieldset style='width: 100%; margin: 5px;'>
                            <legend class="gbTitle"><%=Translate.Translate("General")%></legend>
                            <table border="0" cellpadding="2" cellspacing="0" width='100%' style='width: 100%;'>
                                <tr>
                                    <td width="170" height="40">
                                        <dw:TranslateLabel ID="tLabelCalcFieldName" runat="server" Text="Name" />
                                    </td>
                                    <td>
                                        <div id="errNameStr" style="color: Red;">
                                        </div>
                                        <asp:TextBox ID="NameStr" CssClass="NewUIinput" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <asp:Panel runat="server" ID="CalculatedFieldTypeAddIn">
                            <div id="err<%=CalculatedFieldAddIn.AddInTypeName %>_AddInTypes" style="color: Red; width: 100%; margin: 5px;">
                            </div>
                            <de:AddInSelector runat="server" ID="CalculatedFieldAddIn" AddInBreakFieldsets="false" useNewUI="true" onBeforeUpdateSelection = 'disposeNumberCtrl()' AddInShowNothingSelected="false" AddInGroupName="Field type" AddInParameterName="Selection" AddInTypeName="Dynamicweb.eCommerce.CalculatedFields.CalculatedFieldTypeProvider" />
                        </asp:Panel>
                        <asp:Literal runat="server" ID="LoadParametersScript"></asp:Literal>
                        <fieldset style='width: 100%; margin: 5px;'>
                            <legend class="gbTitle">
                                <%=Translate.Translate("Scheduling")%></legend>
                            <table border="0" cellpadding="2" cellspacing="0" width='100%' style='width: 100%;'>
                                <tr>
                                    <td width="170" valign="middle">
                                        <dw:TranslateLabel ID="tLabelBegin" Text="Begin" runat="server" />
                                    </td>
                                    <td valign="top" colspan="2">
                                        <dw:DateSelector runat="server" ID="dsDateFrom" AllowNeverExpire="false" />
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="middle">
                                        <dw:TranslateLabel ID="tLabelRepeat" Text="Repeat every" runat="server" />
                                    </td>
                                    <td valign="top" colspan="2">
                                        <table border="0" cellpadding="0" cellspacing="0" width='100%' style='width: 100%;'>
                                            <tr>
                                                <td width="105" height="30" valign="middle">
                                                    <omc:NumberSelector ID="nsRepeatList" AllowNegativeValues="false" MinValue="1" MaxValue="200" runat="server" />
                                                </td>
                                                <td valign="middle">
                                                    <asp:DropDownList ID="ddlRepeatType" CssClass="NewUIinput" Width="100px" runat="server">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
            </table>
            <br />
            <asp:Button ID="SaveButton" Style="display: none" runat="server"></asp:Button>
            <asp:Button ID="DeleteButton" Style="display: none" runat="server"></asp:Button>
        </div>
    </form>
    <asp:Literal ID="BoxEnd" runat="server"></asp:Literal>

    <script type="text/javascript">
        addMinLengthRestriction('NameStr', 1, '<%=Translate.JsTranslate("A name is needed")%>');
        activateValidation('Form1');
    </script>

    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</body>
</html>
