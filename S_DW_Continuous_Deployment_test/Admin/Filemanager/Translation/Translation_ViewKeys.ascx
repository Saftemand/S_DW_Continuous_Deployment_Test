<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Translation_ViewKeys.ascx.vb" Inherits="Dynamicweb.Admin.Translation_ViewKeys" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<table class="dContent" style="width: 200px; table-layout: fixed" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="100%" class="dTitle">
			<strong>
				<dw:TranslateLabel id="lbViewKeys" runat="server" Text="View keys" />
			</strong>
		</td>
		<td class="dTitle" width="24" align="center">
		    <img alt="" src="/Admin/Images/Close_off.gif" border="0" 
		        onmouseover="this.src='/Admin/Images/Close_on.gif';"
		        onmouseout="this.src='/Admin/Images/Close_off.gif';"
		        onmousedown="this.src='/Admin/Images/Close_press.gif';"
		        onclick="ViewKeysDialog.close(); return false;" />
		</td>
	</tr>
	<tr>
	    <td colspan="2" class="dSubTitle">
	        <dw:TranslateLabel id="lbSelectCulture" Text="Select location" runat="server" />
	    </td>
	</tr>
	<tr>
	    <td colspan="2" class="dContentInner">
	        <table width="100%" cellspacing="0" cellpadding="0">
	            <tr>
	                <td id="rowViewGlobal" width="100%" runat="server">
	                    <nobr>
	                        <input type="checkbox" onclick="javascript:ViewKeysDialog.toggleRow(this); javascript:Page.switchViewKeysByLocation('Global', this.checked);" id="chkViewGlobal" name="chkViewGlobal" runat="server" value="on" />&nbsp;
	                        <label for="ViewKeys_chkViewGlobal"><dw:TranslateLabel ID="lbViewGlobal" Text="Global" runat="server" /></label>
	                    </nobr>
	                </td>
	            </tr>
	            <tr>
	                <td id="rowViewLocal" runat="server">
	                    <nobr>
	                        <input type="checkbox" onclick="javascript:ViewKeysDialog.toggleRow(this); javascript:Page.switchViewKeysByLocation('Local', this.checked);" id="chkViewLocal" name="chkViewGlobal" checked runat="server" value="on" />&nbsp;
	                        <label for="ViewKeys_chkViewLocal"><dw:TranslateLabel ID="lbViewLocal" Text="Local" runat="server" /></label>
	                    </nobr>
	                </td>
	            </tr>
	        </table>
	    </td>
	</tr>
</table>