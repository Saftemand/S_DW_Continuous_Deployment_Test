<%@ Page Language="vb" AutoEventWireup="false" Codebehind="FileLinkManager.aspx.vb" Inherits="Dynamicweb.Admin.FileLinkManager"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head runat="server" />
		<title></title>
        <dw:ControlResources ID="ControlResources1" runat="server" />
        			
        <script type="text/javascript">
            function ok() {
                var selValue = "";
                var elm = document.forms['linkForm'].elements['fileManagement'];

                if (elm) {
                     for (var i = 0; i < elm.length; i++) {
                        if (elm[i].checked) {
                            selValue = elm[i].value;
                        }
                    }
                }

                closeDialog(selValue);
            }

            function cancel() {
                closeDialog("");
            }

            function closeDialog(action) {
                var returnValue = {
                    action: action
                };
                if (parent.FilesWithReferences_wnd) {
                    parent.FilesWithReferences_wnd.returnValue = returnValue;
                    parent.FilesWithReferences_wnd.ok();
                } else {
                    window.returnValue = returnValue;
                    window.close();
                }
            }
			</script>
	</head>
	<body>
		<form id="linkForm" method="post" runat="server">
			<table border="0" cellspacing="0" cellpadding="0" width="100%">
				<asp:Label id="linkButtons" runat="server"></asp:Label>
			</table>
		</form>
	</body>
</html>
<%
Translate.GetEditOnlineScript()
%>
