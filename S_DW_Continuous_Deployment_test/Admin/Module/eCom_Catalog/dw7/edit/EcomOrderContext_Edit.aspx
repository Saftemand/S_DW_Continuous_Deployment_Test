<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EcomOrderContext_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomOrderContext_Edit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
	<link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
	<script type="text/javascript" src="/Admin/FormValidation.js"></script>

    <script type="text/javascript">
        var contexts = <%=ExistingOrderContexts%>;

        $(document).observe('dom:loaded', function () {
            window.focus(); // for ie8-ie9 
            document.getElementById('NameStr').focus();
        });

        function saveOrderContext(close) {
            if (!validateSystemName()) {
                return;
            }

            $("Close").value = close ? 1 : 0;
            $('Form1').SaveButton.click();
        }

        function validateSystemName() {
            if (contexts.indexOf($('IdStr').value.toLowerCase()) >= 0){
                $('errIdStr').innerHTML = '<%=Translate.Translate("The id should be unique")%>';
                return false;
            }

            return true;
        }

        function onAfterEditSystemName(input) {
            if (input) {
                input.value = makeSystemName(input.value);
            }
        }

        function makeSystemName(name) {
            var ret = name;

            if (ret && ret.length) {
                ret = ret.replace(/[^0-9a-zA-Z_\s]/gi, '_'); // Replacing non alphanumeric characters with underscores
                while (ret.indexOf('_') == 0) ret = ret.substr(1); // Removing leading underscores

                ret = ret.replace(/\s+/g, ' '); // Replacing multiple spaces with single ones
                ret = ret.replace(/\s([a-z])/g, function (str, g1) { return g1.toUpperCase(); }); // Camel Casing
                ret = ret.replace(/\s/g, '_'); // Removing spaces

                if (ret.length > 1) ret = ret.substr(0, 1).toUpperCase() + ret.substr(1); else ret = ret.toUpperCase();
            }

            return ret;
        }

    </script>
</head>
<body>
	<asp:Literal id="BoxStart" runat="server"></asp:Literal>
    <form id="Form1" runat="server">
        <table border="0" cellpadding="2" cellspacing="2" width='95%' style='width:95%; background-color: #FFFFFF;'>
			<tr>
				<td>
					<fieldset style='width: 100%; margin: 5px;'>
                        <legend class="gbTitle"><dw:TranslateLabel Text="Order context" runat="server" /></legend>
						<table border="0" cellpadding="2" cellspacing="2" width='100%' style='width:100%'>
							<tr>
								<td>
									<table border="0" cellpadding="2" cellspacing="2" width="100%">
										<tr>
											<td width="100"><dw:TranslateLabel id="tLabelId" runat="server" Text="Id" /></td>
											<td>
				                                <div id="errIdStr" style="color: Red;"></div>
				                                <asp:textbox width="170" id="IdStr" MaxLength="50" CssClass="NewUIinput" onblur="onAfterEditSystemName(this);" runat="server" />
				                            </td>
										</tr>
										<tr>
											<td width="100"><dw:TranslateLabel id="tLabelName" runat="server" Text="Navn" /></td>
											<td>
				                                <div id="errNameStr" style="color: Red;"></div>
				                                <asp:textbox width="170" id="NameStr" MaxLength="255" CssClass="NewUIinput" runat="server" />
				                            </td>
										</tr>
										<tr>
											<td style="vertical-align:top"><dw:TranslateLabel id="tLabelShops" runat="server" Text="Shops" /></td>
											<td>
                                                <asp:CheckBoxList id="ShopList" runat="server"></asp:CheckBoxList>
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

  	    <asp:Button id="SaveButton" style="display:none" UseSubmitBehavior="true" runat="server"></asp:Button>
	    <asp:Button id="DeleteButton" style="display:none" UseSubmitBehavior="true" runat="server"></asp:Button>
        <input id="Close" type="hidden" name="Close" value="0" />
    </form>
	<asp:Literal id="BoxEnd" runat="server"></asp:Literal>

	<script type="text/javascript">
	    addMinLengthRestriction('IdStr', 1, '<%=Translate.JsTranslate("A ID is needed")%>');
	    addMinLengthRestriction('NameStr', 1, '<%=Translate.JsTranslate("A name is needed")%>');
	    activateValidation('Form1');
    </script>

    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</body>
</html>
