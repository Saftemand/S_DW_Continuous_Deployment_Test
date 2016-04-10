<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EditSubmit.aspx.vb" Inherits="Dynamicweb.Admin.EditSubmit" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
	<dw:ControlResources ID="ctrlResources" IncludePrototype="false" IncludeScriptaculous="false" runat="server"></dw:ControlResources>
	<script type="text/javascript">
		function help() {
		    <%=Dynamicweb.Gui.Help("", "modules.basicforms.editsubmit")%>
		}

		function savesubmit(close) {
			if (document.getElementById("FormFieldName").value.length < 1) {
				alert('<%=Translate.JSTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>');
				document.getElementById("FormFieldName").focus();
				return;
			}
			overlayShow();
			if (close) {
				document.getElementById("close").value = "True"
			}
			document.getElementById("form1").submit();
		}

		function back() {
			location = "ListSubmits.aspx?formid=" + document.getElementById("formid").value;
		}

		function overlayShow() {
			showOverlay('wait');
		}

		function showlayout() {
			layoutDialog
		}
	</script>
	<style type="text/css">
		.label {
			width: 170px;
			vertical-align: top;
			font-weight: bold;
		}

		.value {
			vertical-align: top;
		}

		.valuesTable tr td {
			padding: 5px;
		}
	</style>
</head>

<body>
	<form id="form1" runat="server" enableviewstate="false">
		<input type="hidden" id="formid" runat="server" />
		<input type="hidden" id="action" runat="server" value="save" />
		<input type="hidden" id="close" runat="server" />
		<div style="overflow: hidden; position: fixed; top: 0px; width: 100%;">
			<dw:RibbonBar runat="server" ID="myribbon">
				<dw:RibbonBarTab Active="true" Name="Felt" runat="server">
					<dw:RibbonBarGroup runat="server" ID="toolsGroup" Name="Felt">
						<dw:RibbonBarButton ID="cmdName" runat="server" Size="Small" Text="Gem" Image="Save" OnClientClick="savefield(false);">
						</dw:RibbonBarButton>
						<dw:RibbonBarButton ID="RibbonBarButton1" runat="server" Size="Small" Text="Gem og luk" Image="SaveAndClose" OnClientClick="savefield(true);">
						</dw:RibbonBarButton>
						<dw:RibbonBarButton runat="server" Text="Annuller" Size="Small" Image="Cancel" ID="cmdCancel" OnClientClick="back();" ShowWait="true" WaitTimeout="500">
						</dw:RibbonBarButton>
					</dw:RibbonBarGroup>
					<dw:RibbonBarGroup ID="helpGroup" runat="server" Name="Help">
						<dw:RibbonBarButton ID="cmdHelp" runat="server" Size="Large" Text="Help" Image="Help" OnClientClick="help();">
						</dw:RibbonBarButton>
					</dw:RibbonBarGroup>
				</dw:RibbonBarTab>
			</dw:RibbonBar>

			<div id="breadcrumb">
				<dw:TranslateLabel Text="Formularer" runat="server" />
				&#187; <span id="breadcrumbTextFormname" runat="server"></span>
				&#187; <span id="breadcrumbTextSubmitdate" runat="server"></span>
			</div>
		</div>
		<div style="overflow: auto; position: fixed; top: 135px; width: 100%; bottom: 0px;">
			<dw:GroupBox ID="GB_settings" runat="server" DoTranslation="True" Title="Submit">
				<table>
					<tr>
						<td width="170" valign="top">
							<dw:TranslateLabel runat="server" Text="Dato" />
						</td>
						<td>
							<span id="date" runat="server"></span>
						</td>
					</tr>
					<tr>
						<td>
							<dw:TranslateLabel runat="server" Text="IP" />
						</td>
						<td>
							<span id="ip" runat="server"></span>
						</td>
					</tr>
				</table>
			</dw:GroupBox>

			<dw:GroupBox ID="optionsGroup" runat="server" DoTranslation="True" Visible="true" Title="Værdier">
				<div id="valuesTable" runat="server">
				</div>
			</dw:GroupBox>
		</div>
	</form>
	<dw:Overlay ID="wait" runat="server"></dw:Overlay>
</body>
</html>
