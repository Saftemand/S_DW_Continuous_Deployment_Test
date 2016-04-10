<%@ Page EnableViewState="false" ValidateRequest="false" Language="vb" AutoEventWireup="false"
    Codebehind="PreviewMessageInBrowser.aspx.vb" Inherits="Dynamicweb.Admin.NewsLetterV3.PreviewMessageInBrowser" %>

<%@ Import Namespace="Dynamicweb.Backend" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Preview message in Browser</title>
    <link href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET" />

    <script type="text/javascript">
               
        function PreviewHMTLInFrame(strHTML) 
        {        
            var frm = document.forms["frmFrame"];
            var txtHTMLPreview = frm.elements["txtHTML"];
            txtHTMLPreview.value=strHTML;
            frm.submit();
        }
        
    </script>

</head>
<body style=" margin-top:10px; margin-bottom: 10px;" >
                    
    <form name="frmFrame" action="PreviewFrame.aspx" method="post" target="frameHTML">
        <input type="hidden" name="txtHTML" />
    </form>

    <form id="frm" runat="server">
        <dw:TabHeader ID="dwTabHeader" runat="server" />
        <table class="tabTable" id="Table1" cellpadding="0" width="100%" border="0">
            <tr id="trPreviewHTML" runat="server">
                <td valign="top" align="left">
                    <dw:GroupBoxStart ID="dwGroupBoxStartHTML" Title="HTML" runat="server" doTranslation="true" />
                    
                    <iframe name="frameHTML" id ="frameHTML" src="previewFrame.aspx" 
                        frameborder="0" width="98%" marginwidth="0px" scrolling="auto"
                        marginheight="0px" style="padding: 10px 0px 10px 10px;">
                    </iframe>
                    
                    <dw:GroupBoxEnd ID="dwGroupBoxEnd" runat="server" />
                </td>
            </tr>
            <tr id="trPreviewText" runat="Server">
                <td valign="top" align="left">
                    <dw:GroupBoxStart ID="dwGroupBoxStartText" Title="Text" runat="server" doTranslation="True" />
                    <div id="divText" runat="server" style="padding: 10px 10px 10px 10px;" />
                    <dw:GroupBoxEnd ID="GroupBoxEnd1" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="right" style="padding-right: 5px; padding-bottom: 5px;">
                    <input type="button" id="btnClose" runat="server" onclick="window.close();" class="buttonSubmit" />
                </td>
            </tr>
        </table>
        <%  Translate.GetEditOnlineScript() %>
    </form>
                    
</body>
</html>