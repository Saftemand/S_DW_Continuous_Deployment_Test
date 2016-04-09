<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TreeView.aspx.vb" Inherits="Dynamicweb.Admin.NewsLetterV3.TreeView" %>

<%@ Register Assembly="Dynamicweb.Admin" Namespace="Dynamicweb.Admin.ModulesCommon.ContextMenu"
    TagPrefix="cm" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC  "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tree</title>
    <link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
    <link rel="STYLESHEET" type="text/css" href="/Admin/Module/Common/DropMenu.css">
    <script language="javascript" type="text/javascript">
        function ReloadContent(url)
        {        
            var newwin = window.open(url, "ListRight");
        }
        
         function DeleteConfirm()
		{
		    var selectedNode = document.getElementById("hfSelectedNode").value;
            var categoryNode = document.getElementById("<% = HiddenFieldIdForCategoryName %>" + selectedNode);            
            if(categoryNode != null)
            {
                var catName = document.getElementById("<% = HiddenFieldIdForCategoryName %>" + selectedNode).value;                        
                if(confirm('<%=Translate.JSTranslate("Do you want to delete ")%>['+catName+']?'))
                {
                    return true;
                }
            }
            else
            {
                if(confirm('<%=Translate.JSTranslate("Slet")%>?'))
                    {
                        return true;
                    }
            }
			return false;
		}	
    </script>
</head>
<body onkeypress="<% = ContextMenuList.GetEscReference() %><% = ContextMenuCategories.GetEscReference() %><% = ContextMenuCategories.GetEscReference() %><% = ContextMenuAllRecipient.GetEscReference() %><% = ContextMenuEmptyDeleted.GetEscReference() %><% = ContextMenuIntegration.GetEscReference() %><% = ContextMenuIntegrationItem.GetEscReference() %>"
    onclick="<% = ContextMenuList.GetOnClickReference() %><% = ContextMenuCategories.GetOnClickReference() %><% = ContextMenuSearch.GetOnClickReference() %><% = ContextMenuAllRecipient.GetOnClickReference() %><% = ContextMenuEmptyDeleted.GetOnClickReference() %><% = ContextMenuIntegration.GetOnClickReference() %><% = ContextMenuIntegrationItem.GetOnClickReference() %>">
    <form id="form1" runat="server">
        <div id="Tree">
            <div id="List">
            
                <asp:TreeView ID="LinksTreeView" Width="100%" height="320" runat="server" SelectedNodeStyle-Font-Bold="true">
                    <Nodes>
                        <asp:TreeNode Text="Drafts" ImageUrl="/Admin/Module/NewsLetterV3/Img/Drafts.gif"
                            SelectAction="Select" NavigateUrl="~/Admin/Module/NewsLetterV3/NewsLetter_List.aspx?status=1"
                            Target="ListRight" Value="1"></asp:TreeNode>
                        <asp:TreeNode Text="Categories" ImageUrl="/Admin/Module/NewsLetterV3/Img/Categories.gif" NavigateUrl="~/Admin/Module/NewsLetterV3/Category_List.aspx"
                            Target="ListRight" SelectAction="SelectExpand" Value="5"></asp:TreeNode>
                        <asp:TreeNode Text="Outbox" ImageUrl="/Admin/Module/NewsLetterV3/Img/Outbox.gif"
                            SelectAction="Select" NavigateUrl="~/Admin/Module/NewsLetterV3/NewsLetter_List.aspx?status=2"
                            Target="ListRight" Value="2"></asp:TreeNode>
                        <asp:TreeNode Text="Sent Items" ImageUrl="/Admin/Module/NewsLetterV3/Img/SentItems.gif"
                            SelectAction="SelectExpand" Expanded="False" NavigateUrl="~/Admin/Module/NewsLetterV3/NewsLetter_List.aspx?status=3"
                            Target="ListRight" Value="3"></asp:TreeNode>
                        <asp:TreeNode Text="Deleted Items" ImageUrl="/Admin/Module/NewsLetterV3/Img/DeletedItems.gif"
                            SelectAction="SelectExpand" NavigateUrl="~/Admin/Module/NewsLetterV3/NewsLetter_List.aspx?status=4"
                            Target="ListRight" Value="4"></asp:TreeNode>
                        <asp:TreeNode Text="Search" ImageUrl="/Admin/Module/NewsLetterV3/Img/Search.gif"
                            SelectAction="Select" NavigateUrl="~/Admin/Module/NewsLetterV3/SearchPage.aspx"
                            Target="ListRight"></asp:TreeNode>
                        <asp:TreeNode Text="All recipients" ImageUrl="/Admin/Module/NewsLetterV3/Img/Recipients.gif"
                            SelectAction="Select" NavigateUrl="~/Admin/Module/NewsLetterV3/Recipient_List.aspx"
                            Target="ListRight" Value="6" ></asp:TreeNode>
                         <asp:TreeNode Text="Integration" ImageUrl="/Admin/Module/NewsLetterV3/Img/Integration.gif"
                            SelectAction="Select" NavigateUrl="~/Admin/Module/NewsLetterV3/IntegrationRule_List.aspx" 
                            Target="ListRight" Value="7" ></asp:TreeNode>
                    </Nodes>
                </asp:TreeView> 
                
                <cm:ContextMenu ID="ContextMenuList" CssClass="altMenuLeftPane" runat="server" AutoHide="True"
                    Width="100%" SelectedNodeContainerControl="hfSelectedNode">
                    <cm:ContextMenuItem  Name="Addcategory" Text="Add category" CommandName="AddCategory" Tooltip="Click to add new category"
                        ImageUrl="/Admin/Module/NewsLetterV3/Img/AddCategory_small.gif" />
                    <cm:ContextMenuItem Name="Search" Text="Search" CommandName="Search" Tooltip="Search" ImageUrl="/Admin/Images/Icons/Module_Filearchive_small.gif" />
                </cm:ContextMenu>
                
                <cm:ContextMenu ID="ContextMenuCategories" CssClass="altMenuLeftPane" runat="server"
                    AutoHide="True" Width="100%" SelectedNodeContainerControl="hfSelectedNode">
                    <cm:ContextMenuItem Name="Editcategory" Text="Edit category" CommandName="EditCategory" Tooltip="Click to edit this category"
                        ImageUrl="/Admin/Module/NewsLetterV3/Img/EditCategory_small.gif" />
                    <cm:ContextMenuItem Name="Addrecipient" Text="Add recipient" CommandName="AddRecipient" Tooltip="Click to add new recipient"
                        ImageUrl="/Admin/Module/NewsLetterV3/Img/AddRecipient_small.gif" />
                    <cm:ContextMenuItem Name="Search" Text="Search" CommandName="Search" Tooltip="Search" ImageUrl="/Admin/Images/Icons/Module_Filearchive_small.gif" />
                    <cm:ContextMenuItem Name="Delimiter" />
                    <cm:ContextMenuItem Name="Deletecategory" Text="Delete category" OnClickClientScript="return DeleteConfirm();"
                        CommandName="DeleteCategory" Tooltip="Click to delete this category" ImageUrl="/Admin/Images/Icons/Page_delete.gif" />
                </cm:ContextMenu>
                
                <cm:ContextMenu ID="ContextMenuDeletedCategories" CssClass="altMenuLeftPane" runat="server"
                    AutoHide="True" Width="100%" SelectedNodeContainerControl="hfSelectedNode">
                    <cm:ContextMenuItem Name="Restorecategory" Text="Restore category" CommandName="RestoreCategory" Tooltip="Click to restore this category"
                        ImageUrl="/Admin/Images/Icons/Page_edit.gif" />                    
                    <cm:ContextMenuItem Name="Delimiter" />
                    <cm:ContextMenuItem Name="Deletecategory" Text="Delete category" OnClickClientScript="return DeleteConfirm();"
                        CommandName="DeleteCategory" Tooltip="Click to delete this category" ImageUrl="/Admin/Images/Icons/Page_delete.gif" />
                </cm:ContextMenu>
                
                <cm:ContextMenu ID="ContextMenuSearch" CssClass="altMenuLeftPane" runat="server"
                    AutoHide="True" Width="100%" SelectedNodeContainerControl="hfSelectedNode">
                    <cm:ContextMenuItem Name="Search" Text="Search" CommandName="Search" Tooltip="Search" ImageUrl="/Admin/Images/Icons/Module_Filearchive_small.gif" />
                </cm:ContextMenu>
                
                <cm:ContextMenu ID="ContextMenuEmptyDeleted" CssClass="altMenuLeftPane" runat="server"
                    AutoHide="True" Width="100%" SelectedNodeContainerControl="hfSelectedNode">
                    <cm:ContextMenuItem Name="Search" Text="Search" CommandName="Search" Tooltip="Search" ImageUrl="/Admin/Images/Icons/Module_Filearchive_small.gif" />
                    <cm:ContextMenuItem Name="Delimiter" />
                    <cm:ContextMenuItem Name="Empty" Text="Empty"  OnClickClientScript="return DeleteConfirm();" 
                    CommandName="Empty" Tooltip="Empty deleted newsletters" ImageUrl="/Admin/Module/NewsLetterV3/Img/DeletedItems_small.gif" />
                </cm:ContextMenu>
                
                <cm:ContextMenu ID="ContextMenuAllRecipient" CssClass="altMenuLeftPane" runat="server"
                    AutoHide="True" Width="100%" SelectedNodeContainerControl="hfSelectedNode">
                    <cm:ContextMenuItem Name="Addrecipient" Text="Add recipient" CommandName="AddRecipient" Tooltip="Click to add new recipient"
                        ImageUrl="/Admin/Module/NewsLetterV3/Img/AddRecipient_small.gif" />
                    <cm:ContextMenuItem Name="Search" Text="Search" CommandName="Search" Tooltip="Search" ImageUrl="/Admin/Images/Icons/Module_Filearchive_small.gif" />
                </cm:ContextMenu>
                
                 <cm:ContextMenu ID="ContextMenuIntegration" CssClass="altMenuLeftPane" runat="server"
                    AutoHide="True" Width="100%" SelectedNodeContainerControl="hfSelectedNode">
                    <cm:ContextMenuItem Name="Addnewsrule" Text="Add news rule" CommandName="AddNewsIntegrationRule" Tooltip="Click to add new integration rule"
                        ImageUrl="/Admin/Module/NewsLetterV3/Img/Integration_News.gif" />                    
                </cm:ContextMenu>
                
                <cm:ContextMenu ID="ContextMenuIntegrationItem" CssClass="altMenuLeftPane" runat="server"
                    AutoHide="True" Width="100%" SelectedNodeContainerControl="hfSelectedNode">
                     <cm:ContextMenuItem Name="Editrule" Text="Edit rule" CommandName="EditRule" Tooltip="Click to edit this rule" ImageUrl="/Admin/Images/Icons/Page_edit.gif" />                    
                    <cm:ContextMenuItem Name="Deleterule" Text="Delete rule" OnClickClientScript="return DeleteConfirm();" CommandName="DeleteRule" Tooltip="Click to delete this rule" ImageUrl="/Admin/Images/Icons/Page_delete.gif" />
                </cm:ContextMenu>
                
                <asp:HiddenField ID="hfSelectedNode" runat="server" />
                <asp:Panel ID=CategoriesNames runat=server />
            </div>
        </div>
        <%  Translate.GetEditOnlineScript() %>
    </form>
</body>
</html>
