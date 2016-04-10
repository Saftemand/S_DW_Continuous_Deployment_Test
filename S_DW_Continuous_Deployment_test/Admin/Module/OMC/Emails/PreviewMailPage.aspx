<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PreviewMailPage.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Emails.PreviewMailPage" %>
<%@ Import Namespace="Dynamicweb" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script type="text/javascript">
    function SelectVariant(variation) {
        document.getElementById("link1").className = "";
        document.getElementById("link2").className = "";

        document.getElementById("link" + variation).className = "active";

        var isVariant = variation == '1' ? false : true;

        var url = document.getElementById("testurl").value + '&variant=' + isVariant;
        document.getElementById("ifSplirPreview").src = url;
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head2" runat="server">
    <title>
        <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Preview" />
    </title>
</head>
<body>
    <form action="">
        <input type="hidden" id="testurl" value="/Admin/Module/OMC/Emails/PreviewMailPage.aspx?emailId=<%=Dynamicweb.Input.Request("emailId") %>&userId=<%=Dynamicweb.Input.Request("userId") %>" />
        <input type="hidden" id="hdHasSplitTest" value="False" runat="server" />
    </form>
    <%If Base.ChkBoolean(hdHasSplitTest.Value) Then%>
    <div class="header" id="splitHeader" runat="server">
        <h1 runat="server" id="previewHeading">
        </h1>
        <a href="javascript:SelectVariant('1');" class="active" id="link1"><%= Dynamicweb.Backend.Translate.Translate("Original")%></a>
        <a href="javascript:SelectVariant('2');" class="" id="link2"><%= Dynamicweb.Backend.Translate.Translate("Variants")%></a>
    </div>
    <%End If%>
    <div style="position: fixed; top: 43px; bottom: 0px; right: 0px; left: 0px;">
        <iframe id="ifSplirPreview" src="/Admin/Module/OMC/Emails/PreviewMailPage.aspx?emailId=<%=Dynamicweb.Input.Request("emailId") %>&userId=<%=Dynamicweb.Input.Request("userId") %>&variant=false" style="border: 0; width: 100%; height: 100%;"></iframe>
    </div>
</body>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
