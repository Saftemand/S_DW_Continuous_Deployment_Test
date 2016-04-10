<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Translation_CultureList.ascx.vb" Inherits="Dynamicweb.Admin.Translation_CultureList" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<table class="dContent" style="width: 300px; table-layout: fixed" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="100%" class="dTitle">
			<strong>
				<dw:TranslateLabel id="lbTemplateTags" runat="server" Text="Culture list" />
			</strong>
		</td>
		<td class="dTitle" width="24" align="center">
		    <img alt="" src="/Admin/Images/Close_off.gif" border="0" 
		        onmouseover="this.src='/Admin/Images/Close_on.gif';"
		        onmouseout="this.src='/Admin/Images/Close_off.gif';"
		        onmousedown="this.src='/Admin/Images/Close_press.gif';"
		        onclick="CultureListDialog.close(); return false;" />
		</td>
	</tr>
	<tr>
	    <td colspan="2" class="dSubTitle">
	        <dw:TranslateLabel id="lbSelectCulture" Text="Select culture" runat="server" />
	    </td>
	</tr>
	<tr>
	    <td colspan="2" class="dContentInner">
			<div id="divCultures" style="width: 298px; height: 250px; overflow: auto">
				<table border="0" width="100%" cellspacing="0" cellpadding="0">
	                <asp:Repeater ID="repCultures" runat="server">
	                    <ItemTemplate>
	                        <tr>
	                            <td width="100%">
	                                <div id="rowCulture" runat="server">
	                                    <nobr>
	                                        <input type="checkbox" onclick="javascript:CultureListDialog.toggleRow(this);" id="chkCulture" value='<%#Eval("Name")%>' runat="server" />&nbsp;
	                                        <label id="lbCulture" runat="server"><%#Eval("EnglishName") %>&nbsp;-&nbsp;<%#Eval("NativeName") %></label><br />
	                                    </nobr>
	                                </div>
	                            </td>
	                        </tr>
	                    </ItemTemplate>
	                </asp:Repeater>
				</table>
			</div>
		</td>
	</tr>
	<tr>
	    <td colspan="2" align="right" style="padding: 4px">
	        <asp:Button Width="50" ID="cmdSubmit" Text="OK" CssClass="buttonSubmit" runat="server" />
	    </td>
	</tr>
</table>