<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Status_List.aspx.vb" Inherits="Dynamicweb.Admin.Employee.Status_List" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<LINK REL="STYLESHEET" TYPE="text/css" HREF="/Admin/Stylesheet.css">
<SCRIPT language="javascript">
function ConfirmDelete(elm)
{
	return confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("row"))%>\n(' + elm.ClientCommandArgument + ')');
}
</SCRIPT>
<body MS_POSITIONING="GridLayout">
<form id="ListForm" method="post" runat="server">
<%=Gui.MakeHeaders(Translate.Translate("Medarbejder") & " " & Translate.Translate("status"), Translate.Translate("status"), "all")%>
<TABLE border="0" cellpadding="5" cellspacing="5" class="TabTable">
<div id="Tab1" style="DISPLAY:"/>
<TBODY>
    <TR>
        <TD valign="top">
            <asp:Repeater id="_list" runat="server">
                <HeaderTemplate>
                    <table width="100%" cellpadding="0" cellspacing="1" border="0">
                        <tr>
                            <td width="85%"><b><%=Translate.Translate("status")%></b></td>
                            <td width="30" align="center"><b><%=Translate.Translate("Sorter")%></b></td>
							<td width="10" align="center"><strong>&nbsp;<%=Translate.Translate("Standard")%>&nbsp;</strong></td>
                            <td width="10" align="center"><b><%=Translate.Translate("Slet")%></b></td>
                        </tr>
                        <tr>
                            <td colspan="4" bgcolor="#C4C4C4"><img src="/Admin/images/nothing.gif" width="1" height="1" alt="" border="0"></td>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <a href="Status_Edit.aspx?StatusID=<%#DataBinder.Eval(Container.DataItem, "ID")%>">
								<%#DataBinder.Eval(Container.DataItem, "Name")%>
                            </a>
                        </td>
                        <td align="center"><%# BuildSortLinks(CType(DataBinder.Eval(Container.DataItem, "ID"), Integer), CType(DataBinder.Eval(Container.DataItem, "IsFirst"), Integer), CType(DataBinder.Eval(Container.DataItem, "IsLast"), Boolean))%></td>    
						<td align="center">
							<asp:ImageButton Enabled=<%#(not _isReadonly)%> id="Default" runat="server" CausesValidation=False CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID")%>' OnCommand="ChangeDefault" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "DefaultImage")%>'>
							</asp:ImageButton>
						</td>
			            <td align="center">
							<a runat="server" style="<%#DeleteStyle%>" OnServerClick="OnDelete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID")%>' OnClick='if (!ConfirmDelete(this)) return false;' ClientCommandArgument='<%# Base.JSEnable(DataBinder.Eval(Container.DataItem, "Name"))%>' ID="A1">
								<img src="/Admin/Images/Delete.gif" alt="<%=Translate.Translate("Slet")%>" border="0">
							</a>
						</td>
                    </tr>
                </ItemTemplate>
                <SeparatorTemplate>
                    <tr>
                        <td colspan="4" bgcolor="#C4C4C4"><img src="/Admin/images/nothing.gif" width="1" height="1" alt="" border="0"></td>
                    </tr>
                </SeparatorTemplate>
                <FooterTemplate>
					<tr>
						<td colspan="4" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
					</tr>
                </FooterTemplate>
            </asp:Repeater>
			<tr>
				<td valign="top">
					&nbsp;<asp:Label id="NotFound" runat="server" Text=""><%= Translate.Translate("Ingen fundet")%></asp:Label>
				</td>
			</tr>
	        </table>
        </TD>
    </TR>
    <tr>
	    <td align=right valign=bottom>
		    <table>
			    <tr>
			        <td align="right">
						<%=Gui.Button(Translate.Translate("Ny") & " " & Translate.Translate("Status"), "document.location.href='Status_Edit.aspx'", 0)%>&nbsp;
						<%=Gui.Button(Translate.Translate("Annuller"), "document.location.href='Employee_Options.aspx'", 0)%>
					</td>
			    </tr>
		    </table>
	    </td>
    </tr>    
</TBODY>
</TABLE>
</form>
</body>
</html>
<%Translate.GetEditOnlineScript()%>
