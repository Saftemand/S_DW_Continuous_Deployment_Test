<%@ Page Language="vb" MasterPageFile="/Admin/Content/Management/EntryContent.Master" AutoEventWireup="false" CodeBehind="EcomAdvConfigAssortments_Edit.aspx.vb" Inherits="Dynamicweb.Admin.EcomAdvConfigAssortments_Edit" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">

    <script language="javascript" type="text/javascript">
        var page = SettingsPage.getInstance();
        
        page.onSave = function() {

            document.getElementById('MainForm').submit();
        }
        
        page.onHelp = function() {
            <%=Gui.help("", "administration.controlpanel.ecom.assortment") %>
        }

    </script>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server" >

    <div id="PageContent">
        <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
            <tr>
                <td valign="top" width="600px">
				    <%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
				        <table cellpadding="3" cellspacing="0" border="0" style="margin: 5px;">
					        <colgroup>
						        <col width="200px" />
						        <col />
                            </colgroup>
                            <tr>
                                <td><%=Translate.Translate("Assortments")%>:</td>
                                <td>
                                    <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Ecom/Assortments/UseAssortments") = "True", "CHECKED", "")%> id="/Globalsettings/Ecom/Assortments/UseAssortments" name="/Globalsettings/Ecom/Assortments/UseAssortments" />
                                </td>
                                <td><%=Translate.Translate("Enable")%></td>
                            </tr>
                        </table>
                    <%=Gui.GroupBoxEnd%>
                </td>
            </tr>
        </table>
    </div>

    <% Translate.GetEditOnlineScript() %>

</asp:Content>
