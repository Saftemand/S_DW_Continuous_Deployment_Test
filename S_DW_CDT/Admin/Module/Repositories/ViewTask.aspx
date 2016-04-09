<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ViewTask.aspx.vb" Inherits="Dynamicweb.Admin.ViewTask" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
	    <title></title>
        <dw:ControlResources IncludePrototype="true" IncludeUIStylesheet="true" runat="server">
            <Items>
                <dw:GenericResource Url="/Admin/Module/Common/Stylesheet_ParSet.css" />
            </Items>
        </dw:ControlResources>
    </head>
    <body>
        <form id="MainForm" onsubmit="" runat="server" style="overflow: hidden">
	        <div style="min-width:1000px;overflow:hidden">
		        <dw:Ribbonbar runat="server" ID="myribbon">
			        <dw:RibbonbarTab Active="true" Name="Repository" runat="server">
				        <dw:RibbonbarGroup runat="server" ID="grpTools" Name="Tools">
					        <dw:RibbonbarButton runat="server" Text="Save" Size="Small" Image="Save" KeyboardShortcut="ctrl+s" ID="cmdSave" OnClientClick="save();"  ShowWait="true" WaitTimeout="500">
					        </dw:RibbonbarButton>
					        <dw:RibbonbarButton runat="server" Text="Save and close" Size="Small" Image="SaveAndClose" ID="cmdSaveAndClose" OnClientClick="saveAndClose();"  ShowWait="true" WaitTimeout="500">
					        </dw:RibbonbarButton>
					        <dw:RibbonbarButton runat="server" Text="Cancel" Size="Small" Image="Cancel" ID="cmdCancel" OnClientClick="cancel();"  ShowWait="true" WaitTimeout="500">
					        </dw:RibbonbarButton>
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
                <a href="/Admin/Module/Repositories/ViewRepository.aspx?id=<%=RepositoryId%>"><%=RepositoryId%></a> »
                <a href="#"><b><%= ItemId%></b></a>
            </div>

            <dw:GroupBox ID="grpTask" runat="server" Title="Task">
                <table>
                    <tr>
                        <td class="leftColHigh"><dw:TranslateLabel runat="server" Text="Start time"/></td>
                        <td><dw:DateSelector ID="dateStartTime" AllowNeverExpire="True" runat="server" /></td>
                    </tr>
                    <tr>
                        <td class="leftColHigh"><dw:TranslateLabel runat="server" Text="End time"/></td>
                        <td><dw:DateSelector ID="dateEndTime" AllowNeverExpire="True" runat="server" /></td>
                    </tr>
                    <tr>
                        <td class="leftColHigh"><dw:TranslateLabel runat="server" Text="Repeat interval (minutes)"/></td>
                        <td><asp:TextBox ID="txtRepeatInterval" runat="server" CssClass="std" /></td>
                    </tr>
                    <tr>
                        <td class="leftColHigh"><dw:TranslateLabel runat="server" Text="Type"/></td>
                        <td><asp:DropDownList ID="ddlTypes" runat="server" CssClass="std" onchange="showParameters();" /></td>
                    </tr>
                </table>
            </dw:GroupBox>
            
            <dw:GroupBox ID="grpTypeParameters" runat="server" Title="Type parameters">
                <div id="IndexBuilderParameters">
                    <table>
                        <tr>
                            <td class="leftColHigh"><dw:TranslateLabel runat="server" Text="Index" /></td>
                            <td>
                                <asp:DropDownList ID="ddlIndexes" runat="server" CssClass="std" onchange="getBuilds();" />
                            </td>
                        </tr>
                        <tr>
                            <td class="leftColHigh"><dw:TranslateLabel runat="server" Text="Build" /></td>
                            <td id="buildsContainer">
                                <select id="ddlBuilds" name="ddlBuilds" class="std">
                                </select>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="CustomProviderParameters">
                    <dw:TranslateLabel runat="server" Text="A custom provider type is selected. The user interface does not currently support these."/><br/>
                    <dw:TranslateLabel runat="server" Text="Please edit the task directly in the file."/>
                </div>
            </dw:GroupBox>

            <input type="hidden" name="repository" value="<%=RepositoryId%>"/>
            <input type="hidden" name="item" value="<%=ItemId%>"/>
            <input type="hidden" name="save" id="save" value=""/>
            <input type="hidden" name="close"id="close" value=""/>
        </form>
        <dw:Overlay ID="ItemTypeEditOverlay" runat="server"></dw:Overlay>

        <%Translate.GetEditOnlineScript()%>
    </body>
    
    <script type="text/javascript">
        function showParameters() {
            var typesSelector = $("<%=TypesSelector%>");
            var selectedValue = typesSelector[typesSelector.selectedIndex].value;

            if (selectedValue === "<%=IndexBuilderType%>") {
                $("IndexBuilderParameters").show();
                $("CustomProviderParameters").hide();
            } else {
                $("IndexBuilderParameters").hide();
                $("CustomProviderParameters").show();
            }
        }

        function getBuilds() {
            var indexSelector = $("<%=IndexSelector%>");
            var selectedValue = indexSelector[indexSelector.selectedIndex].value;
            var url = "ViewTask.aspx?cmd=GetBuilds&repository=<%=RepositoryId%>&index=" + selectedValue;

            new Ajax.Request(url, {
                method: 'get',
                onSuccess: function (response) {
                    $("buildsContainer").innerHTML = response.responseText;
                }
            });
        }

        function cancel() {
            location.href = "ViewRepository.aspx?id=<%=RepositoryId%>";
        }

        function save() {
            $("save").value = "true";
            document.forms["MainForm"].submit();
        }

        function saveAndClose() {
            $("close").value = "true";
            save();
        }

        getBuilds();
        showParameters();
    </script>
</html>
