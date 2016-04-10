<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FolderEdit.aspx.vb" Inherits="Dynamicweb.Admin.FolderEdit" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ctrlResources" runat="server" />
    <script type="text/javascript">        
        function validateFields() {
            var element = document.getElementById('<%=newName.ClientID%>');
            if (element && (!element.value || element.value == "")) {
                alert('<%= Backend.Translate.JsTranslate("Folder name can not be empty.") %>');
                return false;
            }
            return true;
        }

        function onload() {            
            setTimeout(function () { document.getElementById('<%=newName.ClientID%>').focus() }, 100);            
        }
    </script>
</head>
<body onload="onload();">
    <form id="form1" runat="server">
    <div>
        <br />
        <table>
            <tr>
                <td><dw:TranslateLabel runat="server" Text="Folder name" /></td>
                <td ><input type="text" id="newName" runat="server" class="NewUIinput"  /></td>
            </tr>
            <tr>
                <td></td>
                <td align="right"><asp:Button ID="btnSave" runat="server" OnClientClick="return validateFields();" Text="Save" Width="50" /></td>
            </tr>
        </table>        
    </div>
    </form>
</body>
<%Translate.GetEditOnlineScript()%>
</html>
