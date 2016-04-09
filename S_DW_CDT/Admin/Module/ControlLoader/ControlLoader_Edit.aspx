<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ControlLoader_Edit.aspx.vb" Inherits="Dynamicweb.Admin.ControlLoader_Edit" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<dw:ModuleHeader ID="ModuleHeader1" runat="server" ModuleSystemName="ControlLoader" />
<dw:ModuleSettings id="ModuleSettings1" runat="server" ModuleSystemName="ControlLoader"
	Value="Control">
</dw:ModuleSettings>
<table border="0" cellpadding="0" cellspacing="0" width="598">
	<tr>
		<td>
			<dw:GroupBox ID="GroupBox1" runat="server" Title="Sorting">
				<table border="0" cellpadding="2" cellspacing="0">
					<tr>
						<td style="width: 170px;" valign="top">Control path</td>
						<td><input type="text" name="Control" value="" id="Control" runat="server" class="std" /></td>
					</tr>
				</table>
			</dw:GroupBox>
		</td>
	</tr>
</table>