<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HelloWorld_Edit.aspx.cs" Inherits="CustomModules.HelloWorld.HelloWorld_Edit" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<dw:ModuleHeader ID="ModuleHeader1" runat="server" ModuleSystemName="HelloWorld" />
<dw:ModuleSettings id="ModuleSettings1" runat="server" ModuleSystemName="HelloWorld" Value="HelloText" />
	
<dw:GroupBox ID="GroupBox1" runat="server" Title="Text">
<table style="width: 100%;">
	<tr>
		<td style="width:170px;">Text</td>
		<td><input id="HelloText" class="std" type="text" runat="server"/></td>
	</tr>
</table>
</dw:GroupBox>
