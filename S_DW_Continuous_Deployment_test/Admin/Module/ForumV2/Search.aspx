<%@ Page ValidateRequest="false" Language="vb" AutoEventWireup="false" Codebehind="Search.aspx.vb" Inherits="Dynamicweb.Admin.ForumV2.Search" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Blog_List</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<LINK href="ForumV2Css.css" type="text/css" rel="STYLESHEET">
	</HEAD>
	<body MS_POSITIONING="GridLayout" style="MARGIN-LEFT: 20px">
		<form id="ListBlog" method="post" runat="server">
			<dw:tabheader id="Tabs" title="Search" runat="server" Headers="Search"></dw:tabheader>
			<div id="Tab1">
				<table class="tabTable" cellSpacing="0" cellPadding="0" style="WIDTH:550px" border="0">
					<tr>
						<td style="HEIGHT: 153px" vAlign="top">
							<table cellPadding="0" width="100%">
								<tr>
									<td style="HEIGHT: 107px"><dw:groupboxstart id="gbSearchStart" title="Search" runat="server" Height="8px" Width="528px"></dw:groupboxstart>
										<table width="100%">
											<tr>
												<td style="WIDTH: 100px; HEIGHT: 17px" width="100%"><%=Translate.Translate("Søgetekst")%></td>
												<td style="WIDTH: 300px; HEIGHT: 17px"><asp:textbox id="txStringSearch" Width="320px" Runat="server" CssClass="std"></asp:textbox></td>
												<td style="HEIGHT: 17px"><asp:button id="cmdSearchOK" Width="56px" Runat="server" CssClass="ButtonSubmit" Text="Search"></asp:button></td>
											</tr>
										</table>
										<table width="100%">
											<tr>
												<td><%=Translate.Translate("Følgende_kategorier")%></td>
											</tr>
											<tr>
												<td align="center"><asp:checkboxlist id="chBoxList" RepeatColumns="3" RepeatDirection="Horizontal" Runat="Server"></asp:checkboxlist></td>
											</tr>
										</table>
										<asp:RequiredFieldValidator id="vlField" runat="server" ControlToValidate="txStringSearch"></asp:RequiredFieldValidator>
									</td>
								</tr>
								<tr>
									<td vAlign="bottom" align="right" colSpan="2">
										<table cellSpacing="0" cellPadding="0" border="0">
											<tr>
												<td style="WIDTH: 39px" width="40">&nbsp;</td>
												<td style="WIDTH: 20px"><%=Gui.Button(Translate.Translate("Luk"), "location='Category_List.aspx'", 0)%></td>
												<td width="5">&nbsp;</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>
							<asp:repeater id="lsSearchList" Runat="server">
								<HeaderTemplate>
									<table border="0" cellpadding="0" style="WIDTH:550px">
										<tr valign="top">
											<td colspan="3"><br>
											</td>
										</tr>
										<tr>
											<td align="left" width="300"><strong>&nbsp;<%=Translate.Translate("Tråd")%></strong></td>
											<td align="center" width="400"><strong><%=Translate.Translate("Beskrivelse")%></strong></td>
										</tr>
										<tr>
											<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
										</tr>
								</HeaderTemplate>
								<ItemTemplate>
									<tr>
										<td align="left">&nbsp;<a href='Thread_Edit.aspx?ThreadID=
										<%#DataBinder.Eval(Container.DataItem, "ID") %>
										'><%# DataBinder.Eval(Container.DataItem, "Headline") %></a></td>
										<td align="center"><%# DataBinder.Eval(Container.DataItem, "Description") %></td>
									</tr>
								</ItemTemplate>
								<SeparatorTemplate>
									<tr>
										<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
									</tr>
								</SeparatorTemplate>
							</asp:repeater>
						</td>
					</tr>
					<tr>
						<td vAlign="top" style="HEIGHT: 1px">&nbsp;<dw:translatelabel id="tlNotFound" runat="server" Text="No found." Visible="False"></dw:translatelabel>
						</td>
					</tr>
					<TR>
						<TD id="LinkButtons" colSpan="2" runat="server">
							<ASP:LINKBUTTON id="lbLastPage" Runat="server" OnCommand="LastPage_Click" text="<" Visible="False"></ASP:LINKBUTTON>
							<ASP:LINKBUTTON id="lbPageN1" Runat="server" OnCommand="NavigationLink_Click"></ASP:LINKBUTTON>
							<ASP:LINKBUTTON id="lbPageN2" Runat="server" OnCommand="NavigationLink_Click"></ASP:LINKBUTTON>
							<ASP:LINKBUTTON id="lbPageN3" Runat="server" OnCommand="NavigationLink_Click"></ASP:LINKBUTTON>
							<ASP:LINKBUTTON id="lbNextPage" Runat="server" CommandName="next" OnCommand="NextPage_Click" text=">"
								Visible="False"></ASP:LINKBUTTON></TD>
						</TD>
					</TR>
				</table>
			</div>
			</TD>
		</form>
		<%=Gui.SelectTab()%>
	</body>
</HTML>
<%
	Translate.GetEditOnlineScript()
%>