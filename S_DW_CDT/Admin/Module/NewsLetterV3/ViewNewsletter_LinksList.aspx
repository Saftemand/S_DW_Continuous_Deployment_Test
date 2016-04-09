<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ViewNewsletter_LinksList.aspx.vb"
    Inherits="Dynamicweb.Admin.NewsLetterV3.ViewNewsletter_LinksList" %>

<%@ Register Src="/Admin/Module/Common/Record.ascx" TagName="Record" TagPrefix="list" %>
<%@ Register Src="/Admin/Module/Common/Pager.ascx" TagName="Pager" TagPrefix="list" %>
<%@ Register Src="/Admin/Module/Common/Header.ascx" TagName="Header" TagPrefix="list" %>
<%@ Register Src="~/Admin/Module/NewsLetterV3/ClickersList.ascx" TagName="ClList"
    TagPrefix="list" %>
<%@ Register Assembly="DynamicWeb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<!DOCTYPE html PUBLIC  "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head runat="server">
    <title>ViewNewsletter_LinksList</title>
    <link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
    <link rel="stylesheet" type="text/css" href="/Admin/Module/Common/Stylesheet.css">
    <script language="javascript" type="text/javascript">
        
        function openUrl(url)
        {
            var newwin = window.open(url, "blank");
        }
		function cc(objRow)
		{ 
		    //Change color of row when mouse is over... (ChangeColor)
		    objRow.style.backgroundColor = '#EBF7FD';
		}
		function ccb(objRow)
		{ 
		    //Remove color of row when mouse is out... (ChangeColorBack)
			objRow.style.backgroundColor='';
		}
    </script>

</head>
<body style="background-color: #fff;">
    <form id="Form1" runat="server" class="formNewsletter">
        <dw:TranslateLabel ID="NoRecordsFoundLabel" runat="server" Text="No links found."
            Visible="false" />
        <asp:Repeater ID="List" runat="server">
            <HeaderTemplate>
                <table width="562px" cellspacing="0" cellpadding="0" border="0">
            </HeaderTemplate>
            <ItemTemplate>
                <tr onmouseout="ccb(this);" onmouseover="cc(this);" style="height: 20px;">
                    <list:Record runat="server"  ID="linkUrl" Width="15px"
                        IsBoolean="true" ImgSrc='/Admin/images/Expand.gif' ImgCheckedSrc='/Admin/images/Expand_off.gif'
                        IsAction="true" RecordID='<%# DataBinder.Eval(Container.DataItem, "ID") %>' OnRecordCheckedChange="ExpandChange" />
                    <td style="width:515px;"><img src="/Admin/images/editor/Link.gif" width="21px" height="20px" alt="" /><a title="<%#Base.ChkString(DataBinder.Eval(Container.DataItem, "Url"))%>" href ="<%#Base.ChkString(DataBinder.Eval(Container.DataItem, "Url"))%>" target="_blank">
                        <nobr><%#Base.ChkString(DataBinder.Eval(Container.DataItem, "ShortName"))%></nobr></a>
                    </td>
                    <list:Record runat="server" Width="34px" Text='<%# DataBinder.Eval(Container.DataItem, "Clicks") %>' />
                </tr>
                <tr>
                    <td colspan="3" class="DividerRows">
                    </td>
                </tr>
                <tr id="ClickersList" runat="server">
                    <td colspan="3">
                        <list:ClList ID="ClickersListList" runat="server" LinkID='<%# DataBinder.Eval(Container.DataItem, "ID") %>' />
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
        <% Translate.GetEditOnlineScript() %>
    </form>
</body>
</html>
