<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="ForumV2" TagName="Files" src="Files.ascx" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Page ValidateRequest="false" Language="vb" AutoEventWireup="false" Codebehind="Post_Edit.aspx.vb" Inherits="Dynamicweb.Admin.ForumV2.Post_Edit" %>
<HTML>
	<HEAD>
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<LINK href="ForumV2Css.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="Navigation.js"></script>
			<script language="javascript">
		<!--
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
				<dw:tabheader id="Tabs" title="<br>" runat="server"></dw:tabheader>
				<DIV id="Tab1">
					<TABLE class="tabTable" cellSpacing="0" cellPadding="0"  style="WIDTH:550px" border="0">
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
											<dw:translatelabel id="CategoryLabel" runat="server" Text="Tråd"></dw:translatelabel></TD>
										<TD><STRONG>
												<asp:Literal id="lThread" Runat="server"></asp:Literal></STRONG></TD>
									</TR>
									<TR>
										<TD height="20">&nbsp;
											<dw:translatelabel id="AuthorLabel" runat="server" Text="Opretter"></dw:translatelabel></TD>
										<TD><STRONG>
												<asp:Literal id="lAuthor" Runat="server"></asp:Literal></STRONG></TD>
									</TR>
									<TR>
										<TD>&nbsp;
											<dw:translatelabel id="HeadlineLabel" runat="server" Text="Overskrift"></dw:translatelabel></TD>
										<TD>
											<asp:TextBox id="txHeadline" MaxLength="150" Runat="server" CssClass="std"></asp:TextBox></TD>
									</TR>
									<TR>
										<TD>&nbsp;
											<dw:translatelabel id="DateLabel" runat="server" Text="Dato"></dw:translatelabel></TD>
										<TD><%=Dates.DateSelect(_date, false, false, false, "_date")%></TD>
									</TR>
									<TR>
										<TD>&nbsp;</TD>
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
					<TABLE class="tabTable" cellSpacing="0" cellPadding="0"  style="WIDTH:550px" border="0">
						<TR>
							<TD vAlign="top">&nbsp;</TD>
						</TR>
						<TR>
							<TD vAlign="top">
								<ForumV2:Files ID="listFiles" TabID="2" runat="server" />
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
							height="40" cellPadding="1"  style="WIDTH:550px" align="center" border="0" valign="middle">
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
	</body>
</HTML>
<%
	Translate.GetEditOnlineScript()
%>