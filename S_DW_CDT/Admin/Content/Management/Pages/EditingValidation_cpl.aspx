<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" Codebehind="EditingValidation_cpl.aspx.vb" Inherits="Dynamicweb.Admin.EditingValidation_cpl" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <script language="javascript" type="text/javascript" src="/Admin/Module/Common/Validation.js"></script>
    
    <script type="text/javascript">
        var page = SettingsPage.getInstance();

        page.onSave = function() {
            page.submit();
        }

        function onChangeNotify(checkbox) {
            var rows = ['rowNotify'];

            for (var i = 0; i < rows.length; i++) {
                var row = document.getElementById(rows[i]);
                if (row)
                    row.style.display = (checkbox.checked ? '' : 'none');
            }
        }
    </script>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <div id="PageContent">
        <TABLE border="0" cellpadding="2" cellspacing="0" class="tabTable">
		    <TR>
			    <TD valign="top">
				    <%=Gui.GroupBoxStart(Translate.Translate("Markup validation"))%>
				    <table border="0" cellpadding="2" cellspacing="0" width="100%" style="table-layout: fixed">
				         <tr>
				            <td width="170">
				                
				            </td>
				            <td>
				                <input type="checkbox" value="True" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Settings/MarkupValidation/HideButton")), "checked", String.Empty)%> 
                                    id="/Globalsettings/Settings/MarkupValidation/HideButton" name="/Globalsettings/Settings/MarkupValidation/HideButton" />
                                    <label for="/Globalsettings/Settings/MarkupValidation/HideButton">
				                    <%=Translate.Translate("Hide setting on page")%>
				                </label>
				            </td>
				        </tr>
				        <tr>
				            <td width="170">
				                
				            </td>
				            <td>
				                <input type="checkbox" value="True" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Settings/MarkupValidation/ShowWarnings")), "checked", String.Empty)%> 
                                    id="/Globalsettings/Settings/MarkupValidation/ShowWarnings" name="/Globalsettings/Settings/MarkupValidation/ShowWarnings" />
                                    <label for="/Globalsettings/Settings/MarkupValidation/ShowWarnings">
				                    <%=Translate.Translate("Show warnings")%>
				                </label>
				            </td>
				        </tr>
				        <tr>
				            <td>
				                
				            </td>
				            <td>
				                <input type="checkbox" value="True" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Settings/MarkupValidation/ValidateTopLevel")), "checked", String.Empty)%> 
                                    id="/Globalsettings/Settings/MarkupValidation/ValidateTopLevel" name="/Globalsettings/Settings/MarkupValidation/ValidateTopLevel" />
                                    <label for="/Globalsettings/Settings/MarkupValidation/ValidateTopLevel">
				                    <%=Translate.Translate("Validate top-level pages")%>
				                </label>
				            </td>
				        </tr>
				        <tr>
				            <td>
				               
				            </td>
				            <td>
				                <input type="checkbox" onclick="onChangeNotify(this);" value="True" <%=IIf(Base.ChkBoolean(Base.GetGs("/Globalsettings/Settings/MarkupValidation/EnableNotification")), "checked", String.Empty)%> 
                                    id="/Globalsettings/Settings/MarkupValidation/EnableNotification" name="/Globalsettings/Settings/MarkupValidation/EnableNotification" />      
                                     <label for="/Globalsettings/Settings/MarkupValidation/EnableNotification">
				                    <%=Translate.Translate("Notificering_ved_ændring")%>
                                </label>
				            </td>
				        </tr>
				       </table>
				    <%=Gui.GroupBoxEnd()%>
					
				        <div id="rowNotify" style="display: <%=Base.IIF(Base.ChkBoolean(Base.GetGs("/Globalsettings/Settings/MarkupValidation/EnableNotification")), String.Empty, "none")%>">
				        <dw:GroupBox ID="GroupBox1" runat="server" Title="Notificering_ved_ændring">
				            
				                <table>
				                    <tr>
                                        <td width="170">
                                            <%=Translate.Translate("Subject")%>
                                        </td>
                                        <td>
                                            <input type="text" class="std" value='<%=Base.GetGs("/Globalsettings/Settings/MarkupValidation/EmailSubject") %>'
                                                id="Text1" name="/Globalsettings/Settings/MarkupValidation/EmailSubject" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=Translate.Translate("Email")%>
                                        </td>
                                        <td>
                                            <input type="text" class="std" value='<%=Base.GetGs("/Globalsettings/Settings/MarkupValidation/SendResultsTo") %>' 
                                                id="Text2" name="/Globalsettings/Settings/MarkupValidation/SendResultsTo" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%=Translate.Translate("Template")%>
                                        </td>
                                        <td>
                                            <%=Gui.FileManager(Base.GetGs("/Globalsettings/Settings/MarkupValidation/Template"), "Templates/Validation", "/Globalsettings/Settings/MarkupValidation/Template")%>
                                        </td>
                                    </tr>
				                </table>
				            
				            </dw:GroupBox>
				        </div>
				    

				    </td>
			    </TD>
		    <TR>
    </TABLE>
</div>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</asp:Content>
