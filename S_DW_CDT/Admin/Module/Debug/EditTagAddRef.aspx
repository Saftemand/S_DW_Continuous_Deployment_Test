<%@ Page Language="vb" AutoEventWireup="false" validateRequest="false" Codebehind="EditTagAddRef.aspx.vb" Inherits="Dynamicweb.Admin.EditTagAddRef" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Add tag reference</title>
		<meta content="True" name="vs_snapToGrid">
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../../Stylesheet.css" type="text/css" rel="STYLESHEET">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			&nbsp;
			<TABLE id="Table1" cellSpacing="1" cellPadding="1" border="0">
				<TR>
					<TD colSpan="3"><asp:panel id="panSearchAndEdit" runat="server" BorderWidth="0" Visible="True"><BR>
							<BR>
							<%=Gui.GroupboxStart("Search")%>
							<TABLE id="Table3" cellSpacing="1" cellPadding="1" width="576" border="0">
								<TR>
									<TD style="WIDTH: 107px">
										<asp:Label id="Label1" runat="server">Function</asp:Label></TD>
									<TD>
										<asp:TextBox id="txtxSFunction" runat="server" Width="150px"></asp:TextBox></TD>
									<TD></TD>
								</TR>
								<TR>
									<TD style="WIDTH: 107px">
										<asp:Label id="Label2" runat="server">Page</asp:Label></TD>
									<TD>
										<asp:TextBox id="txtxSPage" runat="server" Width="150px"></asp:TextBox>&nbsp;or
										<asp:DropDownList id="ddlSearchPages" runat="server" Width="150px"></asp:DropDownList></TD>
									<TD></TD>
								</TR>
								<TR>
									<TD style="WIDTH: 107px">
										<asp:Label id="Label3" runat="server">TemplateFile</asp:Label></TD>
									<TD>
										<asp:TextBox id="txtxSTemplateFile" runat="server" Width="150px"></asp:TextBox></TD>
									<TD></TD>
								</TR>
								<TR>
									<TD style="WIDTH: 107px">
										<asp:Label id="Label4" runat="server">TagName</asp:Label></TD>
									<TD>
										<asp:TextBox id="txtxSTagName" runat="server" Width="150px"></asp:TextBox></TD>
									<TD></TD>
								</TR>
								<TR>
									<TD style="WIDTH: 107px"></TD>
									<TD>
										<asp:Button id="btnSearchbtn" runat="server" Text="Search"></asp:Button>&nbsp;<INPUT onclick="JavaScript:window.opener.location.reload();window.close();" type="button"
											value="Close" name="Close"></TD>
									<TD></TD>
								</TR>
							</TABLE>
							<%=Gui.GroupboxEnd()%>
							<P></P>
							<P><%=Gui.GroupboxStart("Search Result")%>
								<asp:DataGrid id="dtgSearch" runat="server" Visible="False" BorderWidth="0px" Width="500px" AutoGenerateColumns="False"
									OnEditCommand="dtgSearch_Edit" BorderColor="#E7E7FF" BorderStyle="None" BackColor="White"
									CellPadding="3" GridLines="Horizontal" HorizontalAlign="Left">
									<SelectedItemStyle Font-Bold="True" HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top"
										BackColor="#738A9C"></SelectedItemStyle>
									<EditItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top"></EditItemStyle>
									<AlternatingItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top" BackColor="#F9F8F3"></AlternatingItemStyle>
									<ItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top" BackColor="#ECE9D8"></ItemStyle>
									<HeaderStyle Font-Bold="True" ForeColor="Black" Width="100%" BackColor="#ECE9D8"></HeaderStyle>
									<FooterStyle ForeColor="#4A3C8C" BackColor="#B5C7DE"></FooterStyle>
									<Columns>
										<asp:EditCommandColumn ButtonType="LinkButton" UpdateText="" CancelText="" EditText="Add Reference">
											<HeaderStyle Font-Bold="True" ForeColor="White"></HeaderStyle>
										</asp:EditCommandColumn>
										<asp:BoundColumn DataField="TagID" ReadOnly="True" HeaderText="TagID">
											<HeaderStyle Font-Bold="True" ForeColor="Black"></HeaderStyle>
										</asp:BoundColumn>
										<asp:BoundColumn DataField="TagPage" ReadOnly="True" HeaderText="TagPage">
											<HeaderStyle Font-Bold="True" ForeColor="Black"></HeaderStyle>
										</asp:BoundColumn>
										<asp:BoundColumn DataField="TagName" ReadOnly="True" HeaderText="TagName">
											<HeaderStyle Font-Bold="True" ForeColor="Black"></HeaderStyle>
										</asp:BoundColumn>
										<asp:HyperLinkColumn Text="Show" Target="_blank" DataNavigateUrlField="TagID" DataTextField="TagID" HeaderText="Showtest"
											NavigateUrl="ShowTag.aspx"></asp:HyperLinkColumn>
									</Columns>
									<PagerStyle HorizontalAlign="Right" ForeColor="#4A3C8C" BackColor="#E7E7FF" Mode="NumericPages"></PagerStyle>
								</asp:DataGrid></P>
							<%=Gui.GroupboxEnd()%>
							<BR>
						</asp:panel></TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
