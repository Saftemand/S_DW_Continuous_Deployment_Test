<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="ForumV2" TagName="MultiSelect" src="MultiSelect.ascx" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Page Language="vb" ValidateRequest="false" AutoEventWireup="false" Codebehind="Category_Edit.aspx.vb" Inherits="Dynamicweb.Admin.ForumV2.Category_Edit" %>
<HTML>
	<HEAD>
		<script src="Navigation.js" language="javascript"></script>
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
			<LINK href="ForumV2Css.css" type="text/css" rel="STYLESHEET">
	</HEAD>
	<body style="MARGIN-LEFT: 20px;">
		<form id="Form1" method="post" runat="server">
			<asp:Panel ID="FormPanel" Runat="server">
				<dw:tabheader id="Tabs" title="<br>" runat="server"></dw:tabheader>
				<DIV id="Tab1">
					<TABLE class="tabTable" cellSpacing="0" cellPadding="0" style="WIDTH:550px" border="0">
						<TR>
							<TD vAlign="top">
								<asp:customvalidator id="formValidator" Runat="server" OnServerValidate="CheckFields"></asp:customvalidator></TD>
							</TD></TR>
						<TR>
						<TR>
							<TD height="3">&nbsp;</TD>
						</TR>
						<TR>
							<TD vAlign="top">
								<dw:groupboxstart id="SettingsStart" title="Settings" runat="server"></dw:groupboxstart>
								<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
									<TR>
										<TD>&nbsp;</TD>
									</TR>
									<TR>
										<TD width="150">&nbsp;<%=Translate.Translate("Navn")%></TD>
										<TD>
											<asp:TextBox id="txName" Runat="server" CssClass="std" MaxLength = "100"></asp:TextBox></TD>
									</TR>
									<TR>
										<TD>&nbsp;<%=Translate.Translate("Beskrivelse")%></TD>
										<TD>
											<asp:TextBox id="txDescription" Runat="server" CssClass="std" MaxLength = "200"></asp:TextBox></TD>
									</TR>
									<TR>
										<TD valign="top"><br />&nbsp;<%=Translate.Translate("Frontend html edit mode")%></TD>
										<TD valign="top">
									        <br />
									        <asp:RadioButton ID="radText" runat="server" GroupName="HtmlMode" Text="Text"/><br />
									        <asp:RadioButton ID="radHtml" runat="server" GroupName="HtmlMode" Text="Html"/><br />
									        <asp:RadioButton ID="radHtmlExtended" runat="server" GroupName="HtmlMode" Text="Html Extended" />
									    </TD>
									</TR>
									<TR>
										<TD>&nbsp;</TD>
									</TR>
								</TABLE>
							</TD>
						</TR>
						<TR>
							<TD vAlign="bottom" align="right">
								<TABLE cellSpacing="0" cellPadding="0" border="0">
									<TR>
										<TD>
											<input type="submit" name="btnSubmit" class="ButtonSubmit" style="width: 50px;" value="<%=Translate.Translate("OK")%>"></TD>
										<td>
											&nbsp;<input type="button" id="btnCancel" class="buttonSubmit" value="<%=translate.translate("Annuller")%>" onclick="location.href='Thread_List.aspx?Refresh=<%=Base.ChkNumber(Request("CategoryID"))%>'" />
										</td>
										<TD width="10">&nbsp;</TD>
									</TR>
									<TR>
										<TD colSpan="4" height="5"></TD>
									</TR>
								</TABLE>
							</TD>
						</TR>
					</TABLE>
				</DIV>
				<DIV id="Tab2" style="DISPLAY: none">
					<TABLE class="tabTable" cellSpacing="0" cellPadding="0" style="WIDTH:550px" border="0">
						<TR>
							<TD height="3">&nbsp;</TD>
						</TR>
						<TR>
							<TD vAlign="top">
								<dw:groupboxstart id="ModeratorsStart" runat="server"></dw:groupboxstart>
								<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
									<TR>
										<TD>&nbsp;</TD>
									</TR>
									<TR>
										<TD align="center">
											<ForumV2:multiselect id="Moderators" runat="server"></ForumV2:multiselect></TD>
									</TR>
									<TR>
										<TD>&nbsp;</TD>
									</TR>
								</TABLE>
							</TD>
						</TR>
						<TR>
							<TD>&nbsp;</TD>
						</TR>
						<TR>
							<TD vAlign="bottom" align="right">
								<TABLE cellSpacing="0" cellPadding="0" border="0">
									<TR>
										<TD>
											<input type="submit" name="btnSubmit" class="ButtonSubmit" style="width: 50px;" value="OK">
										<td>
											&nbsp;<input type="button" id="btnCancel" class="buttonSubmit" value="<%=translate.translate("Annuller")%>" onclick="location.href='Thread_List.aspx?Refresh=<%=Base.ChkNumber(Request("CategoryID"))%>'" />
										</td>
										<TD width="10">&nbsp;</TD>
									</TR>
									<TR>
										<TD colSpan="4" height="5"></TD>
									</TR>
								</TABLE>
							</TD>
						</TR>
					</TABLE>
				</DIV>
			</asp:Panel>
			<asp:panel id="NoAccess" Runat="server">
				<TABLE height="80%" width="100%">
					<TR>
						<TD>
							<TABLE style="BORDER-RIGHT: gray 1px solid; BORDER-TOP: gray 1px solid; MARGIN-TOP: 2px; BORDER-LEFT: gray 1px solid; BORDER-BOTTOM: gray 1px solid; BACKGROUND-COLOR: #ffffff"
								height="40" cellPadding="1" width="598" align="center" border="0" valign="middle">
								<TR>
									<TD vAlign="middle" align="center"><BR>
										<STRONG><FONT color="#808080">You have no permissions to process this operation.</FONT></STRONG>
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
		</form>
	</body>
</HTML>
<%
	Translate.GetEditOnlineScript()
%>