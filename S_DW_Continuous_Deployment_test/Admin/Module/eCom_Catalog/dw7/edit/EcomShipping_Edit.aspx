<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EcomShipping_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomShipping_Edit" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Shipping </title>
    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server">
        <Items>
            <dw:GenericResource Url="/Admin/Module/eCom_Catalog/images/ObjectSelector.css" />
            <dw:GenericResource Url="/Admin/Module/OMC/js/NumberSelector.js" />
            <dw:GenericResource Url="/Admin/Module/OMC/css/NumberSelector.css" />

            <dw:GenericResource Url="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
            <dw:GenericResource Url="../css/EcomShipping_Edit.css" />
            <dw:GenericResource Url="/Admin/FormValidation.js" />
            <dw:GenericResource Url="../js/EcomShipping_Edit.js" />
        </Items>
    </dw:ControlResources>
    <%= ServiceAddin.Jscripts%>

    <script type="text/javascript">
        strHelpTopic = 'ecom.controlpanel.shipping.edit';
        var shippingEditor = null;

        function saveShipping(close) {
            shippingEditor.save(close);
        }
        
        document.observe("dom:loaded", function () {
            shippingEditor = Dynamicweb.eCommerce.Shipping.initShippingMethodEditor({
                titles: {
                    methodTypeMatrixRules: "<%=Translate.JsTranslate("Fee Rules")%>"
                }
            });
            <% If Not IsPostBack AndAlso Not String.IsNullOrEmpty(ServiceAddin.AddInSelectedType) Then%>
            <%= ServiceAddin.GetLoadParameters()%>
            <% End If%>
        });
    </script>
</head>

<body>
    <asp:Literal ID="BoxStart" runat="server"></asp:Literal>
    <form id="Form1" method="post" runat="server" style="padding: 1px;">
        <fieldset class="props-group">
            <legend class="gbTitle"><%=Translate.Translate("Metode")%></legend>
            <table border="0" cellpadding="2" cellspacing="2" width="100%">
                <tr>
                    <td class="field">
                        <dw:TranslateLabel ID="tLabelName" runat="server" Text="Navn" />
                    </td>
                    <td>
                        <asp:TextBox ID="NameStr" CssClass="NewUIinput" runat="server" />
                        <span id="errNameStr" style="display: none" class="error">
                            <%=Translate.JsTranslate("A name is needed")%>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td class="field">
                        <dw:TranslateLabel ID="tLabelDescription" runat="server" Text="Beskrivelse" />
                    </td>
                    <td>
                        <asp:TextBox ID="DescriptionStr" CssClass="NewUIinput" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="field">
                        <dw:TranslateLabel ID="tLabelMax" runat="server" Text="Standardgebyr" />
                    </td>
                    <td>
                        <asp:TextBox ID="MaxStr" CssClass="NewUIinput" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="field">
                        <dw:TranslateLabel ID="tLabelFreeFee" runat="server" Text="Fragt fri ved køb over" />
                    </td>
                    <td>
                        <asp:TextBox ID="FreeFeeAmount" CssClass="NewUIinput" runat="server"></asp:TextBox></td>
                </tr>
            </table>
        </fieldset>
        <fieldset class="props-group">
            <legend class="gbTitle"><%=Translate.Translate("Countries")%></legend>
            <table border="0" cellpadding="2" cellspacing="2" width="100%">
                <tr>
                    <td class="field" style="vertical-align:top;">
                        <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Shipping available in" />
                    </td>
                    <td>
                        <label for="country-rel-list-all" class="radio block">
                            <input type="radio" id="country-rel-list-all" name="country-mode" checked="checked" value="all" /> All countries
                        </label>
                        <label for="country-rel-list-choose" class="radio block">
                            <input type="radio" id="country-rel-list-choose"  name="country-mode" value="choose" /> Selected countries
                        </label>
                        <div id="country-rel-list-container" style="display:none">
                            <asp:Literal id="countryRelList" runat="server"></asp:Literal>
                        </div>
                    </td>
                </tr>
            </table>
        </fieldset>

		<asp:Panel runat="server" ID="ServicePanel" class="ship-provider-selector hide">
			<de:AddInSelector AddInParameterWidth="95%"
				runat="server" 
				ID="ServiceAddin"
                useNewUI="True"
				AddInGroupName="Shipping Provider" 
				AddInTypeName="Dynamicweb.eCommerce.Cart.ShippingProvider"
				/>
		</asp:Panel>
        <fieldset runat="server" id="FeeRulesCnt" class="props-group hide">
            <legend class="gbTitle"><%=Translate.Translate("Parameters")%></legend>
            <br />
            <dw:RadioButton ID="UseMinApplicableFee" runat="server" FieldName="FeeSelection" FieldValue="low" /> <label for="FeeSelectionlow"><dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Use lowest applicable fee" /></label>
            <br />
            <dw:RadioButton ID="UseMaxApplicableFee" runat="server" FieldName="FeeSelection" FieldValue="high" /> <label for="FeeSelectionhigh"><dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Use highest applicable fee" /></label>

            <br />
            <br />
            <dw:EditableList ID="Rules" runat="server" AllowPaging="true" AllowSorting="true" AutoGenerateColumns="false">
            </dw:EditableList>       
        </fieldset>
        <asp:Button id="SaveButton" style="DISPLAY:none" runat="server"></asp:Button>
        <asp:Button id="DeleteButton" style="DISPLAY:none" runat="server"></asp:Button>
        <input id="Close" type="hidden" name="Close" value="0" />
    </form>
    <asp:Literal ID="BoxEnd" runat="server"></asp:Literal>

    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</body>
</html>
