<%@ Page Language="vb" AutoEventWireup="false" Codebehind="EcomRounding_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.RoundingEdit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR"/>
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE"/>
		<meta content="JavaScript" name="vs_defaultClientScript"/>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css"/>
		<script type="text/javascript" src="/Admin/Module/eCom_Catalog/dw7/images/AjaxAddInParameters.js"></script>
		
			<dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
		<link rel="STYLESHEET" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
		
		<style type="text/css">
		body.margin {
			margin-top: 0px;
			margin-left: 0px;
			margin-right: 0px;
			margin-bottom: 0px;
			
		}
		
		input,select,textarea {font-size: 11px; font-family: verdana,arial;}
		</style>		

        <script type="text/javascript">
		    strHelpTopic = 'ecom.controlpanel.rounding.edit';

		    $(document).observe('dom:loaded', function () {
		        window.focus(); // for ie8-ie9 
		        document.getElementById('Name').focus();
		    }); 

		    function testRounding() {
		        var amount = document.getElementById("TestAmount");
		        if (amount && amount.value != "") {
    		    
		            var testBool = true;
                    var validChars 	= "0123456789.,-+ ";

                    for (var i = 0; i < amount.value.length; i++) {
                        if (validChars.indexOf(amount.value.charAt(i)) == -1) {
                            testBool = false;
                            break;
                        }
                    }

		            if (testBool) {
		                var button = document.getElementById("roundButton");
		                if (button) {
		                    button.disabled = true;
		                }
		                getRoundingResult("<%=roundId%>", amount.value);
		            } else {
		                alert('<%=Translate.JsTranslate("Værdi skal et valid tal!")%>');
		            }     
    		        
		        }
		    }
		    function save(close) {
		        document.getElementById("Close").value = close ? 1 : 0;
		        document.getElementById('Form1').SaveButton.click();
		    }
		</script>
		
		<script type="text/javascript" src="/Admin/FileManager/FileManager_browse2.js" ></script>
	    <script type="text/javascript" src="/Admin/FormValidation.js"></script>
	</HEAD>
	
	<body MS_POSITIONING="GridLayout" style="background: #DFE9F5 url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;">
	
    	<asp:Literal id="BoxStart" runat="server"></asp:Literal>
		<form id="Form1" method="post" runat="server">
            <input id="Close" type="hidden" name="Close" value="0" />
        	<dw:TabHeader id="TabHeader1" runat="server" TotalWidth="100%"></dw:TabHeader>
	
		    <table class="tabTable100" id="DW_Ecom_tableTab">
		        <tr>
		            <td valign="top">
	        			<div id="Tab1">
			                
			                <div style="height:5px"></div>

                            <fieldset style='width: 95%;margin:5px;'><legend class=gbTitle><%=Translate.Translate("Indstillinger")%></legend>
                                <table cellpadding=2 cellspacing=2 style="width:100%;">
                                    <tr>
                                        <td width="170">
                                            <dw:TranslateLabel id="tLabelName" runat="server" Text="Navn"></dw:TranslateLabel>
                                        </td>
                                        <td>
                                            <div id="errName" style="color: Red;">
                                                <asp:Literal ID="Literal_errName" runat="server"></asp:Literal>
                                            </div>
                                            <asp:textbox id="Name" CssClass="NewUIinput" runat="server"></asp:textbox>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td width="170"><dw:TranslateLabel id="tLabelMethod" runat="server" Text="Metode"></dw:TranslateLabel></td>
                                        <td><asp:DropDownList id="Method" CssClass="NewUIinput" runat="server" ></asp:DropDownList></asp:textbox></td>
                                    </tr>

                                    <tr>
                                        <td width="170"><strong><%=Translate.Translate("Heltal")%></strong></td>
                                    </tr>
                                    
                                    <tr>
                                        <td width="170"><dw:TranslateLabel id="tLabelModIntegerPart" runat="server" Text="Faktor" /></td>
                                        <td>
                                            <div id="errModIntegerPart" style="color: Red;">
                                                <asp:Literal ID="Literal_errModIntegerPart" runat="server"></asp:Literal>
                                            </div>
                                            <asp:textbox id="ModIntegerPart" CssClass="NewUIinput" runat="server"></asp:textbox>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td width="170"><dw:TranslateLabel id="tLabelModIntegerCorrection" runat="server" Text="Tillæg" /></td>
                                        <td>
                                            <div id="errModIntegerCorrection" style="color: Red;">
                                                <asp:Literal ID="Literal_errModIntegerCorrection" runat="server"></asp:Literal>
                                            </div>
                                            <asp:textbox id="ModIntegerCorrection" CssClass="NewUIinput" runat="server"></asp:textbox>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td width="170"><strong><%=Translate.Translate("Decimaltal")%></strong></td>
                                    </tr>
                                    
                                    <tr>
                                        <td width="170"><dw:TranslateLabel id="tLabelModDecimalPart" runat="server" Text="Faktor" /></td>
                                        <td>
                                            <div id="errModDecimalPart" style="color: Red;">
                                                <asp:Literal ID="Literal_errModDecimalPart" runat="server"></asp:Literal>
                                            </div>
                                            <asp:textbox id="ModDecimalPart" CssClass="NewUIinput" runat="server"></asp:textbox>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td width="170"><dw:TranslateLabel id="tLabelModDecimalCorrection" runat="server" Text="Tillæg" /></td>
                                        <td>
                                            <div id="errModDecimalCorrection" style="color: Red;">
                                                <asp:Literal ID="Literal_errModDecimalCorrection" runat="server"></asp:Literal>
                                            </div>
                                            <asp:textbox id="ModDecimalCorrection" CssClass="NewUIinput" runat="server"></asp:textbox>
                                        </td>
                                    </tr>
                                    
                                    <tr>
                                        <td width="170"><dw:TranslateLabel id="tLabelDecimals" runat="server" Text="Antal decimaler"></dw:TranslateLabel></td>
                                        <td>
                                            <div id="errDecimals" style="color: Red;">
                                                <asp:Literal ID="Literal_errDecimals" runat="server"></asp:Literal>
                                            </div>
                                            <asp:textbox id="Decimals" CssClass="NewUIinput" runat="server"></asp:textbox>
                                        </td>
                                    </tr>
        					    </table>
                            </fieldset>
                            
                            <div style="height:10px"></div>

                            <asp:Literal id="RoundintTest" runat="server"></asp:Literal>				

			                <asp:Button id="SaveButton" style="display:none;" runat="server"></asp:Button>
			                <asp:Button id="DeleteButton" style="display:none;" runat="server"></asp:Button>
		                </div>
		
		            </td>
		        </tr>
		    </table>

	    </form>

        <asp:Literal id="BoxEnd" runat="server"></asp:Literal>

	    <!--<script>
            addMinLengthRestriction('Name', 1, '<%=Translate.JsTranslate("A name is needed")%>');
            addMinValueRestriction('ModIntegerPart', 1, '<%=Translate.JsTranslate("This is a invalid value")%>');
            addNumericRestriction('ModIntegerPart', '<%=Translate.JsTranslate("This has to be a numerical value")%>');
            addNumericRestriction('ModIntegerCorrection', '<%=Translate.JsTranslate("This has to be a numerical value")%>');
            addMinValueRestriction('ModDecimalPart', 1, '<%=Translate.JsTranslate("This is a invalid value")%>');
            addNumericRestriction('ModDecimalPart', '<%=Translate.JsTranslate("This has to be a numerical value")%>');
            addNumericRestriction('ModDecimalCorrection', '<%=Translate.JsTranslate("This has to be a numerical value")%>');
            addMinMaxValueRestriction('Decimals', 0, 10, '<%=Translate.JsTranslate("This is a invalid value")%>');
            activateValidation('Form1');
        </script>-->
    </body>
</HTML>

<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>