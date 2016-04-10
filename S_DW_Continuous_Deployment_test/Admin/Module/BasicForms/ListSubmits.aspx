<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ListSubmits.aspx.vb" Inherits="Dynamicweb.Admin.ListSubmits" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
	<dw:ControlResources ID="ctrlResources" IncludePrototype="false" runat="server" />
	<script type="text/javascript">
		function help() {
		    <%=Dynamicweb.Gui.Help("", "modules.basicforms.listsubmits")%>
		}

		function back() {
			overlayShow();
			location = "ListForms.aspx";
		}

		function editsubmit(submitid) {
			if (!submitid) {
				var submitid = ContextMenu.callingID;
			}
			overlayShow();
			location = "EditSubmit.aspx?ID=" + submitid;
		}

		function exportData(format, withHeaders) {
			overlayShow();
			location = "ListSubmits.aspx?action=" + format + "&headers=" + withHeaders + "&formid=" + document.getElementById("formid").value;
			setTimeout(overlayHide, 1000);
		}

		function deletesubmit() {
			var submitid = ContextMenu.callingID;
			var submitName = document.getElementById("submitname" + submitid).innerHTML;
			if (confirm("<%=Translate.JsTranslate("Slet %%?", "%%", Translate.JsTranslate("submit"))%> (" + submitName + ")")) {
				overlayShow();
				location = "ListSubmits.aspx?action=delete&ID=" + submitid;
			}
		}

		function overlayHide() {
			hideOverlay('wait');
		}
		function overlayShow() {
			showOverlay('wait');
		}
	</script>
</head>
<body>
	<form id="form1" runat="server">
		<input type="hidden" name="formid" id="formid" runat="server" />
		<dw:Toolbar ID="ToolbarButtons" runat="server" ShowEnd="false">
			<dw:ToolbarButton ID="cmdAdd" runat="server" Divide="None" Image="DeleteDocument" Text="Luk" OnClientClick="back();" />
			<dw:ToolbarButton ID="ToolbarButton1" runat="server" Divide="None" ImagePath="/Admin/Images/ExcelIcon.gif" Text="Export to excel" OnClientClick="exportData('export', true);" />
			<dw:ToolbarButton ID="ToolbarButton2" runat="server" Divide="None" ImagePath="/Admin/Images/ext/csv.gif" Text="Export to csv" OnClientClick="exportData('exportcsv', true);" />
			<dw:ToolbarButton ID="cmdHelp" runat="server" Divide="None" Image="Help" Text="Help" OnClientClick="help();" />
		</dw:Toolbar>
		<h2 class="subtitle">
			<dw:TranslateLabel ID="lbSetup" Text="Formularer" runat="server" />
			&#187; <span id="breadcrumbText" runat="server"></span>
			&#187; <dw:TranslateLabel ID="TranslateLabel1" Text="Submits" runat="server" />
			<span runat="server" id="submitcount"></span>
		</h2>
		<dw:List ID="list" ShowPaging="false" PageSize="1000" NoItemsMessage="" ShowTitle="false" ShowCollapseButton="false" StretchContent="false" runat="server">
			<Columns>
				<dw:ListColumn ID="colDate" Name="Dato" Width="60" runat="server" EnableSorting="true" />
				<dw:ListColumn ID="colPageId" Name="PageId" Width="60" runat="server" EnableSorting="true" />
				<dw:ListColumn ID="colValues" Name="Data" runat="server" EnableSorting="true" />
				<dw:ListColumn ID="colFields" Name="Fields" Width="60" runat="server" ItemAlign="Center" HeaderAlign="Center" EnableSorting="true" />
                <dw:ListColumn ID="colIp" Name="IP" Width="120" runat="server" EnableSorting="true" />
				<dw:ListColumn ID="colSession" Name="Session" Width="120" runat="server" EnableSorting="true" />                
			</Columns>
		</dw:List>
	</form>

	<dw:ContextMenu ID="submitContext" runat="server">
		<%--<dw:ContextMenuButton ID="ContextMenuButton3" runat="server" Text="Rediger" ImagePath="/Admin/Images/Ribbon/Icons/Small/Edit.png" OnClientClick="editform();" Divide="After">
		</dw:ContextMenuButton>
		<dw:ContextMenuButton ID="ContextMenuButton4" runat="server" Text="Kopier" ImagePath="/Admin/Images/Ribbon/Icons/Small/Copy.png" OnClientClick="copyform();">
		</dw:ContextMenuButton>
		<dw:ContextMenuButton ID="ContextMenuButton1" runat="server" Text="Omdøb" ImagePath="/Admin/Images/Ribbon/Icons/Small/RenameDocument.png" OnClientClick="renameform();">
		</dw:ContextMenuButton>--%>
		<dw:ContextMenuButton ID="deleteFieldBtn" runat="server" Text="Slet" Image="Delete" OnClientClick="deletesubmit();" Divide="None">
		</dw:ContextMenuButton>
	</dw:ContextMenu>
	<dw:Overlay ID="wait" runat="server"></dw:Overlay>
	<%  
		Dynamicweb.Backend.Translate.GetEditOnlineScript()
	%>
</body>
</html>
