<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="GroupFiltersExecution.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.SearchFilters.GroupFiltersExecution" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <meta http-equiv="X-UA-Compatible" content="IE=8" />

        <title></title>

        <dw:ControlResources ID="ctrlResources" CombineOutput="false" IncludePrototype="true" IncludeUIStylesheet="true" runat="server">
            <Items>
                <dw:GenericResource Url="/Admin/Module/eCom_Catalog/dw7/css/GroupFiltersOptionsEdit.css" />
            </Items>
        </dw:ControlResources>

        <style type="text/css">
            .paged-queries ul,
            .paged-queries ul li
            {
                list-style: none;
                margin: 0px;
                padding: 0px;
            }
            
            .paged-queries ul li
            {
                height: 18px;
                line-height: 18px;
            }
            
            .paged-queries ul li input,
            .paged-queries ul li label
            {
                float: left;
            }
            
            .paged-queries ul li input
            {
                width: 14px;
                height: 14px;
                margin: 0px;
                margin-top: 1px;
                padding: 0px;
            }
            
            .paged-queries ul li input:active,
            .paged-queries ul li input:focus
            {
                outline: none !important;
            }
            
            .paged-queries ul li label
            {
                margin-left: 5px;
            }
            
            td.warning
            {
                padding-left: 5px;
            }
            
            td.warning h4
            {
                padding-left: 22px;
                
                height: 18px;
                line-height: 18px;
                font-weight: bold;
                font-size: 11px;
                
                margin-bottom: 5px;
                
                background: url('/Admin/Images/Ribbon/Icons/Small/warning.png') 1px 0px no-repeat;
            }
            
            td.warning p
            {
                margin: 0px;
            }
        </style>
    </head>
    <body>
        <form id="MainForm" runat="server">
             <table border="0" cellspacing="0" cellpadding="2">
                <tr>
                    <td>
                        <div class="filter-options-selector-container">
                            <dw:GroupBox ID="gbPerformance" Title="Performance" DoTranslation="true" runat="server">
                                <table border="0">
                                    <tr>
                                        <td>
                                            <table border="0">
                                                <tr>
                                                    <td style="width: 170px" valign="top">
                                                        <dw:TranslateLabel ID="lbPagedQueries" Text="Paged queries" runat="server" />
                                                    </td>
                                                    <td class="paged-queries">
                                                        <ul>
                                                            <li>
                                                                <input type="radio" id="rbPagedQueries0" name="PagedQueries" <%=If(GetPagedQueriesModeIsSelected(0), "checked=""checked""", String.Empty)%> value="0" />
                                                                <label for="rbPagedQueries0"><dw:TranslateLabel ID="lbPagedQueries0" Text="Inherit" runat="server" /></label>
                                                                <div class="options-clear"></div>
                                                            </li>
                                                            <li>
                                                                <input type="radio" id="rbPagedQueries1" name="PagedQueries" <%=If(GetPagedQueriesModeIsSelected(1), "checked=""checked""", String.Empty)%> value="1" />
                                                                <label for="rbPagedQueries1"><dw:TranslateLabel ID="lbPagedQueries1" Text="Enable" runat="server" /></label>
                                                                <div class="options-clear"></div>
                                                            </li>
                                                            <li>
                                                                <input type="radio" id="rbPagedQueries2" name="PagedQueries" <%=If(GetPagedQueriesModeIsSelected(2), "checked=""checked""", String.Empty)%> value="2" />
                                                                <label for="rbPagedQueries2"><dw:TranslateLabel ID="lbPagedQueries2" Text="Disable" runat="server" /></label>
                                                                <div class="options-clear"></div>
                                                            </li>
                                                        </ul>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="warning">
                                            <h4><dw:TranslateLabel ID="lbWarning" Text="Important notice" runat="server" /></h4>
                                            <p>
                                                <dw:TranslateLabel ID="lbWarningText1" Text="Changing these settings may cause some frontend functionality of the module to stop working properly." runat="server" /><br />
                                                <dw:TranslateLabel ID="lbWarningText2" Text="Please check the documentation before changing these values." runat="server" />
                                            </p>
                                        </td>
                                    </tr>
                                </table>
                            </dw:GroupBox>
                        </div>
                    </td>
                </tr>
            </table>

            <input type="submit" id="cmdSubmit" name="cmdSubmit" value="Submit" style="display: none" />
        </form>

        <script type="text/javascript">
            document.observe("dom:loaded", function () {
                if (parent && parent.Dynamicweb) {
                    popUp = parent.Dynamicweb.Controls.PopUpWindow.current(window);
                    if (popUp != null) {
                        popUp.add_ok(function (sender, args) {
                            sender.get_okButton().disabled = true;
                            sender.get_operationIndicator().show();

                            args.set_cancel(true);

                            document.getElementById('cmdSubmit').click();
                        });
                    }
                }
            });
        </script>
    </body>

    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
