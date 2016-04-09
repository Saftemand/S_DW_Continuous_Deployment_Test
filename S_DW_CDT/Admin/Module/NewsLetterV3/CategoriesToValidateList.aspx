<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CategoriesToValidateList.aspx.vb"
    Inherits="Dynamicweb.Admin.NewsLetterV3.CategoriesToValidateList" EnableViewState="true" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Check emails</title>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" runat="server"></dw:ControlResources>
    <link rel="stylesheet" href="css/main.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Stylesheet.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Module/Common/Stylesheet.css" />
    <script type="text/javascript">

        function validate() {
            $('btnValidate').click();
        }

        function help() {
		    <%=Gui.Help("newsletterv3", "modules.newsletterv3.general.email.check")%>
	    }

    </script>
</head>
<body>
    <div id="containerNewsletter">
        <form id="form1" runat="server" class="formNewsletter">
            <dw:Toolbar ID="ValidateToolBar" runat="server" ShowStart="true" ShowEnd="false">
                <dw:ToolbarButton ID="tbValidate" runat="server" OnClientClick="validate();" Image="Check" Text="Validate">
                </dw:ToolbarButton>
                <dw:ToolbarButton ID="tbHelp" runat="server" OnClientClick="help();" Image="Help" Text="Help">
                </dw:ToolbarButton>
            </dw:Toolbar>
             <div class="list">
                <table width="100%" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="title">
                            <%=GetBreadcrumb() %>
                        </td>
                    </tr>
                </table>
            </div>
            <table class="tabTable" id="Table1" cellpadding="0" width="100%" border="0">
                <tr>
                    <td valign="top">
                        <dw:GroupBoxStart ID="dwGroupBoxStartCategories" Title="Categories" runat="server"
                            doTranslation="True" />
                        <div id="divNoCategoriesFound" runat="server" style="padding: 10px 0px 10px 10px;">
                            <dw:TranslateLabel ID="dwTrans1" runat="server" Text="No categories found" />
                        </div>
                        <asp:DataList ID="dlCategories" runat="server" RepeatColumns="2" EnableViewState="True"
                            CellPadding="3">
                            <ItemTemplate>
                                    <label class="checkbox"><input runat="server" id="chkCategories" type="checkbox" value='<%#DataBinder.Eval(Container.DataItem,"ID")%>'
                                        checked="checked" />&nbsp;<%#DataBinder.Eval(Container.DataItem,"Name")%></label>
                                &nbsp;&nbsp;&nbsp;
                            </ItemTemplate>
                        </asp:DataList>
                        <dw:GroupBoxEnd ID="dwGroupBoxEnd" runat="server" />
                            <label class="checkbox"  style="padding-left: 10px;"><input type="checkbox" id="chkUnsubscribed" runat="server" />
                            <dw:TranslateLabel Text="Include recipients w/o subscription" ID="dwTrans3" runat="server" />
                        </label>
                        <dw:GroupBoxStart ID="gbCheckingMethodStart" DoTranslation="true" Title="Checking method" runat="server"/>
                        <label class="checkbox"  style="padding-left: 10px;">
                            <input type="radio" id="checkMethod1" name="checkMethod" value="SMTP" checked="checked"/>
                            <dw:TranslateLabel Text="Check only e-mail server existence" ID="TranslateLabel2" runat="server" />
                        </label>
                        <label class="checkbox"  style="padding-left: 10px;">
                            <input type="radio" id="checkMethod2" name="checkMethod" value="Mailbox"/>
                            <dw:TranslateLabel Text="Check e-mail existence" ID="TranslateLabel3" runat="server" />
                        </label>
                        <dw:GroupBoxEnd ID="gbCheckingMethodEnd" runat="server" />
                        <div id="divNoRecipientsFound" runat="Server" visible="false" enableviewstate="false">
                            <br />
                            &nbsp;&nbsp;<strong><dw:TranslateLabel Text="No recipients found." ID="dwTransNoRecipientsFound"
                                runat="server" />
                            </strong>
                        </div>
                    </td>
                </tr>
            </table>
            <input type="button" id="btnValidate" runat="server" style="display: none" />
            <%  Translate.GetEditOnlineScript() %>
        </form>
    </div>
</body>
</html>
