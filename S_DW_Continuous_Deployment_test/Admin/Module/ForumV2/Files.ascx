<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Files.ascx.vb" Inherits="Dynamicweb.Admin.ForumV2.Files" className="Files" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<TABLE cellSpacing="2" cellPadding="2" width="100%" border="0">
	<tr>
		<td>
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
				<tr>
					<td width="100%" align="left">
						<strong>
							<dw:TranslateLabel id="lbNameHeadline" Text="Navn" runat="server" />
						</strong>
					</td>
					<td align="center">
						<strong>
							<dw:TranslateLabel id="lbDeleteHeadline" Text="Slet" runat="server" />
						</strong>
					</td>
				</tr>
				<tr>
					<td colspan="2" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
				</tr>
				<tr id="rowNoFiles" runat="server">
					<td colspan="2">
						<dw:TranslateLabel id="lbNoFiles" Text="Ikke_fundet" runat="server" />
					</td>
				</tr>
				<asp:Repeater ID="repList" runat="server">
					<ItemTemplate>
						<tr>
							<td align="left">
								<%#Eval("FileLink")%>
							</td>
							<td align="center">
								<a runat="server" CausesValidation="False" OnClick="return true;" OnServerClick="OnDeleteFile" CommandArgument='<%#Eval("InnerID") %>' ID="lnkDeleteFile">
									<img src="/Admin/Images/Delete.gif" alt='<%=Translate.translate("Slet")%>' border="0" />
								</a>
							</td>
						</tr>
					</ItemTemplate>
				</asp:Repeater>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td colspan="2">
						<table cellspacing="0" cellpadding="2" border="0" width="100%">
							<tr>
								<td align="right">
									<input type="file" id="flFile" name="flFile" />&nbsp;
									<asp:Button CausesValidation="False" ID="cmdAddFile" Text="Upload" CssClass="buttonSubmit" runat="server" />
								</td>
							</tr>
							<tr id="rowMaxSize" runat="server">
								<td align="right">
									<font color="#c4c4c4"><small><asp:Label id="lbMaximumFileSize" runat="server" /></small></font>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>



