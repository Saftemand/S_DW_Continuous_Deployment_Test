<%@ Control Language="vb" AutoEventWireup="false" Codebehind="UCReportTree.ascx.vb"
    Inherits="Dynamicweb.Admin.StatisticsV3.UCReportTree" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%=JavaArray%>
<span>
    <dw:TranslateLabel ID="NoNewslettersReceived" runat="server" Visible="false" Text="There are not recipients." />
</span>
<table id="trControl" runat="server" visible="true" width="512px" cellpadding="0"
    cellspacing="0">
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td valign="top" rowspan="2" style="width: 35px;">
                        <img src="<%=_hostname%>/Admin/Images/Icons/Statv2_Report_heading.gif" width="32"
                            height="36" alt="" border="0"></td>
                    <td style="border-bottom: 1px solid #cccccc;">
                        <strong style="color: #003366"><b><span id="lblPreDdlText" runat="server"></span></b>
                            <select class="std" id="ddl" style="width: 53px" runat="server">
                            </select>
                            <b><span id="lblPostDdlText" runat="server"></span></b></strong>
                    </td>
                    <td style="border-bottom: 1px solid #cccccc;" align="right">
                        &nbsp;
                        <asp:ImageButton Width="21" Height="20" runat="server" ID="HideList" Visible="false"
                            ImageUrl="/Admin/Images/ExpandTree_off.gif" />
                        <asp:ImageButton Width="21" Height="20" runat="server" ID="ExpandList" ImageUrl="/Admin/Images/ExpandTree_on.gif" />
                    </td>
                    <td style="border-bottom: 1px solid #cccccc; width: 80px;">
                        &nbsp;
                        <dw:TranslateLabel ID="HideListText" runat="server" Text="Hide list" Visible="false" />
                        <dw:TranslateLabel ID="ExpandListText" runat="server" Text="Expand list" />
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                    <td>
                        &nbsp;</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td style="border-bottom: 1px solid #cccccc;">
            <table width="100%" border="0" cellpadding="2" cellspacing="0">
                <tr>
                    <td style="border-bottom: 1px solid #cccccc; width: 20px;">
                    </td>
                    <td colspan="4" style="border-bottom: 1px solid #cccccc;">
                        <b><span id="lblTitleNode_1" runat="server"></span></b>
                    </td>
                </tr>
                <asp:Repeater ID="rptStat" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td valign="top">
                                <img src="#" title="ImgNode" alt="lblIconNode" id="lblIconNode" visible="true" runat="server" />
                            </td>
                            <td valign="top" colspan="4">
                                <a href="#" id="lblNodeUrl_1" runat="server">
                                    <nobr><span id="lblNodeText_1" runat="server" /></nobr>
                                </a><span id="lblNodeText_2" runat="server" visible="false" />
                            </td>
                        </tr>
                        <tr>
                            <asp:Repeater ID="rptList" Visible="true" runat="server">
                                <HeaderTemplate>
                                    <tr>
                                        <td>
                                            &nbsp;</td>
                                        <td style="border-top: 1px solid #cccccc;">
                                            <b>
                                                <dw:TranslateLabel Text="<%#Me.ChildTitle_1%>" runat="server" ID="ChildTitle_1" />
                                            </b>
                                        </td>
                                        <td style="border-top: 1px solid #cccccc;">
                                            <b>
                                                <dw:TranslateLabel Text="<%#Me.ChildTitle_2%>" runat="server" ID="TranslateLabel1" />
                                            </b>
                                        </td>
                                        <td style="border-top: 1px solid #cccccc;">
                                            <b>
                                                <dw:TranslateLabel Text="<%#Me.ChildTitle_3%>" runat="server" ID="TranslateLabel2" />
                                            </b>
                                        </td>
                                        <td style="border-top: 1px solid #cccccc;">
                                            <b>
                                                <dw:TranslateLabel Text="<%#Me.ChildTitle_4%>" runat="server" ID="TranslateLabel3" />
                                            </b>
                                        </td>
                                    </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            &nbsp;</td>
                                        <td style="border-top: 1px solid #cccccc;">
                                            <img src="<%=_hostname%>/Admin/Images/Icons/Add_vsmall.gif" alt="Added" title="Added"
                                                id="AddChildImg" width="14" height="14" style="display: <%#Base.ChkString(IIF(DataBinder.Eval(Container.DataItem, Me.ChildFlag),"","none"))%>"><img
                                                    src="<%=_hostname%>/Admin/Images/Icons/Delete_vsmall.gif" alt="Deleted"
                                                    title="Deleted" id="DeleteChildImg" width="14" height="14" style="display: <%#Base.ChkString(IIF(DataBinder.Eval(Container.DataItem, Me.ChildFlag),"none",""))%>">&nbsp;<nobr><%#Base.ChkString(DataBinder.Eval(Container.DataItem, Me.ChildText_1))%> </nobr>
                                        </td>
                                        <td style="border-top: 1px solid #cccccc;">
                                            <nobr>
                                                                <%#Base.ChkString(DataBinder.Eval(Container.DataItem, Me.ChildText_2))%> </nobr>
                                        </td>
                                        <td style="border-top: 1px solid #cccccc;">
                                            <nobr>
                                                                <%#Base.ChkString(DataBinder.Eval(Container.DataItem, Me.ChildText_3))%> </nobr>
                                        </td>
                                        <td style="border-top: 1px solid #cccccc;">
                                            <nobr>
                                                                <%#Base.ChkString(DataBinder.Eval(Container.DataItem, Me.ChildText_4))%> </nobr>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tr>
                    </ItemTemplate>
                    <SeparatorTemplate>
                        <tr>
                            <td style="padding: 0; margin: 0;">
                            </td>
                            <td colspan="4" style="background-color: #CCCCCC; height: 1px; padding: 0; margin: 0;">
                            </td>
                        </tr>
                    </SeparatorTemplate>
                </asp:Repeater>
            </table>
        </td>
    </tr>
</table>
