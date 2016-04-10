<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EcomVatGrp_Edit.aspx.vb"
    Inherits="Dynamicweb.Admin.eComBackend.EcomVatGrp_Edit" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
    <meta name="vs_defaultClientScript" content="JavaScript">
    <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
    <link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true"
        runat="server" />
    <link rel="STYLESHEET" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
    <style type="text/css">
        BODY.margin
        {
            margin: 0px;
        }
        input, select, textarea
        {
            font-size: 11px;
            font-family: verdana,arial;
        }
    </style>

    <script type="text/javascript">

        $(document).observe('dom:loaded', function () {
            window.focus(); // for ie8-ie9 
            document.getElementById('NameStr').focus();
        }); 

	function getVat() {
		if (VatFees.innerHTML == "") {
		    FillLayer("");
		    document.body.style.cursor = "wait";
			EcomUpdator.document.location.href = "EcomUpdator.aspx?CMD=ShowVATFees&ID=<%=vg.ID%>&LangID=<%=langId%>";	
		}	
	}

	function FillLayer(fill) {
	    var fillStr = '<asp:Literal id="LoadBlock" runat="server"></asp:Literal>';

		if (fill != "") {
	        document.body.style.cursor = "default";
			fillStr = fill;
		}	
		
		VatFees.innerHTML = fillStr;
	}

	function saveVat(close) {
	    document.getElementById('Close').value = close ? 1 : 0;
	    document.getElementById('Form1').SaveButton.click();
	}

	var deleteMsg = '<%= DeleteMessage %>';
	function deleteVat() {
	    if (confirm(deleteMsg)) document.getElementById('Form1').DeleteButton.click();
	}

	function validationError() {
	    //switch to default tab
	    Tabs.tab(1);
    }
    </script>

    <script language="JavaScript">
		strHelpTopic = 'ecom.controlpanel.salestax.edit';
		function TabHelpTopic(tabName) {
			switch(tabName) {
				case 'GENERAL':
					strHelpTopic = 'ecom.controlpanel.salestax.edit.general';
					break;
				case 'RATES':
					strHelpTopic = 'ecom.controlpanel.salestax.edit.rates';
					getVat();
					break;
				default:
					strHelpTopic = 'ecom.controlpanel.salestax.edit';
			}
		}

		function switchVatGroupType(radio) {
		    if (radio.id == "toggleAddInsDefault") {
		        document.getElementById('ConfigurableVatProviders').style.display = 'none';
		        document.getElementById('Tab2_head').style.display = 'inline';
		    }
		    else {
		        document.getElementById('ConfigurableVatProviders').style.display = 'block';
		        document.getElementById('Tab2_head').style.display = 'none';
		    }
		}
    </script>

    <script language="javascript" src="/Admin/FormValidation.js"></script>

    <%=VatProviderAddIn.Jscripts%>

</head>
<body ms_positioning="GridLayout" style="background: #DFE9F5 url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;">
    <asp:Literal ID="BoxStart" runat="server" />
    <form id="Form1" method="post" runat="server">
    <asp:Literal ID="NoVatExistsForLanguageBlock" runat="server"></asp:Literal>
    <dw:TabHeader ID="TabHeader1" runat="server" TotalWidth="100%" />
    <table border="0" cellpadding="0" cellspacing="0" class="tabTable100" id="DW_Ecom_tableTab">
        <tr>
            <td valign="top">
                <div id="Tab1" style="display: ;">
                    <br>
                        <table border="0" cellpadding="0" cellspacing="0" width='95%' style='width: 95%;'>
                            <tr>
                                <td>
                                    <fieldset style='width: 100%; margin: 5px;'>
                                        <legend class="gbTitle">
                                            <%=Translate.Translate("Indstillinger")%>&nbsp;</legend>
                                        <table border="0" cellpadding="2" cellspacing="0" width='100%' style='width: 100%;'>
                                            <tr>
                                                <td>
                                                    <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                                        <tr>
                                                            <td width="170">
                                                                <dw:TranslateLabel ID="tLabelName" runat="server" Text="Navn" />
                                                            </td>
                                                            <td>
                                                                <div id="errNameStr" name="errNameStr" style="color: Red;">
                                                                </div>
                                                                <asp:TextBox ID="NameStr" CssClass="NewUIinput" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="170">
                                                                <dw:TranslateLabel ID="tLabelVatName" runat="server" Text="Egennavn" />
                                                            </td>
                                                            <td>
                                                                <div id="errVatNameStr" name="errVatNameStr" style="color: Red;">
                                                                </div>
                                                                <asp:TextBox ID="VatNameStr" CssClass="NewUIinput" runat="server" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                        <table>
                                            <tr>
                                                <td width="170">
                                                    <dw:TranslateLabel ID="tLabelType" runat="server" Text="Type" />
                                                </td>
                                                <td>
                                                    <input runat="server" type="radio" name="toggleAddIns" id="toggleAddInsDefault" onclick="switchVatGroupType(this);" />
                                                    <label for="toggleAddInsDefault"><dw:TranslateLabel ID="tLabelAddInDefault" runat="server" Text="Default" /></label>
                                                    <br />
                                                    <input runat="server" type="radio" name="toggleAddIns" id="toggleAddInsProvider" onclick="switchVatGroupType(this);" />
                                                    <label for="toggleAddInsProvider"><dw:TranslateLabel ID="tLabelAddInProvider" runat="server" Text="Provider" /></label>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                    <br />
                                    <asp:Panel runat="server" ID="ConfigurableVatProviders" style="display: none;">
										<br />
										<de:AddInSelector 
											runat="server" 
											ID="VatProviderAddin" 
											AddInGroupName="Configurable VAT Provider" 
											AddInTypeName="Dynamicweb.eCommerce.Prices.ConfigurableVatProvider"
											/>
									</asp:Panel>
                                </td>
                            </tr>
                        </table>
                        <br>
                        <asp:Button ID="SaveButton" Style="display: none;" runat="server" />
                        <asp:Button ID="DeleteButton" Style="display: none;" runat="server" />
                        <input type="hidden" name="Close" id="Close" value="0" />
                </div>
                <div id="Tab2" style="display: none;">
                    <div id="VatFees"></div>
                </div>
            </td>
        </tr>
    </table>

	<asp:Literal runat="server" ID="LoadParametersScript"></asp:Literal>                            

    </form>
    <asp:Literal ID="BoxEnd" runat="server" />
    <iframe frameborder="0" name="EcomUpdator" id="EcomUpdator" width="1" height="1"
        align="right" marginwidth="0" marginheight="0" src="EcomUpdator.aspx" border="0">
    </iframe>

    <script type="text/javascript">
        addMinLengthRestriction('NameStr', 1, '<%=Translate.JsTranslate("A name needs to be specified")%>');
        addMinLengthRestriction('VatNameStr', 1, '<%=Translate.JsTranslate("A vat-name needs to be specified")%>');
        activateValidation('Form1');
    </script>

</body>
</html>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>