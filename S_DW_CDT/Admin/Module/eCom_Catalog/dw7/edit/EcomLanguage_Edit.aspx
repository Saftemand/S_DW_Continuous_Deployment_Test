<%@ Page Language="vb" AutoEventWireup="false" Codebehind="EcomLanguage_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.LanguageEdit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
	<HEAD>
		<title></title>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		
			<dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
		<link rel="STYLESHEET" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
		
		<style type="text/css">BODY.margin {
	MARGIN: 0px
}
INPUT {
	FONT-SIZE: 11px; FONT-FAMILY: verdana,arial
}
SELECT {
	FONT-SIZE: 11px; FONT-FAMILY: verdana,arial
}
TEXTAREA {
	FONT-SIZE: 11px; FONT-FAMILY: verdana,arial
}
		</style>
        <script type="text/javascript">
            var confirmMsg = '<%= Translate.JsTranslate("Changing the default language will force a localization of not translated products and groups. Do you want to continue?") %>';

            $(document).observe('dom:loaded', function () {
                window.focus(); // for ie8-ie9 
                document.getElementById('Name').focus();
            });

            function saveLanguage(close) {
                if ((!$('IsDefault') || $('IsDefault').checked == false) || confirm(confirmMsg)) {
                    document.getElementById("imgProcessing").style.display = "";
                    document.getElementById("Close").value = close ? 1 : 0;
                    document.getElementById('Form1').SaveButton.click();
                }
            }
        </script>
	    <script type="text/javascript" src="/Admin/FormValidation.js"></script>	
	</HEAD>
	<body style="background: #DFE9F5 url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;" MS_POSITIONING="GridLayout">
		<asp:literal id="BoxStart" runat="server"></asp:literal>
		<form id="Form1" name="Form1" method="post" runat="server">
            <asp:Literal id="errCodeBlock" runat="server"></asp:Literal>
			<dw:tabheader id="TabHeader1" runat="server" TotalWidth="100%"></dw:tabheader>
			<table class="tabTable100" id="DW_Ecom_tableTab" cellSpacing="0" cellPadding="0" border="0">
				<tr>
					<td vAlign="top">
						<div id="Tab1"><br>
								<table style="WIDTH: 95%" cellSpacing="0" cellPadding="0" width="95%" border="0">
									<tr>
										<td>
											<fieldset style="MARGIN: 5px; WIDTH: 100%"><legend class="gbTitle"><%=Translate.Translate("Indstillinger")%></legend>
												<table style="WIDTH: 100%" cellSpacing="0" cellPadding="2" width="100%" border="0">
													<tr>
														<td>
															<table cellSpacing="2" cellPadding="2" width="100%" border="0">
																<tr>
																	<td width="170"><dw:translatelabel id="tLabelName" runat="server" Text="Navn"></dw:translatelabel></td>
																	<td>
				                                                        <div id="errName" name="errName" style="color: Red;"></div>
				                                                        <asp:textbox id="Name" CssClass="NewUIinput" runat="server"></asp:textbox>
                                                                    </td>
																</tr>
                                                                <tr>
                                                                    <td width="170"><dw:TranslateLabel ID ="tLabelLanguagesId" runat="server" Text="ID" /></td>
                                                                    <td>
                                                                        <div id="errId" name="errId" style="color:red;"></div>
                                                                        <asp:textbox id="LangIdBox" Enabled="false" ReadOnly="true" runat="server"></asp:textbox>
                                                                    </td>
                                                                </tr>
																<tr>
																	<td width="170"><dw:translatelabel id="tLabelCode2" runat="server" Text="Landekode %%"></dw:translatelabel></td>
																	<td>
				                                                        <div id="errCode2" name="errCode2" style="color: Red;"></div>
				                                                        <asp:dropdownlist id="Code2" CssClass="NewUIinput" runat="server"></asp:dropdownlist>
																	</td>
																</tr>
																<tr>
																	<td width="170"><dw:translatelabel id="tLabelNativeName" runat="server" Text="Egennavn"></dw:translatelabel></td>
																	<td>
				                                                        <div id="errNativeName" name="errNativeName" style="color: Red;"></div>
				                                                        <asp:textbox id="NativeName" CssClass="NewUIinput" runat="server"></asp:textbox>
																	</td>
																</tr>
																<tr>
																	<td width="170"><dw:translatelabel id="tLabelIsDefault" runat="server" Text="Default"></dw:translatelabel></td>
																	<td><asp:checkbox id="IsDefault" runat="server"></asp:checkbox><asp:CheckBox id="IsDefaultTmp" runat="server" disabled></asp:CheckBox></td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</fieldset>
											<br>
											<br>
										</td>
									</tr>
								</table>
		                        <div id="imgProcessing" style="display: none">
	                                <img src="/Admin/Module/Seo/Dynamicweb_wait.gif" border="0" alt="" />
	                            </div>		
 								<br>                               					
							<asp:button id="SaveButton" style="DISPLAY: none" runat="server"></asp:button><asp:button id="DeleteButton" style="DISPLAY: none" runat="server"></asp:button></div>
                            <input id="Close" type="hidden" name="Close" value="0" />
					</td>
				</tr>
			</table>
		</form>
		<asp:literal id="BoxEnd" runat="server"></asp:literal><asp:literal id="removeDelete" runat="server"></asp:literal>
	<script>
        addMinLengthRestriction('Name', 1, '<%=Translate.JsTranslate("A name is needed")%>');
        addMinLengthRestriction('Code2', 1, '<%=Translate.JsTranslate("A country code needs to be selected")%>');
        addMinLengthRestriction('NativeName', 1, '<%=Translate.JsTranslate("A native name is needed")%>');
        activateValidation('Form1');
    </script>
		<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
	</body>
</HTML>
