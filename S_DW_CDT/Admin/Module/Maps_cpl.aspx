<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Maps_cpl.aspx.vb" Inherits="Dynamicweb.Admin.Maps.Maps_cpl" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>
		<%=Translate.JsTranslate("Store Locator", 9)%></title>
	<dw:ControlResources ID="ctrlResources" IncludePrototype="true" runat="server" />
	<style type="text/css">
		tr.status-None td, tr.status-SaveError td
		{
			background: #faa;
		}
		tr.status-Updated td
		{
			background: #afa;
		}
		*[id="GroupIDs"]
		{
			display: block;
		}
	</style>
	<script type="text/javascript">		(function () {
			var disableViewState = function () {
				$('__EVENTTARGET').value = '';
				$('__EVENTARGUMENT').value = '';
				$('__VIEWSTATE').value = '';
				$('__EVENTVALIDATION').value = '';
			},

		save = function () {
			disableViewState();
			$('hiddenSource').value = 'ManagementCenterSave';
			$('frmGlobalSettings').action = 'ControlPanel_Save.aspx';
			$('frmGlobalSettings').submit();
		},

		saveAndClose = function () {
			disableViewState();
			$('frmGlobalSettings').action = 'ControlPanel_Save.aspx';
			$('frmGlobalSettings').submit();
		},

		cancel = function () {
			location.href = 'ControlPanel.aspx';
		},

		selectedGroupsChanged = function () {
			Form.Element.disable('UpdateGeoLocations');
			$$('#GroupIDs option').each(function (option) {
				if (option.selected) {
					Form.Element.enable('UpdateGeoLocations');
				}
			});
		},

		selectAllGroups = function () {
			$$('#GroupIDs option').each(function (option) {
				option.selected = true;
			});
			selectedGroupsChanged();
		},

		toggleSelectedGroups = function () {
			$$('#GroupIDs option').each(function (option) {
				option.selected = !option.selected;
			});
			selectedGroupsChanged();
		};

			Event.observe(window, 'load', function () {
				$('cmdSave').observe('click', save);
				$('cmdOk').observe('click', saveAndClose);
				$('cmdCancel').observe('click', cancel);

				$('btnSelectAllGroups').observe('click', selectAllGroups);
				$('btnToggleSelectedGroups').observe('click', toggleSelectedGroups);
				$('GroupIDs').observe('change', selectedGroupsChanged);
				selectedGroupsChanged();
			});
		} ());</script>
</head>
<body>
	<form runat="server" method="post" name="frmGlobalSettings" id="frmGlobalSettings">
	<dw:Toolbar ID="ToolbarButtons" ShowStart="false" ShowEnd="false" runat="server">
		<dw:ToolbarButton ID="cmdSave" runat="server" Image="Save" Text="Save" />
		<dw:ToolbarButton ID="cmdOk" runat="server" Divide="Before" Image="SaveAndClose" Text="Gem og luk" />
		<dw:ToolbarButton ID="cmdCancel" runat="server" Divide="Before" Image="Cancel" Text="Cancel" />
	</dw:Toolbar>
	<div style="display: none">
		<input id="hiddenSource" type="hidden" name="_source" value="ManagementCenter" />
	</div>
	<dw:GroupBox ID="Settings" runat="server" Title="Settings" DoTranslation="true">
		<table>
			<tr>
				<td>
					<label for="GoogleMapsAPIKey">
						<dw:TranslateLabel runat="server" Text="Google Maps API key" />
					</label>
				</td>
				<td>
					<input size="42" id="GoogleMapsAPIKey" name="/Globalsettings/Settings/GoogleMaps/GoogleMapsAPIKey" value="<%= Server.HtmlEncode(Base.GetGs("/Globalsettings/Settings/GoogleMaps/GoogleMapsAPIKey")) %>" />
				</td>
			</tr>
			<tr>
				<td>
					<label for="GoogleMapsClientID">
						<dw:TranslateLabel runat="server" Text="Google Maps Client ID" />
					</label>
				</td>
				<td>
					<input size="42" id="GoogleMapsClientID" name="/Globalsettings/Settings/GoogleMaps/GoogleMapsClientID" value="<%= Server.HtmlEncode(Base.GetGs("/Globalsettings/Settings/GoogleMaps/GoogleMapsClientID")) %>" />
				</td>
			</tr>
		</table>
	</dw:GroupBox>
	<dw:GroupBox ID="BatchUpdate" runat="server" Title="Batch update" DoTranslation="true">
		<label for="GroupsSelector">
			<dw:TranslateLabel runat="server" Text="Groups" />
		</label>
		<select id="GroupIDs" runat="server" multiple="True">
		</select>
		<div class="buttons">
			<button type="button" id="btnSelectAllGroups">
				<dw:TranslateLabel runat="server" Text="Select all" />
			</button>
			<button type="button" id="btnToggleSelectedGroups">
				<dw:TranslateLabel runat="server" Text="Toggle selection" />
			</button>
			<button type="submit" id="UpdateGeoLocations" runat="server">
				<dw:TranslateLabel runat="server" Text="Update" />
			</button>
		</div>
		<dw:List ID="LocationsList" runat="server" Title="Locations" ShowPaging="false" Visible="false">
		</dw:List>
	</dw:GroupBox>
	</form>
	<%
		Translate.GetEditOnlineScript()
	%></body>
</html>
