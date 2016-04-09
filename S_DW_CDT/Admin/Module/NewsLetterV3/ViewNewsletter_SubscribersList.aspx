<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ViewNewsletter_SubscribersList.aspx.vb" Inherits="Dynamicweb.Admin.NewsLetterV3.ViewNewsletter_SubscribersList" %>

<%@ Register Src="/Admin/Module/Common/Record.ascx" TagName="Record" TagPrefix="list" %>
<%@ Register Assembly="DynamicWeb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.NewsLetterV3" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<!DOCTYPE html PUBLIC  "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head runat="server">
    <title>ViewNewsletter_SubscribersList</title>
    <link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
    <link rel="stylesheet" type="text/css" href="/Admin/Module/Common/Stylesheet.css">
    <script language="javascript" type="text/javascript">
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
    <dw:TranslateLabel ID="NoRecordsFoundLabel" runat="server" Text="No subscribers found" Visible="false" />
    <asp:Repeater ID="List" runat="server"  >
        <HeaderTemplate>
            <table width="575px" cellspacing="0" cellpadding="0" border="0" style="overflow:scroll;">
        </HeaderTemplate>
        <ItemTemplate>
            <tr onMouseOut="ccb(this);" onMouseOver="cc(this);" style="vertical-align:top;">
                <list:Record runat="server"  Width="333px" id="RecordRecipientName" ImgSrc="/Admin/Module/NewsLetterV3/Img/Recipients.gif"
                    Text='<%# DataBinder.Eval(Container.DataItem, "RecipientName") %>' />
                <list:Record runat="server" Width="77px" 
                    Text='<%# DataBinder.Eval(Container.DataItem, "MailFormat") %>' />
                <list:Record runat="server" Width="165px" ID="RecordDate" visible='<%# DataBinder.Eval(Container.DataItem, "IsOpen") %>'
                    Text='<%# Dynamicweb.NewsLetterV3.Common.ShowDate(DataBinder.Eval(Container.DataItem, "OpenDate"), True)%>'/>
                <list:Record runat="server" Width="165px" ID="RecordDateEmpty" visible='<%# Not DataBinder.Eval(Container.DataItem, "IsOpen") AND DataBinder.Eval(Container.DataItem, "MailFormat") <> 2  %>' />
                <list:Record runat="server" Width="165px" ID="RecordDateEmptyForTextFormat" visible='<%# Not DataBinder.Eval(Container.DataItem, "IsOpen") AND DataBinder.Eval(Container.DataItem, "MailFormat") = 2 %>' />
            </tr>            
        </ItemTemplate>
        <FooterTemplate>
            </table>
        </FooterTemplate>
    </asp:Repeater>

    <asp:Repeater ID="SmsRecipients" runat="server" Visible=false  >
        <HeaderTemplate>
            <table width="575px" cellspacing="0" cellpadding="0" border="0" style="overflow:scroll;">
        </HeaderTemplate>
        <ItemTemplate>
            <tr onMouseOut="ccb(this);" onMouseOver="cc(this);" style="vertical-align:top;">
                <list:Record ID="Record1" runat="server"  Width="575px" ImgSrc="/Admin/Module/NewsLetterV3/Img/Recipients.gif"
                    Text='<%# DataBinder.Eval(Container.DataItem, "RecipientName") %>' />               
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
