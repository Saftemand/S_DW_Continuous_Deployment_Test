<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RenameLead.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Leads.Details.RenameLead" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" runat="server" />
    <script type="text/javascript">
        function submitForm(params) {
            if ((params && params.Delete) && !confirm('<%=Backend.Translate.JsTranslate("Are you sure you want to delete this renamed lead?")%>')) {
                return;
            }
            $('renameLeadForm').request({
                method: 'post',
                parameters: params,
                onSuccess: function (transport) {
                    if (params) {
                        var company = document.getElementById("name").value;
                        if (params.Delete) {
                            company = document.getElementById("originalName").innerHTML;
                        }
                        if (company && company.length > 0) {
                            if (parent.document.getElementsByClassName("visitor-details-location-field-company").length > 0) {
                                var companyDiv = parent.document.getElementsByClassName("visitor-details-location-field-company")[0];
                                if (companyDiv && companyDiv.firstChild) {
                                    companyDiv.firstChild.innerHTML = company;
                                }
                            }
                        }
                    }                    
                    parent.dialog.hide('renameLeadPopup');
                }
             });
        }
    </script>
</head>
<body>
    <form id="renameLeadForm" runat="server">
    <asp:HiddenField ID="hdRenamedLeadID" runat="server" />
    <div>
        <br />
       <table>
           <tr>
                <td><dw:TranslateLabel runat="server" Text="Name:" /></td>
                <td><label runat="server" id="originalName" /></td>
            </tr>
            <tr>
                <td><dw:TranslateLabel runat="server" Text="New name:" /></td>
                <td><input type="text" class="NewUIinput" runat="server" id="name" />                   
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <dw:TranslateLabel runat="server" Text="The IP" />
                    <dw:Label ID="lblIP" runat="server" doTranslation="false"  />
                    <dw:TranslateLabel runat="server" Text="will appear in the list with this name in the future" />
                </td>
            </tr>
            <tr>
                <td></td>
                <td align="right">
                    <br />
                    <input type="button" runat="server" value="Clear" id="btnDelete" onclick="submitForm({ Delete: true });" />
                    <input type="button" runat="server" value="Save" onclick="submitForm({ Save: true });" />
                </td>
            </tr>
        </table>        
    </div>
    </form>
    <%Translate.GetEditOnlineScript()%>
</body>
</html>
