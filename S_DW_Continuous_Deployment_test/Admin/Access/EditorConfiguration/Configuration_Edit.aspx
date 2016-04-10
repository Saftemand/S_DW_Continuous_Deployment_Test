<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Configuration_Edit.aspx.vb"
    Inherits="Dynamicweb.Admin.Configuration_Edit" CodePage="65001" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Configuration_Edit</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1" />
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1" />
    <meta name="vs_defaultClientScript" content="JavaScript" />
    <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5" />
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" runat="server" />
    <script src="/Admin/Module/Common/Validation.js" type="text/javascript"></script>
    <script type="text/javascript">
	function init(){
	    try {
		    parent.document.getElementById("ListUsers").innerHTML = document.body.innerHTML;
        } catch(e) {
        //Nothing
		}
	}

	function ValidateThisForm()
	{
		var form = parent.document.getElementById("ConfigurationEdit");
		var controlToValidate = form.elements["name"];
		ValidateForm(form, controlToValidate,
			"<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>");
	}
	
	var returnURL = '<%=Base.ChkString(Base.Request("ReturnURL")) %>';
	function SaveEvent() 
	{
		var form = document.getElementById("ConfigurationEdit");
		form.target = '';
		form.action = 'Configuration_Edit.aspx?ReturnURL=' + returnURL;
		
		var controlToValidate = form.elements["name"];
		ValidateForm(form, controlToValidate, '<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>');
	}
	
	function CancelEvent() 
	{
	    location = returnURL;
	}

	function save(doClose) {
	    var form = document.getElementById("AddinConfigurationEdit");
	    if (doClose) {
	        form.action = 'Configuration_Edit.aspx?doClose=true';
	    }
	    form.submit();
	}
	function cancel() {
	    document.location.href = "../../Content/Management/Pages/EditingConfigurationsSettings_cpl.aspx";
	}
    </script>
</head>
<body onload="init();">
<%If Not TextEditorAddIn.UseProviderBasedEditors Then%>
<%=Gui.MakeHeaders(Translate.Translate("Konfiguration"), Translate.Translate("Konfiguration"), "All", False, "")%>
<%End If%>
    <div id="AddinBasedConfigurationDiv" runat="server" visible="False">
        <asp:Literal ID="AddinSelectorScripts" runat="server"></asp:Literal>
        <div id="divToolbar" style="height: auto; min-width: 600px;">
            <dw:Toolbar ID="Buttons" runat="server" ShowEnd="false">
                <dw:ToolbarButton ID="cmdSave" runat="server" Divide="None" Image="Save"
                    Text="Save" OnClientClick="save(false);" ShowWait="True">
                </dw:ToolbarButton>
                <dw:ToolbarButton ID="cmdSaveAndClose" runat="server" Divide="None" Image="SaveAndClose"
                    Text="Save and close" OnClientClick="save(true);" ShowWait="True">
                </dw:ToolbarButton>
                <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="None" Image="Cancel" Text="Cancel"
                    OnClientClick="cancel()" ShowWait="True">
                </dw:ToolbarButton>
            </dw:Toolbar>
            <h2 class="subtitle">
                <dw:TranslateLabel ID="lbSubTitle" Text="Editor configuration" runat="server" />
            </h2>
        </div>
        <dw:Infobar runat="server" ID="InfoBarErrorMessages" Visible="False">
        </dw:Infobar>
        <form id="AddinConfigurationEdit" method="post" action="Configuration_Edit.aspx"
        runat="server">
        <input type="hidden" id="editorConfigurationId" runat="server" />
        <br />
        <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
            <tr>
                <td>
                    <fieldset style="width: 100%; margin: 5px; border-width: 0">
                        <div style="width: 170px; float: left">
                            <label><dw:TranslateLabel Text="Configuration Name" runat="server" /></label>
                        </div>
                        <div style="float: left; margin-left: 5px">
                            <input type="text" runat="Server" id="ProviderConfigurationName" class="std"/>
                        </div>
                    </fieldset>
                </td>
            </tr>
            <tr>
                <td>
                    <div runat="server" id="AddinBasedEditorConfigurationDiv">
                        <de:AddInSelector runat="server" ID="addinSelector" AddInTypeName="Dynamicweb.Extensibility.TextEditorAddIn" AddInShowNothingSelected="false"
                            useNewUI="True" />
                    </div>
                    <asp:Literal ID="AddinSelectorLoadScripts" runat="server"></asp:Literal>
                </td>
            </tr>
        </table>
        </form>
    </div>
    <form id="ConfigurationEdit" method="post" action="EditorConfiguration/Configuration_Edit.aspx" target="AccessListUsers">
    <table border="0" cellpadding="0" cellspacing="0" width="600" class="tabTable" runat="server"
        id="ClassicConfigTable">
        <tr>
            <td valign="top">
                <input type="hidden" name="ConfigurationID" value="<%=Configuration.Id%>" />
                <input type="hidden" name="Action" value="save" />
                <div id="Tab1">
                    <table border="0" cellpadding="0" width="598" height="100%">
                        <tr>
                            <td valign="top">
                                <br />
                                <%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
                                <table border="0" cellpadding="0" width="100%">
                                    <tr>
                                        <td width="170px">
                                            <%=Translate.Translate("Navn")%>
                                        </td>
                                        <td>
                                            <input type="text" name="name" maxlength="255" id="configurationName" value="<%=Server.HtmlEncode(Configuration.Name)%>"
                                                class="std">
                                        </td>
                                    </tr>
                                </table>
                                <%=Gui.GroupBoxEnd()%>
                                <%=Gui.GroupBoxStart(Translate.Translate("Værktøjslinier"))%>
                                <table border="0" cellpadding="2" cellspacing="0">
                                    <tr>
                                        <td colspan="2">
                                            <strong>
                                                <%=Translate.Translate("Funktioner",2)%></strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Source") = "True", "checked", "")%>
                                                id="Source" name="Source">
                                        </td>
                                        <td>
                                            <label for="Source">
                                                <%=Translate.Translate("Kilde")%></label>
                                        </td>
                                    </tr>
                                    <!--TR>
												<TD style="padding-left:40px;">			
													<INPUT type="checkbox" value="True" <%=IIf(Configuration.Value("DocProps") = "True", "checked", "")%> id="DocProps" name="DocProps">
												</TD>
												<TD><LABEL for="DocProps"><%=Translate.Translate("Egenskaber")%></LABEL>
												</TD>
											</TR-->
                                    <!--TR>
												<TD style="padding-left:40px;">			
													<INPUT type="checkbox" value="True" <%=IIf(Configuration.Value("Save") = "True", "checked", "")%> id="Save" name="Save">
												</TD>
												<TD><LABEL for="Save"><%=Translate.Translate("Gem")%></LABEL>
												</TD>
											</TR-->
                                    <!--TR>
												<TD style="padding-left:40px;">			
													<INPUT type="checkbox" value="True" <%=IIf(Configuration.Value("NewPage") = "True", "checked", "")%> id="NewPage" name="NewPage">
												</TD>
												<TD><LABEL for="NewPage"><%=Translate.Translate("Ny side")%></LABEL>
												</TD>
											</TR-->
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("FitWindow") = "True", "checked", "")%>
                                                id="FitWindow" name="FitWindow">
                                        </td>
                                        <td>
                                            <label for="FitWindow">
                                                <%=Translate.Translate("Maximize window")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Preview") = "True", "checked", "")%>
                                                id="Preview" name="Preview">
                                        </td>
                                        <td>
                                            <label for="Preview">
                                                <%=Translate.Translate("Preview")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Templates") = "True", "checked", "")%>
                                                id="Templates" name="Templates">
                                        </td>
                                        <td>
                                            <label for="Templates">
                                                <%=Translate.Translate("Templates")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Print") = "True", "checked", "")%>
                                                id="Print" name="Print">
                                        </td>
                                        <td>
                                            <label for="Print">
                                                <%=Translate.Translate("Udskriv")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("SpellCheck") = "True", "checked", "")%>
                                                id="SpellCheck" name="SpellCheck">
                                        </td>
                                        <td>
                                            <label for="SpellCheck">
                                                <%=Translate.Translate("Stavekontrol")%></label>
                                        </td>
                                    </tr>
                                    <!-- <tr>
							                    <td style="padding-left:40px;">			
								                    <input type="checkbox" value="True" <%=IIf(Configuration.Value("GoogleTranslate") = "True", "checked", "")%> id="GoogleTranslate" name="GoogleTranslate">
							                    </td>
							                    <td><label for="GoogleTranslate"><%=Translate.Translate("Translate")%></label>
							                    </td>
						                    </tr> -->
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("UniversalKey") = "True", "checked", "")%>
                                                id="UniversalKey" name="UniversalKey">
                                        </td>
                                        <td>
                                            <label for="UniversalKey">
                                                <%=Translate.Translate("Universaltastatur")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <strong>
                                                <%=Translate.Translate("Rediger",2)%></strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Cut") = "True", "checked", "")%>
                                                id="Cut" name="Cut">
                                        </td>
                                        <td>
                                            <label for="Cut">
                                                <%=Translate.Translate("Klip")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Copy") = "True", "checked", "")%>
                                                id="Copy" name="Copy">
                                        </td>
                                        <td>
                                            <label for="Copy">
                                                <%=Translate.Translate("Kopier")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Paste") = "True", "checked", "")%>
                                                id="Paste" name="Paste">
                                        </td>
                                        <td>
                                            <label for="Paste">
                                                <%=Translate.Translate("Sæt ind")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("PasteText") = "True", "checked", "")%>
                                                id="PasteText" name="PasteText">
                                        </td>
                                        <td>
                                            <label for="PasteText">
                                                <%=Translate.Translate("Sæt ind som tekst")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("PasteWord") = "True", "checked", "")%>
                                                id="PasteWord" name="PasteWord">
                                        </td>
                                        <td>
                                            <label for="PasteWord">
                                                <%=Translate.Translate("Sæt ind fra Word")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("DwInsertCode") = "True", "checked", "")%>
                                                id="DwInsertCode" name="DwInsertCode">
                                        </td>
                                        <td>
                                            <label for="PasteWord">
                                                <%=Translate.Translate("Paste code")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Undo") = "True", "checked", "")%>
                                                id="Undo" name="Undo">
                                        </td>
                                        <td>
                                            <label for="Undo">
                                                <%=Translate.Translate("Fortryd")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Redo") = "True", "checked", "")%>
                                                id="Redo" name="Redo">
                                        </td>
                                        <td>
                                            <label for="Redo">
                                                <%=Translate.Translate("Annuller fortryd")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Find") = "True", "checked", "")%>
                                                id="Find" name="Find">
                                        </td>
                                        <td>
                                            <label for="Find">
                                                <%=Translate.Translate("Find")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Replace") = "True", "checked", "")%>
                                                id="Replace" name="Replace">
                                        </td>
                                        <td>
                                            <label for="Replace">
                                                <%=Translate.Translate("Erstat")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("SelectAll") = "True", "checked", "")%>
                                                id="SelectAll" name="SelectAll">
                                        </td>
                                        <td>
                                            <label for="SelectAll">
                                                <%=Translate.Translate("Marker alt",1)%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <strong>
                                                <%=Translate.Translate("Indsæt",2)%></strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Link") = "True", "checked", "")%>
                                                id="Link" name="Link">
                                        </td>
                                        <td>
                                            <label for="Link">
                                                <%=Translate.Translate("Link")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Unlink") = "True", "checked", "")%>
                                                id="Unlink" name="Unlink">
                                        </td>
                                        <td>
                                            <label for="Unlink">
                                                <%=Translate.Translate("Fjern link")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("DwPageLink") = "True", "checked", "")%>
                                                id="DwPageLink" name="DwPageLink">
                                        </td>
                                        <td>
                                            <label for="DwPageLink">
                                                <%=Translate.Translate("Internal link")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Anchor") = "True", "checked", "")%>
                                                id="Anchor" name="Anchor">
                                        </td>
                                        <td>
                                            <label for="Anchor">
                                                <%=Translate.Translate("Bogmærke")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Image") = "True", "checked", "")%>
                                                id="Image" name="Image">
                                        </td>
                                        <td>
                                            <label for="Image">
                                                <%=Translate.Translate("Billede")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Flash") = "True", "checked", "")%>
                                                id="Flash" name="Flash">
                                        </td>
                                        <td>
                                            <label for="Flash">
                                                <%=Translate.Translate("Flash")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Table") = "True", "checked", "")%>
                                                id="Table" name="Table">
                                        </td>
                                        <td>
                                            <label for="Table">
                                                <%=Translate.Translate("Tabel")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Rule") = "True", "checked", "")%>
                                                id="Rule" name="Rule">
                                        </td>
                                        <td>
                                            <label for="Rule">
                                                <%=Translate.Translate("Vandret linie")%></label>
                                        </td>
                                    </tr>
                                    <!--TR>
												<TD style="padding-left:40px;">			
													<INPUT type="checkbox" value="True" <%=IIf(Configuration.Value("Smiley") = "True", "checked", "")%> id="Smiley" name="Smiley">
												</TD>
												<TD><LABEL for="Smiley"><%=Translate.Translate("Smiley")%></LABEL>
												</TD>
											</TR-->
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("SpecialChar") = "True", "checked", "")%>
                                                id="SpecialChar" name="SpecialChar">
                                        </td>
                                        <td>
                                            <label for="SpecialChar">
                                                <%=Translate.Translate("Symbol")%></label>
                                        </td>
                                    </tr>
                                    <!--TR>
												<TD style="padding-left:40px;">			
													<INPUT type="checkbox" value="True" <%=IIf(Configuration.Value("PageBreak") = "True", "checked", "")%> id="PageBreak" name="PageBreak">
												</TD>
												<TD><LABEL for="PageBreak"><%=Translate.Translate("Sideskift")%></LABEL>
												</TD>
											</TR-->
                                    <tr>
                                        <td colspan="2">
                                            <strong>
                                                <%=Translate.Translate("Formatering",2)%></strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Bold") = "True", "checked", "")%>
                                                id="Bold" name="Bold">
                                        </td>
                                        <td>
                                            <label for="Bold">
                                                <%=Translate.Translate("Fed")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Italic") = "True", "checked", "")%>
                                                id="Italic" name="Italic">
                                        </td>
                                        <td>
                                            <label for="Italic">
                                                <%=Translate.Translate("Kursiv")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Underline") = "True", "checked", "")%>
                                                id="Underline" name="Underline">
                                        </td>
                                        <td>
                                            <label for="Underline">
                                                <%=Translate.Translate("Understreget")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("StrikeThrough") = "True", "checked", "")%>
                                                id="StrikeThrough" name="StrikeThrough">
                                        </td>
                                        <td>
                                            <label for="StrikeThrough">
                                                <%=Translate.Translate("Overstreget")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Subscript") = "True", "checked", "")%>
                                                id="Subscript" name="Subscript">
                                        </td>
                                        <td>
                                            <label for="Subscript">
                                                <%=Translate.Translate("Sænket skrift")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Superscript") = "True", "checked", "")%>
                                                id="Superscript" name="Superscript">
                                        </td>
                                        <td>
                                            <label for="Superscript">
                                                <%=Translate.Translate("Hævet skrift")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("RemoveFormat") = "True", "checked", "")%>
                                                id="RemoveFormat" name="RemoveFormat">
                                        </td>
                                        <td>
                                            <label for="RemoveFormat">
                                                <%=Translate.Translate("Fjern formatering")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <strong>
                                                <%=Translate.Translate("Justering",2)%></strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("JustifyLeft") = "True", "checked", "")%>
                                                id="JustifyLeft" name="JustifyLeft">
                                        </td>
                                        <td>
                                            <label for="JustifyLeft">
                                                <%=Translate.Translate("Venstrejusteret")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("JustifyCenter") = "True", "checked", "")%>
                                                id="JustifyCenter" name="JustifyCenter">
                                        </td>
                                        <td>
                                            <label for="JustifyCenter">
                                                <%=Translate.Translate("Centreret")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("JustifyRight") = "True", "checked", "")%>
                                                id="JustifyRight" name="JustifyRight">
                                        </td>
                                        <td>
                                            <label for="JustifyRight">
                                                <%=Translate.Translate("Højrejusteret")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("JustifyFull") = "True", "checked", "")%>
                                                id="JustifyFull" name="JustifyFull">
                                        </td>
                                        <td>
                                            <label for="JustifyFull">
                                                <%=Translate.Translate("Lige margener",1)%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("OrderedList") = "True", "checked", "")%>
                                                id="OrderedList" name="OrderedList">
                                        </td>
                                        <td>
                                            <label for="OrderedList">
                                                <%=Translate.Translate("Talopstilling")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("UnorderedList") = "True", "checked", "")%>
                                                id="UnorderedList" name="UnorderedList">
                                        </td>
                                        <td>
                                            <label for="UnorderedList">
                                                <%=Translate.Translate("Punktopstilling")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Outdent") = "True", "checked", "")%>
                                                id="Outdent" name="Outdent">
                                        </td>
                                        <td>
                                            <label for="Outdent">
                                                <%=Translate.Translate("Formindsk indrykning")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Indent") = "True", "checked", "")%>
                                                id="Indent" name="Indent">
                                        </td>
                                        <td>
                                            <label for="Indent">
                                                <%=Translate.Translate("Forøg indrykning")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input id="Blockquote" <%=IIf(Configuration.Value("Blockquote") = "True", "checked", "")%>
                                                name="Blockquote" type="checkbox" value="True">
                                        </td>
                                        <td>
                                            <label for="Blockquote">
                                                <%=Translate.Translate("Blockquote")%>
                                            </label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <strong>
                                                <%=Translate.Translate("Typografi",2)%></strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("Style") = "True", "checked", "")%>
                                                id="Style" name="Style">
                                        </td>
                                        <td>
                                            <label for="Style">
                                                <%=Translate.Translate("Typografi")%></label>
                                        </td>
                                    </tr>
                                    <!--TR>
												<TD style="padding-left:40px;">			
													<INPUT type="checkbox" value="True" <%=IIf(Configuration.Value("FontFormat") = "True", "checked", "")%> id="FontFormat" name="FontFormat">
												</TD>
												<TD><LABEL for="FontFormat"><%=Translate.Translate("Typografi")%></LABEL>
												</TD>
											</TR-->
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("FontName") = "True", "checked", "")%>
                                                id="FontName" name="FontName">
                                        </td>
                                        <td>
                                            <label for="FontName">
                                                <%=Translate.Translate("Skrifttype")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("FontSize") = "True", "checked", "")%>
                                                id="FontSize" name="FontSize">
                                        </td>
                                        <td>
                                            <label for="FontSize">
                                                <%=Translate.Translate("Skriftstørrelse")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("TextColor") = "True", "checked", "")%>
                                                id="TextColor" name="TextColor">
                                        </td>
                                        <td>
                                            <label for="TextColor">
                                                <%=Translate.Translate("Tekst farve")%></label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 40px;">
                                            <input type="checkbox" value="True" <%=IIf(Configuration.Value("BGColor") = "True", "checked", "")%>
                                                id="BGColor" name="BGColor">
                                        </td>
                                        <td>
                                            <label for="BGColor">
                                                <%=Translate.Translate("Baggrundsfarve")%></label>
                                        </td>
                                    </tr>
                                    <!--TR> DO NOT DELETE, we might need it later
												<TD colspan=2><strong><%=Translate.Translate("Formularer",2)%></strong></TD>
											</TR>
											<TR>
												<TD style="padding-left:40px;">			
													<INPUT type="checkbox" value="True" <%=IIf(Configuration.Value("Form") = "True", "checked", "")%> id="Form" name="Form">
												</TD>
												<TD><LABEL for="Form"><%=Translate.Translate("Formular")%></LABEL>
												</TD>
											</TR>
											<TR>
												<TD style="padding-left:40px;">			
													<INPUT type="checkbox" value="True" <%=IIf(Configuration.Value("Checkbox") = "True", "checked", "")%> id="Checkbox" name="Checkbox">
												</TD>
												<TD><LABEL for="Checkbox"><%=Translate.Translate("Checkboks")%></LABEL>
												</TD>
											</TR>
											<TR>
												<TD style="padding-left:40px;">			
													<INPUT type="checkbox" value="True" <%=IIf(Configuration.Value("Radio") = "True", "checked", "")%> id="Radio" name="Radio">
												</TD>
												<TD><LABEL for="Radio"><%=Translate.Translate("Radio-knap")%></LABEL>
												</TD>
											</TR>
											<TR>
												<TD style="padding-left:40px;">			
													<INPUT type="checkbox" value="True" <%=IIf(Configuration.Value("TextField") = "True", "checked", "")%> id="TextField" name="TextField">
												</TD>
												<TD><LABEL for="TextField"><%=Translate.Translate("Tekstfelt")%></LABEL>
												</TD>
											</TR>
											<TR>
												<TD style="padding-left:40px;">			
													<INPUT type="checkbox" value="True" <%=IIf(Configuration.Value("Textarea") = "True", "checked", "")%> id="Textarea" name="Textarea">
												</TD>
												<TD><LABEL for="Textarea"><%=Translate.Translate("Tekstområde")%></LABEL>
												</TD>
											</TR>
											<TR>
												<TD style="padding-left:40px;">			
													<INPUT type="checkbox" value="True" <%=IIf(Configuration.Value("Select") = "True", "checked", "")%> id="Select" name="Select">
												</TD>
												<TD><LABEL for="Select"><%=Translate.Translate("Liste")%></LABEL>
												</TD>
											</TR>
											<TR>
												<TD style="padding-left:40px;">			
													<INPUT type="checkbox" value="True" <%=IIf(Configuration.Value("Button") = "True", "checked", "")%> id="Button" name="Button">
												</TD>
												<TD><LABEL for="Button"><%=Translate.Translate("Knap")%></LABEL>
												</TD>
											</TR>
											<TR>
												<TD style="padding-left:40px;">			
													<INPUT type="checkbox" value="True" <%=IIf(Configuration.Value("ImageButton") = "True", "checked", "")%> id="ImageButton" name="ImageButton">
												</TD>
												<TD><LABEL for="ImageButton"><%=Translate.Translate("Billedknap")%></LABEL>
												</TD>
											</TR>
											<TR>
												<TD style="padding-left:40px;">			
													<INPUT type="checkbox" value="True" <%=IIf(Configuration.Value("HiddenField") = "True", "checked", "")%> id="HiddenField" name="HiddenField">
												</TD>
												<TD><LABEL for="HiddenField"><%=Translate.Translate("Skjult felt")%></LABEL>
												</TD>
											</TR-->
                                </table>
                                <%=Gui.GroupBoxEnd%>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" valign="bottom">
                                <table cellspacing="5">
                                    <tr>
                                        <%If Base.Request("ReturnURL") <> "" Then%>
                                        <td>
                                            <%=Gui.Button(Translate.Translate("Gem"), "SaveEvent();", 0)%>
                                        </td>
                                        <td>
                                            <%=Gui.Button(Translate.Translate("Annuller"), "CancelEvent();", 0)%>
                                        </td>
                                        <%Else%>
                                        <td>
                                            <%=Gui.Button(Translate.Translate("Gem"), "window.frames.AccessListUsers.ValidateThisForm()", 0)%>
                                        </td>
                                        <td>
                                            <%=Gui.Button(Translate.Translate("Annuller"), "EditorConfigurations();", 0)%>
                                        </td>
                                        <%End If%>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
<%
    Translate.GetEditOnlineScript()
%>