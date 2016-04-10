<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="GroupFiltersEdit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.SearchFilters.GroupFiltersEdit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <meta http-equiv="X-UA-Compatible" content="IE=8" />

        <title></title>

        <dw:ControlResources ID="ctrlResources" CombineOutput="false" IncludeUIStylesheet="true" runat="server">
            <Items>
                <dw:GenericResource Url="/Admin/Module/eCom_Catalog/dw7/css/GroupFiltersEdit.css" />
                <dw:GenericResource Url="/Admin/Module/eCom_Catalog/dw7/js/GroupFiltersEdit.js" />
            </Items>
        </dw:ControlResources>
    </head>
    <body>
        <form id="MainForm" runat="server">
            <table border="0" cellspacing="0" cellpadding="2">
                <tr>
                    <td>
                        <div class="description-container">
                            <dw:GroupBox ID="gbDescription" Title="Description" runat="server">
                                <p>
                                    <dw:TranslateLabel ID="lbDescriptionGeneral" Text="You can make your search filters dependant on the product group that is currently active." runat="server" />
                                    <dw:TranslateLabel ID="lbDescriptionModes" Text="There are several visibility modes that can be configured for each filter:" runat="server" />
                                </p>
                                <ul>
                                    <li>
                                        <strong>
                                            <dw:TranslateLabel ID="lbModeDefault" Text="Default" runat="server" />
                                        </strong>
                                        <small>
                                            <dw:TranslateLabel ID="lbModeDefaultDescription" Text="The filter will behave as usual." runat="server" />
                                        </small>
                                    </li> 
                                    <li>
                                        <strong>
                                            <dw:TranslateLabel ID="lbModeEnforce" Text="Enforce" runat="server" />
                                        </strong>
                                        <small>
                                            <dw:TranslateLabel ID="lbModeEnforceDescription" Text="The filter will be shown even if it is not enabled through the paragraph settings." runat="server" />
                                        </small>
                                    </li>
                                    <li>
                                        <strong>
                                            <dw:TranslateLabel ID="lbModeProhibit" Text="Prohibit" runat="server" />
                                        </strong>
                                        <small>
                                            <dw:TranslateLabel ID="lbModeProhibitDescription" Text="The filter will be hidden even if it is enabled through the paragraph settings." runat="server" />
                                        </small>
                                    </li>
                                </ul>
                            </dw:GroupBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="list-container">
                            <dw:List ID="lstFilters" PageSize="10" NoItemsMessage="No filters found" ShowTitle="false" runat="server">
                                <Columns>
                                    <dw:ListColumn ID="colFilter" Name="Filter" Width="250" EnableSorting="true" />
                                    <dw:ListColumn ID="colFilterType" Name="Filter type" Width="150" EnableSorting="true" />
                                    <dw:ListColumn ID="colFilterGroup" Name="Filter group" Width="150" EnableSorting="true" />
                                    <dw:ListColumn ID="colVisibility" Name="Visibility mode" Width="100" />
                                </Columns>
                            </dw:List>
                        </div>
                    </td>
                </tr>
            </table>

            <input type="hidden" id="stateVisibility" name="stateVisibility" value="<%=Dynamicweb.Base.ChkString(MyBase.Request("stateVisibility"))%>" />
            <input type="hidden" id="stateVisibilityRemove" name="stateVisibilityRemove" value="" />
            <input type="submit" id="cmdSubmit" name="cmdSubmit" value="Submit" style="display: none" />
        </form>
    </body>

    <script type="text/javascript">
        GroupFiltersEdit.get_current().initialize();
    </script>

    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
