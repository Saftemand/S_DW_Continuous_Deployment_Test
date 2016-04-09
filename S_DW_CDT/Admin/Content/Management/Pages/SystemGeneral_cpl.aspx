<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" CodeBehind="SystemGeneral_cpl.aspx.vb" Inherits="Dynamicweb.Admin.SystemGeneral_cpl" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript" src="/Admin/Module/Common/Validation.js"></script>
    
    <script type="text/javascript">
        var page = SettingsPage.getInstance();

        page.onSave = function() {
            var eml = document.getElementById("/Globalsettings/Settings/CommonInformation/Email");
	        var ret = true;
    		
	        if(eml.value.length > 0)
		        ret = IsEmailValid(eml,	"<%=Translate.JSTranslate("Ugyldig_værdi_i:_%%", "%%", Translate.Translate("E-mail"))%>");
    				
	        if(ret){
                if(document.getElementById('/Globalsettings/Settings/Designs/UseOnlyDesignsAndLayouts').checked != ('True'=='<%=Base.GetGs("/Globalsettings/Settings/Designs/UseOnlyDesignsAndLayouts")%>'))
                {
                    var hiddenOpenTo = document.getElementById('hiddenOpenTo');
                    if (document.getElementById('hiddenSource').value == "ManagementCenter")
                        hiddenOpenTo.value = 'load=Start.aspx';
                    else
                        hiddenOpenTo.value = 'load=Pages/SystemGeneral_cpl.aspx&OpenTo=SystemSolutionSettings';
                }
		        document.getElementById('MainForm').submit();
            }
        }

        page.onHelp = function() {
            <%=Gui.help("", "administration.managementcenter.system.solution") %>
        }
    </script>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <%
        Dim DWAdminLanguage As String = CStr(Base.GetGs("/Globalsettings/Modules/LanguagePack/DefaultLanguage"))
        Dim sql As String
    %>
    <input id="hiddenOpenTo" type="hidden" name="OpenTo" value="" />
    <div id="PageContent">
        <TABLE border="0" cellpadding="2" cellspacing="0" class="tabTable">
            <TR>
	            <TD valign="top">
		            <%=Gui.GroupBoxStart(Translate.Translate("Generel information"))%>
		            <TABLE border="0" cellpadding="2" cellspacing="0">
			            <TR>
				            <TD width="170"><LABEL for="/Globalsettings/Settings/CommonInformation/SolutionTitle"><%=Translate.Translate("Løsningstitel")%></LABEL></TD>
				            <TD><INPUT type="text" maxlength="255" value="<%=Server.HtmlEncode(Base.GetGs("/Globalsettings/Settings/CommonInformation/SolutionTitle"))%>" class="std" id="/Globalsettings/Settings/CommonInformation/SolutionTitle" name="/Globalsettings/Settings/CommonInformation/SolutionTitle"></TD>
			            </TR>
			           <TR>
				            <TD><LABEL for="/Globalsettings/Settings/CommonInformation/Email"><%=Translate.Translate("E-mail")%> (<%=Translate.Translate("System")%>)</LABEL></TD>
				            <TD><INPUT type="text" maxlength="255" value="<%=Server.HtmlEncode(Base.GetGs("/Globalsettings/Settings/CommonInformation/Email"))%>" class="std" id="/Globalsettings/Settings/CommonInformation/Email" name="/Globalsettings/Settings/CommonInformation/Email"></TD>
			            </TR>
						
			            <TR>
				            <TD valign="top"><LABEL for="/Globalsettings/Settings/CommonInformation/CopyrightMetaInformation"><%=Translate.Translate("Copyright")%></LABEL></TD>
				            <TD><textarea class="std" name="/Globalsettings/Settings/CommonInformation/CopyrightMetaInformation"
						            ID="/Globalsettings/Settings/CommonInformation/CopyrightMetaInformation" rows="5"><%=Base.GetGs("/Globalsettings/Settings/CommonInformation/CopyrightMetaInformation")%></textarea></TD>
			            </TR>
		            </TABLE>
					<%=Gui.GroupBoxEnd%>
					<dw:GroupBox ID="GroupBox1" runat="server" Title="Login screen">
					<table border="0" cellpadding="2" cellspacing="0">
					<TR>
					        <td width="170"><label for="/Globalsettings/Settings/CommonInformation/SolutionLoginInfoLogo"><%= Translate.Translate("Licensed to")%> (<%= Translate.Translate("Logo")%>)</label></td>
					        <td><%= Gui.FileManager(Base.GetGs("/Globalsettings/Settings/CommonInformation/SolutionLoginInfoLogo"), "System", "/Globalsettings/Settings/CommonInformation/SolutionLoginInfoLogo", "jpg,gif,png")%></td>
			            </TR>
						<TR>
					        <td width="170"></td>
							<td><small><%= Translate.Translate("Max")%> w 170 x h 110 px</small></td>
						</TR>
					 <TR>
				            <TD><LABEL for="/Globalsettings/Settings/CommonInformation/Partner"><%=Translate.Translate("Partner")%></LABEL></TD>
				            <TD><INPUT type="text" maxlength="255" value="<%=Server.HtmlEncode(Base.GetGs("/Globalsettings/Settings/CommonInformation/Partner"))%>" class="std" id="/Globalsettings/Settings/CommonInformation/Partner" name="/Globalsettings/Settings/CommonInformation/Partner"></TD>
			            </TR>
			            <TR>
				            <TD valign="top"><LABEL for="/Globalsettings/Settings/CommonInformation/SolutionLoginInfo"><%= Translate.Translate("Solution login info")%></LABEL></TD>
				            <TD><textarea class="std" name="/Globalsettings/Settings/CommonInformation/SolutionLoginInfo"
						            ID="Textarea2" rows="3"><%= Base.GetGs("/Globalsettings/Settings/CommonInformation/SolutionLoginInfo")%></textarea></TD>
			            </TR>
						<TR>
				            <TD><LABEL for="/Globalsettings/Settings/CommonInformation/PartnerEmail"><%= Translate.Translate("Partner e-mail")%></LABEL></TD>
				            <TD><INPUT type="text" maxlength="255" value="<%=Server.HtmlEncode(Base.GetGs("/Globalsettings/Settings/CommonInformation/PartnerEmail"))%>" class="std" id="/Globalsettings/Settings/CommonInformation/PartnerEmail" name="/Globalsettings/Settings/CommonInformation/PartnerEmail"></TD>
			            </TR>
						
					</table>
					</dw:GroupBox>
		            

		            <%=Gui.GroupBoxStart(Translate.Translate("IE 8 Compatibility"))%>
		            <table border="0" cellpadding="2" cellspacing="0">
		            <tr>
			            <td width="170"></td>
			            <td>
				            <%
					            If Base.GetGs("/Globalsettings/Settings/IE8/Mode") = "" Then
						            Base.SetGs("/Globalsettings/Settings/IE8/Mode", "EmulateIE7")
					            End If
				            %>
				            <input type="radio" value="IE8Standards" <%=IIf(Base.GetGs("/Globalsettings/Settings/IE8/Mode") = "IE8Standards", "checked", "")%> id="Mode3" name="/Globalsettings/Settings/IE8/Mode"><label for="Mode3"><%=Translate.Translate("Standards Compliance")%> (<%=Translate.Translate("Standard")%>)</label><br />
				            <input type="radio" value="EmulateIE7" <%=IIf(Base.GetGs("/Globalsettings/Settings/IE8/Mode") = "EmulateIE7", "checked", "")%> id="Mode1" name="/Globalsettings/Settings/IE8/Mode"><label for="Mode1"><%=Translate.Translate("Emulate IE 7")%>: "IE=EmulateIE7"</label><br />
				            <input type="radio" value="IE8Comp" <%=IIf(Base.GetGs("/Globalsettings/Settings/IE8/Mode") = "IE8Comp", "checked", "")%> id="Mode2" name="/Globalsettings/Settings/IE8/Mode"><label for="Mode2"><%=Translate.Translate("Force IE 7 Standards Compliance")%>: "IE=7"</label>
    						
			            </td>
		            </tr>
		            </table>
		            <%=Gui.GroupBoxEnd%>
		            <%=Gui.GroupBoxStart(Translate.Translate("Performance"))%>
		            <TABLE border="0" cellpadding="2" cellspacing="0" ID="Table1">
			            <TR>
				            <TD width="170"></TD>
				            <TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/Performance/AllNavigationImagesInTheSameJavascript") = "True", "checked", "")%> id="/Globalsettings/Settings/Performance/AllNavigationImagesInTheSameJavascript" name="/Globalsettings/Settings/Performance/AllNavigationImagesInTheSameJavascript"><LABEL for="/Globalsettings/Settings/Performance/AllNavigationImagesInTheSameJavascript"><%=Translate.Translate("Alle navigationsbilleder i samme Javascript")%></LABEL></TD>
			            </TR>
			            <TR>
				            <TD></TD>
				            <TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/Performance/ActivateMouseoverTextsOnMenuItems") = "True", "checked", "")%> id="/Globalsettings/Settings/Performance/ActivateMouseoverTextsOnMenuItems" name="/Globalsettings/Settings/Performance/ActivateMouseoverTextsOnMenuItems"><LABEL for="/Globalsettings/Settings/Performance/ActivateMouseoverTextsOnMenuItems"><%=Translate.Translate("Aktiver mouseover tekster på menupunkter")%></LABEL></TD>
			            </TR>
			            <TR>
				            <TD></TD>
				            <TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/Performance/ActivateTitleTextsOnMenuItems") = "True", "checked", "")%> id="/Globalsettings/Settings/Performance/ActivateTitleTextsOnMenuItems" name="/Globalsettings/Settings/Performance/ActivateTitleTextsOnMenuItems"><LABEL for="/Globalsettings/Settings/Performance/ActivateTitleTextsOnMenuItems"><%=Translate.Translate("Aktiver title tekster på menupunkter")%></LABEL></TD>
			            </TR>
			            <TR>
				            <TD></TD>
				            <TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/Performance/DeactivateBrowserCache") = "True", "checked", "")%> id="/Globalsettings/Settings/Performance/DeactivateBrowserCache" name="/Globalsettings/Settings/Performance/DeactivateBrowserCache"><LABEL for="/Globalsettings/Settings/Performance/DeactivateBrowserCache"><%=Translate.Translate("Deaktiver browser cache")%></LABEL></TD>
			            </TR>
			            <tr>
				            <td></td>
				            <td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/Performance/DeactivateParagraphAnchor") = "True", "checked", "")%> id="/Globalsettings/Settings/Performance/DeactivateParagraphAnchor" name="/Globalsettings/Settings/Performance/DeactivateParagraphAnchor"><label for="/Globalsettings/Settings/Performance/DeactivateParagraphAnchor"><%=Translate.Translate("Deaktiver afsnits bogmærke")%></label></td>
			            </tr>
			            <tr>
				            <td></td>
				            <td><input id="/Globalsettings/Settings/Performance/ActivateDropDownCache" <%=IIf(Base.GetGs("/Globalsettings/Settings/Performance/ActivateDropDownCache") = "True", "checked", "")%>="" name="/Globalsettings/Settings/Performance/ActivateDropDownCache" type="checkbox" value="True"><label for="/Globalsettings/Settings/Performance/ActivateDropDownCache"><%=Translate.Translate("Aktiver dropdown cache")%></label></td>
			            </tr>
		            </TABLE>
		            <%=Gui.GroupBoxEnd%>
<%=Gui.GroupBoxStart(Translate.Translate("Google API Includes"))%>
<TABLE border="0" cellpadding="2" cellspacing="0" ID="Table1">
    <TR>
        <TD width="170"></TD>
        <TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/GoogleAPI/jQuery") = "True", "checked", "")%> id="/Globalsettings/Settings/GoogleAPI/jQuery" name="/Globalsettings/Settings/GoogleAPI/jQuery"><LABEL for="/Globalsettings/Settings/GoogleAPI/jQuery">jQuery 1.7</LABEL></TD>
    </TR>
    <TR>
        <TD></TD>
        <TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/GoogleAPI/jQueryUI") = "True", "checked", "")%> id="/Globalsettings/Settings/GoogleAPI/jQueryUI" name="/Globalsettings/Settings/GoogleAPI/jQueryUI"><LABEL for="/Globalsettings/Settings/GoogleAPI/jQueryUI">jQuery UI 1.8.16</LABEL></TD>
    </TR>
    <TR>
        <TD></TD>
        <TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/GoogleAPI/Prototype") = "True", "checked", "")%> id="/Globalsettings/Settings/GoogleAPI/Prototype" name="/Globalsettings/Settings/GoogleAPI/Prototype"><LABEL for="/Globalsettings/Settings/GoogleAPI/Prototype">Prototype 1.7.0.0</LABEL></TD>
    </TR>
    <TR>
        <TD></TD>
        <TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/GoogleAPI/ScriptAculoUs") = "True", "checked", "")%> id="/Globalsettings/Settings/GoogleAPI/ScriptAculoUs" name="/Globalsettings/Settings/GoogleAPI/ScriptAculoUs"><LABEL for="/Globalsettings/Settings/GoogleAPI/ScriptAculoUs">ScriptAculoUs 1.9.0</LABEL></TD>
    </TR>
    <tr>
        <td></td>
        <td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/GoogleAPI/MooTools") = "True", "checked", "")%> id="/Globalsettings/Settings/GoogleAPI/MooTools" name="/Globalsettings/Settings/GoogleAPI/MooTools"><label for="/Globalsettings/Settings/GoogleAPI/MooTools">MooTools 1.4.1</label></td>
    </tr>
    <tr>
        <td></td>
        <td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/GoogleAPI/SWFObject") = "True", "checked", "")%> id="/Globalsettings/Settings/GoogleAPI/SWFObject" name="/Globalsettings/Settings/GoogleAPI/SWFObject"><label for="/Globalsettings/Settings/GoogleAPI/SWFObject">SWFObject 2.2</label></td>
    </tr>
</TABLE>
<%=Gui.GroupBoxEnd%>

<%=Gui.GroupBoxStart(Translate.Translate("Dynamicweb includes and parsers"))%>
<TABLE border="0" cellpadding="2" cellspacing="0" ID="Table2">
    <TR>
        <TD width="170"></TD>
        <TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/DwInclude/DisableHrefNameParser") = "True", "checked", "")%> id="/Globalsettings/Settings/DwInclude/DisableHrefNameParser" name="/Globalsettings/Settings/DwInclude/DisableHrefNameParser"><LABEL for="/Globalsettings/Settings/DwInclude/DisableHrefNameParser">Disable href="#name" parsing</LABEL></TD>
    </TR>
    <TR>
        <TD></TD>
        <TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/DwInclude/DisableDwscript") = "True", "checked", "")%> id="/Globalsettings/Settings/DwInclude/DisableDwscript" name="/Globalsettings/Settings/DwInclude/DisableDwscript"><LABEL for="/Globalsettings/Settings/DwInclude/DisableDwscript">Disable DWScript.js on layouts</LABEL></TD>
    </TR>
	<TR>
        <TD></TD>
        <TD><INPUT type="checkbox" value="True" <%=IIf(String.IsNullOrEmpty(Base.GetGs("/Globalsettings/Settings/DwInclude/EnablePageAndParagraphCompatibilityParsing")) OrElse Base.GetGs("/Globalsettings/Settings/DwInclude/EnablePageAndParagraphCompatibilityParsing") = "True", "checked", "")%> id="Checkbox1" name="/Globalsettings/Settings/DwInclude/EnablePageAndParagraphCompatibilityParsing"><LABEL for="/Globalsettings/Settings/DwInclude/EnablePageAndParagraphCompatibilityParsing">Enable Page and ParagraphSetup compatibility parsing</LABEL></TD>
    </TR>
	
	<TR>
        <TD></TD>
        <TD>
		<INPUT 
		type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/DwInclude/DisablePerformanceComment") = "True", "checked", "")%> id="/Globalsettings/Settings/DwInclude/DisablePerformanceComment" name="/Globalsettings/Settings/DwInclude/DisablePerformanceComment"><LABEL for="/Globalsettings/Settings/DwInclude/DisablePerformanceComment">Disable performance comment</LABEL>
		</TD>
    </TR>
	
</TABLE>
<%=Gui.GroupBoxEnd%>
<%= Gui.GroupBoxStart(Translate.Translate("Designs and layouts"))%> 
    <table border="0" cellpadding="2" cellspacing="0" id="Table4">
        <tr>
            <td width="170"> 
            </td>
            <td>
                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/Designs/UseOnlyDesignsAndLayouts") = "True", "checked", "")%>
                    id="/Globalsettings/Settings/Designs/UseOnlyDesignsAndLayouts" name="/Globalsettings/Settings/Designs/UseOnlyDesignsAndLayouts" />
                <label for="/Globalsettings/Settings/Designs/UseOnlyDesignsAndLayouts"><%= Translate.Translate("Only use designs and layouts (This hides template and stylesheet related functions from the interface)")%></label>
            </td>
        </tr>
        <tr>
            <td width="170"> 
            </td>
            <td>
                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/Designs/IgnoreAllModuleJsAndCss") = "True", "checked", "")%>
                    id="/Globalsettings/Settings/Designs/IgnoreAllModuleJsAndCss" name="/Globalsettings/Settings/Designs/IgnoreAllModuleJsAndCss" />
                <label for="/Globalsettings/Settings/Designs/IgnoreAllModuleJsAndCss"><%= Translate.Translate("Ignore all module js and css when using designs and layouts")%></label>
            </td>
        </tr>
		<tr>
            <td width="170"> 
            </td>
            <td>
                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/Designs/DoNotIncludeBaseHref") = "True", "checked", "")%>
                    id="/Globalsettings/Settings/Designs/DoNotIncludeBaseHref" name="/Globalsettings/Settings/Designs/DoNotIncludeBaseHref" />
                <label for="/Globalsettings/Settings/Designs/DoNotIncludeBaseHref"><%= Translate.Translate("Do not add base href")%></label>
            </td>
        </tr>
		
        <tr>
            <td width="170"> 
            </td>
            <td>
                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/Designs/OptimizeNavigationXml") = "True", "checked", "")%>
                    id="/Globalsettings/Settings/Designs/OptimizeNavigationXml" name="/Globalsettings/Settings/Designs/OptimizeNavigationXml" />
                <label for="/Globalsettings/Settings/Designs/OptimizeNavigationXml"><%= Translate.Translate("Optimize navigation xml")%></label>
            </td>
        </tr>
    </table>
<%=Gui.GroupBoxEnd%>
    <dw:GroupBox ID="GroupBox2" runat="server" Title="Updates">
        <table border="0" cellpadding="2" cellspacing="0" id="Table7">
            <tr>
                <td width="170"> 
                </td>
                <td>
                    <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/Updates/DisableTemplateUpdates") = "True", "checked", "")%>
                        id="/Globalsettings/Settings/Updates/DisableTemplateUpdates" name="/Globalsettings/Settings/Updates/DisableTemplateUpdates" />
                    <label for="/Globalsettings/Settings/Updates/DisableTemplateUpdates"><%= Translate.Translate("Disable all template updates")%></label>
                </td>
            </tr>
        </table>
    </dw:GroupBox>
		            <%
		                If Session("DW_Admin_UserID") < 3 Then
		                    Response.Write(Gui.GroupBoxStart(Translate.Translate("Kundeadgang")))
			            %>
			            <TABLE border="0" cellpadding="2" cellspacing="0">
				            <TR>
					            <TD width="170"><%=Translate.Translate("Standardsprog")%></TD>
					            <TD>
						            <select class="std" name="/Globalsettings/Modules/LanguagePack/DefaultLanguage" id="/Globalsettings/Modules/LanguagePack/DefaultLanguage">
							            <%	
							                If Base.GetGs("/Globalsettings/Modules/LanguagePack/DefaultLanguage") = "" Then
							                    DWAdminLanguage = 1
							                End If

							                Using LanguageConn As System.Data.IDbConnection = Translate.LanguageDB.CreateConnection()
							                    Using cmdLanguage As IDbCommand = LanguageConn.CreateCommand
							                        cmdLanguage.CommandText = "SELECT * FROM [Languages] WHERE LanguageActive=1"
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
					            </TD>
				            </TR>
				            <tr>
					            <td width="170">
						            <%=Translate.Translate("Dynamicweb login URL")%>
					            </td>
					            <td>
						            <select name="/Globalsettings/Settings/DynamicwebLoginUrl" class="std">
							            <option <%=IIf(Base.GetGs("/Globalsettings/Settings/DynamicwebLoginUrl") = "www.dynamicweb.dk", "selected", "")%>="" value="www.dynamicweb.dk">dynamicweb.dk</option>
							            <option <%=IIf(Base.GetGs("/Globalsettings/Settings/DynamicwebLoginUrl") = "www.dynamicweb.se", "selected", "")%> value="www.dynamicweb.se">dynamicweb.se</option>
							            <option <%=IIf(Base.GetGs("/Globalsettings/Settings/DynamicwebLoginUrl") = "www.dynamicweb.no", "selected", "")%>="" value="www.dynamicweb.no">dynamicweb.no</option>
							            <option <%=IIf(Base.GetGs("/Globalsettings/Settings/DynamicwebLoginUrl") = "www.dynamicweb.nl", "selected", "")%>="" value="www.dynamicweb.nl">dynamicweb.nl</option>
							            <option <%=IIf(Base.GetGs("/Globalsettings/Settings/DynamicwebLoginUrl") = "www.dynamicweb.pt", "selected", "")%>="" value="www.dynamicweb.pt">dynamicweb.pt</option>
							            <option <%=IIf(Base.GetGs("/Globalsettings/Settings/DynamicwebLoginUrl") = "www.dynamicweb.biz", "selected", "")%>="" value="www.dynamicweb.biz">dynamicweb.biz</option>
						            </select>
					            </td>
				            </tr>
				            <TR>
					            <TD width="170"><%=Translate.Translate("Vis ved login")%></TD>
					            <TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/CustomerAccess/ShowAreabox") = "True", "checked", "")%> id="DWShow_Areabox" name="/Globalsettings/Settings/CustomerAccess/ShowAreabox">
					            <label for="DWShow_Areabox"><%=Translate.Translate("Sprog", 9)%></label>
					            </TD>
				            </TR>
							<TR>
					            <TD></TD>
					            <TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/CustomerAccess/HideRememberFeatures") = "True", "checked", "")%> id="HideRememberFeatures" name="/Globalsettings/Settings/CustomerAccess/HideRememberFeatures">
					            <label for="HideRememberFeatures"><%= Translate.Translate("Disable save username and password.")%></label>
					            </TD>
				            </TR>
				            <TR>
					            <TD width="170"><%=Translate.Translate("Lås")%></TD>
					            <TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/CustomerAccess/LockStylesheet") = "True", "checked", "")%> id="DWLock_Stylesheet" name="/Globalsettings/Settings/CustomerAccess/LockStylesheet">
					            <label for="DWLock_Stylesheet">
					            <% 
					                If Gui.NewUI() Then
					                    Response.Write(Translate.Translate("Designer (Management Center)"))
					                Else
					                    Response.Write(Translate.Translate("Fanen %%", "%%", Translate.Translate("Stylesheet")))
					                End If
                                %>
					            </label>
					            </TD>
				            </TR>
				            <TR>
					            <TD width="170"></TD>
					            <TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/CustomerAccess/LockTemplateFolder") = "True", "checked", "")%> id="DWLock_Templates" name="/Globalsettings/Settings/CustomerAccess/LockTemplateFolder">
					            <label for="DWLock_Templates"><%=Translate.Translate("Mappen %%","%%",Translate.Translate("Template"))%></label>
					            </TD>
				            </TR>
				            <TR>
					            <TD width="170"></TD>
					            <TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/CustomerAccess/LockNavigationFolder") = "True", "checked", "")%> id="DWLock_Navigation" name="/Globalsettings/Settings/CustomerAccess/LockNavigationFolder">
					            <label for="DWLock_Navigation"><%=Translate.Translate("Mappen %%","%%",Translate.Translate("Navigation"))%></label>
					            </TD>
				            </TR>
				            <TR>
					            <TD width="170"></TD>
					            <TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/CustomerAccess/LockSystemFolder") = "True", "checked", "")%> id="DWLock_System" name="/Globalsettings/Settings/CustomerAccess/LockSystemFolder">
					            <label for="DWLock_System"><%=Translate.Translate("Mappen %%","%%",Translate.Translate("System"))%></label>
					            </TD>
				            </TR>
				            <% If Gui.NewUI() Then%>
				            <tr>
				                <td>&nbsp;</td>
				                <td>
				                    <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/CustomerAccess/LockDeveloperTools") = "True", "checked", "")%> id="DWLock_DeveloperTools" name="/Globalsettings/Settings/CustomerAccess/LockDeveloperTools" />
				                    <label for="DWLock_DeveloperTools"><%=Translate.Translate("Developer (Management Center)")%></label>
				                </td>
				            </tr>
				            <tr>
				                <td>&nbsp;</td>
				                <td>
				                    <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/CustomerAccess/LockMgmtCenter") = "True", "checked", "")%> id="DWLock_LockMgmtCenter" name="/Globalsettings/Settings/CustomerAccess/LockMgmtCenter" />
				                    <label for="DWLock_LockMgmtCenter"><%=Translate.Translate("Management Center")%></label>
				                </td>
				            </tr>
				            <%End If %>
			            </TABLE>
			            <%	
			                Response.Write(Gui.GroupBoxEnd)
			            End If
		            %>
		            <%=Gui.GroupBoxStart(Translate.Translate("Min side"))%>
			            <TABLE border="0" cellpadding="2" cellspacing="0" ID="Table1">
				            <TR>
					            <TD width="170"><LABEL for="/Globalsettings/Settings/MyPage/HideStat"><%=Translate.Translate("Skjul statistik")%></LABEL></TD>
					            <TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Settings/MyPage/HideStat") = "True", "checked", "")%> id="/Globalsettings/Settings/MyPage/HideStat" name="/Globalsettings/Settings/MyPage/HideStat"></TD>
				            </TR>
				            <TR>
					            <TD width="170"><LABEL for="/Globalsettings/Settings/MyPage/CustomInfoBoxURLLocation"><%=Translate.Translate("Seneste nyt side")%></LABEL></TD>
					            <TD><INPUT type="text" class="std" value="<%=Base.GetGs("/Globalsettings/Settings/MyPage/CustomInfoBoxURLLocation")%>" id="/Globalsettings/Settings/MyPage/CustomInfoBoxURLLocation" name="/Globalsettings/Settings/MyPage/CustomInfoBoxURLLocation"></TD>
				            </TR>
			            </TABLE>
		            <%=Gui.GroupBoxEnd%>

		            <%=Gui.GroupBoxStart(Translate.Translate("Brugerdefinerede fejlsider"))%>
			            <table border="0" cellpadding="2" cellspacing="0" id="Table1">
				            <tr>
					            <td width="170"><label for="PageNotFoundRedirectTo"><%=Translate.Translate("HTTP 404")%></label></td>
					            <td><%=Gui.LinkManager(base.GetGs("/Globalsettings/Settings/PageNotFound/RedirectTo"), "PageNotFoundRedirectTo", "")%></td>
				            </tr>
			            </table>
		            <%=Gui.GroupBoxEnd%>


		            
		            <%= Gui.GroupBoxStart(Translate.Translate("Logging"))%>
			            <table border="0" cellpadding="2" cellspacing="0" id="Table3">
				            <tr>
					            <td width="170"></td>
					            <td><label><input type="checkbox" <%=IIf(Base.GetGs("/Globalsettings/Settings/Logging/Disable71Logging") = "True", "checked=""checked """, "")%>name="/Globalsettings/Settings/Logging/Disable71Logging" id="/Globalsettings/Settings/Logging/Disable71Logging" value="True" /><%= Translate.Translate("Disable 7.1 logging (CartV1, CartV2, Payment gateways and Checkout handlers)")%></label></td>
				            </tr>
			            </table>
		            <%=Gui.GroupBoxEnd%>
		          
		            <%= Gui.GroupBoxStart(Translate.Translate("Security"))%>
			            <table border="0" cellpadding="2" cellspacing="0" id="Table5">
				            <tr>
					            <td width="170"></td>
					            <td><label><input type="checkbox" <%=IIf(Base.GetGs("/Globalsettings/Modules/ImportExport/checkToken") = "True", "checked=""checked """, "")%>name="/Globalsettings/Modules/ImportExport/checkToken" id="/Globalsettings/Modules/ImportExport/checkToken" value="True" /><%= Translate.Translate("Check token when activating pipeline runner in Import/export or job runner in Data Integration")%></label></td>
				            </tr>
				            <tr>
					            <td width="170"></td>
					            <td>
                                    <label><input type="checkbox" <%=IIf(Base.GetGs("/Globalsettings/Settings/ForceSSL4Admin") = "True", "checked=""checked """, "")%>name="/Globalsettings/Settings/ForceSSL4Admin" id="/Globalsettings/Settings/ForceSSL4Admin" value="True" /><%= Translate.Translate("Force ssl on /Admin")%></label>
					            </td>
				            </tr>
			            </table>
		            <%=Gui.GroupBoxEnd%>

                    <%If Base.HasVersion("8.5.0.0") Then%>
                    <%= Gui.GroupBoxStart(Translate.Translate("Pdf"))%>
                        <table border="0" cellpadding="2" cellspacing="0" id="Table7">
                            <tr>
					            <td width="170"><label><%= Translate.Translate("Page size")%></label></td>
					            <td>
                                    <select class="std" id="/Globalsettings/Settings/Pdf/PageSize" name="/Globalsettings/Settings/Pdf/PageSize" />
                                    <option value=""><%= Translate.Translate("Not set")%></option>
                                    <%For Each item As PDFClass.PaperSize In [Enum].GetValues(GetType(PDFClass.PaperSize))%>
                                        <%If item <> PDFClass.PaperSize.None Then%>
                                    	    <option value="<%=PDFClass.GetPaperSizeName(item)%>" <%=IIf(PDFClass.GetPaperSizeValue(Base.GetGs("/Globalsettings/Settings/Pdf/PageSize")) = item, "selected", "")%>><%=PDFClass.GetPaperSizeName(item)%></option>
                                        <%End If%>
                                    <%Next%>
                                    </select>
                                </td>
                            </tr>
                        </table>
                    <%=Gui.GroupBoxEnd%>
                    <%End If%>

                    <%If Dynamicweb.Backend.User.Current.IsAngel Then%>
					    <%= Gui.GroupBoxStart(Translate.Translate("File system"))%>
			                <table border="0" cellpadding="2" cellspacing="0" id="Table6">
				                <tr>
					                <td width="170"><label for="/Globalsettings/System/Filesystem/ImagesFolderName"><%= Translate.Translate("Images folder name")%></label></td>
					                <td>
                                        <select class="std" id="/Globalsettings/System/Filesystem/ImagesFolderName" name="/Globalsettings/System/Filesystem/ImagesFolderName"/>
											<option value=""><%= Translate.Translate("Not set")%> (Billeder)</option> 
                                            <option value="Billeder" <%=IIF(Base.GetGs("/Globalsettings/System/Filesystem/ImagesFolderName")="Billeder","selected","")%>="" >Billeder</option> 
                                            <option value="Images" <%=IIF(Base.GetGs("/Globalsettings/System/Filesystem/ImagesFolderName")="Images","selected","")%>="" >Images</option> 
                                       </select>
                                    </td>
				                </tr>                                
			                </table>
		                <%=Gui.GroupBoxEnd%>
                    <%End If%>
	            </TD>
            </TABLE>
    </div>
    <%  Dynamicweb.Backend.Translate.GetEditOnlineScript()
        %>
</asp:Content>
