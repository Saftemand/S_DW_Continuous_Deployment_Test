<%@ Page Language="vb" MasterPageFile="/Admin/Content/Management/EntryContent.Master" AutoEventWireup="false" CodeBehind="EcomAdvConfigShoppingCart_Edit.aspx.vb" Inherits="Dynamicweb.Admin.EcomAdvConfigShoppingCart_Edit" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">

    <script language="javascript" type="text/javascript">
        var page = SettingsPage.getInstance();

        page.onSave = function () {

            document.getElementById('MainForm').submit();
        }

        page.onHelp = function () {
            <%=Gui.help("", "administration.controlpanel.ecom.cart") %>
        }

    </script>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">

    <div id="PageContent">
        <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
            <tr>
                <td valign="top" width="600px">
                    <dw:GroupBox ID="GroupBox1" runat="server" Title="Indstillinger" DoTranslation="true">
                        <table cellpadding="2" cellspacing="0" border="0" style="margin: 5px;">
                            <colgroup>
                                <col width="450px" />
                                <col width="20px" />
                            </colgroup>
                            <tr>
                                <td>
                                    <dw:TranslateLabel runat="server" Text="Recalculate a user's cart when the user logs in " />
                                </td>
                                <td>
                                    <input type="checkbox" name="/Globalsettings/Ecom/Cart/RecalculateOnUserLogin" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Cart/RecalculateOnUserLogin") = "True", "checked", "")%> />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Skip payment and shipping step if only one method exists" />
                                </td>
                                <td>
                                    <input type="checkbox" name="/Globalsettings/Ecom/Cart/SkipMethodStep" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Cart/SkipMethodStep")), "checked", "")%> />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dw:TranslateLabel ID="TranslateLabel10" runat="server" Text="Skip payment gateway if order amount is 0 or less" />
                                </td>
                                <td>
                                    <input type="checkbox" name="/Globalsettings/Ecom/Cart/SkipPaymentGateway" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Cart/SkipPaymentGateway")), "checked", "")%> />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Enable step validation" />
                                </td>
                                <td>
                                    <input type="checkbox" name="/Globalsettings/Ecom/Cart/StepValidate" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Cart/StepValidate")), "checked", "")%> />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dw:TranslateLabel ID="TranslateLabel9" runat="server" Text="Disable step validation when go back" />
                                </td>
                                <td>
                                    <input type="checkbox" name="/Globalsettings/Ecom/Cart/DisableBackStepValidation" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Cart/DisableBackStepValidation")), "checked", "")%> />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div style="color: Gray">
                                        <p>
                                            <dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Notice that step validation requires changes to the AcceptCart.html template. Click ´Help´ for further information." />
                                        </p>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Create new cart when current cart is an order and is manipulated" />
                                </td>
                                <td>
                                    <input type="checkbox" name="/Globalsettings/Ecom/Cart/MakeNewCartWhenCartIsOrderAndIsManipulated" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Cart/MakeNewCartWhenCartIsOrderAndIsManipulated")), "checked=""checked""", "")%> />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dw:TranslateLabel ID="TranslateLabel8" runat="server" Text="Organize orderlines so discounts and taxes are grouped with their parent orderlines" />
                                </td>
                                <td>
                                    <input type="checkbox" name="/Globalsettings/Ecom/Cart/OrganizeDiscountAndTaxOrderLines" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Cart/OrganizeDiscountAndTaxOrderLines")), "checked=""checked""", "")%> />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dw:TranslateLabel runat="server" Text="Keep cart in context after checkout step" />
                                </td>
                                <td>
                                    <input type="checkbox" name="/Globalsettings/Ecom/Cart/KeepCartInContext" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Cart/KeepCartInContext")), "checked=""checked""", "")%> />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div style="color: Gray">
                                        <p>
                                            <dw:TranslateLabel runat="server" Text="Notice that the cart will stay in the context until checkout has been validated. Click ´Help´ for further information." />
                                        </p>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </dw:GroupBox>
                    <%If Base.HasVersion("8.5.0.0") Then%>

                    <dw:GroupBox ID="GroupBox4" runat="server" Title="Extranet" DoTranslation="true">
                        <table cellpadding="2" cellspacing="0" border="0" style="margin: 5px;">
                            <colgroup>
                                <col width="450px" />
                                <col width="20px" />
                            </colgroup>
                            <tr>
                                <td>
                                    <dw:TranslateLabel ID="TranslateLabel12" runat="server" Text="Do not replace existing cart when user logs in" />
                                </td>
                                <td>
                                    <input type="checkbox" name="/Globalsettings/Ecom/Cart/UsePreviousCartInsteadOfNewCart" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Cart/UsePreviousCartInsteadOfNewCart")), "checked", "")%> />
                                </td>
                            </tr>
                        </table>
                    </dw:GroupBox>

                    <%End If%>

                    <dw:GroupBox ID="GroupBox2" runat="server" Title="Default methods" DoTranslation="true">
                        <table cellpadding="2" cellspacing="0" border="0" style="margin: 5px;">
                            <colgroup>
                                <col width="450px" />
                                <col width="20px" />
                            </colgroup>
                            <tr>
                                <td colspan="2">
                                    <div style="color: Gray">
                                        <p>
                                            <dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Use default methods before the user selects them" />
                                        </p>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="Payment" />
                                </td>
                                <td>
                                    <input type="checkbox" name="/Globalsettings/Ecom/Cart/UseDefaultPayment" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Cart/UseDefaultPayment")), "checked", "")%> />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dw:TranslateLabel ID="TranslateLabel7" runat="server" Text="Shipping" />
                                </td>
                                <td>
                                    <input type="checkbox" name="/Globalsettings/Ecom/Cart/UseDefaultShipping" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Cart/UseDefaultShipping")), "checked", "")%> />
                                </td>
                            </tr>
                        </table>
                    </dw:GroupBox>

                    <dw:GroupBox ID="GroupBox3" runat="server" Title="Saved for later" DoTranslation="true">
                        <table cellpadding="2" cellspacing="0" border="0" style="margin: 5px;">
                            <colgroup>
                                <col width="450px" />
                                <col width="20px" />
                            </colgroup>
                            <tr>
                                <td><%= Translate.Translate("Saved for later valid time (days)")%></td>
                                <td style="width: 80px;">
                                    <input style="width: 25px; float: left;" type="text" name="/Globalsettings/Ecom/Cart/SavedForLaterValidTime" id="/Globalsettings/Ecom/Cart/SavedForLaterValidTime" value="<%=Base.GetGs("/Globalsettings/Ecom/Cart/SavedForLaterValidTime")%>" class="std" />
                                </td>
                            </tr>
                        </table>
                    </dw:GroupBox>

                </td>
            </tr>
        </table>
    </div>

    <% Translate.GetEditOnlineScript()%>
</asp:Content>
