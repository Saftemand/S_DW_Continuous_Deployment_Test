<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="WorkflowPopup.aspx.vb" Inherits="Dynamicweb.Admin.WorkflowPopup" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="True" runat="server" />
</head>
<body style="height: auto">
    <table cellpadding="2" cellspacing="0" border="0" width="100%" id="Table13">
        <tr>
            <td width="100%" valign="top">

                <script>
                    function checkAll(chkValue)
                    {
                        theForm = document.forms.vc;

                        if(theForm.elements["PageID"])
                        {
                            if(!theForm.elements["PageID"].length)
                                theForm.elements["PageID"].checked = chkValue;

                            for(var i = 0; i < theForm.elements["PageID"].length; i++)
                                theForm.elements["PageID"][i].checked = chkValue;
                        }
                    }

                    function Approve()
                    {
                        if(document.forms.vc)
                        {
                            theForm = document.forms.vc;
                            theForm.submit();
                        }
                    }
                </script>

                <style>
                    form {
                        margin: 0px;
                        padding: 0px;
                    }
                </style>
                <%=Gui.GroupBoxStart(Translate.Translate("Pages awaiting approval"))%>&nbsp;
					<asp:Literal runat="server" ID="WorkflowMypage"></asp:Literal>
                <%=Gui.GroupBoxEnd%>
            </td>
        </tr>
        <tr>
            <td align="right">
                <asp:Literal runat="server" ID="WorkflowMypageApproveButton"></asp:Literal>
            </td>
        </tr>
        <!-- Override Options BY RAP 9/11-05 -->
        <%If Base.ChkNumber(Session("DW_Admin_UserType")) <= 3 Then%>
        <tr>
            <td width="100%" valign="top" style="padding-top: 20px;">

                <script>
                    function checkAll(chkValue)
                    {
                        theForm = document.forms.vcOverride;

                        if(theForm.elements["PageID"])
                        {
                            if(!theForm.elements["PageID"].length)
                                theForm.elements["PageID"].checked = chkValue;

                            for(var i = 0; i < theForm.elements["PageID"].length; i++)
                                theForm.elements["PageID"][i].checked = chkValue;

                        }
                    }

                    function ApproveOverride()
                    {
                        if(document.forms.vcOverride)
                        {
                            theForm = document.forms.vcOverride;
                            theForm.submit();
                        }
                    }
                </script>

                <style type="text/css">
                    form {
                        margin: 0px;
                        padding: 0px;
                    }
                </style>
                <%=Gui.GroupBoxStart(Translate.Translate("Procedureadministration"))%>
                <asp:Literal runat="server" ID="Procedureadministration"></asp:Literal>
                <%=Gui.GroupBoxEnd%>
            </td>
        </tr>
        <tr runat="server" id="HavePagesForApprovalRow" visible="false">
            <td align="right">
                <table cellpadding="2" cellspacing="0">
                    <tr>
                        <td align="right">
                            <%=Gui.Button(Translate.Translate("Næste %%", "%%", Translate.Translate("trin")), "document.getElementById('publish').value = 'false';ApproveOverride();", 0)%>
                        </td>
                        <td align="right">
                            <%=Gui.Button(Translate.Translate("Strakspublicer"), "document.getElementById('publish').value = 'true';ApproveOverride();", 0)%>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <%End If%>
    </table>
</body>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
