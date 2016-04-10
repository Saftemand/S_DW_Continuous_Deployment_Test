<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CategorySelector.aspx.vb" Inherits="Dynamicweb.Admin.NewsLetterV3.CategorySelector" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="mc" Namespace="Dynamicweb.Admin.ModulesCommon" Assembly="Dynamicweb.Admin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title><%=Translate.Translate("Categories") %></title>
    <link href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET" />
    <link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/List/List.css" />
	<link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
    <link rel="stylesheet" type="text/css" href="/Admin/Content/StyleSheetNewUI.css" />
	<dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
    <style type="text/css">
       
        .cBody {
            overflow: auto;
            width: 280px;
            height: 300px;
        }
    </style>
    
    <script type="text/javascript">
        function doPostBackToParent() {
            <%If Base.Request("paragraph") = "true" Then%>
                window.opener.CartNewsletterSubcription();
            <%Else%>
                var btn = window.opener.document.getElementById('Step0_cmdSubmitCategories');
                if(btn) btn.click();
            <%End If%>

            self.close();
        }
                
        function validateCategories(sender, args) {
		    var cats = document.getElementById('lstCategories').value.replace(",", "");
            args.IsValid = cats.length > 0;
        }
    </script>
</head>

	<body style="background-color:#FFF; margin: 0px">

    <form id="form1" runat="server">
        <div id="divToolbar">
            <div id="Buttons" class="Toolbar">
            <ul>
                <li>
                    <img src="/Admin/Images/Ribbon/UI/Toolbar/Start.gif" style="margin-top: 4px; margin-bottom: 4px; margin-left: 2px;" alt="">
                </li>
                <li>
                    <asp:Button class="buttonSubmit" id="cmdOK" runat="server" />
                </li>
                <li>
                    <input type="button" class="buttonSubmit" value="<%=Translate.Translate("Annuler") %>" onclick="window.close();" />    
                </li>
            </ul>
            </div>
            <h2 class="subtitle"><%=Translate.Translate("Categories") %></h2>
        </div>
    <div>
        <table cellspacing="0" cellpadding="0" border="0" width="100%" height="400">
            <tr width="100%" valign="top">
                <td align="center">
                    <table>
                        <tr>
                            <td>
                                <div id="divCategories" class="cBody" align="left" runat="server">
                                    <mc:ListSelector Columns="1" ID="lstCategoriesCtrl" Name="lstCategories" DataTextField="DisplayName" DataValueField="ID" runat="server" />
                                </div>
                                <div id="divNoCategories" class="cBody" runat="server">
                                    <dw:TranslateLabel ID="lbNoCategories" runat="server" Text="Ikke fundet" />
                                </div>
                            </td>
                        </tr>
                        <tr valign="bottom"><td>&nbsp;<asp:CustomValidator ClientValidationFunction="validateCategories" ID="cvCategories" runat="server" /></td></tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>

    </form>

</body>
</html>
