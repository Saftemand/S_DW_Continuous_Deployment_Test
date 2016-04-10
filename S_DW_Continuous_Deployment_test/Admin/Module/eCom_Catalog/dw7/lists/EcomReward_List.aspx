<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EcomReward_List.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomReward_List" %>
<%@ Register assembly="Dynamicweb.Controls" namespace="Dynamicweb.Controls" tagprefix="dw" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" IncludeUIStylesheet="true" runat="server"></dw:ControlResources>
	<link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
    <script type="text/javascript" src="../js/ecomLists.js"></script>
    <script type="text/javascript">
        $(document).observe('dom:loaded', function () {
            initRewardList();
            window.g_rewardList._reStretch();
        });

        function initRewardList() {
            window.g_rewardList = createRewardList({
                listId: "RewardList",
                titles: {
                    deleteConfirmation: "<%= Translate.JsTranslate("Do you want to delete the selected reward(s)?")%>"
                },
                urls: {
                    deleteItems: "/Admin/Module/eCom_Catalog/dw7/lists/EcomReward_List.aspx",
                    edit: "/Admin/Module/eCom_Catalog/dw7/Edit/EcomReward_Edit.aspx"
                }
            });
        }
        function createRewardList(opts) {
            var rewardListId = opts.listId;

            var list = {
                _reStretch: function () {
                    Dynamicweb.Controls.StretchedContainer.stretchAll();
                    Dynamicweb.Controls.StretchedContainer.Cache.updatePreviousDocumentSize();
                },

                _getCheckedRows: function (selId) {
                    var ids = [];
                    if (!selId) {
                        var checkedRows = List.getSelectedRows(rewardListId);
                        if (checkedRows) {
                            for (var i = 0; i < checkedRows.length; i++) {
                                ids[i] = checkedRows[i].id.replace("row", "");
                            }
                        }
                    } else {
                        ids.push(selId);
                    }
                    return ids;
                },

                rowSelected: function () {
                    var checkedRows = List.getSelectedRows(rewardListId);
                    if (List && checkedRows.length > 0) {
                        $("cmdRewardDelete").className = "";
                        $("linkRewardDelete").href = "javascript:window.g_rewardList.deleteSelectedItems();";
                    } else {
                        $("cmdRewardDelete").className = "toolbarButtonDisabled";
                    }
                },

                deleteSelectedItems: function (id) {
                    var ids = this._getCheckedRows(id);
                    if (confirm(opts.titles.deleteConfirmation)) {
                        new Ajax.Request(opts.urls.deleteItems, {
                            method: 'get',
                            parameters: {
                                RewardID: ids,
                                action: "delete"
                            },
                            onComplete: function (transport) {
                                if (transport.responseText.length == 0) {
                                    window.location.reload(true);
                                } else {
                                    alert(transport.responseText);
                                }
                            }
                        });
                    }
                },

                editItem: function (id, createCopy) {
                    var xref = opts.urls.edit;
                    if (id) {
                        xref += "?ID=" + id;
                        if (createCopy) {
                            xref += "&CopyMode=true"
                        }
                    }
                    openInContentFrame(xref);
                },

                copyItem: function (id) {
                    this.editItem(id, true);
                }
            };
            return list;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div style="height: 98%;">
            <asp:Literal id="BoxStart" runat="server"></asp:Literal>
           <dw:StretchedContainer ID="OuterContainer" Stretch="Fill" Anchor="document" runat="server" Scroll="HorizontalOnly">
            <dw:List runat="server"
                 ID="RewardList"
                 AllowMultiSelect="true"
                 UseCountForPaging="true"
                 HandleSortingManually="true"
                 HandlePagingManually="true"
                 OnClientSelect="window.g_rewardList.rowSelected();"
                 Personalize="true"
                 StretchContent="true" ShowTitle="false">
                <Filters></Filters>
                <Columns>
			        <dw:ListColumn ID="colName" runat="server" Name="Name" EnableSorting="true" Width="300" />
			        <dw:ListColumn ID="colRulesCount" runat="server" Name="Rule count" EnableSorting="true" />
                    <dw:ListColumn ID="colAppliedCount" runat="server" Name="Applied statistics" EnableSorting="true" />
                    <dw:ListColumn ID="colActive" runat="server" Name="Active" EnableSorting="true"  Width="20" ItemAlign="Center" />
                </Columns>
            </dw:List>
            </dw:StretchedContainer>
            <asp:Literal id="BoxEnd" runat="server"></asp:Literal> 
        </div>
        <dw:ContextMenu ID="RewardListContext" runat="server">
            <dw:ContextMenuButton ID="cmdCopyReward" runat="server" Divide="None" ImagePath="/Admin/images/ecom/eCom_Discounts_add_small.gif" Text="Copy reward" OnClientClick="window.g_rewardList.copyItem(ContextMenu.callingID);" />
            <dw:ContextMenuButton ID="cmdEditReward" runat="server" Divide="None" ImagePath="/Admin/images/ecom/eCom_Discounts_small.gif" Text="Edit reward" OnClientClick="window.g_rewardList.editItem(ContextMenu.callingID);" />
            <dw:ContextMenuButton ID="cmdDeleteReward" runat="server" Divide="None" ImagePath="/Admin/images/ecom/eCom_Discounts_delete_small.gif" Text="Delete reward" OnClientClick="window.g_rewardList.deleteSelectedItems(ContextMenu.callingID);" />
        </dw:ContextMenu>
    </form>
</body>
</html>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>