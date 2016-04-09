<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ViewRepository.aspx.vb" Inherits="Dynamicweb.Admin.Repositories.ViewRepository" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
	    <title></title>
        <dw:ControlResources IncludePrototype="true" IncludeUIStylesheet="true" runat="server">
        </dw:ControlResources>
    </head>
    <body>
        <form id="MainForm" onsubmit="" runat="server" style="overflow: hidden">
	        <div style="min-width:1000px;overflow:hidden">
		        <dw:Ribbonbar runat="server" ID="myribbon">
			        <dw:RibbonbarTab Active="true" Name="Repository" runat="server">
				        <dw:RibbonbarGroup runat="server" ID="grpTools" Name="Tools">
					        <dw:RibbonbarButton runat="server" Text="Save" Size="Small" Image="Save" KeyboardShortcut="ctrl+s" ID="cmdSave"  ShowWait="true" WaitTimeout="500">
					        </dw:RibbonbarButton>
					        <dw:RibbonbarButton runat="server" Text="Save and close" Size="Small" Image="SaveAndClose" ID="cmdSaveAndClose"  ShowWait="true" WaitTimeout="500">
					        </dw:RibbonbarButton>
					        <dw:RibbonbarButton runat="server" Text="Cancel" Size="Small" Image="Cancel" ID="cmdCancel"  ShowWait="true" WaitTimeout="500">
					        </dw:RibbonbarButton>
				        </dw:RibbonbarGroup>
				        <dw:RibbonbarGroup runat="server" ID="grpAdd" Name="Add">
					        <dw:RibbonbarButton runat="server" Text="Add Index" Size="Small" Image="AddDocument" ID="cmdNewIndex" OnClientClick="dialog.show('NewIndexDialog');"></dw:RibbonbarButton>
					        <dw:RibbonbarButton runat="server" Text="Add Query" Size="Small" Image="AddDocument" ID="cmdNewQuery" OnClientClick="dialog.show('NewQueryDialog');"></dw:RibbonbarButton>
					        <dw:RibbonbarButton runat="server" Text="Add Facets" Size="Small" Image="AddDocument" ID="cmdNewFacets" OnClientClick="dialog.show('NewFacetsDialog');"></dw:RibbonbarButton>
				            <dw:RibbonbarButton runat="server" Text="Add Task" Size="Small" Image="AddDocument" ID="cmdNewTask" OnClientClick="dialog.show('NewTaskDialog');"></dw:RibbonbarButton>
				        </dw:RibbonbarGroup>
				        <dw:RibbonbarGroup ID="grpHelp" runat="server" Name="Help">
					    <dw:RibbonbarButton ID="RibbonbarButton1" runat="server" Size="Large" Text="Help" Image="Help"  OnClientClick="window.open('http://manual.net.dynamicweb.dk/Default.aspx?ID=1&m=keywordfinder&keyword=administration.managementcenter.Repositories&LanguageID=en', 'dw_help_window', 'location=no,directories=no,menubar=no,toolbar=yes,top=0,width=1024,height=' + (screen.availHeight-100) + ',resizable=yes,scrollbars=yes');"></dw:RibbonbarButton>
                        </dw:RibbonbarGroup>
                    </dw:RibbonbarTab>
                </dw:Ribbonbar>
            </div>

            <div id="breadcrumb" style="height:18px;padding-top:3px;padding-left:10px">
                »
                <a href="/admin/content/management/Start.aspx">Management</a> »
                <a href="#">Repositories</a> »
                <a href="#"><b><%=_repository.Name%></b></a>
            </div>

            <dw:List runat="server" ID="lstRepositoryElements" ShowTitle="false">
                <Columns>
                    <dw:ListColumn runat="server" Name="" Width="16"  />
                    <dw:ListColumn runat="server" Name="Name" Width="350" />
                    <dw:ListColumn runat="server" Name="Type" Width="100" />
                </Columns>
            </dw:List>

            <dw:Dialog runat="server" ID="NewIndexDialog" Width="500">
                <dw:GroupBox runat="server" ID="GroupBox1" Title="New Index">
                    <table>
                        <tr>
                            <td class="left-label"><%= Dynamicweb.Backend.Translate.Translate("Name")%></td>
                            <td>
                                <input type="text" name="indexName" id="newIndexName" value="" class="std" /><br />
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
            </dw:Dialog>

            <dw:Dialog runat="server" ID="NewQueryDialog" Width="500">
                <dw:GroupBox runat="server" ID="GroupBox2" Title="New Query">
                    <table>
                        <tr>
                            <td class="left-label"><%= Dynamicweb.Backend.Translate.Translate("Name")%></td>
                            <td>
                                <input type="text" id="newQueryName" value="" class="std" />
                            </td>
                        </tr>
                        <tr>
                            <td class="left-label"><%= Dynamicweb.Backend.Translate.Translate("Data Source")%></td>
                            <td>
                                <%= SelectIndexDataSources()%>
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
            </dw:Dialog>

            <dw:Dialog runat="server" ID="NewFacetsDialog" Width="500">
                <dw:GroupBox runat="server" ID="GroupBox3" Title="New Facets">
                    <table>
                        <tr>
                            <td class="left-label"><%= Dynamicweb.Backend.Translate.Translate("Name")%></td>
                            <td>
                                <input type="text" id="newFacetsName" value="" class="std" /><br />
                            </td>
                        </tr>
                        <tr>
                            <td class="left-label"><%= Dynamicweb.Backend.Translate.Translate("Query")%></td>
                            <td>
                                <%= SelectQueryDataSources()%>
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
            </dw:Dialog>

            <dw:Dialog runat="server" ID="NewTaskDialog" Width="500">
                <dw:GroupBox runat="server" ID="GroupBox4" Title="New Task">
                    <table>
                        <tr>
                            <td class="left-label"><%= Dynamicweb.Backend.Translate.Translate("Name")%></td>
                            <td>
                                <input type="text" name="taskName" id="newTaskName" value="" class="std" /><br />
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
            </dw:Dialog>
            
            <dw:ContextMenu ID="mnuContext" runat="server">
                <dw:ContextMenuButton Text="Open" Image="Document" OnClientClick="openItem(ContextMenu.callingItemID);" runat="server" />
                <dw:ContextMenuButton Text="Delete" Image="Delete" OnClientClick="deleteItem(ContextMenu.callingItemID);" runat="server" />
            </dw:ContextMenu>
        </form>
        <dw:Overlay ID="ItemTypeEditOverlay" runat="server"></dw:Overlay>

        <%Translate.GetEditOnlineScript()%>
        <script type="text/javascript">
            var repositoryName = "<%= _repository.Name%>";

            function addIndexOkAction() {
                var emptyNameText = "<%= Dynamicweb.Backend.Translate.Translate("The name of the index cannot be empty.")%>";

                var indexName = document.getElementById("newIndexName").value;
                if (indexName.length > 0) {
                    location.href = "/Admin/Module/Repositories/ViewIndex.aspx?repository=" + repositoryName + "&new=true&item=" + indexName;
                }
                else {
                    alert(emptyNameText);
                }
            }

            function addQueryOkAction() {
                var emptyNameText = "<%= Dynamicweb.Backend.Translate.Translate("The name of the query cannot be empty.")%>";
                var noDataSourceText = "<%= Dynamicweb.Backend.Translate.Translate("Data Source should be selected.")%>";

                var queryName = document.getElementById("newQueryName").value;
                var querySource = document.getElementById("newQuerySource").value;

                if (queryName.length == 0) {
                    alert(emptyNameText);
                    return;
                }

                if (querySource.length == 0) {
                    alert(noDataSourceText);
                    return;
                }

                location.href = "/Admin/Module/Repositories/ViewQuery.aspx?repository=" + repositoryName + "&new=true&item=" + queryName + "&source=" + querySource;
            }

            function addFacetsOkAction() {
                var emptyNameText = "<%= Dynamicweb.Backend.Translate.Translate("The name of the facets cannot be empty.")%>";
                var noQueryText = "<%= Dynamicweb.Backend.Translate.Translate("Query should be selected.")%>";

                var name = document.getElementById("newFacetsName").value;
                var query = document.getElementById("newFacetsQuery").value;

                if (name.length == 0) {
                    alert(emptyNameText);
                    return;
                }

                if (query.length == 0) {
                    alert(noQueryText);
                    return;
                }

                location.href = "/Admin/Module/Repositories/ViewFacets.aspx?repository=" + repositoryName + "&new=true&item=" + name + "&query=" + query;
            }

            function addTaskOkAction() {
                var emptyNameText = "<%= Dynamicweb.Backend.Translate.Translate("The name of the task cannot be empty.")%>";

                var indexName = document.getElementById("newTaskName").value;
                if (indexName.length > 0) {
                    location.href = "/Admin/Module/Repositories/ViewTask.aspx?repository=" + repositoryName + "&new=true&item=" + indexName;
                }
                else {
                    alert(emptyNameText);
                }
            }

            function openItem(idString) {
                var elements = idString.split("|");
                location.href = elements[2];
            }

            function deleteItem(idString) {
                var elements = idString.split("|");
                var deleteString = '<%=Translate.Translate("Delete")%>? ' + elements[1];

                if (confirm(deleteString))
                    location.href = 'ViewRepository.aspx?CMD=delete&repository=' + elements[0] + "&item=" + elements[1];
            }
        </script>
    </body>
</html>
