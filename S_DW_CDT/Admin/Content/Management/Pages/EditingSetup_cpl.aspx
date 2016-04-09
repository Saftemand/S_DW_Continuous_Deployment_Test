<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb"
    AutoEventWireup="false" CodeBehind="EditingSetup_cpl.aspx.vb" Inherits="Dynamicweb.Admin.EditingSetup_cpl" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="System.Data" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        label.label-highlight
        {
            font-weight: bold;
        }
        
        label.label-highlight-disabled
        {
            font-weight: bold;
            color: #c3c3c3;
        }
    </style>
    <style type="text/css">
        span.editor-notification
        {
            display: block;
            margin-top: 2px;
            padding-left: 20px;
            background: url('/Admin/Images/Ribbon/Icons/Small/information.png') top left no-repeat;
            height: 16px;
            color: #8c8c8c;
        }
    </style>
    <script language="javascript" type="text/javascript" src="/Admin/Module/Common/Validation.js"></script>
    <script type="text/javascript">
        var page = SettingsPage.getInstance();

        page.onSave = function () {
            var key = '/Globalsettings/Ecom/UseNew';
            var chk = document.getElementById('/Globalsettings/Ecom/UseNew');

            if (chk && top.dwtop && typeof (top.dwtop.Dynamicweb) != 'undefined') {
                top.dwtop.Dynamicweb.Globals.IsNewEcom = chk.checked;
            }

            page.submit();
        }

        function showEditorContexts() {
            var cb = document.getElementById("/Globalsettings/Settings/TextEditor/UseProviderBasedEditors");
            if (cb != null) {
                var div = document.getElementById("editorContextsDiv");
                if (div != null) {
                    div.style.display = cb.checked ? "block" : "none";
                }
            }                          
        }
        window.onload = function () { showEditorContexts(); }
    </script>
</asp:Content>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <div id="PageContent">
        <%
            Dim DISABLED As Boolean
            Dim sql As String
            Dim DWParagraphMaxLockTime As String
            Dim strParagraphBottomSpace As String            
            Dim DWAdminLanguage As String = CStr(Base.GetGs("/Globalsettings/Modules/LanguagePack/DefaultLanguage"))
        %>
        <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
            <tr>
                <td valign="top">
                    <%  If Session("DW_Admin_UserID") < 3 Then%>
                    <%=Gui.GroupBoxStart(Translate.Translate("Brugergrænseflade"))%>
                    <input type="hidden" value="True" id="/Globalsettings/Settings/ContentEditor/UseNew"
                        name="/Globalsettings/Settings/ContentEditor/UseNew" />
                    <input type="hidden" value="True" id="Hidden1" name="/Globalsettings/Ecom/UseNew" />
                    <table cellpadding='2' cellspacing='0' border='0' width='100%' style="table-layout: fixed">
                        <tr valign="top">
                            <td width="170" align="left">
                                &nbsp;
                            </td>
                            <td align="left">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr valign="top">
                            <td width="170" align="left">
                                <%=Translate.Translate("Default language")%>
                            </td>
                            <td align="left">
                                <select class="std" name="/Globalsettings/Modules/LanguagePack/DefaultLanguage" id="/Globalsettings/Modules/LanguagePack/DefaultLanguage">
                                    <%	
                                        If Base.GetGs("/Globalsettings/Modules/LanguagePack/DefaultLanguage") = "" Then
                                            DWAdminLanguage = 1
                                        End If

                                        Using LanguageConn As System.Data.IDbConnection = Translate.LanguageDB.CreateConnection()
                                            Using cmdLanguage As IDbCommand = LanguageConn.CreateCommand
                                                sql = "SELECT * FROM [Languages] WHERE LanguageActive=1"
                                                cmdLanguage.CommandText = sql
                                                
                                                Using drLanguageReader As IDataReader = cmdLanguage.ExecuteReader()
                                                    Dim opLanguageName As Integer = drLanguageReader.GetOrdinal("LanguageName")
                                                    Dim opid As Integer = drLanguageReader.GetOrdinal("LanguageID")

                                                    Do While drLanguageReader.Read
                                                        Response.Write("<option value=""" & drLanguageReader(opid) & """ " & IIf(CStr(drLanguageReader(opid)) = Base.GetGs("/Globalsettings/Modules/LanguagePack/DefaultLanguage"), "Selected", "") & ">" & drLanguageReader(opLanguageName) & "</option>")
                                                    Loop
                                                End Using
                                            End Using
                                        End Using
                                    %>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr valign="top">
                            <td width="170" align="left">
                            </td>
                            <td align="left">
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/ContentEditor/UseSimpleParagraphList") = "True", "checked", "")%>
                                    id="/Globalsettings/Settings/ContentEditor/UseSimpleParagraphList" name="/Globalsettings/Settings/ContentEditor/UseSimpleParagraphList">
                                <label for="/Globalsettings/Settings/ContentEditor/UseSimpleParagraphList">
                                    <%=Translate.Translate("Simple paragraph list")%></label>
                            </td>
                        </tr>
                        <%
                            If String.IsNullOrEmpty(Base.GetGs("/Globalsettings/Settings/ContentEditor/ParagraphList/ShowUpdatedDate")) Then
                                Base.SetGs("/Globalsettings/Settings/ContentEditor/ParagraphList/ShowUpdatedDate", "True")
                            End If
                            If String.IsNullOrEmpty(Base.GetGs("/Globalsettings/Settings/ContentEditor/ParagraphList/ShowUpdatedUser")) Then
                                Base.SetGs("/Globalsettings/Settings/ContentEditor/ParagraphList/ShowUpdatedUser", "True")
                            End If
                        %>
                        <tr valign="top">
                            <td width="170" align="left">
                                <%=Translate.Translate("Vis detaljer")%>
                            </td>
                            <td align="left">
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/ContentEditor/ParagraphList/ShowUpdatedDate") = "True", "checked", "")%>
                                    id="/Globalsettings/Settings/ContentEditor/ParagraphList/ShowUpdatedDate" name="/Globalsettings/Settings/ContentEditor/ParagraphList/ShowUpdatedDate">
                                <label for="/Globalsettings/Settings/ContentEditor/ParagraphList/ShowUpdatedDate">
                                    <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Redigeret" />
                                </label>
                                <br />
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/ContentEditor/ParagraphList/ShowUpdatedUser") = "True", "checked", "")%>
                                    id="/Globalsettings/Settings/ContentEditor/ParagraphList/ShowUpdatedUser" name="/Globalsettings/Settings/ContentEditor/ParagraphList/ShowUpdatedUser">
                                <label for="/Globalsettings/Settings/ContentEditor/ParagraphList/ShowUpdatedUser">
                                    <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Bruger" />
                                </label>
                                <br />
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/ContentEditor/ParagraphList/ShowValidFrom") = "True", "checked", "")%>
                                    id="/Globalsettings/Settings/ContentEditor/ParagraphList/ShowValidFrom" name="/Globalsettings/Settings/ContentEditor/ParagraphList/ShowValidFrom">
                                <label for="/Globalsettings/Settings/ContentEditor/ParagraphList/ShowValidFrom">
                                    <dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Aktiv fra" />
                                </label>
                                <br />
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/ContentEditor/ParagraphList/ShowValidTo") = "True", "checked", "")%>
                                    id="/Globalsettings/Settings/ContentEditor/ParagraphList/ShowValidTo" name="/Globalsettings/Settings/ContentEditor/ParagraphList/ShowValidTo">
                                <label for="/Globalsettings/Settings/ContentEditor/ParagraphList/ShowValidTo">
                                    <dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Aktiv til" />
                                </label>
                            </td>
                        </tr>
                    </table>
                    <%=Gui.GroupBoxEnd%>
                    <%End If%>
                    <%=Gui.GroupBoxStart(Translate.Translate("Afsnit"))%>
                    <table border="0" cellpadding="2" cellspacing="0">
                        <tr>
                            <%
                                If Trim(Base.GetGs("/Globalsettings/Settings/Paragraph/MaximumLockingInMinutes")) = "" Or Not IsNumeric(Base.GetGs("/Globalsettings/Settings/Paragraph/MaximumLockingInMinutes")) Then
                                    DWParagraphMaxLockTime = "30"
                                Else
                                    DWParagraphMaxLockTime = Base.GetGs("/Globalsettings/Settings/Paragraph/MaximumLockingInMinutes")
                                End If
                            %>
                            <td width="170">
                                <label for="/Globalsettings/Settings/Paragraph/MaximumLockingInMinutes">
                                    <%=Translate.Translate("Maksimal låsning i minutter")%></A>
                            </td>
                            <td>
                                <input type="text" maxlength="255" class="std" value="<%=DWParagraphMaxLockTime%>"
                                    name="/Globalsettings/Settings/Paragraph/MaximumLockingInMinutes" id="DWParagraphMaxLockTime">
                            </td>
                        </tr>
                        <tr style='display: <%=Base.IIf(Gui.NewUI(), "none", String.Empty)%>'>
                            <td>
                                <label for="/Globalsettings/Settings/Paragraph/FrontendEditingEnabled">
                                    <%=Translate.Translate("Frontend editering")%></label>
                            </td>
                            <td>
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/Paragraph/FrontendEditingEnabled") = "True", "checked", "")%>
                                    id="DWFrontend_Active" name="/Globalsettings/Settings/Paragraph/FrontendEditingEnabled">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <%=Translate.Translate("Mellemrum inden afsnit")%>
                            </td>
                            <td>
                                <select name="/Globalsettings/Settings/Paragraph/SpacesBeforeParagraph" class="std"
                                    style="width: 35px;">
                                    <%
                                        If Base.GetGs("/Globalsettings/Settings/Paragraph/SpacesBeforeParagraph") = "" Then
                                            strParagraphBottomSpace = 1
                                        Else
                                            strParagraphBottomSpace = Base.GetGs("/Globalsettings/Settings/Paragraph/SpacesBeforeParagraph")
                                        End If
                                        For i As Integer = 0 To 9
                                            If CStr(i) = CStr(strParagraphBottomSpace) Then
                                                Response.Write("<option value=""" & i & """ selected>" & i & "</option>")
                                            Else
                                                Response.Write("<option value=""" & i & """>" & i & "</option>")
                                            End If
                                        Next
                                    %>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/Paragraph/HideSpaceSetting") = "True", "checked", "")%>
                                    id="Checkbox1" name="/Globalsettings/Settings/Paragraph/HideSpaceSetting">
                                <label for="/Globalsettings/Settings/Paragraph/HideSpaceSetting">
                                    <%=Translate.Translate("Skjul indstilling på afsnit")%></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/Paragraph/RequireAltAndTitle") = "True", "checked", "")%>
                                    id="/Globalsettings/Settings/Paragraph/RequireAltAndTitle" name="/Globalsettings/Settings/Paragraph/RequireAltAndTitle">
                                <label for="/Globalsettings/Settings/Paragraph/RequireAltAndTitle">
                                    <%= Translate.Translate("Require alt and title to be filled out")%></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/Paragraph/EnableAlignmentOnParagraphImages") = "True", "checked", "")%>
                                    id="/Globalsettings/Settings/Paragraph/EnableAlignmentOnParagraphImages" name="/Globalsettings/Settings/Paragraph/EnableAlignmentOnParagraphImages">
                                <label for="/Globalsettings/Settings/Paragraph/EnableAlignmentOnParagraphImages">
                                    <%=Translate.Translate("Enable alignment on paragraph images")%></label>
                            </td>
                        </tr>
                        <tr valign="top">
                            <td width="170" align="left">
                            </td>
                            <td align="left">
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/ContentEditor/UseNavigationCancel") = "True", "checked", "")%>
                                    id="/Globalsettings/Settings/ContentEditor/UseNavigationCancel" name="/Globalsettings/Settings/ContentEditor/UseNavigationCancel">
                                <label for="/Globalsettings/Settings/ContentEditor/UseNavigationCancel">
                                    <%=Translate.Translate("Warn when closing paragraph without saving or cancel.")%></label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <%
                                    If Base.GetGs("/Globalsettings/Settings/Paragraph/SpaceMode") = "" Then
                                        Base.SetGs("/Globalsettings/Settings/Paragraph/SpaceMode", "tr")
                                    End If
                                %>
                                <input type="radio" value="tr" <%=IIf(Base.GetGs("/Globalsettings/Settings/Paragraph/SpaceMode") = "tr", "checked", "")%>
                                    id="Mode1" name="/Globalsettings/Settings/Paragraph/SpaceMode"><label for="Mode1"><%=Translate.Translate("Standard (tr)")%></label><br />
                                <input type="radio" value="div" <%=IIf(Base.GetGs("/Globalsettings/Settings/Paragraph/SpaceMode") = "div", "checked", "")%>
                                    id="Mode2" name="/Globalsettings/Settings/Paragraph/SpaceMode"><label for="Mode2"><%=Translate.Translate("Div")%></label><br />
                                <input type="radio" value="none" <%=IIf(Base.GetGs("/Globalsettings/Settings/Paragraph/SpaceMode") = "none", "checked", "")%>
                                    id="Mode3" name="/Globalsettings/Settings/Paragraph/SpaceMode"><label for="Mode3"><%=Translate.Translate("Ingen")%></label>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <input type="checkbox" id="/Globalsettings/Settings/Paragraph/DisableStandard" <%=IIf(Base.GetGs("/Globalsettings/Settings/Paragraph/DisableStandard") = "true", "checked", "")%>
                                    name="/Globalsettings/Settings/Paragraph/DisableStandard" value="true" />
                                <label for="/Globalsettings/Settings/Paragraph/DisableStandard"><%=Translate.Translate("Disable standard paragraph")%></label>
                            </td>
                        </tr>
                    </table>
                    <%=Gui.GroupBoxEnd%>
                    <%=Gui.GroupBoxStart(Translate.Translate("Side"))%>
                    <table border="0" cellpadding="2" cellspacing="0">
                        <tr>
                            <td style="padding-left: 170px;">
                                <input id="/Globalsettings/Settings/Page/Edit/ShowLogoAlt" <%=IIf(Base.GetGs("/Globalsettings/Settings/Page/Edit/ShowLogoAlt") = "True", "checked", "")%>
                                    name="/Globalsettings/Settings/Page/Edit/ShowLogoAlt" type="checkbox" value="True">
                            </td>
                            <td>
                                <label for="/Globalsettings/Settings/Page/Edit/ShowLogoAlt">
                                    <%=Translate.Translate("Show alt tekst for logo")%>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td  style="padding-left: 170px;"><input type="checkbox" id="/Globalsettings/Settings/Page/DisableStandard" <%=IIf(Base.GetGs("/Globalsettings/Settings/Page/DisableStandard") = "true", "checked", "")%>
                                    name="/Globalsettings/Settings/Page/DisableStandard" value="true" /></td>
                            <td>
                                
                                <label for="/Globalsettings/Settings/Page/DisableStandard"><%=Translate.Translate("Disable standard page")%></label>
                            </td>
                        </tr>
                    </table>
                    <%=Gui.GroupBoxEnd%>
                    <%=Gui.GroupBoxStart(Translate.Translate("Date selector"))%>
                    <table border="0" cellpadding="2" cellspacing="0">
                        <tr>
                            <td style="padding-left: 170px;">
                                <input id="/Globalsettings/Settings/Page/Edit/DisablePopupCalendar" <%=IIf(Base.GetGs("/Globalsettings/Settings/Page/Edit/DisablePopupCalendar") = "True", "checked", "")%>
                                    name="/Globalsettings/Settings/Page/Edit/DisablePopupCalendar" type="checkbox"
                                    value="True">
                            </td>
                            <td>
                                <label for="/Globalsettings/Settings/Page/Edit/DisablePopupCalendar">
                                    <%=Translate.Translate("Disable the popup calendar")%>
                                </label>
                            </td>
                        </tr>
                    </table>
                    <%=Gui.GroupBoxEnd%>
                    <%If Base.HasVersion("8.3.0.0") Then%>
                        <%=Gui.GroupBoxStart(Translate.Translate("Editor selector"))%>
                        <table border="0" cellpadding="2" cellspacing="0">
                            <tr>
                                <td style="padding-left: 170px;">
                                    <input id="/Globalsettings/Settings/TextEditor/UseProviderBasedEditors" <%=IIf(Base.GetGs("/Globalsettings/Settings/TextEditor/UseProviderBasedEditors") = "True", "checked", "")%>
                                        name="/Globalsettings/Settings/TextEditor/UseProviderBasedEditors" type="checkbox" value="True" onclick="showEditorContexts();">
                                </td>
                                <td>
                                    <label for="/Globalsettings/Settings/TextEditor/UseProviderBasedEditors">
                                        <%=Translate.Translate("Use provider based editors")%>
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 170px;">
                                    <span class="editor-notification"></span>
                                </td>
                                <td>
                                    <dw:TranslateLabel id="lbEditorNotification" Text="This will disable all previously saved editor configurations. Provider based editors are selected under Editor Configuration."
                                            runat="server" />
                                            <br/>
                                </td>
                            </tr>
                        </table>
                        <%=Gui.GroupBoxEnd%>
                        <div id="editorContextsDiv" style="display:none;">
                        <%If Base.HasVersion("8.4.0.0") Then%>
                        <%=Gui.GroupBoxStart(Translate.Translate("Editor contexts"))%>
                        <table border="0" cellpadding="2" cellspacing="0">
                            <tr>
                                <td width="170" align="left">
                                    <%=Translate.Translate("Use in Ecommerce description")%>
                                </td>
                                <td align="left">
                                    <select class="std" name="/Globalsettings/Settings/ProviderBasedEditor/EcomDescriptionEditorConfigID" id="/Globalsettings/Settings/ProviderBasedEditor/EcomDescriptionEditorConfigID">
                                        <% FillConfigurationsList("/Globalsettings/Settings/ProviderBasedEditor/EcomDescriptionEditorConfigID")%>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td width="170" align="left">
                                    <%=Translate.Translate("Use in Ecommerce teaser")%>
                                </td>
                                <td align="left">
                                    <select class="std" name="/Globalsettings/Settings/ProviderBasedEditor/EcomTeaserEditorConfigID" id="/Globalsettings/Settings/ProviderBasedEditor/EcomTeaserEditorConfigID">
                                        <% FillConfigurationsList("/Globalsettings/Settings/ProviderBasedEditor/EcomTeaserEditorConfigID")%>
                                    </select>
                                </td>
                            </tr>
                        </table>
                        <%=Gui.GroupBoxEnd%>
                        <%End If%>
                        </div>
                    <%End If%>
                </td>
                </TD>
                <tr>
            </FORM>
        </table>
        <%
            Translate.GetEditOnlineScript()
        %>
    </div>
</asp:Content>
