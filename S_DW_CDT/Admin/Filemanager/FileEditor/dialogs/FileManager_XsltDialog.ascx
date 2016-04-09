<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="FileManager_XsltDialog.ascx.vb" Inherits="Dynamicweb.Admin.FileManager_XsltDialog" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<table cellspacing="0" cellpadding="0" style="width: 100%">
	<tr>
		<td colspan="2" class="dContentInner">
			<table width="100%">
				<tr>
					<td>
					    <div style="padding-bottom: 5px;">
					        <dw:TranslateLabel ID="lbErrorDescription" Text="Error description" runat="server" />:
					    </div>
						<div id="dErrorDescription" style="height: 150px; overflow: auto; border: 1px solid #c3c3c3; background-color: #ffffff; padding: 5px"></div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<input type="hidden" id="XsltFilename" value="" />
<input type="hidden" id="XsltDirectory" value="" />