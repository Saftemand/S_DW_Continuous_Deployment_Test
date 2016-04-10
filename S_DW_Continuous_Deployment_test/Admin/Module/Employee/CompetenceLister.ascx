<%@ Import namespace="Dynamicweb"%>
<%@ Import namespace="Dynamicweb.backend" %>
<%@ Control Language="vb" AutoEventWireup="false" Codebehind="CompetenceLister.ascx.vb" Inherits="Dynamicweb.Admin.Employee.CompetenceLister" %>
<table cellSpacing="0" cellPadding="2" width="100%" border="0">
    <asp:repeater id="_repeatComp" Runat="server">
        <HeaderTemplate>
            <tr>
                <td>
                    <table ID="ListerTab" cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr>
                            <td width="45%" align="left"><strong><%=Translate.Translate("Kategorier")%></strong></td>
                            <td width="45%" align="left"><strong><%=Translate.Translate("Kompetence")%></strong></td>
                            <td width="10%" align="center"><strong><%=Translate.Translate("Slet")%></strong></td>
                        </tr>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td align="left"><%# DataBinder.Eval(Container.DataItem, "AccessCompetenceCategoryName") %></td>
                <td align="left"><%# DataBinder.Eval(Container.DataItem, "AccessCompetenceName") %></td>
                <td align="center"><asp:ImageButton OnCommand="_btnDelete_Command" CommandArgument="<%# IncreaseRowIndex()%>" CausesValidation="False" ID="_btnDelete" AlternateText="Delete" ImageUrl="/Admin/Images/Delete.gif" ImageAlign="Middle" BorderWidth="0" Runat="server"></asp:ImageButton></td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
</table>
</td> </tr> </FooterTemplate> </asp:repeater>
<tr>
    <td colSpan="3">
        <table cellSpacing="2" cellPadding="0" width="100%" border="0">
            <tr>
                <td bgColor="#c4c4c4" colSpan="4"><IMG height="1" alt="" src="/Admin/Images/nothing.gif" width="1" border="0"></td>
            </tr>
            <tr>
                <td width="5"></td>
                <td width="170"><asp:label id="_lblCompetence" Runat="server"><%=Translate.Translate("Kompetence")%></asp:label></td>
                <td><asp:dropdownlist id="_lstCategoryCompetence" Runat="server" Width="250px" CssClass="std"></asp:dropdownlist></td>
                <td align="right"><asp:button id="_btnAdd" onclick="_btnAdd_Click" CssClass="buttonSubmit" Runat="server" Text="Add"
                        CausesValidation="False"></asp:button></td>
            </tr>
        </table>
    </td>
</tr>
</TABLE>
