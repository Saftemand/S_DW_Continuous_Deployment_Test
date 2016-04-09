<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" CodeBehind="SystemSolutionDetails_cpl.aspx.vb" Inherits="Dynamicweb.Admin.SystemSolutionDetails_cpl" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        table.gbTab
        {
            width: 100%;
        }
        
        table.gbTab tr
        {
            vertical-align: top;
        }
        
        table.gbTab tr td.col
        {
            width: 170px;
        }
        
        div.smallText
        {
            font-size: 8pt;
        }
        
        div.panel
        {
            padding-bottom: 10px;
        }
    </style>

    <script type="text/javascript">
        var page = SettingsPage.getInstance();

        page.onHelp = function() {
            <%=Gui.help("", "administration.managementcenter.system.information") %>
        }
        
        function doUpdate(){
         document.forms[0].action = document.location.toString();
         document.forms[0].submit();
        }
    </script>

</asp:Content>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <div id="PageContent">
        <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
            <tr>
                <td valign="top">
                    <dw:GroupBoxStart ID="gbVersionStart" Title="Version" runat="server" />
                    <table class="gbTab" border="0" cellpadding="2" cellspacing="0">
                        <tr>
                            <td class="col">
                                <dw:TranslateLabel ID="lbContentVersion" Text="Content version" runat="server" />
                            </td>
                            <td>
                                <asp:Literal ID="litContentVersion" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="lbAssemblyVersions" Text="Assembly versions" runat="server" />
                            </td>
                            <td>
                                <div class="panel">
                                    <strong>Dynamicweb.dll&nbsp;<asp:Literal ID="litDynamicwebVersion" runat="server" />
                                    </strong>
                                    <div class="smallText">
                                        <asp:Literal ID="litDynamicwebFileVersion" runat="server" />
                                    </div>
                                </div>
                                <div class="panel">
                                    <strong>Dynamicweb.Admin.dll&nbsp;<asp:Literal ID="litDynamicwebAdminVersion" runat="server" />
                                    </strong>
                                    <div class="smallText">
                                        <asp:Literal ID="litDynamicwebAdminFileVersion" runat="server" />
                                    </div>
                                </div>
                                <div class="panel">
                                    <strong>Dynamicweb.Controls.dll&nbsp;<asp:Literal ID="litDynamicwebControlsVersion" runat="server" />
                                    </strong>
                                    <div class="smallText">
                                        <asp:Literal ID="litDynamicwebControlsFileVersion" runat="server" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="lbBuildDate" Text="Build date" runat="server" />
                            </td>
                            <td>
                                <asp:Literal ID="litBuildDate" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel8" Text=".NET Runtime version" runat="server" />
                            </td>
                            <td>
                                <asp:Literal ID="NetRuntimeVersion" runat="server" /> (NP: <%=System.Environment.Version.Revision %>)
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel9" Text="Application bit version" runat="server" />
                            </td>
                            <td>
                                <asp:Literal ID="litApplicationBitVersion" runat="server" />Bit
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel10" Text="OS type" runat="server" />
                            </td>
                            <td>
                                <asp:Literal ID="litOSBitVersion" runat="server" />
                            </td>
                        </tr>
						<tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel7" Text="Server time" runat="server" />
                            </td>
                            <td>
                                <asp:Literal ID="litServertime" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <dw:GroupBoxEnd ID="gbVersionEnd" runat="server" />
                    <dw:GroupBox ID="GroupBox2" runat="server" Title="File locations">
                        <table class="gbTab" border="0" cellpadding="2" cellspacing="0">
                            <tr>
                                <td colspan="2">
                                    <dw:Infobar ID="assemblyWarning" runat="server" Type="Error" Visible="false">
                                        ERROR. This solution has a version conflict.</dw:Infobar>
                                </td>
                            </tr>
                            <tr>
                                <td class="col">
                                    <dw:TranslateLabel ID="TranslateLabel6" Text="Home directory" runat="server" />
                                </td>
                                <td>
                                    <asp:Literal ID="litHomeDir" runat="server" /><br />
                                </td>
                            </tr>
                            <tr>
                                <td class="col">
                                    <dw:TranslateLabel ID="TranslateLabel2" Text="Admin location" runat="server" />
                                </td>
                                <td>
                                    <asp:Literal ID="litAdminLocation" runat="server" /><br />
                                    <span style="white-space: nowrap">
                                        <asp:Literal ID="litAdminBinLocation" runat="server" Visible="false" /></span>
                                </td>
                            </tr>
                            <tr>
                                <td class="col">
                                    <dw:TranslateLabel ID="TranslateLabel3" Text="Bin location" runat="server" />
                                </td>
                                <td>
                                    <span style="white-space: nowrap">
                                        <asp:Literal ID="litBinLocation" runat="server" /></span>
                                </td>
                            </tr>
                            <tr>
                                <td class="col">
                                    <dw:TranslateLabel ID="TranslateLabel4" Text="File location" runat="server" />
                                </td>
                                <td>
                                    <asp:Literal ID="litFilesLocation" runat="server" />
                                </td>
                            </tr>
                            <tr runat="server" id="databaseLocation">
                                <td class="col">
                                    <dw:TranslateLabel ID="TranslateLabel5" Text="Database location" runat="server" />
                                </td>
                                <td>
                                    <asp:Literal ID="litDatabaseLocation" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </dw:GroupBox>
                    <dw:GroupBox ID="GroupBox3" runat="server" Title="IIS">
                        <table class="gbTab" border="0" cellpadding="2" cellspacing="0">
                            <tr>
                                <td class="col">
                                    Version
                                </td>
                                <td>
                                    <%=HttpContext.Current.Request.ServerVariables("SERVER_SOFTWARE")%>
                                </td>
                            </tr>
                            <tr>
                                <td class="col">
                                    IIS Name
                                </td>
                                <td id="iisName" runat="server">
                                </td>
                            </tr>
                            <tr>
                                <td class="col">
                                    Application pool
                                </td>
                                <td id="iisAppPoolId" runat="server">
                                </td>
                            </tr>
                            <tr>
                                <td class="col">
                                    404 Handler
                                </td>
                                <td id="iisHandler404" runat="server">
                                </td>
                            </tr>
                        </table>
                    </dw:GroupBox>
                    <dw:GroupBox ID="GroupBox4" runat="server" Title="Reporting">
                        <table class="gbTab" border="0" cellpadding="2" cellspacing="0">
                            <tr>
                                <td class="col">
                                    Last CRM report
                                </td>
                                <td>
                                    <%=Dynamicweb.Dates.ToDate(Base.GetGs("/Globalsettings/Settings/CommonInformation/SolutionLastReportDate")).ToString(Dates.DateFormatStringShort)%>
                                </td>
                            </tr>
                            <tr>
                                <td class="col">
                                    CRM installation ID
                                </td>
                                <td>
                                    <%=Base.GetGs("/Globalsettings/Settings/CommonInformation/InstallationCrmID")%>
                                </td>
                            </tr>
                            <tr>
                                <td class="col">
                                    Installation checksum
                                </td>
                                <td id="InstallationChecksum" runat="server">
                                </td>
                            </tr>
                        </table>
                    </dw:GroupBox>
                    <dw:GroupBoxStart ID="gbServerStart" Title="Server" runat="server" />
                    <table class="gbTab" border="0" cellpadding="2" cellspacing="0">
                        <tr>
                            <td class="col">
                                <dw:TranslateLabel ID="lbServer" Text="Server" runat="server" />
                            </td>
                            <td>
                                <asp:Literal ID="litServer" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="lbMachine" Text="Machine" runat="server" />
                            </td>
                            <td>
                                <asp:Literal ID="litMachine" runat="server" />&nbsp;(<a id="lnkMachine" target="_blank" runat="server"></a>)
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="lbPath" Text="Path" runat="server" />
                            </td>
                            <td>
                                <a id="lnkPath" target="_blank" runat="server"></a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="lbIntranetPath" Text="Intranet path" runat="server" />
                            </td>
                            <td>
                                <a id="lnkIntranetPath" target="_blank" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <dw:GroupBoxEnd ID="gbServerEnd" runat="server" />
                    <dw:GroupBoxStart ID="gbDatabaseStart" Title="Database" runat="server" />
                    <table class="gbTab" border="0" cellpadding="2" cellspacing="0">
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="lbDatabaseType" Text="Database type" runat="server" />
                            </td>
                            <td>
                                <asp:Literal ID="litDatabaseType" runat="server" />
                                <div id="divDatabaseParameters" class="smallText" runat="server">
                                    <asp:Literal ID="litDatabaseParameters" runat="server" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="col">
                                <dw:TranslateLabel ID="lbLanguageDB" Text="Language database" runat="server" />
                            </td>
                            <td>
                                <asp:Literal ID="litLanguageDB" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <dw:GroupBoxEnd ID="gpDatabaseEnd" runat="server" />
                    <dw:GroupBox ID="GroupBox1" runat="server" Title="Updates">
                        <table class="gbTab" border="0" cellpadding="2" cellspacing="0">
                            <tr>
                                <td class="col">
                                </td>
                                <td>
                                    <a href="/Admin/Update/ShowUpdateLog.aspx" target="_blank" download>
                                        <dw:TranslateLabel ID="TranslateLabel1" Text="Download update log" runat="server" />
                                    </a>
                                </td>
                            </tr>
                            <tr>
                                <td class="col">
                                </td>
                                <td>
                                    <table cellpadding="0" cellspacing="0" border="0">
                                        <%=GetUpdateScriptsAndVersionNumbers()%>
                                        <tr>
                                            <td>
                                            </td>
                                            <td>
                                                <input name="RunUpdate" type="hidden" value="True" />
                                                <input type="button" <%If Not CanUpdate Then%> disabled="disabled" title="<%=Translate.Translate("Only user with administrator privileges can run update")%>" <%End If%> value="Rerun updates" onclick="doUpdate();" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </dw:GroupBox>
                </td>
            </tr>
        </table>
    </div>
    <%  Dynamicweb.Backend.Translate.GetEditOnlineScript()
    %>
</asp:Content>
