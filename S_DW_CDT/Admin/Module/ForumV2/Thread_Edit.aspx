<%@ Page ValidateRequest="false" Language="vb" AutoEventWireup="false" Codebehind="Thread_Edit.aspx.vb" Inherits="Dynamicweb.Admin.ForumV2.Thread_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="ForumV2" TagName="Files" src="Files.ascx" %>
<HTML>
	<HEAD>
		<script src="Navigation.js" language="javascript"></script>
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<LINK href="ForumV2Css.css" type="text/css" rel="STYLESHEET">
			<script language="javascript">
		<!--
			
			function ConfirmVariantDelete(variant)
			{
				return confirm("<%=Translate.Translate("Slet variant")%> \"" + variant.ClientCommandArgument + "\"?");
			}
			
			function Validate()
			{
				if(typeof(Page_ClientValidate) == 'function')
					Page_ClientValidate();
			}
			
			function Send()
			{
				if(typeof(dw_HTMLMode) != "undefined" && dw_HTMLMode == false)
					document.forms.Form1._Editor.value = DWEditor.DOM.body.innerHTML;
			}
			
			function RefreshView()
			{
				<asp:Literal id="AccessProc" runat="server"></asp:Literal>
			}
		//-->
			</script>
	</HEAD>
	<body onload="RefreshView();" style="MARGIN-LEFT: 20px;">
		<asp:Panel ID="FormPanel" Runat="server">
			<FORM id="Form1" method="post" runat="server" enctype="multipart/form-data">
				<dw:tabheader id="Tabs" title="<br>" runat="server" Headers="Edit,Voting,Attachments"></dw:tabheader>
				<DIV id="Tab1">
					<TABLE class="tabTable" cellSpacing="0" cellPadding="0" border="0" style="WIDTH:550px">
						<TR>
							<TD vAlign="top">
								<asp:customvalidator id="formValidator" Runat="server" OnServerValidate="CheckFields"></asp:customvalidator></TD>
							</TD></TR>
						<TR>
							<TD>&nbsp;</TD>
						</TR>
						<TR>
							<TD vAlign="top">
								<dw:groupboxstart id="SettingsStart" title="Settings" runat="server"></dw:groupboxstart>
								<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
									<TR>
										<TD>&nbsp;</TD>
									</TR>
									<TR>
										<TD width="150" height="20">&nbsp;
											<dw:translatelabel id="CategoryLabel" runat="server"></dw:translatelabel></TD>
										<TD><STRONG>
												<asp:Literal id="lCategory" Runat="server"></asp:Literal></STRONG></TD>
									</TR>
									<TR>
										<TD height="20">&nbsp;
											<dw:translatelabel id="AuthorLabel" runat="server"></dw:translatelabel></TD>
										<TD><STRONG>
												<asp:Literal id="lAuthor" Runat="server"></asp:Literal></STRONG></TD>
									</TR>
									<TR>
										<TD>&nbsp;
											<dw:translatelabel id="HeadlineLabel" Text="" runat="server"></dw:translatelabel></TD>
										<TD>
											<asp:TextBox id="txHeadline" MaxLength="100" Runat="server" CssClass="std"></asp:TextBox></TD>
									</TR>
									<TR>
										<TD>&nbsp;
											<dw:translatelabel id="DescriptionLabel" runat="server"></dw:translatelabel></TD>
										<TD>
											<asp:TextBox id="txDescription" MaxLength="150" Runat="server" CssClass="std"></asp:TextBox></TD>
									</TR>
									<TR>
										<TD>&nbsp;
											<dw:translatelabel id="DateLabel" runat="server"></dw:translatelabel></TD>
										<TD><%=Dates.DateSelect(_date, false, false, false, "_date")%></TD>
									</TR>
									<TR>
										<TD>&nbsp;
											<dw:translatelabel id="StickyLabel" runat="server"></dw:translatelabel></TD>
										<TD>
											<asp:CheckBox id="chkSticky" Runat="server"></asp:CheckBox></TD>
									</TR>
									<TR>
										<TD>&nbsp;
											<dw:translatelabel id="ClosedLabel" runat="server"></dw:translatelabel></TD>
										<TD>
											<asp:CheckBox id="chkClosed" Runat="server"></asp:CheckBox></TD>
									</TR>
								</TABLE>
								<dw:groupboxend id="SettingsEnd" runat="server"></dw:groupboxend><BR>
								<BR>
								<dw:groupboxstart id="TextStart" title="Text" runat="server"></dw:groupboxstart>
								<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
									<TR>
										<TD>&nbsp;</TD>
									</TR>
									<TR>
										<TD align="center"><%=Gui.Editor("_Editor", 530, 300, _text)%></TD>
									</TR>
									<TR>
										<TD>&nbsp;</TD>
									</TR>
								</TABLE>
								<dw:groupboxend id="TextEnd" runat="server"></dw:groupboxend></TD>
						</TR>
						<TR>
							<TD vAlign="bottom" align="right">
								<TABLE cellSpacing="0" cellPadding="0" border="0">
									<TBODY>
										<TR>
											<TD><INPUT class="ButtonSubmit" id="btnSubmit" onclick="Send(); Validate(); if (ValidatorOnSubmit()) return true;"
													type="submit" value="<%=Translate.Translate("OK")%>" name="btnSubmit"></TD>
							</TD>
							<TD width="5">&nbsp;</TD>
							<TD><INPUT class="buttonSubmit" id="btnCancel" type="submit" value="<%=Translate.Translate("Annuller")%>" name="btnCancel"></TD>
							<TD width="10">&nbsp;</TD>
						</TR>
						<TR>
							<TD colSpan="3" height="5"></TD>
						</TR>
					</TABLE>
					</TD></TR></TBODY></TABLE><BR>
				</DIV>
				<DIV id="Tab2" style="DISPLAY: none">
					<TABLE class="tabTable" cellSpacing="0" cellPadding="0" style="WIDTH:550px" border="0">
						<TR>
							<TD>&nbsp;</TD>
						</TR>
						<TR>
							<TD vAlign="top">
								<dw:groupboxstart id="VotingStart" runat="server"></dw:groupboxstart>
								<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
									<TR>
										<TD>&nbsp;</TD>
									</TR>
									<TR>
										<TD width="90">&nbsp;
											<asp:Label id="QuestionLabel" runat="server" /></TD>
										<TD>
											<asp:TextBox id="txQuestion" Runat="server" CssClass="std"></asp:TextBox></TD>
									</TR>
									<TR>
										<TD>&nbsp;</TD>
									</TR>
									<TR>
										<TD colSpan="2">
											<asp:Repeater id="repeatVariants" Runat="server">
												<HeaderTemplate>
													<table width="100%" cellspacing="0" cellpadding="0" border="0" style="margin-left: 2px; margin-top: 2px;">
														<tr>
															<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
														</tr>
														<tr bgcolor="#f5f5f5">
															<td width="400"><strong>&nbsp;<%=Translate.Translate("Tekst")%></strong></td>
															<td align="right" width="50"><strong><%=Translate.Translate("Antal")%></strong></td>
															<td align="right" width="50"><strong><%=Translate.Translate("Slet")%></strong></td>
															<td width="6" bgcolor="#ffffff">&nbsp;</td>
														</tr>
														<tr>
															<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
														</tr>
												</HeaderTemplate>
												<ItemTemplate>
													<tr>
														<td>&nbsp;<a href='VoteVariant_Edit.aspx?ThreadID=<%=_threadID%>&VariantID=<%# DataBinder.Eval(Container.DataItem, "ID") %>'><%# DataBinder.Eval(Container.DataItem, "Text") %></a></td>
														<td align="center"><%# DataBinder.Eval(Container.DataItem, "Count") %></td>
														<td align="center"><a runat="server" OnServerClick="DeleteVariant" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID")%>' OnClick='return ConfirmVariantDelete(this);' ClientCommandArgument='<%# HttpContext.Current.Server.HtmlDecode(DataBinder.Eval(Container.DataItem, "Text"))%>'>
																<img src="/Admin/Images/Icons/Page_Delete.gif" alt="Delete variant" border="0"></a>
														</td>
														<td>&nbsp;</td>
													</tr>
												</ItemTemplate>
												<FooterTemplate>
													</table>
												</FooterTemplate>
											</asp:Repeater>
										</TD>
									</TR>
									<TR>
										<TD colSpan="3">
											<asp:Literal id="NoVotes" Runat="server" Text="&nbsp;No variants found"></asp:Literal></TD>
									</TR>
									<TR>
										<TD>&nbsp;</TD>
									</TR>
									<TR>
										<TD align="right" colSpan="3">
											<TABLE cellSpacing="0" border="0">
												<TR>
													<TD><INPUT class="buttonSubmit" id="btnNewVote" onclick="Send(); return true;" type="submit"
															value="<%=Translate.Translate("Tilføj")%>" name="btnNewVote"></TD>
												</TR>
											</TABLE>
										</TD>
									</TR>
								</TABLE>
							</TD>
						</TR>
					</TABLE>
				</DIV>
				<DIV id="Tab3" style="DISPLAY: none">
					<TABLE class="tabTable" cellSpacing="0" cellPadding="0"  style="WIDTH:550px" border="0">
						<TR>
							<TD vAlign="top">&nbsp;</TD>
						</TR>
						<TR>
							<TD vAlign="top">
								<ForumV2:Files ID="listFiles" TabID="3" runat="server" />
							</TD>
						</TR>
					</TABLE>
				</DIV>
			</FORM>
		</asp:Panel>
		<asp:panel id="NoAccess" Runat="server">
			<TABLE height="80%" width="100%">
				<TR>
					<TD>
						<TABLE style="BORDER-RIGHT: gray 1px solid; BORDER-TOP: gray 1px solid; MARGIN-TOP: 2px; BORDER-LEFT: gray 1px solid; BORDER-BOTTOM: gray 1px solid; BACKGROUND-COLOR: #ffffff"
							height="40" cellPadding="1" width="550" align="center" border="0" valign="middle">
							<TR>
								<TD vAlign="middle" align="center"><BR>
									<STRONG><FONT color="#808080"><%=Translate.Translate("Du har ikke rettigheder til at udføre denne handling")%></FONT></STRONG>
								</TD>
							</TR>
							<TR>
								<TD>&nbsp;</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
		</asp:panel>
	</body>
	<%=Gui.SelectTab() %>
</HTML>
<%
	Translate.GetEditOnlineScript()
%>