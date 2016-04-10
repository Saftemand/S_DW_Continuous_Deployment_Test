<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ShowTag.aspx.vb" Inherits="Dynamicweb.Admin.ShowTag"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Tag reference</title>
		<meta content="True" name="vs_snapToGrid">
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../../Stylesheet.css" type="text/css" rel="STYLESHEET">
	</HEAD>
	<body leftMargin="0" topMargin="0" MARGINWIDTH="0" MARGINHEIGHT="0">
		<TABLE id="tblOuter" height="100%" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<TR bgColor="#3366cc" height="24">
				<TD width="10">
					<IMG height="1" alt="" src="/Admin/images/Nothing.gif" width="10" border="0">
				</TD>
				<TD style="COLOR: white" noWrap align="right">
					&nbsp;
				</TD>
				<TD width="10">
					<IMG height="1" alt="" src="/Admin/images/Nothing.gif" width="10" border="0">
				</TD>
			</TR>
			<TR>
				<TD width="10" rowSpan="2">
					<IMG height="1" alt="" src="/Admin/images/Nothing.gif" width="10" border="0">
				</TD>
				<TD vAlign="top" align="left">
					<TABLE id="tblInner" cellSpacing="0" cellPadding="0" width="100%" border="0">
						<TR>
							<TD colSpan="2" height="10">
								&nbsp;
							</TD>
						</TR>
						<TR>
							<TD style="MARGIN: 1px; BORDER-BOTTOM: #9c9a9c thin solid" bgColor="#9ccfff" colSpan="2">
								<TABLE runat="server" id="tblCategory" cellSpacing="1" cellPadding="1" width="100%" border="0">
									<TR>
										<TD vAlign="top" noWrap align="right" style="HEIGHT: 15px">
											&nbsp;<asp:Label id="lblCategory" runat="server" text="Category:" />
										</TD>
										<TD vAlign="top" align="left" width="100%" style="HEIGHT: 15px">
											<asp:label id="fldCategory" Font-Italic="True" runat="server" />
										</TD>
									</TR>
									<TR>
										<TD vAlign="top" noWrap align="right">
											&nbsp;<asp:Label id="lblTagName" runat="server" text="Tag name:" visible="False" />
										</TD>
										<TD vAlign="top" align="left" width="100%">
											<asp:label id="fldTagName" runat="server" Font-Bold="True" visible="False" />
										</TD>
									</TR>
								</TABLE> <!--tblCategory-->
							</TD>
						</TR>
						<TR>
							<td>
								<TABLE runat="server" id="tblTagDetails" visible="true" cellSpacing="0" cellPadding="0"
									width="100%" border="0">
									<TR>
										<TD width="10" rowspan="100">
											<IMG height="1" alt="" src="/Admin/images/Nothing.gif" width="10" border="0">
										</TD>
										<TD>
											&nbsp;
										</TD>
										<TD width="10" rowspan="100">
											<IMG height="1" alt="" src="/Admin/images/Nothing.gif" width="10" border="0">
										</TD>
									</TR>
									<TR>
										<TD>
											<TABLE runat="server" id="tblSummary" visible="false" cellSpacing="1" cellPadding="1" width="100%"
												border="0">
												<TR>
													<TD colSpan="2" style="HEIGHT: 15px">
														<asp:label id="lblSummary" runat="server" Text="Summary" Font-Bold>
													Summary</asp:label>
													</TD>
												</TR>
												<TR>
													<TD width="50">
														<IMG height="1" alt="" src="/Admin/images/Nothing.gif" width="50" border="0">
													</TD>
													<TD>
														<asp:label id="fldSummary" runat="server" />
													</TD>
												</TR>
											</TABLE> <!--tblSummary-->
											<TABLE runat="server" id="tblSettings" visible="false" cellSpacing="1" cellPadding="1"
												width="100%" border="0">
												<TR>
													<TD colSpan="2">
														<asp:label id="lblSettings" runat="server" Text="Settings" Font-Bold />
													</TD>
												</TR>
												<TR>
													<TD width="50">
														<IMG height="1" alt="" src="/Admin/images/Nothing.gif" width="50" border="0">
													</TD>
													<TD>
														<asp:label id="fldSettings" runat="server" />
													</TD>
												</TR>
											</TABLE> <!--tblSettings-->
											<TABLE runat="server" id="tblExample" visible="false" cellSpacing="1" cellPadding="1" width="100%"
												border="0">
												<TR>
													<TD colSpan="2">
														<asp:label id="lblExample" runat="server" Text="Example" Font-Bold />
													</TD>
												</TR>
												<TR>
													<TD width="50">
														<IMG height="1" alt="" src="/Admin/images/Nothing.gif" width="50" border="0">
													</TD>
													<TD>
														<asp:label id="fldExample" runat="server" />
													</TD>
												</TR>
											</TABLE> <!--tblExample-->
											<TABLE runat="server" id="tblRemarks" visible="false" cellSpacing="1" cellPadding="1" width="100%"
												border="0">
												<TR>
													<TD colSpan="2">
														<asp:label id="lblRemarks" runat="server" Text="Remarks" Font-Bold />
													</TD>
												</TR>
												<TR>
													<TD width="50">
														<IMG height="1" alt="" src="/Admin/images/Nothing.gif" width="50" border="0">
													</TD>
													<TD>
														<asp:label id="fldRemarks" runat="server" />
													</TD>
												</TR>
											</TABLE> <!--tblRemarks-->
											<TABLE runat="server" id="tblSeeAlso" visible="false" cellSpacing="1" cellPadding="1" width="100%"
												border="0">
												<TR>
													<TD colSpan="2">
														<asp:label id="lblSeeAlso" runat="server" Text="SeeAlso" Font-Bold />
													</TD>
												</TR>
												<TR>
													<TD width="50">
														<IMG height="1" alt="" src="/Admin/images/Nothing.gif" width="50" border="0">
													</TD>
													<TD>
														<asp:label id="fldSeeAlso" runat="server" />
													</TD>
												</TR>
											</TABLE> <!--tblSeeAlso-->
										</TD>
									</TR>
									<tr>
										<td>
											<TABLE runat="server" id="tblOverview" visible="false" cellSpacing="1" cellPadding="1"
												width="100%" border="0">
												<TR>
													<TD colSpan="2">
														<asp:label id="lblOverview" runat="server" Text="Summary" Font-Bold />
													</TD>
												</TR>
												<TR>
													<TD width="50">
														<IMG height="1" alt="" src="/Admin/images/Nothing.gif" width="50" border="0">
													</TD>
													<TD>
														<asp:label id="fldOverview" runat="server" />
													</TD>
												</TR>
											</TABLE> <!--tblOverview-->
										</td>
									</tr>
								</TABLE> <!--tblTagDetails-->
							</td>
						</TR>
					</TABLE> <!--tblInner-->
				</TD>
			</TR>
		</TABLE> <!--tblOuterFrame-->
	</body>
</HTML>
