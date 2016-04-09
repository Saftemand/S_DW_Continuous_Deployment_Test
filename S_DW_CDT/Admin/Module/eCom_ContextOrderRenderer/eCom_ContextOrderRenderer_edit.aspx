<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="eCom_ContextOrderRenderer_edit.aspx.vb" Inherits="Dynamicweb.Admin.eCom_ContextOrderRenderer" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .test-order-container .checked, .test-order-container .unchecked {
            display:none;
        }
            .test-order-container.checked .checked, .test-order-container.unchecked .unchecked {
                display:block;
            }
    </style>
    <script type="text/javascript">
        document.observe("dom:loaded", function () {
            var cnt = $("test-order-container");
            var modeSelector = $("RenderInTestMode");
            var checkFn = function changeTestMode() {
                if (modeSelector.checked) {
                    cnt.addClassName("checked");
                    cnt.removeClassName("unchecked");
                } else {
                    cnt.addClassName("unchecked");
                    cnt.removeClassName("checked");
                }
            }
            modeSelector.on("change", checkFn);
            checkFn();
        });
    </script>
</head>
<body>
    <input type="hidden" name="eCom_ContextOrderRenderer_settings" value="Template,RenderInTestMode,TestOrderId" />
    <dw:ModuleHeader ID="dwHeaderModule" runat="server" ModuleSystemName="eCom_ContextOrderRenderer" />

    <dw:GroupBox ID="grpboxPaging" Title="Settings" runat="server">
        <table cellpadding="2" cellspacing="0" width="100%" border="0">
            <colgroup>
                <col width="170px" />
                <col />
            </colgroup>
            <tr style="padding-top: 10px;">
                <td valign="top">
                    <dw:TranslateLabel ID="DwTemplate" runat="server" Text="Template" />
                </td>
                <td>
                    <dw:FileManager runat="server" ID="Template" Name="Template" Folder="Templates/eCom/Order/" FullPath="True"></dw:FileManager>
                </td>
            </tr>
        </table>
    </dw:GroupBox>

    <fieldset id="test-order-container" class="test-order-container unchecked">
        <legend>
            <label class="chb-item" for="RenderInTestMode">
                <input type="checkbox" name="RenderInTestMode" id="RenderInTestMode" runat="server" />
                <span class="lbl-text">
                    <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Test mode display" />
                </span>
            </label>
        </legend>
        <div class="unchecked">
            <p>
                <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Select 'Test mode display' checkbox to allow test order select" />
            </p>
        </div>
        <div class="checked">
            <table cellpadding="2" cellspacing="0" width="100%" border="0">
                <colgroup>
                    <col width="170px" />
                    <col />
                </colgroup>
                <tr style="padding-top: 10px;">
                    <td valign="top">
                        <dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Select order or cart" />
                    </td>
                    <td>
                        <%=RenderOrderSelector()%>
                    </td>
                </tr>
            </table>
        </div>
    </fieldset>
</body>
</html>
