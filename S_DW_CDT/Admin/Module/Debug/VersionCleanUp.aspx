<%@ Page Language="vb" AutoEventWireup="false" Codebehind="VersionCleanUp.aspx.vb" Inherits="Dynamicweb.Admin.VersionCleanUp" %>
<%
Server.ScriptTimeout = 180
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>VersionCleanUp</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<BR>
			<table border="0" cellpadding="0" width="600" cellspacing="0">
				<tr>
					<td align="center">
						<strong></strong>
					</td>
				</tr>
				<tr>
					<td align="left">
						<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0" width="600">
							<TR>
								<TD ID="Tab1" CLASS="seltab" onclick="TabClick(this);" HEIGHT="20" ALIGN="center" VALIGN="middle">Version 
									Clean</TD>
								<TD CLASS="hiddentab" HEIGHT="20" WIDTH="1"><BR>
								</TD>
								<TD CLASS="hiddentab" HEIGHT="20" WIDTH="523"><BR>
								</TD>
							</TR>
						</TABLE>
					</td>
				</tr>
			</table>
			<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
				<tr>
					<td valign="top">
						<TABLE id="Table2" cellPadding="0" width="100%" border="0">
							<TR>
								<TD>
									<FIELDSET style="MARGIN: 5px; WIDTH: 100%"><LEGEND class="gbTitle">Clean</LEGEND>
										<table cellpadding="0" border="0" cellspacing="0">
											<tr>
												<td style="WIDTH: 180px">
													&nbsp;CleanUp Pages
												</td>
												<td style="WIDTH: 88px">
													<asp:Button Runat="server" name="btnCleanPages" ID="btnCleanPage" Text="Clean"></asp:Button>
												</td>
											</tr>
											<tr>
												<td colspan="2" height="4"></td>
											</tr>
											<tr>
												<td style="WIDTH: 180px">
													&nbsp;CleanUp Paragraphs
												</td>
												<td style="WIDTH: 88px">
													<asp:Button Runat="server" name="btnCleanParagraphs" ID="btnCleanParagraphs" Text="Clean"></asp:Button>
												</td>
											</tr>
											<tr>
												<td colspan="2" height="4"></td>
											</tr>
											<tr>
												<td style="WIDTH: 180px">
													&nbsp;CleanUp News
												</td>
												<td style="WIDTH: 88px">
													<asp:Button Runat="server" name="btnCleanNews" ID="btnCleanNews" Text="Clean"></asp:Button>
												</td>
											</tr>
											<tr>
												<td colspan="2" height="4"></td>
											</tr>
											<tr>
												<td style="WIDTH: 180px">
													&nbsp;CleanUp CalendarEvent
												</td>
												<td style="WIDTH: 88px">
													<asp:Button Runat="server" name="btnCleanCalenderEvent" ID="btnCleanCalenderEvent" Text="Clean"></asp:Button>
												</td>
											</tr>
											<tr>
												<td colspan="2" height="4"></td>
											</tr>
											<tr>
												<td style="WIDTH: 180px">
													&nbsp;CleanUp FAQItem
												</td>
												<td style="WIDTH: 88px">
													<asp:Button Runat="server" name="btnCleanFAQItem" ID="btnCleanFAQItem" Text="Clean"></asp:Button>
												</td>
											</tr>
											<tr>
												<td colspan="2" height="4"></td>
											</tr>
											<tr>
												<td colspan="2" height="4"></td>
											</tr>
										</table>
									</FIELDSET>
								</TD>
							</TR>
							<TR>
								<TD>
									<FIELDSET style="MARGIN: 5px; WIDTH: 100%"><LEGEND class="gbTitle">Info&nbsp;</LEGEND>
										<table cellpadding="0" border="0" cellspacing="0">
											<tr>
												<td colspan="2" height="4"></td>
											</tr>
											<tr>
												<td style="WIDTH: 180px">
													&nbsp;Info Pages
												</td>
												<td>
													<asp:Literal runat="server" ID="litPage"></asp:Literal>
												</td>
											</tr>
											<tr>
												<td colspan="2" height="4"></td>
											</tr>
											<tr>
												<td style="WIDTH: 180px">
													&nbsp;Info Paragraphs
												</td>
												<td>
													<asp:Literal runat="server" ID="LitParagraph"></asp:Literal>
												</td>
											</tr>
											<tr>
												<td colspan="2" height="4"></td>
											</tr>
											<tr>
												<td style="WIDTH: 180px">
													&nbsp;Info News
												</td>
												<td>
													<asp:Literal runat="server" ID="LitNews"></asp:Literal>
												</td>
											</tr>
											<tr>
												<td colspan="2" height="4"></td>
											</tr>
											<tr>
												<td style="WIDTH: 180px">
													&nbsp;Info CalendarEvent
												</td>
												<td>
													<asp:Literal runat="server" ID="LitCalenderEvent"></asp:Literal>
												</td>
											</tr>
											<tr>
												<td colspan="2" height="4"></td>
											</tr>
											<tr>
												<td style="WIDTH: 180px">
													&nbsp;Info FAQItem
												</td>
												<td>
													<asp:Literal runat="server" ID="LitFAQItem"></asp:Literal>
												</td>
											</tr>
											<tr>
												<td colspan="2" height="4"></td>
											</tr>
											<tr>
												<td colspan="2" height="4"></td>
											</tr>
										</table>
									</FIELDSET>
								</TD>
							</TR>
						</TABLE>
						<TABLE id="Table2" cellPadding="0" width="100%" border="0">
							<TR>
								<TD>
									<FIELDSET style="MARGIN: 5px; WIDTH: 100%"><LEGEND class="gbTitle">Clean</LEGEND>
										<table cellpadding="0" border="0" cellspacing="0">
											<tr>
												<td style="WIDTH: 180px">
													&nbsp;Disable Version Control
												</td>
												<td style="WIDTH: 88px">
													<asp:Button Runat="server" name="btnDisableVersion" ID="btnDisableVersion" Text="OK"></asp:Button>
												</td>
											</tr>
											<tr>
												<td colspan="2" height="4"></td>
											</tr>
											<tr>
												<td style="WIDTH: 180px">
													&nbsp;Hide Version Control
												</td>
												<td style="WIDTH: 88px">
													<asp:Button Runat="server" name="btnHideVersion" ID="btnHideVersion" Text="OK"></asp:Button>
												</td>
											</tr>
											<tr>
												<td colspan="2" height="4"></td>
											</tr>
											<tr>
												<td style="WIDTH: 180px">
													&nbsp;Disable WorkFlow
												</td>
												<td style="WIDTH: 88px">
													<asp:Button Runat="server" name="btnDisableWorkFlow" ID="btnDisableWorkFlow" Text="OK"></asp:Button>
												</td>
											</tr>
											<tr>
												<td colspan="2" height="4"></td>
											</tr>
											<tr>
												<td style="WIDTH: 180px">
													&nbsp;Hide WorkFlow
												</td>
												<td style="WIDTH: 88px">
													<asp:Button Runat="server" name="btnHideWorkFlow" ID="btnHideWorkFlow" Text="OK"></asp:Button>
												</td>
											</tr>
											<tr>
												<td colspan="2" height="4"></td>
											</tr>
										</table>
									</FIELDSET>
								</TD>
							</TR>
						</TABLE>
					</td>
				</tr>
			</table>
		</form>
	</body>
</HTML>
