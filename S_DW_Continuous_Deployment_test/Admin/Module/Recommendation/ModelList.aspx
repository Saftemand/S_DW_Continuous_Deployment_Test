<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ModelList.aspx.vb" Inherits="Dynamicweb.Admin.Recommendation.ModelList" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Model list</title>
    <style>
        [itemid] {
            cursor: pointer;
        }
    </style>

    <dw:ControlResources runat="server" ID="ControlResources1" />
    <script>
        var modelEditUrl = '<%= ModelEditUrl %>',

        newModel = function () {
            location.href = modelEditUrl;
        },

        editModel = function (modelId) {
            var url = modelEditUrl + (modelEditUrl.indexOf('?') == -1 ? '?' : '&') + 'id=' + encodeURIComponent(modelId);
            location.href = url;
        },

        deleteModel = function (modelId, message) {
            if (confirm(message)) {
                var form = document.getElementById('ModelListForm');
                form.elements['modelId'].value = modelId;
                form.elements['action'].value = 'delete';
                form.submit();
            }
        },

        showHelp = function () {
            <%=Dynamicweb.Gui.Help("", "recommendation.modellist")%>
        }
    </script>
</head>
<body>
    <form runat="server" id="ModelListForm">
        <div style="display: none">
            <input type="hidden" id="modelId" name="modelId" />
            <input type="hidden" id="action" name="action" />
        </div>
        <dw:Toolbar runat="server" ID="Toolbar" ShowEnd="false">
            <dw:ToolbarButton runat="server" ID="cmdNewModel" Divide="None" ImagePath="/Admin/Images/Icons/Add_vsmall.gif" Text="New model" OnClientClick="newModel()" />
            <dw:ToolbarButton runat="server" ID="cmdHelp" Divide="None" Image="Help" Text="Help" OnClientClick="showHelp()" />
        </dw:Toolbar>
        <dw:Infobar runat="server" ID="InfoBarErrorMessages" Visible="False"></dw:Infobar>

        <dw:StretchedContainer runat="server" ID="OuterContainer" Scroll="Hidden" Stretch="Fill" Anchor="document">

            <dw:List runat="server" ID="ModelList" AllowMultiSelect="false" Title="Models" Personalize="true"
                StretchContent="true" UseCountForPaging="true" HandlePagingManually="true">
                <Columns>
                    <dw:ListColumn runat="server" ID="ModelName" Name="Name" TranslateName="true" />
                    <dw:ListColumn runat="server" ID="ModelServiceUrl" Name="Service url" TranslateName="true" />
                    <dw:ListColumn runat="server" ID="ModelServiceModelId" Name="Service model id" TranslateName="true" />
                    <dw:ListColumn runat="server" ID="ModelLastExportTime" Name="Last export time" TranslateName="true" />
                    <dw:ListColumn runat="server" ID="colDelete" Name="Delete" TranslateName="true" />
                </Columns>
            </dw:List>
        </dw:StretchedContainer>
    </form>

    <script>
        var editUrl = modelEditUrl + '?Id={id}',
                    i, row, rows = document.querySelectorAll('[itemid]');
        for (i = 0; row = rows[i]; i++) {
            Event.observe(row, 'click', function () {
                //  editModel(this.getAttribute('itemid'));
            });
        }
    </script>

    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</body>
</html>
