<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" CodeBehind="DesignerStylesheetSettings_cpl.aspx.vb" Inherits="Dynamicweb.Admin.DesignerStylesheetSettings_cpl" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        var page = SettingsPage.getInstance();
        
        page.onSave = function() {
            document.getElementById('MainForm').submit();
        }
        
        page.onHelp = function() {
            <%=Gui.help("", "administration.managementcenter.designer.stylesheet.settings") %>
        }
    </script>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <div id="PageContent">
        <TABLE border="0" cellpadding="2" cellspacing="0" class="tabTable">
            <tr>
                <td valign="top">
                    <%=Gui.GroupBoxStart(Translate.Translate("Farver"))%>
			            <TABLE border="0" cellpadding="2" cellspacing="0">

				            <TR>
					            <TD width="170"><LABEL for="/Globalsettings/Modules/Stylesheet/Color/WindowsColor"><%=Translate.Translate("Windows farver")%></LABEL></TD>
					            <TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Modules/Stylesheet/Color/WindowsColor") = "True", "checked", "")%> id="/Globalsettings/Modules/Stylesheet/Color/WindowsColor" name="/Globalsettings/Modules/Stylesheet/Color/WindowsColor"></TD>
				            </TR>
				            <TR>
					            <TD><LABEL for="/Globalsettings/Modules/Stylesheet/Color/WebSafeColors"><%=Translate.Translate("Web Safe farver")%></LABEL></TD>
					            <TD><INPUT type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Modules/Stylesheet/Color/WebSafeColors") = "True", "checked", "")%> id="/Globalsettings/Modules/Stylesheet/Color/WebSafeColors" name="/Globalsettings/Modules/Stylesheet/Color/WebSafeColors"></TD>
				            </TR>
    						
				            <tr>
					            <td width="170"><%=Translate.Translate("Baggrundsfarve")%></td>
					            <td><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Modules/Stylesheet/BackgroundColor") = "True", "checked", "")%> id="/Globalsettings/Modules/Stylesheet/BackgroundColor" name="/Globalsettings/Modules/Stylesheet/BackgroundColor"><label for="/Globalsettings/Modules/Stylesheet/BackgroundColor"><%=Translate.Translate("Medtag i CSS fil")%></label></td>
				            </tr>
			            </table>
		            <%=Gui.GroupBoxEnd%>
	                <%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
	                <table border="0" cellpadding="2" cellspacing="0">
		                <tr>
			                <td width="170">
    							
			                </td>
			                <td>
				                <input id="/Globalsettings/Modules/Stylesheet/Settings/DontUseDwCSS" <%=IIf(Base.GetGs("/Globalsettings/Modules/Stylesheet/Settings/DontUseDwCSS") = "True", "checked", "")%>="" name="/Globalsettings/Modules/Stylesheet/Settings/DontUseDwCSS" type="checkbox" value="True">
				                <label for="/Globalsettings/Modules/Stylesheet/Settings/DontUseDwCSS">
					                <%=Translate.Translate("Dont use Dynamicweb generated CSS")%>
				                </label>
			                </td>
		                </tr>
	                </table>
	                <%=Gui.GroupBoxEnd%>
	                <%=Gui.GroupBoxStart(Translate.Translate("Flash"))%>
	                <table border="0" cellpadding="2" cellspacing="0">
		                <tr>
			                <td width="170"><%=Translate.Translate("Embed version")%></td>
			                <td>
			                <%
				                If String.IsNullOrEmpty(Base.GetGs("/Globalsettings/Modules/Stylesheet/Settings/FlashVersion")) Then
					                Base.SetGs("/Globalsettings/Modules/Stylesheet/Settings/FlashVersion", "8")
				                End If
			                 %>
				                <select id="fv" class="std" name="/Globalsettings/Modules/Stylesheet/Settings/FlashVersion">
					                <option <%=IIf(Base.GetGs("/Globalsettings/Modules/Stylesheet/Settings/FlashVersion") = "7", "selected", "")%>="" value="7">7</option>
					                <option <%=IIf(Base.GetGs("/Globalsettings/Modules/Stylesheet/Settings/FlashVersion") = "8", "selected", "")%>="" value="8">8</option>
					                <option <%=IIf(Base.GetGs("/Globalsettings/Modules/Stylesheet/Settings/FlashVersion") = "9", "selected", "")%>="" value="9">9</option>
					                <option <%=IIf(Base.GetGs("/Globalsettings/Modules/Stylesheet/Settings/FlashVersion") = "10", "selected", "")%>="" value="10">10</option>
				                </select>
    							
			                </td>
		                </tr>
		                <tr>
			                <td width="170">
				                <%=Translate.Translate("Wmode")%>
			                </td>
			                <td>
				                <%
					                If String.IsNullOrEmpty(Base.GetGs("/Globalsettings/Modules/Stylesheet/Settings/FlashWmode")) Then
						                Base.SetGs("/Globalsettings/Modules/Stylesheet/Settings/FlashWmode", "Opaque")
					                End If
				                %>
				                <select id="fwm" class="std" name="/Globalsettings/Modules/Stylesheet/Settings/FlashWmode">
					                <option <%=IIf(Base.GetGs("/Globalsettings/Modules/Stylesheet/Settings/FlashWmode") = "Window", "selected", "")%>="" value="Window">Window</option>
					                <option <%=IIf(Base.GetGs("/Globalsettings/Modules/Stylesheet/Settings/FlashWmode") = "Opaque", "selected", "")%>="" value="Opaque">Opaque</option>
					                <option <%=IIf(Base.GetGs("/Globalsettings/Modules/Stylesheet/Settings/FlashWmode") = "Transparent", "selected", "")%>="" value="Transparent">Transparent</option>
				                </select>
			                </td>
		                </tr>
	                </table>
                </td>
            </tr>
        </TABLE>
    </div>
    
    <% Translate.GetEditOnlineScript() %>
</asp:Content>
