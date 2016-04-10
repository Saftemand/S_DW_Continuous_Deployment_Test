<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="eCom_ShowList_edit.aspx.vb" Inherits="Dynamicweb.Admin.eCom_ShowList_edit" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import namespace="Dynamicweb" %>

<input type="hidden" id="eCom_ShowList_settings" name="eCom_ShowList_settings" value="FavListTemplate" />

<dw:ModuleHeader ID="dwHeaderModule" runat="server" ModuleSystemName="eCom_ShowList" />

<dw:GroupBox Title="Template" runat="server">
	<table cellpadding="2" cellspacing="0" width="100%" border="0">
		<colgroup>
			<col width="170px" />
			<col />
		</colgroup>
		<tr>
			<td><dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Public list template" /></td>
			<td><dw:FileManager ID="fileFavListTemplate" Name="FavListTemplate" runat="server" /></td>
		</tr>
	</table>
</dw:GroupBox>
