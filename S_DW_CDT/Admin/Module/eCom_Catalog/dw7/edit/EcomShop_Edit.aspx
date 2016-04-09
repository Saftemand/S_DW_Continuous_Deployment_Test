<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Module/eCom_Catalog/dw7/Main.Master"
    CodeBehind="EcomShop_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomShopEdit" EnableEventValidation="False" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<asp:Content ID="Header" ContentPlaceHolderID="HeadHolder" runat="server">
    <link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
    <link rel="STYLESHEET" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
    <style type="text/css">
        BODY.margin
        {
            margin: 0px;
        }
        INPUT
        {
            font-size: 11px;
            font-family: verdana,arial;
        }
        SELECT
        {
            font-size: 11px;
            font-family: verdana,arial;
        }
        TEXTAREA
        {
            font-size: 11px;
            font-family: verdana,arial;
        }
    </style>
    
    <script type="text/javascript" language="javascript" src="/Admin/FormValidation.js"></script>

    <script type="text/javascript" language="javascript" src="../images/AjaxAddInParameters.js"></script>

    <script type="text/javascript">

        var _saveId = '<%= SaveButton.ClientID %>'
        var _deleteId = '<%= DeleteButton.ClientID %>'
        var _pleaseWait = '<%= PleaseWait.ClientID %>'
        var _productEditScroll = '<%= ProductEditScroll.ClientID %>'

        $(document).observe('dom:loaded', function () {
            window.focus(); // for ie8-ie9 
            document.getElementById('<%=NameStr.ClientID %>').focus();

            addMinLengthRestriction('NameStr', 1, '<%=Translate.JsTranslate("A name needs to be specified")%>');
            activateValidation('Form1');
        });

        function newShop() { 
            location.href='EcomShop_Edit.aspx';
        }

        function save(doClose) {

            if (document.getElementById(_deleteId)) {
                document.getElementById(_deleteId).disabled = 'true';
            }

            if (document.getElementById('SaveAndCloseShopButton')) {
                document.getElementById('SaveAndCloseShopButton').disabled = 'true';
            }

            if (document.getElementById('SaveShopButton')) {
                document.getElementById('SaveShopButton').disabled = 'true';
            }

            if (document.getElementById('DeleteShopButton')) {
                document.getElementById('DeleteShopButton').disabled = 'true';
            }

            if (document.getElementById('NewShopButton')) {
                document.getElementById('NewShopButton').disabled = 'true';
            }

            if (document.getElementById('btnResetSortOrder')) {
                document.getElementById('btnResetSortOrder').disabled = 'true';
            }

            if (document.getElementById(_productEditScroll))
            {
                document.getElementById(_productEditScroll).style.display = 'none'
            }
            
            if (document.getElementById(_pleaseWait)) {
                document.getElementById(_pleaseWait).style.display = ''
            }

            $('doClose').value = doClose;
            $(_saveId).click();
        }

        function deleteShop() {
            var alertmsg = getAjaxPage("EcomUpdator.aspx?CMD=ShopCheckForGroups&shopID=<%=shopId%>");
            if (confirm(alertmsg)) {
                $(_deleteId).click();
            }
        }

        function cancel() {
            location.href = "/Admin/Module/eCom_Catalog/dw7/orderlist.aspx"
        }

        function serializeStockLocations() {
            $("StockLocationID").value = SelectionBox.getElementsRightAsArray("StockLocationSelector");
        }

        function serializeShopLanguages()
        {
            var rArr = $('sboxLangs_lstRight');
            var sel = $('ddlDefLangID');
            var oldVal = null;

            if(sel.selectedIndex != -1)
                oldVal = sel[sel.selectedIndex].value;

            for(i = sel.options.length - 1; i >= 0; i--)
                sel.remove(i);

            if(rArr.options.length == 0 || (rArr.options.length == 1 && rArr.options[0].value == 'sboxLangs_lstRight_no_data'))
                sel.disabled = true;
            else
            {
                var selIndex = 0;

                sel.disabled = false;
                
                for(i = 0; i < rArr.length; i++)
                {

                    if(rArr.options[i].value != 'sboxLangs_lstRight_no_data')
                    {
                        sel.options[i] = new Option(rArr.options[i].text, rArr.options[i].value);

                        if(sel.options[i].value == oldVal)
                            selIndex = i;
                    }
                }

                sel.selectedIndex = selIndex;
            }

            $("sboxLangsIDs").value = SelectionBox.getElementsRightAsArray('sboxLangs');
        }
    </script>

</asp:Content>
<asp:Content ID="Content" ContentPlaceHolderID="ContentHolder" runat="server">
    <input type="hidden" id="doClose" name="doClose" value="" />
    
    <% If Not String.IsNullOrEmpty(Request("ecom7mode")) AndAlso String.Compare(Request("ecom7mode"), "management", True) = 0 Then%>
        <asp:Literal ID="BoxStart" runat="server"></asp:Literal>
        <dw:TabHeader ID="TabHeader1" runat="server" TotalWidth="100%"></dw:TabHeader>
    <% Else%>
        <dw:RibbonBar ID="RibbonBar" runat="server">
            <dw:RibbonBarTab ID="RibbonBarTab1" Name="Shop" runat="server">
                <dw:RibbonBarGroup ID="RibbonBarGroup1" Name="Tools" runat="server">
                    <dw:RibbonBarButton ID="SaveShopButton" Text="Save" Image="Save" Size="Small" runat="server"
                        OnClientClick="save(false);">
                    </dw:RibbonBarButton>
                    <dw:RibbonBarButton ID="SaveAndCloseShopButton" Text="Save and close" Image="SaveAndClose" 
                        Size="Small" runat="server" OnClientClick="save(true);">
                    </dw:RibbonBarButton>
                    <dw:RibbonBarButton ID="btnResetSortOrder" Text="Close" Image="Cancel" Size="Small"
                        runat="server" OnClientClick="cancel();">
                    </dw:RibbonBarButton>
                    <dw:RibbonBarButton ID="DeleteShopButton" Text="Delete" Image="DeleteDocument" Size="Small"
                        runat="server" OnClientClick="deleteShop();" Visible="false">
                    </dw:RibbonBarButton>
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonInsertBarGroup" Name="Insert" runat="server" Visible="false">
                    <dw:RibbonBarButton ID="NewShopButton" Text="New shop" ImagePath="/Admin/Images/eCom/eCom_Shop_add.gif" Size="Large" runat="server"
                        OnClientClick="newShop();" Visible="false">
                    </dw:RibbonBarButton>
                </dw:RibbonBarGroup>
            </dw:RibbonBarTab>
        </dw:RibbonBar>
    <% End If%>
    
    <asp:image ID="PleaseWait" name="PleaseWait" Visable="true" ImageUrl="/Admin/Module/Seo/Dynamicweb_wait.gif" runat="server"></asp:image>
        
    <dw:StretchedContainer ID="ProductEditScroll" Stretch="Fill" Scroll="VerticalOnly" Visible="true"  
        Anchor="document" runat="server">
        <table border="0" cellpadding="0" cellspacing="0" class="tabTable100" id="DW_Ecom_tableTab">
            <tr>
                <td valign="top">
                    <div id="Tab1">
                        <br />
                        <table border="0" cellpadding="0" cellspacing="0" width='95%' style='width: 95%'>
                            <tr>
                                <td>
                                    <fieldset style='margin: 5px; width: 100%'>
                                        <legend class="gbTitle">
                                            <%=Translate.Translate("Indstillinger")%></legend>
                                        <table border="0" cellpadding="2" cellspacing="0" width='100%' style='width: 100%'>
                                            <tr>
                                                <td>
                                                    <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                                        <tr>
                                                            <td width="170">
                                                                <dw:TranslateLabel ID="tLabelName" runat="server" Text="Navn"></dw:TranslateLabel>
                                                            </td>
                                                            <td>
                                                                <div id="errNameStr" name="errNameStr" style="color: Red;">
                                                                </div>
                                                                <asp:TextBox ID="NameStr" runat="server" CssClass="NewUIinput" MaxLength="255"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="170">
                                                                <dw:TranslateLabel ID="tLabelId" runat="server" Text="Id"></dw:TranslateLabel>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="IdStr" runat="server" CssClass="NewUIinput" Enabled="False"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="170">
                                                                <dw:TranslateLabel ID="tLabelIcon" runat="server" Text="Ikon"></dw:TranslateLabel>
                                                            </td>
                                                            <td>
                                                                <dw:FileArchive runat="server" ID="IconStr" ShowPreview="True" MaxLength="255" CssClass="NewUIinput">
                                                                </dw:FileArchive>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="170">
                                                                <dw:TranslateLabel ID="tLabelDefault" runat="server" Text="Standard"></dw:TranslateLabel>
                                                            </td>
                                                            <td>
                                                                <asp:CheckBox ID="IsDefault" runat="server"></asp:CheckBox><asp:CheckBox ID="IsDefaultTmp"
                                                                    runat="server" disabled></asp:CheckBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="170">
                                                                <dw:TranslateLabel ID="tLabelCreated" runat="server" Text="Oprettet"></dw:TranslateLabel>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="CreatedStr" runat="server" CssClass="NewUIinput" Enabled="False"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                         <tr>
                                                            <td width="170">
                                                                <dw:TranslateLabel ID="tLabelOrderFlow" runat="server" Text="Orderflow"></dw:TranslateLabel>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="OrderflowSelect" runat="server"  CssClass="NewUIinput"></asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <%If Base.IsModuleInstalled("eCom_MultiShopAdvanced") Then%>
                                                        <tr>
                                                            <td width="170">
                                                                <dw:TranslateLabel ID="tLabelStockState" runat="server" Text="Default stock state"></dw:TranslateLabel>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="StockStateList" runat="server"  CssClass="NewUIinput"></asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <%End If%>
                                                        <tr>
                                                            <td width="170">
                                                                <dw:TranslateLabel ID="tLabelOrderContext" runat="server" Text="Default cart"></dw:TranslateLabel>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="OrderContextList" runat="server"  CssClass="NewUIinput"></asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                    <%If Base.IsModuleInstalled("eCom_MultiShopAdvanced") Then%>
                                    <fieldset style="margin: 5px; width: 100%">
                                        <legend class="gbTitle">
                                            <dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Languages" />
                                        </legend>
                                        <table cellpadding="1" cellspacing="1" border="0">
                                            <tr>
                                                <td width="170" style="padding-left:4px;">
                                                    <dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Default language"></dw:TranslateLabel>
                                                </td>
                                                <td style="padding-left:4px;">
                                                    <asp:DropDownList ID="ddlDefLangID" runat="server" CssClass="NewUIinput" ClientIDMode="Static"></asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <dw:SelectionBox ID="sboxLangs" runat="server" ClientIDMode="Static" />
                                                    <input type="hidden" name="sboxLangsIDs" id="sboxLangsIDs" value="" runat="server" clientidmode="Static" />
                                                </td>                                          
                                            </tr>
                                        </table>
                                    </fieldset>
                                    <%End If%>
                                    <fieldset style='margin: 5px; width: 100%'>
                                        <legend class="gbTitle">
                                            <dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Stock locations" />
                                        </legend>
                                        <table cellpadding="1" cellspacing="1" border="0">
                                            <tr>
                                                <td>
                                                    <dw:SelectionBox ID="StockLocationSelector" runat="server" />
                                                    <input type="hidden" name="StockLocationID" id="StockLocationID" value="" runat="server" ClientIDMode="Static"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                    <%If Base.HasAccess("UsersExtended") OrElse Base.HasAccess("UserManagementBackend") Then%>
                                    <fieldset style='margin: 5px; width: 100%'>
                                        <legend class="gbTitle">
                                            <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Order notification" />
                                        </legend>
                                        <table border="0" cellpadding="2" cellspacing="0" width='100%' style='width: 100%'>
                                            <tr>
                                                <td>
                                                    <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                                        <tr>
                                                            <td>
                                                                <span style="color: Gray; font-style: italic">
                                                                    <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Select the users that should receive order notifications" />
                                                                    <br />
                                                                    <br />
                                                                    <%=Gui.UserGroupManagerECom("OrderNotificationSubscribers", "OrderNotificationGroupbox", "Form1", "0,1,3,4,5", shopId, NotificationSubscribers, New String() {Nothing, Translate.Translate("Send order notification to:"), Translate.Translate("Other users:")})%>
                                                                </span>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                    <% End If%>
                                    <br />
                                    <br />
                                </td>
                            </tr>
                        </table>
                        <br />
                        <asp:Button ID="SaveButton" Style="display: none" runat="server"></asp:Button>
                        <asp:Button ID="DeleteButton" Style="display: none" runat="server"></asp:Button>
                    </div>
                </td>
            </tr>
        </table>
        
        <% If Not String.IsNullOrEmpty(Request("ecom7mode")) AndAlso String.Compare(Request("ecom7mode"), "management", True) = 0 Then%>
            <asp:Literal ID="BoxEnd" runat="server"></asp:Literal>
            <asp:Literal ID="removeDelete" runat="server"></asp:Literal>
        <% End If%>
       
    </dw:StretchedContainer>
    <script type="text/javascript">
        SelectionBox.setNoDataLeft("StockLocationSelector");
        SelectionBox.setNoDataRight("StockLocationSelector");
        SelectionBox.setNoDataLeft("sboxLangs");
        SelectionBox.setNoDataRight("sboxLangs");
    </script>
    
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</asp:Content>