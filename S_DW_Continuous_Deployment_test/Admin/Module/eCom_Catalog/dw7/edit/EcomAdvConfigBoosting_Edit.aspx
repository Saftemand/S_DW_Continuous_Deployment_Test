<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" CodeBehind="EcomAdvConfigBoosting_Edit.aspx.vb" Inherits="Dynamicweb.Admin.EcomAdvConfigBoosting_Edit" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb" %>


<asp:Content ContentPlaceHolderID="HeadContent" runat="server" >
    <script language="javascript" type="text/javascript">
        var page = SettingsPage.getInstance();
        page.onSave = function () {
            document.getElementById('MainForm').submit();
        }

        page.onHelp = function () {
            <%=Gui.help("", "administration.controlpanel.ecom.boosting") %>
        }

        function ChkValidNum(field) {
            var newValue = '';
            for (i = 0; i < field.value.length; i++) {
                if ((!isNaN(field.value.charAt(i)) || field.value.charAt(i) == '.' || field.value.charAt(i) == ',') && field.value.charAt(i) != ' ') {
                    newValue += field.value.charAt(i);
                }
            }
            field.value = (newValue >= 1 )? newValue : 1;
        }

        function disableBoosting(field) {
            document.getElementById("boostingFields").style.display = field.checked ? "" : "none";
        }
    </script>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server" >
    <%=Gui.GroupBoxStart(Translate.Translate("Boosting"))%>
        <table class="fieldsTable">
            <colgroup><col width="170px"/><col/></colgroup>
            <tr>
                <td><label for="/Globalsettings/Ecom/Boosting/EnableBoosting"><%=Translate.Translate("Enable boosting")%></label></td>
                <td><input type="checkbox" 
                    value="True"
                    id ="/Globalsettings/Ecom/Boosting/EnableBoosting" 
                    onchange ="disableBoosting(this)"
                    <%=IIf(Base.GetGs("/Globalsettings/Ecom/Boosting/EnableBoosting") = "True", "CHECKED", "")%>
                    name ="/Globalsettings/Ecom/Boosting/EnableBoosting" />
                </td></tr>
	    </table>
        <table class="fieldsTable" id="boostingFields" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Boosting/EnableBoosting") = "True", "", "style=""display:none""")%>>
            <colgroup><col width="170px"/><col/></colgroup>
            <%=GetBoostingFields() %>
	    </table>
        <table class="fieldsTabe">
            <tr>
                <td colspan="2">
				    <div style="color:Gray">				                        
				        <%=Translate.Translate("Boosting allows you to rank the importance of the fields that search words appear in.")%>
					</div>		
		        </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div style="color:Gray">				                        
				        <%=Translate.Translate("In order to rank name matches higher than description matches enter a higher value for product name. Use a spread like 5,10,15 etc.")%>
					</div>	
                </td>
            </tr>
        </table>
    <%=Gui.GroupBoxEnd%>

    <% Translate.GetEditOnlineScript() %>

</asp:Content>

