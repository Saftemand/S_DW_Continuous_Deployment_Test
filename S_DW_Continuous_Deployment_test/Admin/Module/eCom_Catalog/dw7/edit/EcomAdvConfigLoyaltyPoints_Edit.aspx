<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" CodeBehind="EcomAdvConfigLoyaltyPoints_Edit.aspx.vb" Inherits="Dynamicweb.Admin.EcomAdvConfigLoyaltyPoints_Edit" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb" %>


<asp:Content ContentPlaceHolderID="MainContent" runat="server" >
    <script language="javascript" type="text/javascript">
        var page = SettingsPage.getInstance();
        page.onSave = function () {
            document.getElementById('MainForm').submit();
        }

        page.onHelp = function () {
            <%=Gui.help("", "administration.controlpanel.ecom.loyaltypoints") %>
        }

        function ChkValidNum(field) {
            var newValue = '';
            for (i = 0; i < field.value.length; i++) {
                if (!isNaN(field.value.charAt(i)) && field.value.charAt(i)!=' ') {
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
                    <input type="text" class="std" onkeyup="ChkValidNum(this);" value="<%=Base.GetGs("/Globalsettings/Ecom/LoyaltyPoints/ExpirationPeriodInMonths")%>"
                        id="/Globalsettings/Ecom/LoyaltyPoints/ExpirationPeriodInMonths" name="/Globalsettings/Ecom/LoyaltyPoints/ExpirationPeriodInMonths"/> <br/>
                    <small class="remark"> 0 - <%= Translate.Translate("Loyalty points do not expire")%></small>
			    </td>
		    </tr>
            <tr>
				<td><%=Translate.Translate("Disallow reward points from products purchased with loyalty points")%></td>
				<td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/LoyaltyPoints/DisallowEarnPointsFromPoints") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/LoyaltyPoints/DisallowEarnPointsFromPoints" name="/Globalsettings/Ecom/LoyaltyPoints/DisallowEarnPointsFromPoints" /></td>
			</tr>
	    </table>
    <%=Gui.GroupBoxEnd%>
</asp:Content>

