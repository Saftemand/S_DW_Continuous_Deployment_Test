<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="FileManager_SaveAsDialog.ascx.vb" Inherits="Dynamicweb.Admin.FileManager_SaveAsDialog" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<table cellspacing="0" cellpadding="0" border="0">
	<tr>
	    <td colspan="2" class="dContentInner">
	        <table border="0" width="100%" cellspacing="0" cellpadding="2">
	            <tr>
	                <td>
			            <dw:TranslateLabel id="lbDirectoryLabel" runat="server" Text="Bibliotek" />:
		            </td>
		            <td id="viewPathColumn" runat="server">
			            <span id="lbDirectory" class="saveas-static-directory" runat="server"></span>
		            </td>
		            <td id="editPathColumn" runat="server">
		                <dw:FolderManager ID="txDirectory" Name="txDirectory" Folder="" runat="server" />
		            </td>
	            </tr>
	            <tr>
		            <td>
			            <dw:TranslateLabel id="lbFileLabel" runat="server" Text="File" />:
		            </td>
		            <td>
			            <asp:TextBox id="txFileName" onkeypress="return SaveAsDialog.onTextChange(event.keyCode);" onkeyup="SaveAsDialog.updateOkState();" CssClass="std saveas-filename" runat="server" />
		            </td>
	            </tr>
	            <tr>
		            <td colspan="2">
			            <span id="pSaveAsLoading" style="display:none">
				            <img src="/Admin/Module/Seo/Dynamicweb_wait.gif" width="16" height="16" alt="" border="0" />
			            </span>
		            </td>
	            </tr>
	        </table>
	    </td>
	</tr>
</table>
