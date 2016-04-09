<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Department_List.aspx.vb" Inherits="Dynamicweb.Admin.Employee.Department_List" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.backend" %>
<%@ Import namespace="System.Data" %>
<LINK REL="STYLESHEET" TYPE="text/css" HREF="/Admin/Stylesheet.css">

<SCRIPT language="javascript">
function MoveEmployee(id, dept)
{
	window.open("Menu.aspx?MoveFrom=" + dept + "&MoveID=" + id + "&RequestAction=MoveEmployee", "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=190,height=350,top=155,left=202");

}
function CopyEmployee(id)
{
	window.open("Menu.aspx?CopyID=" + id + "&RequestAction=CopyEmployee", "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=190,height=350,top=155,left=202");
}

function DelEmployee(id, dep, name)
{
    if (confirm('<%=Translate.JsTranslate("Slet %%?", "%%", Translate.JsTranslate("bruger"))%>\n(' + name + ')'))
        document.location.href = "Employee_Del.aspx?ID=" + id + "&Dept=" + dep;
}
</SCRIPT>

<%=Gui.MakeHeaders(Translate.Translate("Afdeling") & " " & _departmentName, Translate.Translate("Medarbejdere"), "all")%>
<TABLE border="0" cellpadding="0" cellspacing="0" class="TabTable">
<TBODY>
    <TR>
        <TD valign="top">
			<div id="Tab1" style="DISPLAY:"/>
            <asp:Repeater id="_list" runat="server">
                <HeaderTemplate>
                    <table width="100%" cellpadding="0" cellspacing="2" border="0">
                        <tr>
                            <td width="30%" nowrap><b><%=Translate.Translate("Navn")%></b></td>
                            <td width="20%" nowrap><b><%=Translate.Translate("Stillingsbetegnelse")%></b></td>
                            <td width="20%" nowrap><b><%=Translate.Translate("Email")%></b></td>
                            <td align="center" nowrap><b><%=Translate.Translate("Sorter")%></b></td>
                            <td nowrap><b><%=Translate.Translate("Flyt")%></b></td>
                            <td nowrap><b><%=Translate.Translate("Kopier")%></b></td>
                            <td nowrap><b><%=Translate.Translate("Slet")%></b></td>
                        </tr>
                        <tr>
                            <td colspan="10" bgcolor="#C4C4C4"><img src="/Admin/images/nothing.gif" width="1" height="1" alt="" border="0"></td>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <a href="Employee_Add.aspx?ID=<%#DataBinder.Eval(Container.DataItem, "AccessUserID")%>&Dept=<%#_id%>">
                                <span style="color:<%#iif(cbool(CType(Container.DataItem,DataRowView)("AccessUserActive")), "", "#C1C1C1;")%>">
                                <%#IIf(Base.ChkString(DataBinder.Eval(Container.DataItem, "AccessUserName")).Trim().Length = 0 AndAlso Base.ChkString(DataBinder.Eval(Container.DataItem, "AccessUserMiddleName")).Trim().Length = 0, _
                                        DataBinder.Eval(Container.DataItem, "AccessUserUserName"), _
                                        Base.ChkString(DataBinder.Eval(Container.DataItem, "AccessUserName")) + "&nbsp;" + Base.ChkString(DataBinder.Eval(Container.DataItem, "AccessUserMiddleName")))%>
                                </span>
                            </a>
                        </td>
                        <td>
                            <span style="color:<%#iif(cbool(CType(Container.DataItem,DataRowView)("AccessUserActive")), "", "#C1C1C1;")%>">
                            <%# DataBinder.Eval(Container.DataItem, "AccessUserJobTitle") %>&nbsp;
                            </span>
                            </td>
                        <td>
                            <a href="mailto:<%# DataBinder.Eval(Container.DataItem, "AccessUserEmail") %>">
                                <span style="color:<%#iif(cbool(CType(Container.DataItem,DataRowView)("AccessUserActive")), "", "#C1C1C1;")%>">
                                <%# DataBinder.Eval(Container.DataItem, "AccessUserEmail") %>
                                </span>
                            </a>&nbsp;</td>
                        <td align="center">
                        <%# BuildSortLinks(CType(Container.DataItem("AccessUserID"), Integer))%>
                        </td>    
			            <td align="center" onClick="MoveEmployee(<%# DataBinder.Eval(Container.DataItem, "AccessUserID") %>, <%#_id%>);" Style="Cursor: Hand;"><img src="/Admin/images/Icons/Page_Move.gif" border="0"></td>
			            <td align="center" onClick="CopyEmployee(<%# DataBinder.Eval(Container.DataItem, "AccessUserID") %>);" Style="Cursor: Hand;"><img src="/Admin/images/Icons/Page_Copy.gif" border="0"></td>
			            <td align="center"><a href="JavaScript:DelEmployee(<%#DataBinder.Eval(Container.DataItem, "AccessUserID")%>, <%#_id%>, '<%#Base.JSEnable(Server.HtmlEncode(CType(Container.DataItem,DataRowView)("AccessUserName").ToString()))%>')"><img src="/Admin/images/Delete.gif" alt="<%=Translate.Translate("Slet")%>" border="0"></a></td>
                    </tr>
                </ItemTemplate>
                <SeparatorTemplate>
                    <tr>
                        <td colspan="10" bgcolor="#C4C4C4"><img src="/Admin/images/nothing.gif" width="1" height="1" alt="" border="0"></td>
                    </tr>
                </SeparatorTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
            <asp:Label id="_nodataLabel" runat="server" Visible="False" Height="27px"><%=Translate.Translate("Ingen medarbejdere i denne afdeling")%></asp:Label>
        </TD>
    </TR>
    <tr>
	    <td align=right valign=bottom>
		    <table>
			    <tr>
			        <td align="right"><%=Gui.Button(Translate.Translate("Ny") & " " & Translate.Translate("medarbejder"), "document.location.href='Employee_Add.aspx?Dept="&_id & "'", 0)%></td>
			    </tr>
		    </table>
	    </td>
    </tr>    
</TBODY>
</TABLE>
<%Translate.GetEditOnlineScript()%>