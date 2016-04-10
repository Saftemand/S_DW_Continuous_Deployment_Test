<%@ Page Language="C#" AutoEventWireup="true" Inherits="NORRIQ.Admin.Module.NLWI.Settings" CodeBehind="NAVIntegration_edit.aspx.cs" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<head>
    <title></title>
    <link href="/Admin/Stylesheet.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function OK_OnClick() {
            document.getElementById('frmGlobalSettings').submit();
        }

        function findCheckboxNames(form) {
            var _names = "";
            for (var i = 0; i < form.length; i++) {
                if (form[i].name != undefined) {
                    if (form[i].type == "checkbox") {
                        _names = _names + form[i].name + "@"
                    }
                }
            }
            form.CheckboxNames.value = _names;
        }

        function chkNum(field) {
            //var field = document.getElementById('/Globalsettings/Ecom/Cookie/DaysToSave');
            var newValue = '';
            for (i = 0; i < field.value.length; i++) {
                if (!isNaN(field.value.charAt(i))) {
                    //if(field.value.charAt(i) >= 0 && field.value.charAt(i) <= 9){
                    newValue = newValue + '' + field.value.charAt(i);
                }
            }
            field.value = newValue;
        }
    </script>

    <style type="text/css">
        .desc
        {
            width: 75%;
        }
    </style>
    <style type="text/css">
        body
        {
            background: #bfdbff;
        }
    </style>
</head>
<body>
    <div align="center" style="font-weight: bold">
    <dw:TabControl ID="ControlTabs" runat="server" EnableViewState="true    ">
        <dw:TabPage ID="t1" Title="Generelt" runat="server" EnableViewState="true">
            <form method="post" name="frmGlobalSettings" id="frmGlobalSettings">
            <input type="hidden" name="cmd" value="nav.globalsettings" />
            <input type="hidden" name="CheckboxNames" />
            <dw:GroupBox ID="gbB2C" runat="server" DoTranslation="true" Title="Kunder">
                <table width="100%">
                    <tr>
                        <td class="desc">
                            <%=Translate.Translate("Opret nye kunder i NAV:", true)%>
                            <br />
                        </td>
                        <td>
                            <input type="checkbox" <%=(Base.GetGs("/Globalsettings/NLWI/AllowNewCustomer") == "True" ? "CHECKED" : "")%>
                                value="True" id="AllowNewCustomer" name="AllowNewCustomer" class="stdNoWidth"
                                size="4" /><br />
                        </td>
                    </tr>
                    <tr>
                        <td class="desc">
                            <%=Translate.Translate("Kunder skal være logget ind:", true)%>
                            <br />
                        </td>
                        <td>
                            <input type="checkbox" <%=(Base.GetGs("/Globalsettings/NLWI/MustBeLoggedIn") == "True" ? "CHECKED" : "")%>
                                value="True" id="MustBeLoggedIn" name="MustBeLoggedIn" class="stdNoWidth" size="4" /><br />
                        </td>
                    </tr>
                    <tr>
                        <td class="desc">
                            <%=Translate.Translate("Opret ordre som prisberegningskunde(kontantsalg):", true)%>
                            <br />
                        </td>
                        <td>
                            <input type="checkbox" <%=(Base.GetGs("/Globalsettings/NLWI/OrderAsDefaultCustomer") == "True" ? "CHECKED" : "")%>
                                value="True" id="OrderAsDefaultCustomer" name="OrderAsDefaultCustomer" class="stdNoWidth"
                                size="4" /><br />
                        </td>
                    </tr>
                    <tr>
                        <td class="desc">
                            <%=Translate.Translate("Gem kundeinformation i Customfields ved ordreoprettelse:", true)%>
                            <br />
                        </td>
                        <td>
                            <input type="checkbox" <%=(Base.GetGs("/Globalsettings/NLWI/CustomerInfoInCustomfields") == "True" ? "CHECKED" : "")%>
                                value="True" id="CustomerInfoInCustomfields" name="CustomerInfoInCustomfields"
                                class="stdNoWidth" size="4" /><br />
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
            <dw:GroupBox ID="GroupBox4" runat="server" Title="Extenders" Visible="false" DoTranslation="true">
                <table width="100%">
                    <tr>
                        <td class="desc">
                            <%=Translate.Translate("Brug NAV produktsortiment:", true)%>
                            <br />
                        </td>
                        <td>
                            <input type="checkbox" <%=(Base.GetGs("/Globalsettings/NLWI/UseProductselection") == "True" ? "CHECKED" : "")%>
                                value="True" id="UseProductselection" name="UseProductselection" class="stdNoWidth"
                                size="4" /><br />
                        </td>
                    </tr>
                    <tr>
                        <td class="desc">
                            <%=Translate.Translate("Brug NAV Symboler:", true)%>
                            <br />
                        </td>
                        <td>
                            <input type="checkbox" <%=(Base.GetGs("/Globalsettings/NLWI/UseSymbols") == "True" ? "CHECKED" : "")%>
                                value="True" id="UseSymbols" name="UseSymbols" class="stdNoWidth" size="4" /><br />
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
            <dw:GroupBox ID="gbPrices" runat="server" Title="Navision kommunikation" DoTranslation="true">
                <table width="100%">
                    <tr>
                        <td class="desc">
                            <%=Translate.Translate("Beregn produktlister i NAV:", true)%>
                            <br />
                        </td>
                        <td>
                            <input type="checkbox" <%=(Base.GetGs("/Globalsettings/NLWI/CalculateProductlist") == "True" ? "CHECKED" : "")%>
                                value="True" id="CalculateProductlist" name="CalculateProductlist" class="stdNoWidth"
                                size="4" /><br />
                        </td>
                    </tr>
                    <tr>
                        <td class="desc">
                            <%=Translate.Translate("Beregn ordre/kurv ved ændringer:", true)%>
                            <br />
                        </td>
                        <td>
                            <input type="checkbox" <%=(Base.GetGs("/Globalsettings/NLWI/CalculateBasket") == "True" ? "CHECKED" : "")%>
                                value="True" id="CalculateBasket" name="CalculateBasket" class="stdNoWidth" size="4" /><br />
                        </td>
                    </tr>
                    <tr>
                        <td class="desc">
                            <%=Translate.Translate("Beregn ordre inden godkendelse:", true)%>
                            <br />
                        </td>
                        <td>
                            <input type="checkbox" <%=(Base.GetGs("/Globalsettings/NLWI/CalculateAcceptCart") == "True" ? "CHECKED" : "")%>
                                value="True" id="CalculateAcceptCart" name="CalculateAcceptCart" class="stdNoWidth"
                                size="4" /><br />
                        </td>
                    </tr>
                    <tr>
                        <td class="desc">
                            <%=Translate.Translate("Opret ordre i NAV:", true)%>
                            <br />
                        </td>
                        <td>
                            <input type="checkbox" <%=(Base.GetGs("/Globalsettings/NLWI/CreateOrder") == "True" ? "CHECKED" : "")%>
                                value="True" id="CreateOrder" name="CreateOrder" class="stdNoWidth" size="4" /><br />
                        </td>
                    </tr>
                    <tr>
                        <td class="desc">
                            <%=Translate.Translate("Log oprettelse af ordre:", true)%>
                            <br />
                        </td>
                        <td>
                            <input type="checkbox" <%=(Base.GetGs("/Globalsettings/NLWI/LogCreateOrder") == "True" ? "CHECKED" : "")%>
                                value="True" id="LogCreateOrder" name="LogCreateOrder" class="stdNoWidth" size="4" /><br />
                        </td>
                    </tr>
                    <tr>
                        <td class="desc">
                            <%=Translate.Translate("Tillad failover (fejl-ordre overføres til NAV via FTP):", true)%>
                            <br />
                        </td>
                        <td>
                            <input type="checkbox" <%=(Base.GetGs("/Globalsettings/NLWI/AllowFailOver") == "True" ? "CHECKED" : "")%>
                                value="True" id="AllowFailOver" name="AllowFailOver" class="stdNoWidth" size="4" /><br />
                        </td>
                    </tr>
                    <tr>
                        <td class="desc">
                            <%=Translate.Translate("Sorter ordrelinjer som i NAV:", true)%>
                            <br />
                        </td>
                        <td>
                            <input type="checkbox" <%=(Base.GetGs("/Globalsettings/NLWI/SortOrderlines") == "True" ? "CHECKED" : "")%>
                                value="True" id="SortOrderlines" name="SortOrderlines" class="stdNoWidth" size="4" /><br />
                        </td>
                    </tr>
                    <tr>
                        <td class="desc">
                            <%=Translate.Translate("Ordrelinje type for \"fixed\" linjer fra NAV(default=99):", true)%>
                            <br />
                        </td>
                        <td>
                            <input type="text" onkeyup="chkNum(this);" value="<%=Base.GetGs("/Globalsettings/NLWI/OrderLineTypeNIQ")%>"
                                id="OrderLineTypeNIQ" name="OrderLineTypeNIQ" class="stdNoWidth" size="4" /><br />
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
            <dw:GroupBox ID="gbLog" runat="server" Title="Logging / fejlhåndtering / optimering" DoTranslation="true">
                <table width="100%">
                    <tr>
                        <td class="desc">
                            <%=Translate.Translate("Gem priser i Cache(sekunder):", true)%>
                            <br />
                        </td>
                        <td>
                            <input type="text" onkeyup="chkNum(this);" value="<%=Base.GetGs("/Globalsettings/NLWI/CachePricesSeconds")%>"
                                id="CachePricesSeconds" name="CachePricesSeconds" class="stdNoWidth" size="4" /><br />
                        </td>
                    </tr>
                    <tr>
                        <td class="desc">
                            <%=Translate.Translate("Log kommunikationsfejl (mellem DW og NAV):", true)%>
                            <br />
                        </td>
                        <td>
                            <input type="checkbox" <%=(Base.GetGs("/Globalsettings/NLWI/LogErrors") == "True" ? "CHECKED" : "")%>
                                value="True" id="LogErrors" name="LogErrors" class="stdNoWidth" size="4" /><br />
                        </td>
                    </tr>
                    <tr>
                        <td class="desc">
                            <%=Translate.Translate("Ved fejl forsøg igen efter (sekunder):", true)%>
                            <br />
                        </td>
                        <td>
                            <input type="text" onkeyup="chkNum(this);" value="<%=Base.GetGs("/Globalsettings/NLWI/ErrorTimeout")%>"
                                id="ErrorTimeout" name="ErrorTimeout" class="stdNoWidth" size="4" /><br />
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
            <dw:GroupBox ID="GroupBox3" runat="server" Title="Forbindelse" DoTranslation="true">
                <table width="100%">
                    <tr>
                        <td class="desc">
                            <%=Translate.Translate("Timeout på forbindelse:", true)%>
                            <br />
                        </td>
                        <td>
                            <input type="text" onkeyup="chkNum(this);" value="<%=Base.GetGs("/Globalsettings/NLWI/ConnectionTimeout")%>"
                                id="Text3" name="ConnectionTimeout" class="stdNoWidth" size="4" /><br />
                        </td>
                    </tr>
                    <tr>
                        <td class="desc">
                            <%=Translate.Translate("Connectionpooling:", true)%>
                            <br />
                        </td>
                        <td>
                            <input type="checkbox" <%=(Base.GetGs("/Globalsettings/NLWI/ConnectionPooling") == "True" ? "CHECKED" : "")%>
                                value="True" id="ConnectionPooling" name="ConnectionPooling" class="stdNoWidth"
                                size="4" /><br />
                        </td>
                    </tr>
                    <tr>
                        <td class="desc">
                            <%=Translate.Translate("KeepAlive:", true)%>
                            <br />
                        </td>
                        <td>
                            <input type="checkbox" <%=(Base.GetGs("/Globalsettings/NLWI/ConnectionKeepAlive") == "True" ? "CHECKED" : "")%>
                                value="True" id="ConnectionKeepAlive" name="ConnectionKeepAlive" class="stdNoWidth"
                                size="4" /><br />
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
            <table>
                <tr>
                    <td>
                        <%=Gui.Button(Translate.Translate("OK",true), "findCheckboxNames(this.form);OK_OnClick();", 90, false)%>
                    
                        <%=Gui.Button(Translate.Translate("Annuller", true), "location='../Modules.aspx';", 90, false)%>
                    </td>
                    <td width="2">
                    </td>
                </tr>
            </table>
            </form>
        </dw:TabPage>
        <dw:TabPage ID="t2" Title="Server" runat="server" EnableViewState="true">
            <form method="post" action="eCom_NAVIntegration.aspx" name="frmNAVConfig" id="frmNAVConfig">
            <input type="hidden" name="cmd" value="nav.config" />
            <dw:GroupBox ID="gbConnection" runat="server" Title="Forbindelse til NAV Application Manager" DoTranslation=true>
                <table width="100%">
                    <tr>
                        <td class="desc">
                            <%=Translate.Translate("Server URL:", true)%>
                        </td>
                        <td>
                            <input type="text" value="<%=NORRIQ.Configuration.NavConfig.Current.URL%>" id="URL"
                                name="URL" class="stdNoWidth" size="40" /><br />
                        </td>
                    </tr>
                    <tr>
                        <td class="desc">
                            <%=Translate.Translate("Server Port:", true)%>
                        </td>
                        <td>
                            <input type="text" onkeyup="chkNum(this);" value="<%=NORRIQ.Configuration.NavConfig.Current.PORT%>"
                                id="PORT" name="PORT" class="stdNoWidth" size="40" /><br />
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
            <table>
                <tr>
                    <td>
                       <%=Gui.Button(Translate.Translate("OK", true), "document.getElementById('frmNAVConfig').submit();", 90, false)%>
                       <%=Gui.Button(Translate.Translate("Annuller",true), "location='../Modules.aspx';", 90, false)%>
                    </td>
                    <td width="2">
                    </td>
                </tr>
            </table>
            </form>
        </dw:TabPage>
    </dw:TabControl>
</body>
<% Translate.GetEditOnlineScript(); %>