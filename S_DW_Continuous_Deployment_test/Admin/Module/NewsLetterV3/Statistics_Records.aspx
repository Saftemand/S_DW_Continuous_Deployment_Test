<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Statistics_Records.aspx.vb"
    Inherits="Dynamicweb.Admin.NewsLetterV3.Statistics_Records" %>

<!DOCTYPE html PUBLIC  "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.NewsLetterV3" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb.NewsLetterV3.Objects" %>
<html>
<head runat="server">
    <title>Statistic_Records</title>
    <link href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET" />
    <link rel="stylesheet" type="text/css" href="/Admin/Module/Common/Stylesheet.css" />
    <script type="text/javascript">
        function OpenNewsletter(id, type, doCopy)
        {  
            var doCopyStr = "";
            if (doCopy == "True") doCopyStr = "&NotCopy=True";
            var url = "ViewNewsletter.aspx";
            if (type == 4) url = "ViewSmsNewsletter.aspx";  // 4 is SMS newsletteter.
            window.parent.location.href = url + "?NewsletterID=" + id + doCopyStr;   
        }
		function cc(objRow)
		{ 
		    //Change color of row when mouse is over... (ChangeColor)
		    objRow.style.backgroundColor='#EBF7FD';
		}
		function ccb(objRow)
		{ 
		    //Remove color of row when mouse is out... (ChangeColorBack)
			objRow.style.backgroundColor='';
		}
    </script>

</head>
<body style="background-color:#fff;">
    <form id="Form1" runat="server">
        <table cellpadding="0" cellspacing="0" width="565px" border="0" style="table-layout: fixed;">
            <dw:TranslateLabel ID="NoNewslettersReceived" runat="server" Visible="false" Text="There are no received letters." />
            <asp:Repeater ID="rptStat" runat="server">
                <ItemTemplate>
                    <tr onmouseout="ccb(this);" onmouseover="cc(this);" style="height: 20px;">
                        <td style="white-space: nowrap; width: 20px;" class="border_bot">
                            <asp:Image ImageUrl="/Admin/Module/NewsLetterV3/Img/MailUnread.gif" ID="ImgNewsletterUnread"
                                runat="server" AlternateText="Mail unread" />
                            <asp:Image ImageUrl="/Admin/Module/NewsLetterV3/Img/MailRead.gif" ID="ImgNewsletterRead"
                                runat="server" AlternateText="Mail read" />
                        </td>
                        <td style="white-space: nowrap; width: 373px;" class="border_bot">
                            <a href="#" onclick="OpenNewsletter(<%# DataBinder.Eval(Container.DataItem, "ID")%>,<%# CInt(DataBinder.Eval(Container.DataItem, "Type"))%>,'<%= DoCopy.TrueString %>');">
                                <%#Base.ChkString(DataBinder.Eval(Container.DataItem, "Subject"))%>
                            </a>
                        </td>
                        
                        <td style="white-space: nowrap; width: 95px;" class="border_bot">
                            <asp:Label ID="NewsletterSent" runat="server" />
                        </td>
                        <td style="white-space: nowrap; width: 77px;" class="border_bot">
                            <asp:Label ID="NewsletterOpened" runat="server" />
                            <dw:TranslateLabel Visible="false" ID="NewsletterOpenedEmpty" runat="server" Text="-" />
                        </td>
                    </tr>
                    <tr>
                        <asp:Repeater ID="rptLink" DataSource="<%# CType(Container.DataItem, StatisticNewsletter).Links%>"
                            runat="server">
                            <HeaderTemplate>
                                <td colspan="4" style="padding-left: 20px;">
                                    <table cellpadding="0" cellspacing="0" width="545px" border="0" style="table-layout: fixed;">
                                        <tr style="height: 18px;">
                                            <td style="width: 470px;" class="border_bot">
                                                <b>
                                                    <dw:TranslateLabel runat="server" Text="Links" />
                                                </b>
                                            </td>
                                            <td style="width: 75px;" class="border_bot">
                                                <b>
                                                    <dw:TranslateLabel runat="server" Text="Followed" />
                                                </b>
                                            </td>
                                        </tr>
                                </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr  onmouseout="ccb(this);" onmouseover="cc(this);">
                                    <td class="border_bot">
                                        <img src="/Admin/images/editor/Link.gif" width="21" height="20" alt="" /><a title="<%#Base.ChkString(DataBinder.Eval(Container.DataItem, "Url"))%>"
                                            href='<%#Base.ChkString(DataBinder.Eval(Container.DataItem, "Url"))%>' target="_blank">
                                            <nobr><%#Base.ChkString(DataBinder.Eval(Container.DataItem, "ShortName"))%></nobr>
                                        </a>
                                    </td>
                                    <td style="white-space: nowrap;" class="border_bot">
                                        <%#Common.ShowDate(DataBinder.Eval(Container.DataItem, "FirstClicked"))%>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </table> </td>
                            </FooterTemplate>
                        </asp:Repeater>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>
        <%  Translate.GetEditOnlineScript() %>
    </form>
</body>
</html>
