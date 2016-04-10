<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EcomSalesDiscount_Edit.aspx.vb"
    Inherits="Dynamicweb.Admin.eComBackend.EcomSalesDiscount_Edit" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1" />
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1" />
    <meta name="vs_defaultClientScript" content="JavaScript" />
    <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5" />
    <link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css" />
    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true"
        runat="server" />
    <link rel="STYLESHEET" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
    <style type="text/css">
        BODY.margin {
            margin: 0px;
        }

        INPUT {
            font-size: 11px;
            font-family: verdana,arial;
        }

        SELECT {
            font-size: 11px;
            font-family: verdana,arial;
        }

        TEXTAREA {
            font-size: 11px;
            font-family: verdana,arial;
        }

        .autoOverflow {
            overflow: auto;
        }

        .fixed-currency-values {
            width: 105px;
            margin-left: 72px;
        }

            .fixed-currency-values input {
                width: 50px;
                height: 18px;
            }

        div.property-row {
            margin: 10px 10px 10px 10px;
        }

        div.property-name {
            float: left;
        }

        div.property-value {
            margin-left: 160px;
        }

        div.discount-value-type {
            padding-bottom: 10px;
        }

            div.discount-value-type input {
                margin-top: 10px;
                float: left;
            }

            div.discount-value-type div.label {
                text-align: center;
                margin-left: 30px;
            }

        div.discount-value fieldset {
            width: 500px;
            margin-left: 138px !important;
        }

        div.discount-value-description {
            margin: 10px 10px 10px 10px;
            color: Gray;
        }
    </style>
    <%=AddInControl.Jscripts%>
    <dw:ControlResources runat="server" />

    <script type="text/javascript" src="/Admin/Module/eCom_Catalog/images/functions.js"></script>

    <script type="text/javascript" language="javascript" src="/Admin/FormValidation.js"></script>

    <script type="text/javascript" src="/Admin/Extensibility/JavaScripts/ProductsAndGroupsSelector.js"></script>

    <script type="text/javascript">

        $(document).observe('dom:loaded', function () {
            window.focus(); // for ie8-ie9 
            document.getElementById('NameStr').focus();
            <%If Base.HasAccess("eCom_SalesDiscountExtended", "") AndAlso Base.IsModuleInstalled("eCom_MultiShopAdvanced") Then%>
            toggleCountries();
            <%End If%>

            var valueFixed = $("DiscountValueText_Fixed");
            if (valueFixed) {
                valueFixed.observe('keydown', onKeyDown);
                valueFixed.observe('change', onAmountChanged);
            }
            $$("#CurrencyTable input").each(function (input) {
                input.observe('keydown', onKeyDown);
                input.observe('change', onAmountChanged);
            });
        });

	    <%If Base.HasAccess("eCom_SalesDiscountExtended", "") Then%>
        function OnChangeDiscountType(addInName) {
            toggleValueProductDiv(addInName);
            toggleValueGroupBox(addInName);
            toggleValueType();
        }

        function toggleValueProductDiv(addInName) {
            try {
                var productDiv = $('DiscountValue_Product_Div');

                if (addInName == 'Dynamicweb.eCommerce.Orders.SalesDiscounts.ProductDiscount') {
                    // Hide the div
                    productDiv.style.display = 'none';

                    // Change radio if this was selected
                    var productRadio = $('DiscountValue_radio_products')
                    if (productRadio.checked)
                        $('DiscountValue_radio_fixed').checked = true;

                    // Disable radio (So that it cant be selected with arrowkeys while control is selected)
                    productRadio.disabled = true;
                }
                else {
                    // Show the div
                    productDiv.style.display = '';

                    // Enable radio
                    document.getElementById('DiscountValue_radio_products').disabled = false;
                }
            } catch (e) {
                //Nothing
            }
        }

        function toggleValueGroupBox(addInName) {
            try {
                var valueGroupBoxDiv = $('ValueGroupBox_Div');

                if (hideDiscountValueGroupBox(addInName)) {
                    // Hide the div
                    valueGroupBoxDiv.style.display = 'none';
                }
                else {
                    // Show the div
                    valueGroupBoxDiv.style.display = '';
                }
            } catch (e) {
                //Nothing
            }
        }

        function toggleValueType(valueType) {
            if ($('DiscountValue_radio_fixed').checked) {
                $('discount-value-percentage').hide();
                $('discount-value-products').hide();
                $('discount-value-fixed').show();

                onAmountChanged({ srcElement: $("DiscountValueText_Fixed") });
                $$("#CurrencyTable input").each(function (input) {
                    onAmountChanged({ srcElement: input });
                });
            }
            else if ($('DiscountValue_radio_percentage').checked) {
                $('discount-value-percentage').show();
                $('discount-value-products').hide();
                $('discount-value-fixed').hide();
            } else {
                $('discount-value-percentage').hide();
                $('discount-value-products').show();
                $('discount-value-fixed').hide();
            }
        }

        function toggleCountries() {
            if ($('CountryRadioAll').checked) {
                $('SelectedCountries').hide();
            }
            else {
                $('SelectedCountries').show();
            }
        }
        <%End If%>

        function onAmountChanged(e) {
            var srcElement = e.srcElement ? e.srcElement : e.target;
            srcElement.style.color = parseFloat(srcElement.value) === 0 ? "silver" : "black";
        }

        function onKeyDown(e) {
            if (e.keyCode == 46) {
                var srcElement = e.srcElement ? e.srcElement : e.target;
                srcElement.value = "0";
                srcElement.style.color = "silver";
            }
        }

        // Overwrite the doSubmit in form validation
        function doSubmit(button) {
            // Remove any error messages
            try {
                $('valueError').innerHTML = '';
                $('dateError').innerHTML = '';
                $('dateError').hide();
            } catch (ex) { }

            var parentform = getParentFormElement(button);
            if (parentform != null) {
                var validated = doFormValidation(parentform);

                var valueGroupBoxDiv = document.getElementById('ValueGroupBox_Div');
                if (valueGroupBoxDiv.style.display != 'none') {
                    // If discount value panel is showed, check the value inputs
                    var fixedRadio = document.getElementById("DiscountValue_radio_fixed")
                    if (fixedRadio != null && fixedRadio.checked) {
                        var value = document.getElementById("DiscountValueText_Fixed").value;
                        var doubleValue = parseFloat(value);
                        if (isNaN(doubleValue)) {
                            document.getElementById('valueError').innerHTML = '<%=Translate.Translate("Value must be a number") %>';
                                validated = false;
                            }
                        }
                        var percentageRadio = document.getElementById("DiscountValue_radio_percentage")
                        if (percentageRadio != null && percentageRadio.checked) {
                            var value = document.getElementById("DiscountValueText_Percentage").value;
                            var doubleValue = parseFloat(value);
                            if (isNaN(doubleValue)) {
                                document.getElementById('valueError').innerHTML = '<%=Translate.Translate("Value must be a number") %>';
                                validated = false;
                            }
                            else if (doubleValue == 0) {
                                document.getElementById('valueError').innerHTML = '<%=Translate.Translate("Please enter a non-zero value") %>';
                                    validated = false;
                                }
                        }
                        var productsRadio = document.getElementById("DiscountValue_radio_products")
                        if (productsRadio != null && productsRadio.checked) {
                            var value = document.getElementById("DiscountValueProductsSelector_value").value;
                            if (value == null || value == '') {
                                document.getElementById('valueError').innerHTML = '<%=Translate.Translate("At least one product must be selected") %>';
                                validated = false;
                            }
                        }
                    }

                    // Check the date
                    try {
                        var dateFrom = getDate(document.getElementById("DateFrom").value)
                        var dateTo = getDate(document.getElementById("DateTo").value)
                        if (dateFrom.getTime() >= dateTo.getTime()) {
                            $('dateError').innerHTML = '<%=Translate.Translate("From date must be before to date") %>';
                            $('dateError').show();
                            validated = false;
                        }
                    } catch (ex) { }

                    if (validated == true) {
                        /*parentform.submit();*/
                        return true;
                    }
                    else {
                        /*alert('false');*/
                        return false;
                    }
                }
            }
            function getDate(dateString) {
                var dateRegex = /(\d+)-(\d+)-(\d+) (\d+):(\d+)/;
                var match = dateRegex.exec(dateString);
                var date = new Date();
                date.setDate(match[1]);
                date.setMonth(match[2] - 1); // Month has an OB1E
                date.setFullYear(match[3]);
                date.setHours(match[4]);
                date.setMinutes(match[5]);
                date.setSeconds(0);
                date.setMilliseconds(0);
                return date;
            }

            function setDivSize() {
                var thisDiv = document.getElementById("MainContentDiv");
                if (navigator.appName.indexOf('Microsoft') == -1) {
                    //The size 116 px is the height of the tabheader + plus other table elements.
                    //Should be updated if those values change.
                    thisDiv.style.height = window.innerHeight - 116 + "px";
                }
            }

            function setDetailsDisabled() {
                setEnabled(document.getElementById('SalesDiscountDetailsDiv'));
            }
            function setEnabled(el) {
                try {
                    el.disabled = true;
                } catch (e) { }

                if (el.childNodes && el.childNodes.length > 0)
                    for (var x = 0; x < el.childNodes.length; x++)
                        setEnabled(el.childNodes[x]);
            }

            function save(close) {
                document.getElementById("Close").value = close ? 1 : 0;
                document.getElementById('Form1').SaveButton.click();
            }

    </script>

</head>
<body onload="javascript:setDivSize();" style="background: #DFE9F5 url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;" onresize="javascript:setDivSize();">
    <asp:Literal ID="BoxStart" runat="server" />
    <form id="Form1" method="post" runat="server" style="min-height: 100%;">
        <input id="Close" type="hidden" name="Close" value="0" />
        <dw:TabHeader ID="TabHeader" runat="server" TotalWidth="100%" />
        <div id="MainContentDiv" style="min-height: 100%;">
            <dw:Infobar runat="server" ID="NotLocalizedInfo" Type="Warning" Visible="false" Message="The discount is not localized to this language. Save the discount to localize it." />
            <table border="0" cellpadding="0" cellspacing="0" class="tabTable100" id="DW_Ecom_tableTab">
                <tr>
                    <td style="vertical-align: top;">
                        <%=ConvertAlert %>
                        <!-- General -->
                        <dw:GroupBox runat="server" ID="GeneralGroupBox">
                            <!-- Discount Name -->
                            <div class="property-row">
                                <div class="property-name">
                                    <dw:TranslateLabel runat="server" Text="Navn" />
                                </div>
                                <div class="property-value">
                                    <div id="errNameStr" style="color: Red;">
                                    </div>
                                    <asp:TextBox ID="NameStr" CssClass="NewUIinput" runat="server" Width="463" />
                                </div>
                            </div>
                            <!-- Description -->
                            <div class="property-row">
                                <div class="property-name">
                                    <dw:TranslateLabel runat="server" Text="Description" />
                                </div>
                                <div class="property-value">
                                    <asp:TextBox ID="DescriptionStr" CssClass="NewUIinput" runat="server" TextMode="MultiLine" Rows="6" Width="463" />
                                </div>
                            </div>
                        </dw:GroupBox>
                        <dw:Infobar runat="server" Visible="false" ID="NotDefaultInfo" Type="Information"
                            Message="To edit the discount details you need to edit the discount in the default language" />
                        <div id="SalesDiscountDetailsDiv">
                            <!-- Type -->
                            <dw:GroupBox runat="server" ID="TypeGroupBox">
                                <div style="margin: 10px 10px 10px 10px;">
                                    <input type="text" class="NewUIinput" style="display: none" id="Type_SalesDiscount_Hidden" <%If Base.HasAccess("eCom_SalesDiscountExtended", "") Then%>
                                        onchange="OnChangeDiscountType(this.value);" <%End If%> />
                                    <de:SalesDiscountAddInSelector ID="AddInControl" runat="server" HiddenControlToUpdate="Type_SalesDiscount_Hidden" />
                                </div>
                            </dw:GroupBox>
                            <div id="ValueGroupBox_Div">
                                <!-- Discount value -->
                                <dw:GroupBox runat="server" ID="ValueGroupBox">
                                    <div class="property-name">
                                        <div class="discount-value-type">
                                            <asp:RadioButton runat="server" GroupName="DiscountValueRadioGroup" ID="DiscountValue_radio_percentage" onclick="toggleValueType();" />
                                            <div class="label">
                                                <label for="DiscountValue_radio_percentage">
                                                    <img src="/Admin/Images/eCom/SalesDiscount/Percentage.png" alt="" onclick="document.getElementById('DiscountValue_radio_percentage').checked = true;" /><br />
                                                    <dw:TranslateLabel runat="server" Text="Percentage" />
                                                </label>
                                            </div>
                                        </div>
                                        <div class="discount-value-type">
                                            <asp:RadioButton runat="server" GroupName="DiscountValueRadioGroup" ID="DiscountValue_radio_fixed" onclick="toggleValueType();" />
                                            <div class="label">
                                                <label for="DiscountValue_radio_fixed">
                                                    <img src="/Admin/Images/eCom/SalesDiscount/FixedAmount.png" alt="" onclick="document.getElementById('DiscountValue_radio_fixed').checked = true;" /><br />
                                                    <dw:TranslateLabel runat="server" Text="Amount" />
                                                </label>
                                            </div>
                                        </div>
                                        <%If Base.HasAccess("eCom_SalesDiscountExtended", "") Then%>
                                        <div class="discount-value-type" id="DiscountValue_Product_Div">
                                            <asp:RadioButton runat="server" GroupName="DiscountValueRadioGroup" ID="DiscountValue_radio_products" onclick="toggleValueType();" />
                                            <div class="label">
                                                <label for="DiscountValue_radio_products">
                                                    <img src="/Admin/Images/eCom/SalesDiscount/Product.png" alt="" onclick="document.getElementById('DiscountValue_radio_products').checked = true;" /><br />
                                                    <dw:TranslateLabel runat="server" Text="Products" />
                                                </label>
                                            </div>
                                        </div>
                                        <%End If%>
                                    </div>
                                    <div class="property-value discount-value">
                                        <dw:GroupBox runat="server" ID="DiscountValueGroupBox" DoTranslation="true" Title="Parameters">
                                            <div id="discount-value-fixed">
                                                <div class="discount-value-description">
                                                    <dw:TranslateLabel runat="server" Text="Enter a fixed discount sum (e.g. 100) which is subtracted from the price. If the dicount is set to 25 for EURO, then the customer will only get 25 EURO as discount for websites that uses EURO as currency." />
                                                </div>
                                                <div class="property-row">
                                                    <div class="property-name">
                                                        <dw:TranslateLabel runat="server" Text="Amount" />
                                                    </div>
                                                    <div class="property-value">
                                                        <div style="width: 100px; text-align: right; float: left;">
                                                            <label for="DiscountValueText_Fixed">
                                                                <dw:TranslateLabel runat="server" Text="Default currency" />
                                                            </label>
                                                        </div>
                                                        <asp:TextBox runat="server" CssClass="NewUIinput" Style="width: 50px; margin-left: 4px;" ID="DiscountValueText_Fixed" />
                                                        <div class="fixed-currency-values">
                                                            <table id="CurrencyTable" runat="server">
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="discount-value-percentage">
                                                <div class="discount-value-description">
                                                    <dw:TranslateLabel runat="server" Text="Enter a discount percentage. If the discount percentage is set to 50, then the customer will only be charged with half the price." />
                                                </div>
                                                <div class="property-row">
                                                    <div class="property-name">
                                                        <dw:TranslateLabel runat="server" Text="Percentage" />
                                                    </div>
                                                    <div class="property-value">
                                                        <asp:TextBox runat="server" CssClass="NewUIinput" ID="DiscountValueText_Percentage" Width="50px" />
                                                        %
                                                    </div>
                                                </div>
                                            </div>
                                            <div id="discount-value-products">
                                                <div class="discount-value-description">
                                                    <dw:TranslateLabel runat="server" Text="Choose one or more products from your product catalog by clicking the Add products icon. When the sales discount is activated then the chosen product(s) will be added to the customer's cart." />
                                                </div>
                                                <div class="property-row">
                                                    <div class="property-name">
                                                        <dw:TranslateLabel runat="server" Text="Products" />
                                                    </div>
                                                    <div class="property-value">
                                                        <de:ProductsSelector runat="server" ID="DiscountValueProductsSelector" Width="175px" Height="70px" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div style="clear: both; color: Red;" id="valueError"></div>
                                        </dw:GroupBox>
                                    </div>
                                </dw:GroupBox>
                            </div>
                            <!-- Limitation -->
                            <dw:GroupBox runat="server" ID="LimitationGroupBox">
                                <%If Base.HasVersion("8.5.0.0") Then%>
                                <div class="property-row">
                                    <div class="property-name">
                                        <dw:TranslateLabel runat="server" Text="Minimum total price" />
                                    </div>
                                    <div class="property-value">
                                        <input id="MinimumBasketSize" runat="server" type="text" />
                                    </div>
                                    <%End If%>
                                </div>
                                <%If Base.HasAccess("eCom_SalesDiscountExtended", "") Then%>
                                <!-- Date From -->
                                <div class="property-row">
                                    <div class="property-name">
                                        <dw:TranslateLabel runat="server" Text="Date from" />
                                    </div>
                                    <div class="property-value">
                                        <de:DateSelector runat="server" ID="DateFrom" AllowNeverExpire="false" />
                                    </div>
                                </div>
                                <!-- Date To -->
                                <div class="property-row">
                                    <div class="property-name">
                                        <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Date to" />
                                    </div>
                                    <div class="property-value">
                                        <div style="clear: both; color: Red; display: none;" id="dateError"></div>
                                        <de:DateSelector runat="server" ID="DateTo" AllowNeverExpire="true" />
                                    </div>
                                </div>
                                <% If Base.HasAccess("ExtranetExtended") OrElse Base.HasAccess("UserManagementFrontend") Then%>
                                <!-- Users -->
                                <div class="property-row">
                                    <div class="property-name">
                                        <dw:TranslateLabel runat="server" Text="Used by" />
                                    </div>
                                    <div class="property-value">
                                        <input type="radio" runat="server" name="UserSelectorRadio" id="UserSelectorRadioAll"
                                            onclick="javascript: toggleUserSelectorDiv();" />
                                        <label for="UserSelectorRadioAll">
                                            <dw:TranslateLabel runat="server" Text="All" />
                                        </label>
                                        <br />
                                        <input type="radio" runat="server" name="UserSelectorRadio" id="UserSelectorRadioAuth"
                                            onclick="javascript: toggleUserSelectorDiv();" />
                                        <label for="UserSelectorRadioAuth">
                                            <dw:TranslateLabel runat="server" Text="Authenticated users" />
                                        </label>
                                        <br />
                                        <input type="radio" runat="server" name="UserSelectorRadio" id="UserSelectorRadioSelected"
                                            onclick="javascript: toggleUserSelectorDiv();" />
                                        <label for="UserSelectorRadioSelected">
                                            <dw:TranslateLabel runat="server" Text="Selected users and groups" />
                                        </label>
                                        <br />
                                        <div id="UserGroupSelectorDiv" style="display: none; margin: 5px 0px 0px 20px;">
                                            <dw:UserSelector runat="server" ID="SelectedUsersAndGroups" CompatibleWithOldExtranet="true" />
                                        </div>
                                    </div>
                                    <script type="text/javascript">
                                        function toggleUserSelectorDiv() {
                                            document.getElementById('UserGroupSelectorDiv').style.display = document.getElementById('UserSelectorRadioSelected').checked ? 'block' : 'none';
                                        }
                                        toggleUserSelectorDiv();
                                    </script>
                                </div>
                                <%End If%>
                                <%If Base.IsModuleInstalled("eCom_MultiShopAdvanced") Then%>
                                <!-- Shop -->
                                <div class="property-row">
                                    <div class="property-name">
                                        <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Shop (website context):" />
                                    </div>
                                    <div class="property-value">
                                        <select id="ShopSelector" name="ShopSelector" runat="server" size="1" class="std"></select>
                                    </div>
                                </div>
                                <!-- Countries -->
                                <div class="property-row">
                                    <div class="property-name">
                                        <dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Country (website context):" />
                                    </div>
                                    <div class="property-value">
                                        <input type="radio" runat="server" id="CountryRadioAll" name="CountryRadio" onclick="toggleCountries();" />
                                        <label for="CountryRadioAll">
                                            <dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="All" />
                                        </label>
                                        <input type="radio" runat="server" id="CountryRadioSelected" name="CountryRadio" onclick="toggleCountries();" />
                                        <label for="CountryRadioSelected">
                                            <dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="Selected" />
                                        </label>
                                        <br />
                                        <asp:CheckBoxList ID="SelectedCountries" runat="server"></asp:CheckBoxList>
                                    </div>
                                </div>
                                <%End If%>
                                <%End If%>
                                <!-- Active -->
                                <div class="property-row">
                                    <div class="property-name">
                                        <dw:TranslateLabel runat="server" Text="Active" />
                                    </div>
                                    <div class="property-value">
                                        <asp:CheckBox ID="ActiveBool" runat="server" />
                                    </div>
                                </div>
                            </dw:GroupBox>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <asp:Button ID="SaveButton" Style="display: none" runat="server" />
        <asp:Button ID="DeleteButton" Style="display: none" runat="server" />
        <asp:Button ID="DelocalizeButton" Style="display: none" runat="server" />
    </form>
    <asp:Literal ID="BoxEnd" runat="server" />
    <%=AddInControl.LoadParameters%>

    <script type="text/javascript">
        addMinLengthRestriction('NameStr', 1, '<%=Translate.JsTranslate("A name is needed")%>');
        activateValidation('Form1');

        // Disable all but name and description if this is not the default language
        if ('<%=IsDefault %>' == 'False')
            setDetailsDisabled();

    </script>

    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</body>
</html>
