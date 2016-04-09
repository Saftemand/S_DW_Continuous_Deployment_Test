<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" CodeBehind="GiftCardsAdvancedSettings.aspx.vb" Inherits="Dynamicweb.Admin.GiftCards.GiftCardsAdvancedSettings" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb" %>


<asp:Content ContentPlaceHolderID="MainContent" runat="server" >
    <script language="javascript" type="text/javascript">
        var page = SettingsPage.getInstance();
        page.onSave = function () {
            var expirationInput = $('/Globalsettings/Ecom/GiftCards/ExpirationPeriod');
            if (parseInt(expirationInput.value) <= 0) {
                expirationInput.value = '30';
            }
            document.getElementById('MainForm').submit();
        }

        page.onHelp = function () {
            <%=Gui.help("", "administration.managementcenter.eCommerce.orders.giftcards") %>
        }

        function ChkValidNum(field) {
            var newValue = '';
            for (i = 0; i < field.value.length; i++) {
                if (!isNaN(field.value.charAt(i)) && field.value.charAt(i) != ' ') {
                    newValue += field.value.charAt(i);
                }
            }
            field.value = newValue;
        }
    </script>

    <%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
        <table class="fieldsTable">
		    <tr>
			    <td>
                    <%= Translate.Translate("Expiration period (in months)")%>
			    </td>
			    <td>
                    <input type="text" class="std" onkeyup="ChkValidNum(this);" value="<%=Base.GetGs("/Globalsettings/Ecom/GiftCards/ExpirationPeriod")%>"
                        id="/Globalsettings/Ecom/GiftCards/ExpirationPeriod" name="/Globalsettings/Ecom/GiftCards/ExpirationPeriod"/> <br/>                    
			    </td>
		    </tr>
	    </table>
    <%=Gui.GroupBoxEnd%>
</asp:Content>