<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" CodeBehind="SecuritySetup_cpl.aspx.vb" Inherits="Dynamicweb.Admin.SecuritySetup_cpl" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript" src="/Admin/Module/Common/Validation.js"></script>

    <script type="text/javascript">
        var page = SettingsPage.getInstance();

        page.onSave = function () {
            var eml = document.getElementById("/Globalsettings/System/Security/FormAntiSpamReportTo");
            if (IsEmailValid(eml,
			    "<%=Translate.JSTranslate("Ugyldig_værdi_i:_%%", "%%", Translate.JsTranslate("Send kopi til e-mail"))%>"))
		        document.frmGlobalSettings.submit();
        }

		    function setSkipIsEnabled(isEnabled) {
		        var row = document.getElementById('rowSkip');
		        document.getElementById('/Globalsettings/System/Security/SQLInjectionSkip').disabled = !isEnabled;

		        row.className = (!isEnabled ? 'row-injection-disabled' : '');
		    }
    </script>

    <style type="text/css">
        span.sql-injection-skip {
            display: block;
            margin-top: 2px;
            padding-left: 20px;
            background: url('/Admin/Images/Ribbon/Icons/Small/information.png') top left no-repeat;
            height: 16px;
            color: #8c8c8c;
        }

        tr.row-injection-disabled,
        tr.row-injection-disabled span {
            color: #c3c3c3 !important;
        }

            tr.row-injection-disabled textarea {
                background-color: #f3f3f3;
            }
    </style>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <div id="PageContent">
        <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
            <tr>
                <td valign="top">

                    <dw:GroupBox ID="GroupBox1" Title="Formular" runat="server">
                        <table border="0" cellpadding="2" cellspacing="0">
                            <tr>
                                <td width="170"></td>
                                <td>
                                    <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Security/FormAntiSpam") = "True", "checked", "")%> id="/Globalsettings/System/Security/FormAntiSpam" name="/Globalsettings/System/Security/FormAntiSpam">
                                    <label for="/Globalsettings/System/Security/FormAntiSpam">
                                        <dw:TranslateLabel ID="TranslateLabel3" Text="Aktiver antispam funktion" runat="server" />
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dw:TranslateLabel ID="TranslateLabel4" Text="Send kopi til e-mail" runat="server" />
                                </td>
                                <td>
                                    <input type="text" maxlength="255" class="std" value="<%=Base.GetGs("/Globalsettings/System/Security/FormAntiSpamReportTo")%>" name="/Globalsettings/System/Security/FormAntiSpamReportTo" id="/Globalsettings/System/Security/FormAntiSpamReportTo"></td>
                            </tr>
                        </table>
                    </dw:GroupBox>

                    <%If Session("DW_Admin_UserType") = 0 Or Session("DW_Admin_UserType") = 1 Or Session("DW_Admin_UserType") = 3 Then%>
                    <dw:GroupBox ID="GroupBox2" Title="Dynamicweb support" runat="server">
                        <table border="0" cellpadding="2" cellspacing="0">
                            <tr>
                                <td width="170"></td>
                                <td>
                                    <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Security/AngelLocked") = "True", "checked", "")%> id="/Globalsettings/System/Security/AngelLocked" name="/Globalsettings/System/Security/AngelLocked">
                                    <label for="/Globalsettings/System/Security/AngelLocked">
                                        <dw:TranslateLabel ID="TranslateLabel2" Text="Restrict access for support users" runat="server" />
                                    </label>
                                </td>
                            </tr>
                        </table>
                    </dw:GroupBox>
                    <%End If%>

                    <dw:GroupBox ID="gbInjection" Title="SQL injection check" runat="server">
                        <table border="0" cellspacing="0" cellpadding="2">

                            <tr>
                                <td></td>
                                <td>
                                    <input id="/Globalsettings/System/http/DisableSQLInjectionCheck" <%=IIf(Base.GetGs("/Globalsettings/System/http/DisableSQLInjectionCheck") = "True", "checked", "")%> name="/Globalsettings/System/http/DisableSQLInjectionCheck" type="checkbox" onclick="setSkipIsEnabled(!this.checked);" value="True" />
                                    <label for="/Globalsettings/System/http/DisableSQLInjectionCheck">
                                        <dw:TranslateLabel ID="lbDisable" Text="Disable" runat="server" />
                                    </label>
                                </td>
                            </tr>
                            <tr id="rowSkip">
                                <td valign="top">
                                    <label for="/Globalsettings/System/Security/SQLInjectionSkip">
                                        <dw:TranslateLabel ID="lbSkip" Text="Ignore the following fields" runat="server" />
                                    </label>
                                </td>
                                <td>
                                    <textarea class="std" rows="5" id="/Globalsettings/System/Security/SQLInjectionSkip" name="/Globalsettings/System/Security/SQLInjectionSkip"><%= Base.GetGs("/Globalsettings/System/Security/SQLInjectionSkip")%></textarea><br />
                                    <span class="sql-injection-skip">
                                        <dw:TranslateLabel ID="lbSkipHint" Text="Use comma to separate field names." runat="server" />
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 170px"></td>
                                <td>
                                    <input id="/Globalsettings/System/Security/DoNotBanIps" <%=IIf(Base.GetGs("/Globalsettings/System/Security/DoNotBanIps") = "True", "checked", "")%> name="/Globalsettings/System/Security/DoNotBanIps" type="checkbox" value="True" />
                                    <label for="/Globalsettings/System/Security/DoNotBanIps">
                                        <dw:TranslateLabel ID="TranslateLabel1" Text="Do not ban IPs" runat="server" />
                                    </label>
                                </td>
                            </tr>
                        </table>
                    </dw:GroupBox>
                    <%If Base.HasVersion("8.5.0.0") Then%>
                    <dw:GroupBox ID="GroupBox3" Title="SQL injection emails" runat="server">
                        <table border="0" cellspacing="0" cellpadding="2">
                            <tr id="rowDoNotRecieve">
                                <td valign="top" style="width: 170px">
                                    <label for="/Globalsettings/System/Security/SQLInjectionEmailRecipients">
                                        <dw:TranslateLabel ID="TranslateLabel6" Text="List of recipients" runat="server" />
                                    </label>
                                </td>
                                <td>
                                    <textarea class="std" rows="5" id="/Globalsettings/System/Security/SQLInjectionEmailRecipients" name="/Globalsettings/System/Security/SQLInjectionEmailRecipients"><%= Base.GetGs("/Globalsettings/System/Security/SQLInjectionEmailRecipients")%></textarea><br />
                                    <span class="sql-injection-skip">
                                        <dw:TranslateLabel ID="TranslateLabel7" Text="Use comma to separate email addresses." runat="server" />
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </dw:GroupBox>
                    <%End If%>                        

                </td>
                <tr>
        </table>
    </div>
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>

    <script type="text/javascript">
        setSkipIsEnabled(!document.getElementById('/Globalsettings/System/http/DisableSQLInjectionCheck').checked);
    </script>
</asp:Content>
