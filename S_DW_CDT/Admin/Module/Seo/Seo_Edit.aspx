<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" CodeBehind="Seo_Edit.aspx.vb" Inherits="Dynamicweb.Admin.Seo_Edit"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<input type="hidden" name="Seo_settings" value="Template">
<table width="100%" id="Table1" border="0">
	<tr>
		<td>
			<dw:moduleheader id="ModuleHeader1" runat="server" modulesystemname="Seo"></dw:moduleheader>
		</td>
	</tr>
	<tr>
		<td>
			<dw:groupbox id="gb_General" runat="server" title="Generelt">
				<table id="Table3" cellspacing="0" cellpadding="2" border="0">
					<tr>
						<td width="170"><dw:translatelabel id="Translatelabel9" runat="server" text="Template"></dw:translatelabel></td>
						<td><dw:filemanager id="Template" runat="server" cssclass="std" fullpath="False" folder="Templates/Seo"></dw:filemanager></td>
					</tr>
				</table>
			</dw:groupbox>
		</td>
	</tr>
</table>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>