<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="Dynamicweb.Admin.OMC._Default" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls.Charts" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="dw" TagName="Accordion" Src="~/Admin/Content/Accordion/Accordion.ascx" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />
    <title>
        <dw:TranslateLabel ID="lbTitle" Text="Marketing" runat="server" />
    </title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <dw:ControlResources ID="ctrlResources" runat="server">
        <Items>
            <dw:GenericResource Url="/Admin/Module/OMC/js/Default.js" />
            <dw:GenericResource Url="/Admin/Module/OMC/css/Default.css" />
        </Items>
    </dw:ControlResources>
</head>
<body>
    <form id="MainForm" runat="server">
        <table id="mainTab" width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
            <tr valign="top">
                <td id="cellTreeCollapsed" style="display: none">
                    <img id="imgShowNav" class="tree-toolbar-button" style="cursor: pointer" src="/Admin/images/OpenTreeView_off.gif" runat="server" />
                </td>
                <td id="cellTree" style="width: 250px;">
                    <div class="cellTreeContainer">
                        <dw:Tree ID="MainTree" EnableControlMenu="False" UseCookies="false" ShowRoot="false" Title="Marketing" ShowSubTitle="false" LoadOnDemand="true" UseSelection="true" OpenAll="false" UseLines="true" InOrder="true" ClientNodeComparator="OMC.MasterPage.get_current().compareTreeNodes" runat="server">
                            <dw:TreeNode ID="nodeRoot" NodeID="0" ParentID="-1" Name="Root" ItemID="/" runat="server" />
                            <%If Not isFromParameterEditor Then%>
								<dw:TreeNode ID="nodeDashboard" NodeID="1" ParentID="0" Name="Dashboard" HasChildren="false" ItemID="/Dashboard" ImagePath="/Admin/Images/Ribbon/Icons/Small/home.png" Href="javascript:OMC.MasterPage.get_current().set_contentUrl('/Admin/Module/OMC/Dashboard.aspx');" runat="server" />
								<dw:TreeNode ID="nodeReports" NodeID="2" ParentID="0" Name="Reports" HasChildren="true" ItemID="/Reports" ContextMenuID="menuReports" ImagePath="/Admin/Images/Ribbon/Icons/Small/column-chart.png" ImageOpenPath="/Admin/Images/Ribbon/Icons/Small/column-chart.png" ImageClosePath="/Admin/Images/Ribbon/Icons/Small/column-chart.png" runat="server" />
								<dw:TreeNode ID="nodeLeads" NodeID="3" ParentID="0" Name="Leads" HasChildren="true" ItemID="/Leads" ImagePath="/Admin/Images/Ribbon/Icons/Small/flag_green.png" ImageOpenPath="/Admin/Images/Ribbon/Icons/Small/flag_green.png" ImageClosePath="/Admin/Images/Ribbon/Icons/Small/flag_green.png" runat="server" />
								<dw:TreeNode ID="nodeSplitTesting" NodeID="4" ParentID="0" Name="Split tests" HasChildren="false" ItemID="/Experiments" ImagePath="/Admin/Images/Ribbon/Icons/Small/branch_element.png" ImageOpenPath="/Admin/Images/Ribbon/Icons/Small/branch_element.png" ImageClosePath="/Admin/Images/Ribbon/Icons/Small/branch_element.png" Href="javascript:OMC.MasterPage.get_current().set_contentUrl('/Admin/Module/OMC/Experiments/Overview.aspx');" runat="server" />
								<%If Base.IsModuleInstalled("Profiling") Then%>
								<dw:TreeNode ID="nodeProfiling" NodeID="5" ParentID="0" Name="Personalization" HasChildren="true" ItemID="/Profiles" ContextMenuID="menuProfiles" ImagePath="/Admin/Module/OMC/img/profile.png" ImageOpenPath="/Admin/Module/OMC/img/profile.png" ImageClosePath="/Admin/Module/OMC/img/profile.png" runat="server" />
								<%End If%>
								<%End If%>
								<%If Base.IsModuleInstalled("EmailMarketing") Then%>
								<dw:TreeNode ID="nodeNewsletters" NodeID="6" ParentID="0" Name="Email Marketing" HasChildren="true" ItemID="/EmailMarketing" ContextMenuID="menuEmailMarketing" ImagePath="/Admin/Images/Icons/Module_NewsletterV3_small.gif" ImageOpenPath="/Admin/Images/Icons/Module_NewsletterV3_small.gif" ImageClosePath="/Admin/Images/Icons/Module_NewsletterV3_small.gif" runat="server" />
								<%End If%>
								<%If Not isFromParameterEditor Then%>
								<%If False Then 'Base.IsModuleInstalled("Campaigns") Then%>
								<dw:TreeNode ID="nodeAutomations" NodeID="8" ParentID="0" Name="Campaigns" HasChildren="true" ItemID="/Automations" ContextMenuID="MenuAutomation" ImagePath="/Admin/Images/Ribbon/Icons/Small/gantt-chart.png" ImageOpenPath="/Admin/Images/Ribbon/Icons/Small/gantt-chart.png" ImageClosePath="/Admin/Images/Ribbon/Icons/Small/gantt-chart.png" runat="server" />
								<%End If%>
								<%If Base.IsModuleInstalled("SocialMediaPublishing") Then%>
								<dw:TreeNode ID="nodeSocialMediaPublishing" NodeID="7" ParentID="0" Name="Social Media Publishing" HasChildren="true" ItemID="/SocialMediaPublishing" ContextMenuID="menuSocialMediaPublishing" ImagePath="/Admin/Images/Ribbon/Icons/Small/users_family.png" ImageOpenPath="/Admin/Images/Ribbon/Icons/Small/users_family.png" ImageClosePath="/Admin/Images/Ribbon/Icons/Small/users_family.png" runat="server" />
								<%End If%>
								<%If Base.IsModuleInstalled("Sms") Then%>
								<dw:TreeNode ID="TreeNode1" NodeID="8" ParentID="0" Name="SMS" HasChildren="false" ItemID="/Sms" ContextMenuID="menuSms" ImagePath="/Admin/Images/Ribbon/Icons/Small/message.png" ImageOpenPath="/Admin/Images/Ribbon/Icons/Small/message.png" ImageClosePath="/Admin/Images/Ribbon/Icons/Small/message.png" Href="javascript:OMC.MasterPage.get_current().set_contentUrl('/Admin/Module/Sms/SmsList.aspx');" runat="server" />
								<%End If%>
                            <%End If%>
                        </dw:Tree>
                        <div id="accordionContainer">
                            <dw:Accordion ID="Accordion" SelectedButton="omc" ContextMenuID="AccordionMenu" runat="server" />
                        </div>
                    </div>
                    <div id="treeEndMarker" style="height: 1px">
                    </div>
                </td>
                <td id="slider">
                    <div id="sliderHandle">
                        &nbsp;
                    </div>
                </td>
                <td id="cellContent">
                    <div id="cellContentLoading" style="display: none">
                        <div class="omc-loading-container">
                            <div class="omc-loading-container-inner">
                                <img src="/Admin/Images/Ribbon/UI/Overlay/wait.gif" alt="" title="" />
                                <div class="omc-loading-container-text">
                                    <dw:TranslateLabel ID="lbPleaseWait" Text="One moment please..." runat="server" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="entryContainer" style="display: none">
                        <div id="entryTitle">
                        </div>
                        <div id="entryToolbarLoading" style="display: none">
                            <div class="omc-toolbar-loading">
                                <div class="omc-toolbar-loading-inner">
                                    <div class="omc-toolbar-loading-contents">
                                        <img src="/Admin/Module/Seo/Dynamicweb_Wait.gif" border="0" alt="" title="" />
                                        <span>
                                            <dw:TranslateLabel ID="lbLoadingToolbar" Text="Initializing toolbar..." runat="server" />
                                        </span>
                                    </div>
                                </div>
                                <div class="omc-clear">
                                </div>
                            </div>
                        </div>
                        <div id="entryToolbar" style="display: none">
                        </div>
                        <iframe id="ContentFrame" src="about:blank" frameborder="0" width="100%" scrolling="auto" onload="OMC.MasterPage.get_current().contentLoaded();" height="100%" marginheight="0" marginwidth="0"></iframe>
                    </div>
                </td>
            </tr>
        </table>
        <dw:ContextMenu ID="AccordionMenu" runat="server" OnClientSelectView="OMC.MasterPage.onAccordionContextMenuView">
            <dw:ContextMenuButton runat="server" ID="cmdPages" Views="page" Text="Open in new window" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="OMC.MasterPage.onAccordionContextMenu(this, 'page()');" />
            <dw:ContextMenuButton runat="server" ID="cmdFiles" Views="filemanager" Text="Open in new window" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="OMC.MasterPage.onAccordionContextMenu(this, 'filemanager()');" />
            <dw:ContextMenuButton runat="server" ID="cmdUserManagement" Views="usermanagement" Text="Open in new window" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="OMC.MasterPage.onAccordionContextMenu(this, 'userManagement()');" />
            <dw:ContextMenuButton runat="server" ID="cmdEcom" Views="ecom" Text="Open in new window" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="OMC.MasterPage.onAccordionContextMenu(this, 'ecom()');" />
            <dw:ContextMenuButton runat="server" ID="cmdOMC" Views="omc" Text="Open in new window" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="OMC.MasterPage.onAccordionContextMenu(this, 'omc()');" />
            <dw:ContextMenuButton runat="server" ID="cmdModules" Views="modules" Text="Open in new window" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="OMC.MasterPage.onAccordionContextMenu(this, 'modules()');" />
            <dw:ContextMenuButton runat="server" ID="cmdManagementCenter" Views="managementcenter" Text="Open in new window" ImagePath="/Admin/Images/Ribbon/Icons/Small/Document.png" OnClientClick="OMC.MasterPage.onAccordionContextMenu(this, 'mgmtcenter()');" />
        </dw:ContextMenu>
        <dw:ContextMenu ID="menuReport" OnShow="OMC.MasterPage.get_current().get_tree().get_dynamic().highlight(ContextMenu.callingID);" runat="server">
            <dw:ContextMenuButton ID="cmdEditReport" Text="Edit report" ImagePath="/Admin/Module/OMC/img/report_edit_small.png" OnClientClick="OMC.MasterPage.get_current().editReport();" runat="server" />
            <dw:ContextMenuButton ID="cmdDeleteReport" Divide="Before" Text="Delete report" ImagePath="/Admin/Module/OMC/img/report_delete_small.png" OnClientClick="" runat="server" />
        </dw:ContextMenu>
        <dw:ContextMenu ID="menuCategory" OnShow="OMC.MasterPage.get_current().get_tree().get_dynamic().highlight(ContextMenu.callingID);" runat="server">
            <dw:ContextMenuButton ID="cmdCreateReport" Text="Create new report" ImagePath="/Admin/Images/Ribbon/Icons/Small/AddDocument.png" OnClientClick="OMC.MasterPage.get_current().createReport(null);" runat="server" />
            <dw:ContextMenuButton ID="cmdCreateCategory" Text="Create new category" Divide="Before" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_add.png" OnClientClick="OMC.MasterPage.get_current().beginCreateReportCategory(null);" runat="server" />
            <dw:ContextMenuButton ID="cmdEditCategory" Text="Edit category" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_edit.png" OnClientClick="OMC.MasterPage.get_current().beginEditReportCategory(null);" runat="server" />
            <dw:ContextMenuButton ID="cmdDeleteCategory" Divide="Before" Text="Delete category" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_delete.png" OnClientClick="" runat="server" />
        </dw:ContextMenu>
        <dw:ContextMenu ID="menuReports" OnShow="OMC.MasterPage.get_current().get_tree().get_dynamic().highlight(ContextMenu.callingID);" runat="server">
            <dw:ContextMenuButton ID="cmdCreateReportGeneral" Text="Create new report" ImagePath="/Admin/Images/Ribbon/Icons/Small/AddDocument.png" OnClientClick="OMC.MasterPage.get_current().set_contentUrl('/Admin/Module/OMC/Reports/ReportBuilder.aspx');" runat="server" />
            <dw:ContextMenuButton ID="cmdCreateCategoryGeneral" Text="Create new category" Divide="Before" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_add.png" OnClientClick="OMC.MasterPage.get_current().beginCreateReportCategory(null);" runat="server" />
        </dw:ContextMenu>
        <dw:ContextMenu ID="menuTheme" OnShow="OMC.MasterPage.get_current().get_tree().get_dynamic().highlight(ContextMenu.callingID);" runat="server">
            <dw:ContextMenuButton ID="cmdCreateTheme" Text="Create new theme" ImagePath="/Admin/Module/OMC/img/theme_add_small.png" OnClientClick="OMC.MasterPage.get_current().editTheme();" runat="server" />
        </dw:ContextMenu>
        <dw:ContextMenu ID="menuReportTheme" OnShow="OMC.MasterPage.get_current().get_tree().get_dynamic().highlight(ContextMenu.callingID);" runat="server">
            <dw:ContextMenuButton ID="cmdEditTheme" Text="Edit theme" ImagePath="/Admin/Module/OMC/img/theme_edit_small.png" OnClientClick="OMC.MasterPage.get_current().editTheme();" runat="server" />
            <dw:ContextMenuButton ID="cmdDeleteTheme" Divide="Before" Text="Delete theme" ImagePath="/Admin/Module/OMC/img/theme_delete_small.png" OnClientClick="" runat="server" />
        </dw:ContextMenu>
        <dw:ContextMenu ID="menuProfiles" OnShow="OMC.MasterPage.get_current().get_tree().get_dynamic().highlight(ContextMenu.callingID);" runat="server">
            <dw:ContextMenuButton ID="cmdCreateProfile" Text="Create new profile" ImagePath="/Admin/Module/OMC/img/profile_add.png" OnClientClick="OMC.MasterPage.get_current().editProfile();" runat="server" />
        </dw:ContextMenu>
        <dw:ContextMenu ID="menuProfile" OnShow="OMC.MasterPage.get_current().get_tree().get_dynamic().highlight(ContextMenu.callingID);" runat="server">
            <dw:ContextMenuButton ID="cmdEditProfile" Text="Edit profile" ImagePath="/Admin/Module/OMC/img/profile_edit.png" OnClientClick="OMC.MasterPage.get_current().editProfile();" runat="server" />
            <dw:ContextMenuButton ID="cmdDeleteProfile" Divide="Before" Text="Delete profile" ImagePath="/Admin/Module/OMC/img/profile_delete.png" OnClientClick="" runat="server" />
        </dw:ContextMenu>
        <dw:ContextMenu ID="menuDraftEmails" OnShow="OMC.MasterPage.get_current().get_tree().get_dynamic().highlight(ContextMenu.callingID);" runat="server">
            <dw:ContextMenuButton ID="cmdCreateNewsletter" Text="Create new email" ImagePath="/Admin/Module/NewsLetterV3/Img/tbAddNewsletter.gif" OnClientClick="OMC.MasterPage.get_current().editNewsletter(null, null, ContextMenu.callingItemID, true);" runat="server" />
        </dw:ContextMenu>
        <dw:ContextMenu ID="menuEmailMarketing" OnShow="OMC.MasterPage.get_current().get_tree().get_dynamic().highlight(ContextMenu.callingID);" runat="server">
            <dw:ContextMenuButton ID="cmdCreateTopFolder" Divide="Before" Text="Create new top folder" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_add.png" OnClientClick="OMC.MasterPage.get_current().editTopFolder();" runat="server" />
        </dw:ContextMenu>
        <dw:ContextMenu ID="menuSocialMediaPublishing" OnShow="OMC.MasterPage.get_current().get_tree().get_dynamic().highlight(ContextMenu.callingID);" runat="server">
            <dw:ContextMenuButton ID="ContextMenuButton3" Divide="Before" Text="Create new top folder" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_add.png" OnClientClick="OMC.MasterPage.get_current().editSMPTopFolder();" runat="server" />
        </dw:ContextMenu>
        <dw:ContextMenu ID="menuDefaultTopFolder" OnShow="OMC.MasterPage.get_current().get_tree().get_dynamic().highlight(ContextMenu.callingID);" runat="server">
            <dw:ContextMenuButton ID="cmdDefaultCreateEmail" Text="Create new email" ImagePath="/Admin/Module/NewsLetterV3/Img/tbAddNewsletter.gif" OnClientClick="OMC.MasterPage.get_current().editNewsletter(null, null, ContextMenu.callingItemID);" runat="server" />
            <dw:ContextMenuButton ID="cmdDefaultCreateCucstomFolder" Text="Create new folder" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_add.png" OnClientClick="OMC.MasterPage.get_current().beginCreateEmailFolder(ContextMenu.callingItemID);" runat="server" />
            <dw:ContextMenuButton ID="cmdDefaultEditTopFolder" Text="Edit top folder" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_edit.png" OnClientClick="OMC.MasterPage.get_current().editTopFolder(ContextMenu.callingItemID);" runat="server" />
            <%If Me.HasPermissionsAccess Then%>
            <dw:ContextMenuButton ID="cmdDefaultTopFolderPermissions" Text="Permissions" ImagePath="/admin/module/ecom_catalog/dw7/images/content/ecom_user_permission_small.gif" OnClientClick="OMC.MasterPage.get_current().editTopFolderPermissions(ContextMenu.callingItemID);" runat="server" />
            <%End If%>
        </dw:ContextMenu>
        <dw:ContextMenu ID="menuDefaultSMPTopFolder" OnShow="OMC.MasterPage.get_current().get_tree().get_dynamic().highlight(ContextMenu.callingID);" runat="server">
            <dw:ContextMenuButton ID="cmdCreateMessage" Text="Create new message" ImagePath="/Admin/Images/Ribbon/Icons/Small/message_add.png" OnClientClick="OMC.MasterPage.get_current().createMessage(null, null, ContextMenu.callingItemID);" runat="server" />
            <dw:ContextMenuButton ID="cmdCreateSMPFolder" Text="Create new folder" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_add.png" OnClientClick="OMC.MasterPage.get_current().beginCreateSMPFolder(ContextMenu.callingItemID);" runat="server" />
            <dw:ContextMenuButton ID="cmdEditDefaultSMPTopFolder" Text="Edit top folder" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_edit.png" OnClientClick="OMC.MasterPage.get_current().editSMPTopFolder(ContextMenu.callingItemID);" runat="server" />
        </dw:ContextMenu>
        <dw:ContextMenu ID="menuSMPTopFolder" OnShow="OMC.MasterPage.get_current().get_tree().get_dynamic().highlight(ContextMenu.callingID);" runat="server">
            <dw:ContextMenuButton ID="cmdCreateNewMessage" Text="Create new message" ImagePath="/Admin/Images/Ribbon/Icons/Small/message_add.png" OnClientClick="OMC.MasterPage.get_current().createMessage(null, null, ContextMenu.callingItemID);" runat="server" />
            <dw:ContextMenuButton ID="cmdCreateSMPCustomFolder" Text="Create new folder" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_add.png" OnClientClick="OMC.MasterPage.get_current().beginCreateSMPFolder(ContextMenu.callingItemID);" runat="server" />
            <dw:ContextMenuButton ID="cmdEditSMPTopFolder" Text="Edit top folder" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_edit.png" OnClientClick="OMC.MasterPage.get_current().editSMPTopFolder(ContextMenu.callingItemID);" runat="server" />
            <dw:ContextMenuButton ID="cmdDeleteSMPTopFolder" Divide="Before" Text="Delete top folder" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_delete.png" OnClientClick="" runat="server" />
        </dw:ContextMenu>
        <dw:ContextMenu ID="cmdUserSMPFolder" OnShow="OMC.MasterPage.get_current().get_tree().get_dynamic().highlight(ContextMenu.callingID);" runat="server">
            <dw:ContextMenuButton ID="cmdCreateUserSMPFolder" Text="Create new folder" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_add.png" OnClientClick="OMC.MasterPage.get_current().beginCreateSMPFolder(null);" runat="server" />
            <dw:ContextMenuButton ID="cmdEditUserSMPFolder" Text="Edit folder" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_edit.png" OnClientClick="OMC.MasterPage.get_current().beginEditSMPFolder(ContextMenu.callingItemID);" runat="server" />
            <dw:ContextMenuButton ID="cmdDeleteSMPFolder" Divide="Before" Text="Delete folder" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_delete.png" OnClientClick="" runat="server" />
        </dw:ContextMenu>
        <dw:ContextMenu ID="menuTopFolder" OnShow="OMC.MasterPage.get_current().get_tree().get_dynamic().highlight(ContextMenu.callingID);" runat="server">
            <dw:ContextMenuButton ID="cmdCreateEmail" Text="Create new email" ImagePath="/Admin/Module/NewsLetterV3/Img/tbAddNewsletter.gif" OnClientClick="OMC.MasterPage.get_current().editNewsletter(null, null, ContextMenu.callingItemID);" runat="server" />
            <dw:ContextMenuButton ID="cmdCreateCucstomFolder" Text="Create new folder" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_add.png" OnClientClick="OMC.MasterPage.get_current().beginCreateEmailFolder(ContextMenu.callingItemID);" runat="server" />
            <dw:ContextMenuButton ID="cmdEditTopFolder" Text="Edit top folder" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_edit.png" OnClientClick="OMC.MasterPage.get_current().editTopFolder(ContextMenu.callingItemID);" runat="server" />
            <%If Me.HasPermissionsAccess Then%>
            <dw:ContextMenuButton ID="cmdTopFolderPermissions" Text="Permissions" ImagePath="/admin/module/ecom_catalog/dw7/images/content/ecom_user_permission_small.gif" OnClientClick="OMC.MasterPage.get_current().editTopFolderPermissions(ContextMenu.callingItemID);" runat="server" />
            <%End If%>
            <dw:ContextMenuButton ID="cmdDeleteTopFolder" Divide="Before" Text="Delete top folder" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_delete.png" OnClientClick="" runat="server" />
        </dw:ContextMenu>
        <dw:ContextMenu ID="menuAllEmails" OnShow="OMC.MasterPage.get_current().get_tree().get_dynamic().highlight(ContextMenu.callingID);" runat="server">
            <%If Me.HasPermissionsAccess Then%>
            <dw:ContextMenuButton ID="cmdAllEmailsFolderPermissions" Text="Permissions" ImagePath="/admin/module/ecom_catalog/dw7/images/content/ecom_user_permission_small.gif" OnClientClick="OMC.MasterPage.get_current().editTopFolderPermissions(ContextMenu.callingItemID);" runat="server" />
            <%End If%>
        </dw:ContextMenu>
        <dw:ContextMenu ID="menuEmailUserFolder" OnShow="OMC.MasterPage.get_current().get_tree().get_dynamic().highlight(ContextMenu.callingID);" runat="server">
            <dw:ContextMenuButton ID="cmdCreateUserFolder" Text="Create new folder" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_add.png" OnClientClick="OMC.MasterPage.get_current().beginCreateEmailFolder(null);" runat="server" />
            <dw:ContextMenuButton ID="cmdEditEmaiFolder" Text="Edit folder" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_edit.png" OnClientClick="OMC.MasterPage.get_current().beginEditEmailFolder(ContextMenu.callingItemID);" runat="server" />
            <dw:ContextMenuButton ID="cmdDeleteEmailFolder" Divide="Before" Text="Delete folder" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_delete.png" OnClientClick="" runat="server" />
        </dw:ContextMenu>
        <dw:ContextMenu ID="menuAllAutomations" OnShow="OMC.MasterPage.get_current().get_tree().get_dynamic().highlight(ContextMenu.callingID);" runat="server">
            <dw:ContextMenuButton ID="cmdCreateNewAutomation" Text="Create new campaign" ImagePath="/Admin/Images/Ribbon/Icons/Small/AddGear.png" OnClientClick="OMC.MasterPage.get_current().set_contentUrl('/Admin/Module/OMC/Automations/EditAutomation.aspx?New=True');" runat="server" />
        </dw:ContextMenu>
        <dw:ContextMenu ID="MenuAutomations" OnShow="OMC.MasterPage.get_current().get_tree().get_dynamic().highlight(ContextMenu.callingID);" runat="server">
            <dw:ContextMenuButton ID="cmdCreateNewAutomationInFolder" Text="Create new campaign" ImagePath="/Admin/Images/Ribbon/Icons/Small/AddGear.png" OnClientClick="OMC.MasterPage.get_current().set_contentUrl('/Admin/Module/OMC/Automations/EditAutomation.aspx?New=True&caller='+ContextMenu.callingItemID);" runat="server" />
            <dw:ContextMenuButton ID="cmdCreateNewAutomationFolder" Text="Create new folder" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_add.png" OnClientClick="OMC.MasterPage.get_current().beginCreateAutomationFolder(ContextMenu.callingItemID);" runat="server" />
            <dw:ContextMenuButton ID="cmdEditAutomationFolder" Text="Edit folder" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_edit.png" OnClientClick="OMC.MasterPage.get_current().beginEditAutomationFolder(ContextMenu.callingItemID);;" runat="server" />
            <dw:ContextMenuButton ID="cmdDeleteAutomationFolder" Divide="Before" Text="Delete folder" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_delete.png" OnClientClick="" runat="server" />
        </dw:ContextMenu>
        <dw:ContextMenu ID="MenuAutomation" OnShow="OMC.MasterPage.get_current().get_tree().get_dynamic().highlight(ContextMenu.callingID);" runat="server">
            <dw:ContextMenuButton ID="cmdCreateNewTopAutomationFolder" Text="Create new folder" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_add.png" OnClientClick="OMC.MasterPage.get_current().beginCreateAutomationFolder(ContextMenu.callingItemID);" runat="server" />
        </dw:ContextMenu>

        <dw:ContextMenu ID="menuUnpublishedMessage" OnShow="OMC.MasterPage.get_current().get_tree().get_dynamic().highlight(ContextMenu.callingID);" runat="server">
            <dw:ContextMenuButton ID="ContextMenuButton1" Text="Create new message" ImagePath="/Admin/Images/Ribbon/Icons/Small/message_add.png" OnClientClick="OMC.MasterPage.get_current().createMessage(null, null, ContextMenu.callingItemID, true);" runat="server" />
        </dw:ContextMenu>
        <!-- Hosting control for rendering controls asynchronously. Needed in order to have a reference to the current page -->
        <asp:Panel ID="pHostingControl" runat="server">
        </asp:Panel>

        <dw:PopUpWindow ID="pwDialog" UseTabularLayout="true" TranslateTitle="true" ContentUrl=""
            ShowClose="true" HidePadding="true" AutoReload="true" ShowOkButton="false" ShowCancelButton="true" IsModal="True"
            ShowHelpButton="false" SnapToScreen="true" Width="100" AutoCenterProgress="true" Height="100" runat="server" />
        <dw:Dialog runat="server" ID="permissionEditDialog" Width="316" Title="Edit permissions" ShowClose="true" HidePadding="true">
            <iframe id="permissionEditDialogIFrame" style="width: 300px; height: 510px;"></iframe>
        </dw:Dialog>
    </form>

    <script type="text/javascript">
        //<![CDATA[
        $(document.body).observe('unload', function () {
            OMC.MasterPage.get_current().dispose();
        });

        var nodeLeadsID = 3;

        var onTreeAfterExpandAjax = function (sender, args) {
            if (args.ParentNodeID == nodeLeadsID) {
                if (args.ChildrenNodes.length > 0 && args.ChildrenNodes[0].url && args.ChildrenNodes[0].url != '') {
                    var firstNode = args.ChildrenNodes[0];
                    OMC.MasterPage.get_current().get_tree().s(firstNode._ai);
                    try {
                        eval(firstNode.url);
                    } catch (e) {; }
                }
            }
        };

        OMC.MasterPage.get_current().set_controlID('<%=Me.UniqueID%>');
            OMC.MasterPage.get_current().set_dialog('<%=pwDialog.ClientInstanceName%>');

        OMC.MasterPage.get_current().initialize(function () {
            var open = '<%=Dynamicweb.Base.ChkString(MyBase.Request.QueryString("Open")).Replace("'", "\'")%>';

                if (open && open.length) {
                    OMC.MasterPage.get_current().set_contentUrl(OMC.MasterPage.Action.getAction(open));
                } else {
                    OMC.MasterPage.get_current().set_contentUrl('/Admin/Module/OMC/Dashboard.aspx');
                }

                OMC.MasterPage.get_current().get_tree().add_afterExpandAjax(onTreeAfterExpandAjax);
            });

        <%If isFromParameterEditor Then%>
        OMC.MasterPage.get_current()._isFromParameterEditor = true;
        OMC.MasterPage.get_current()._parameterEditorOpenerID = '<%=Input.Request("openerid")%>';
            //OMC.MasterPage.get_current().reload("/EmailMarketing/-1", { highlightNode: true });
            OMC.MasterPage.get_current().showEmailsList(-1, -1, false);
        <%End If%>
        //]]>
    </script>

    <script type="text/javascript">
        <%If Not isFromParameterEditor Then%>
        window.onload = function () {
            parent.frames.left.hidePageFrame();
        }
        <%End If%>
    </script>

    <%Translate.GetEditOnlineScript()%>
</body>
</html>
