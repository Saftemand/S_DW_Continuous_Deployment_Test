<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="UserPaymentCardsTokensList.aspx.vb" Inherits="Dynamicweb.Admin.UserSavedTokensList" %>
<%@ Register assembly="Dynamicweb.Controls" namespace="Dynamicweb.Controls" tagprefix="dw" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="True" runat="server" />
    <script type="text/javascript" >
        function deleteToken(id) {            
            if (confirm("<%= Translate.JsTranslate("Are you sure you want to delete this saved card?")%>")){
                $('DeleteTokenID').value = id;
                form1.submit();
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="DeleteTokenID" name="DeleteTokenID" value="0" />
        <dw:List ID="TokensList" runat="server" PageSize ="25" SortDirection="Ascending" Title="User Saved Cards">
	    <Columns>
		    <dw:ListColumn ID="NameClmn" runat ="server" Name="Name"  TranslateName="true" EnableSorting="true">
		    </dw:ListColumn>
		    <dw:ListColumn ID="CardTypeClmn" runat="server" Name="Card Type" TranslateName="true"  EnableSorting="true">
		    </dw:ListColumn>
		    <dw:ListColumn ID="IdentifierClmn" runat="server" Name="Card number" TranslateName="true"  EnableSorting="true">
		    </dw:ListColumn>
		    <dw:ListColumn ID="PaymentClmn" runat="server" Name="Payment method" TranslateName="true"  EnableSorting="true">
		    </dw:ListColumn>
		     <dw:ListColumn ID="DeleteClmn" runat="server" Name="Delete" TranslateName="true" Width="50" ItemAlign="Center">
		    </dw:ListColumn>
		</Columns>
        </dw:List>
    </form>
</body>
</html>
