<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Cart_cpl.aspx.vb" Inherits="Dynamicweb.Admin.Cart_cpl" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css" />
    <title>
        <%=Translate.JsTranslate("Indkøbskurv",9)%>
    </title>
</head>
<body>

    <script type="text/javascript">
	function OK_OnClick() {
		document.frmGlobalSettings.IsSubmit.value = "True";
		document.frmGlobalSettings.ValueToEncrypt.disabled = true;
		document.frmGlobalSettings.submit();
	}

	function findCheckboxNames(form) {
		var _names="";
		for(var i=0; i < form.length ; i++) {
			if(form[i].name!=undefined) {
				if(form[i].type=="checkbox") {
					_names = _names + form[i].name + "@"
				}
			}
		}
	form.CheckboxNames.value=_names;
	}
    </script>

    <%=Gui.MakeHeaders(Translate.Translate("Kontrol Panel - %%","%%",Translate.Translate("Indkøbskurv",9)),Translate.Translate("Konfiguration"), "all")%>
    <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
        <form method="post" title="frmGlobalSettings" id="frmGlobalSettings" runat="server">
            <input type="hidden" name="CheckboxNames" />
            <input type="hidden" name="IsSubmit" value="False" />
            <tr>
                <td valign="top">
                    <%=Gui.MakeModuleHeader("Cart", "Indkøbskurv", False)%>
                    <%=Gui.GroupBoxStart(Translate.Translate("Priser"))%>
                    <table cellpadding="2" cellspacing="0" border="0">
                        <tr>
                            <td style="width: 170px;">
                                <%=Translate.Translate("Beregn moms")%>
                            </td>
                            <td>
                                <input type="checkbox" value="True" id="VAT" name="/Globalsettings/Modules/Cart/VAT"
                                    runat="server" /></td>
                        </tr>
                        <tr>
                            <td style="width: 170px;">
                                <%=Translate.Translate("Krypter Price parameter")%>
                            </td>
                            <td>
                                <input type="checkbox" value="True" id="EncryptPriceParameter" name="/Globalsettings/Modules/Cart/EncryptPriceParameter"
                                    runat="server" /></td>
                        </tr>
                        <tr>
                            <td style="width: 170px;">
                                <%=Translate.Translate("Krypteringsnøgle")%>
                            </td>
                            <td>
                                <input type="text" class="std" id="EncryptionKey" name="/Globalsettings/Modules/Cart/EncryptionKey"
                                    runat="server" /></td>
                        </tr>
                        <!--tr>
                            <td style="width: 170px;"><%=Translate.Translate("Krypter værdi")%></td>
                            <td><input type="text" runat="server" id="ValueToEncrypt" name="ValueToEncrypt" class="std" /><asp:button ID="ButtonEncrypt" runat="server" CssClass="std" Width="75px" Height="17px" style="margin-left: 5px;" /></td>
                        </tr-->
                    </table>
                    <%=Gui.GroupBoxEnd%>
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td align="right" valign="bottom">
                                <table>
                                    <tr>
                                        <td>
                                            <%=Gui.Button(Translate.JSTranslate("OK"), "findCheckboxNames(this.form);OK_OnClick();", "90")%>
                                        </td>
                                        <td>
                                            <%=Gui.Button(Translate.Translate("Annuller"), "location='ControlPanel.aspx';", "90")%>
                                        </td>
                                        <%=Gui.HelpButton("", "administration.controlpanel.cart")%>
                                        <td style="width: 2px;">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </form>
    </table>
    <%
        Translate.GetEditOnlineScript()
    %>
</body>
</html>
