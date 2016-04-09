<%@ Page Language="vb" AutoEventWireup="false"  validateRequest="false" Codebehind="EditTags.aspx.vb" Inherits="Dynamicweb.Admin.EditTags" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb" %>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>EditTags</title>
		<meta content="True" name="vs_snapToGrid">
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../../Stylesheet.css" type="text/css" rel="STYLESHEET">
	</HEAD>
	<body onLoad="GridScroll()">
		<form id="Form1" method="post" runat="server">
			&nbsp;
			<TABLE id="Table1" cellSpacing="1" cellPadding="1" border="0">
				<TR>
					<TD><asp:button id="btnSearchAndEdit" runat="server" Text="Tags"></asp:button></TD>
					<TD><asp:button id="btnCreateSystem" runat="server" Text="Systems"></asp:button></TD>
					<TD><asp:button id="btnCreateFunction" runat="server" Text="Functions"></asp:button></TD>
				</TR>
				<TR>
					<TD colSpan="3"><asp:panel id="panSearchAndEdit" runat="server" BorderWidth="0" Visible="False"><BR>
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
									<TD style="WIDTH: 107px">
										<asp:Label id="Label5" runat="server">Hide published</asp:Label></TD>
									<TD>
										<asp:CheckBox id="chkShowPublish" runat="server"></asp:CheckBox></TD>
									<TD></TD>
								</TR>
								<TR>
									<TD style="WIDTH: 107px">
										<asp:Label id="Label6" runat="server">Hide unpublished</asp:Label></TD>
									<TD>
										<asp:CheckBox id="chkShowUnPublish" runat="server"></asp:CheckBox></TD>
									<TD></TD>
								</TR>
								<TR>
									<TD style="WIDTH: 107px">
										<asp:Label id="Label7" runat="server">Hide Dismissed</asp:Label></TD>
									<TD>
										<asp:CheckBox id="chkDismissed" runat="server"></asp:CheckBox></TD>
									<TD></TD>
								</TR>
								<TR>
									<TD style="WIDTH: 107px"></TD>
									<TD>
										<asp:Button id="btnSearchbtn" runat="server" Text="Search"></asp:Button></TD>
									<TD></TD>
								</TR>
							</TABLE>
							<%=Gui.GroupboxEnd()%>
							<P></P>
							<P><%=Gui.GroupboxStart("Search Result")%>
								<asp:DataGrid id="dtgSearch" Width="100%" runat="server" Visible="False" BorderWidth="0px" AutoGenerateColumns="False"
									OnEditCommand="dtgSearch_Edit" OnCancelCommand="dtgSearch_Cancel" OnUpdateCommand="dtgSearch_Update"
									OnDeleteCommand="dtgSearch_Delete" BorderColor="#E7E7FF" BorderStyle="None" BackColor="White"
									CellPadding="3" GridLines="Horizontal" HorizontalAlign="Left">
									<SelectedItemStyle Font-Bold="True" HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top"
										BackColor="#738A9C"></SelectedItemStyle>
									<EditItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top"></EditItemStyle>
									<AlternatingItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top" BackColor="#F9F8F3"></AlternatingItemStyle>
									<ItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top" BackColor="#ECE9D8"></ItemStyle>
									<HeaderStyle Font-Bold="True" ForeColor="#000000" BackColor="#ECE9D8"></HeaderStyle>
									<FooterStyle ForeColor="#4A3C8C" BackColor="#B5C7DE"></FooterStyle>
									<Columns>
										<asp:EditCommandColumn ButtonType="LinkButton" EditText="Edit">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:EditCommandColumn>
										<asp:EditCommandColumn ButtonType="LinkButton" UpdateText="Update" CancelText="Cancel">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:EditCommandColumn>
										
										<asp:BoundColumn DataField="TagID" ReadOnly="True" HeaderText="TagID">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:BoundColumn>
										<asp:BoundColumn DataField="TagPage" ReadOnly="True" HeaderText="TagPage">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:BoundColumn>
										<asp:BoundColumn DataField="TagName" ReadOnly="True" HeaderText="TagName">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:BoundColumn>
										<asp:TemplateColumn HeaderText="Editor">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
											<EditItemTemplate>
												<TABLE id="Table4" style="WIDTH: 552px; HEIGHT: 266px" cellSpacing="1" cellPadding="1"
													width="552" border="0">
													<TR>
														<TD style="WIDTH: 134px">TagPath</TD>
														<TD style="WIDTH: 160px">
															<asp:TextBox id="txtTagPath" runat="server" Width="150px"></asp:TextBox></TD>
														<TD vAlign="top" align="left" rowSpan="10">
															<TABLE style="WIDTH: 247px; HEIGHT: 62px" cellSpacing="1" cellPadding="1" width="247" border="0">
																<TR>
																	<TD>Settings</TD>
																</TR>
																<TR>
																	<TD>
																		<asp:TextBox id="txtFileRef" runat="server" TextMode="MultiLine"  Width="232px" Height="80px"></asp:TextBox></TD>
																</TR>
																<TR>
																	<TD><BR>
																		Summary</TD>
																</TR>
																<TR>
																	<TD>
																		<asp:TextBox id="txtDescription" runat="server" TextMode="MultiLine"  Width="232px" Height="80px"></asp:TextBox></TD>
																</TR>
																<TR>
																	<TD><BR>
																		Remarks</TD>
																</TR>
																<TR>
																	<TD>
																		<asp:TextBox id="txtComments" runat="server" TextMode="MultiLine"  Width="232px" Height="80px"></asp:TextBox></TD>
																</TR>
															</TABLE>
														</TD>
													</TR>
													<TR>
														<TD style="WIDTH: 134px">TagPage</TD>
														<TD style="WIDTH: 160px">
															<asp:TextBox id="txtTagPage" runat="server" Width="150px"></asp:TextBox></TD>
													</TR>
													<TR>
														<TD style="WIDTH: 134px">TagName</TD>
														<TD style="WIDTH: 160px">
															<asp:TextBox id="txtTagName" runat="server" Width="150px">3</asp:TextBox></TD>
													</TR>
													<TR>
														<TD style="WIDTH: 134px; HEIGHT: 27px">TagValue</TD>
														<TD style="WIDTH: 160px">
															<asp:TextBox id="txtTagValue" runat="server" Width="150px"></asp:TextBox></TD>
													</TR>
													<TR>
														<TD style="WIDTH: 134px; HEIGHT: 25px">TagTemplateFile</TD>
														<TD style="WIDTH: 160px; HEIGHT: 25px">
															<asp:TextBox id="txtTagTemplateFile" runat="server" Width="150px"></asp:TextBox></TD>
													</TR>
													<TR>
														<TD style="WIDTH: 134px">TagFunction</TD>
														<TD style="WIDTH: 160px">
															<asp:TextBox id="txtTagFunction" runat="server" Width="150px"></asp:TextBox></TD>
													</TR>
													<TR>
														<TD style="WIDTH: 134px">Publish</TD>
														<TD style="WIDTH: 160px">
														<asp:RadioButtonList id="chkTagActive" runat="server"></asp:RadioButtonList></TD>
													</TR>
													<TR>
														<TD style="WIDTH: 134px">TagCategory</TD>
														<TD style="WIDTH: 160px">
															<asp:DropDownList id="ddlTagFunction" Width="150px" Runat="server"></asp:DropDownList></TD>
													</TR>
													<TR>
														<TD style="WIDTH: 134px">DefaultTemplateName</TD>
														<TD style="WIDTH: 160px">
															<asp:TextBox id="txtDefaultTemplateName" Width="150px" Runat="server"></asp:TextBox></TD>
													</TR>
													<TR>
														<TD style="WIDTH: 134px">VersionNumber</TD>
														<TD style="WIDTH: 160px">
															<asp:TextBox id="txtVersionNumber" Width="150px" Runat="server"></asp:TextBox></TD>
													</TR>
													<TR>
														<TD style="WIDTH: 134px"></TD>
														<TD style="WIDTH: 160px"></td><td>
															References<BR>
															<asp:DataGrid BorderWidth="1" BorderColor="#000000"  id="dtgEditRef" CellPadding="2" runat="server" Visible="False" AutoGenerateColumns="False" OnDeleteCommand="dtgEditRef_Delete">
																									<SelectedItemStyle Font-Bold="True" HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top" BackColor="#738A9C"></SelectedItemStyle>
									<EditItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top"></EditItemStyle>
									<AlternatingItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top" BackColor="#F9F8F3"></AlternatingItemStyle>
									<ItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top" BackColor="#ECE9D8"></ItemStyle>
									<HeaderStyle Font-Bold="True" ForeColor="#000000" BackColor="#ECE9D8"></HeaderStyle>
									<FooterStyle ForeColor="#4A3C8C" BackColor="#B5C7DE"></FooterStyle>
<Columns>
																	<asp:ButtonColumn Text="Delete" CommandName="Delete"></asp:ButtonColumn>
																	<asp:BoundColumn Visible="False" DataField="TagRelatedID" HeaderText="RefTagID">
																		<HeaderStyle Font-Bold="True"></HeaderStyle>
																	</asp:BoundColumn>
																	<asp:BoundColumn Visible="False" DataField="TagRelatedMasterID" HeaderText="RefTagID">
																		<HeaderStyle Font-Bold="True"></HeaderStyle>
																	</asp:BoundColumn>
																	<asp:BoundColumn DataField="TagID" HeaderText="RefTagID">
																		<HeaderStyle Font-Bold="True"></HeaderStyle>
																	</asp:BoundColumn>
																	<asp:BoundColumn DataField="TagName" HeaderText="RefTagName">
																		<HeaderStyle Font-Bold="True"></HeaderStyle>
																	</asp:BoundColumn>
																</Columns>
															</asp:DataGrid><br>
															<a style="COLOR: #3399CC;cursor:hand;"  onclick="JavaScript:window.open('EditTagAddRef.aspx?ID=<%#Container.DataItem("TagID")%>');">Add reference</a><BR>
														</TD>
													</TR>
												</TABLE>
												<BR>
											</EditItemTemplate>
										</asp:TemplateColumn>
										<asp:ButtonColumn Text="Delete" CommandName="Delete">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:ButtonColumn>
										<asp:ButtonColumn Text="" CommandName="xDelete">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:ButtonColumn>
										<asp:HyperLinkColumn Text="Show" Target="_blank" DataNavigateUrlField="TagID" DataTextField="TagID" HeaderText="Showtest" DataNavigateUrlFormatString="ShowTag.aspx?TagID={0}">
										</asp:HyperLinkColumn>

									</Columns>
									<PagerStyle HorizontalAlign="Right" ForeColor="#4A3C8C" BackColor="#E7E7FF" Mode="NumericPages"></PagerStyle>
								</asp:DataGrid></P>
							<%=Gui.GroupboxEnd()%>
							<BR>
							<%=Gui.GroupboxStart("Add Tag")%>
							<TABLE id="Table4" style="WIDTH: 552px; HEIGHT: 266px" cellSpacing="1" cellPadding="1"
								width="552" border="0">
								<TR>
									<TD style="WIDTH: 134px">TagPath</TD>
									<TD style="WIDTH: 160px">
										<asp:TextBox id="txtTagPathNew" runat="server" Width="150px"></asp:TextBox></TD>
									<TD vAlign="top" align="left" rowSpan="11">
										<TABLE style="WIDTH: 247px; HEIGHT: 62px" cellSpacing="1" cellPadding="1" width="247" border="0">
											<TR>
												<TD>Settings</TD>
											</TR>
											<TR>
												<TD>
													<asp:TextBox id="txtFileRefNew" runat="server" Width="232px" Height="80px"></asp:TextBox></TD>
											</TR>
											<TR>
												<TD><BR>
													Summary</TD>
											</TR>
											<TR>
												<TD>
													<asp:TextBox id="txtDescriptionNew" runat="server" Width="232px" Height="80px"></asp:TextBox></TD>
											</TR>
											<TR>
												<TD><BR>
													Remarks</TD>
											</TR>
											<TR>
												<TD>
													<asp:TextBox id="txtCommentsNew" runat="server" Width="232px" Height="80px"></asp:TextBox></TD>
											</TR>
										</TABLE>
									</TD>
								</TR>
								<TR>
									<TD style="WIDTH: 134px">TagPage</TD>
									<TD style="WIDTH: 160px">
										<asp:TextBox id="txtTagPageNew" runat="server" Width="150px"></asp:TextBox></TD>
								</TR>
								<TR>
									<TD style="WIDTH: 134px">TagName</TD>
									<TD style="WIDTH: 160px">
										<asp:TextBox id="txtTagNameNew" runat="server" Width="150px">3</asp:TextBox></TD>
								</TR>
								<TR>
									<TD style="WIDTH: 134px; HEIGHT: 27px">TagValue</TD>
									<TD style="WIDTH: 160px">
										<asp:TextBox id="txtTagValueNew" runat="server" Width="150px"></asp:TextBox></TD>
								</TR>
								<TR>
									<TD style="WIDTH: 134px; HEIGHT: 25px">TagTemplateFile</TD>
									<TD style="WIDTH: 160px; HEIGHT: 25px">
										<asp:TextBox id="txtTagTemplateFileNew" runat="server" Width="150px"></asp:TextBox></TD>
								</TR>
								<TR>
									<TD style="WIDTH: 134px">TagFunction</TD>
									<TD style="WIDTH: 160px">
										<asp:TextBox id="txtTagFunctionNew" runat="server" Width="150px"></asp:TextBox></TD>
								</TR>
								<TR>
									<TD style="WIDTH: 134px">Publish</TD>
									<TD style="WIDTH: 160px">
										<asp:CheckBox id="chkTagActiveNew" runat="server"></asp:CheckBox></TD>
								</TR>
								<TR>
									<TD style="WIDTH: 134px">TagCategory</TD>
									<TD style="WIDTH: 160px">
										<asp:DropDownList id="ddlTagFunctionNew" Width="150px" Runat="server"></asp:DropDownList></TD>
								</TR>
								<TR>
									<TD style="WIDTH: 134px">DefaultTemplateName</TD>
									<TD style="WIDTH: 160px">
										<asp:TextBox id="txtDefaultTemplateNameNew" Width="150px" Runat="server"></asp:TextBox></TD>
								</TR>
								<TR>
									<TD style="WIDTH: 134px">VersionNumber</TD>
									<TD style="WIDTH: 160px">
										<asp:TextBox id="txtVersionNumberNew" Width="150px" Runat="server"></asp:TextBox></TD>
								</TR>
								<TR>
									<TD style="WIDTH: 134px"></TD>
									<TD style="WIDTH: 160px">
										<asp:Button id="btnCreateTag" runat="server" Text="Add"></asp:Button></TD>
								</TR>
							</TABLE>
							<%=Gui.GroupboxEnd()%>
						</asp:panel></TD>
				</TR>
				<TR>
					<TD colSpan="3"></TD>
				</TR>
				<TR>
					<TD colSpan="3">
							<asp:panel id="panCreateSystem" runat="server" BorderWidth="0" Visible="False">
								<P>
									<%=Gui.GroupboxStart("Systems")%>
								<P></P>

								<asp:DataGrid id="dtgCreateSystem" Width="100%" runat="server" Visible="False" BorderWidth="0px" AutoGenerateColumns="False" OnEditCommand="dtgCreateSystem_Edit" OnCancelCommand="dtgCreateSystem_Cancel"
									OnUpdateCommand="dtgCreateSystem_Update" OnDeleteCommand="dtgCreateSystem_Delete" BorderColor="#E7E7FF"
									BorderStyle="None" BackColor="White" CellPadding="3" GridLines="Horizontal">
									<SelectedItemStyle Font-Bold="True" HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top" BackColor="#738A9C"></SelectedItemStyle>
									<EditItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top"></EditItemStyle>
									<AlternatingItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top" BackColor="#F9F8F3"></AlternatingItemStyle>
									<ItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top" BackColor="#ECE9D8"></ItemStyle>
									<HeaderStyle Font-Bold="True" ForeColor="#000000" BackColor="#ECE9D8"></HeaderStyle>
									<FooterStyle ForeColor="#4A3C8C" BackColor="#B5C7DE"></FooterStyle>
									<Columns>
										<asp:EditCommandColumn ButtonType="LinkButton" EditText="Edit">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:EditCommandColumn>
										<asp:EditCommandColumn ButtonType="LinkButton" UpdateText="Update" CancelText="Cancel">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:EditCommandColumn>
										<asp:BoundColumn DataField="TagSystemID" ReadOnly="True" HeaderText="TagSystemID">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:BoundColumn>
										<asp:BoundColumn DataField="TagSystemName" HeaderText="TagSystemName">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:BoundColumn>
										<asp:ButtonColumn Text="Delete" CommandName="Delete">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:ButtonColumn>
									</Columns>
									<PagerStyle HorizontalAlign="Right" ForeColor="#4A3C8C" BackColor="#E7E7FF" Mode="NumericPages"></PagerStyle>
								</asp:DataGrid>
								</P>
							<%=Gui.GroupboxEnd()%>
								<P>
								</P>
							<%=Gui.GroupboxStart("Add System")%>
							TagSystems: 
							<asp:TextBox id="txtCreateSystemSystemName" runat="server" Width="150px"></asp:TextBox>&nbsp; 
							<asp:Button id="btnCreateCreateSystem" runat="server" Text="Add"></asp:Button></asp:panel></TD>
							<%=Gui.GroupboxEnd()%>
				</TR>
				<TR>
					<TD colSpan="3">
						<asp:panel id="panCreateFunction" runat="server" BorderWidth="0" Visible="False">
						<P>
							<%=Gui.GroupboxStart("Functions")%>

							<P></P>
								<asp:DataGrid id="dtgCreateFunction" Width="100%" runat="server" Visible="False" BorderWidth="0px" AutoGenerateColumns="False"
									OnEditCommand="dtgCreateFunction_Edit" OnCancelCommand="dtgCreateFunction_Cancel" OnUpdateCommand="dtgCreateFunction_Update"
									OnDeleteCommand="dtgCreateFunction_Delete" BorderColor="#E7E7FF" BorderStyle="None" BackColor="White"
									CellPadding="3" GridLines="Horizontal" Font-Names="Verdana">
									<SelectedItemStyle Font-Bold="True" HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top"
										BackColor="#738A9C"></SelectedItemStyle>
									<EditItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top"></EditItemStyle>
									<AlternatingItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top" BackColor="#F9F8F3"></AlternatingItemStyle>
									<ItemStyle HorizontalAlign="Left" ForeColor="#3399CC" VerticalAlign="Top" BackColor="#ECE9D8"></ItemStyle>
									<HeaderStyle Font-Bold="True" ForeColor="#000000" BackColor="#ECE9D8"></HeaderStyle>
									<FooterStyle ForeColor="#4A3C8C" BackColor="#B5C7DE"></FooterStyle>
									<Columns>
										<asp:EditCommandColumn ButtonType="LinkButton" EditText="Edit">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:EditCommandColumn>
										<asp:EditCommandColumn ButtonType="LinkButton" UpdateText="Update" CancelText="Cancel">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:EditCommandColumn>
										<asp:BoundColumn DataField="TagFunctionID" ReadOnly="True" HeaderText="ID">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:BoundColumn>
										<asp:BoundColumn DataField="TagFunctionName" HeaderText="TagFunctionName">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:BoundColumn>
										<asp:TemplateColumn HeaderText="SystemID">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
											<ItemTemplate>
												<%#Container.DataItem("SystemName")%>
											</ItemTemplate>
											<EditItemTemplate>
												<asp:DropDownList id="Dropdownlist2" runat="server"></asp:DropDownList>
											</EditItemTemplate>
										</asp:TemplateColumn>
										<asp:ButtonColumn Text="Delete" CommandName="Delete">
											<HeaderStyle Font-Bold="True"></HeaderStyle>
										</asp:ButtonColumn>
									</Columns>
									<PagerStyle HorizontalAlign="Right" ForeColor="#4A3C8C" BackColor="#E7E7FF" Mode="NumericPages"></PagerStyle>
								</asp:DataGrid></P>
						<%=Gui.GroupboxEnd()%>
								<P>
								</P>
						<%=Gui.GroupboxStart("Add Function")%>

							<TABLE id="Table2" cellSpacing="1" cellPadding="1" width="300" border="0">
								<TR>
									<TD>TagFunctionName:</TD>
									<TD>
										<asp:TextBox id="txtCreateFunctionFunctionName" runat="server" Width="150px"></asp:TextBox></TD>
									<TD></TD>
								</TR>
								<TR>
									<TD>TagFunctionSystemID:</TD>
									<TD>
										<asp:DropDownList id="ddlTagFunctionSystemID" runat="server" Width="150px"></asp:DropDownList></TD>
									<TD></TD>
								</TR>
								<TR>
									<TD></TD>
									<TD>
										<asp:Button id="btnCreateCreateFunction" runat="server" Text="Add"></asp:Button></TD>
									<TD></TD>
								</TR>
							</TABLE>
						<%=Gui.GroupboxEnd()%>

						</asp:panel><BR>
						<P>&nbsp;&nbsp;<BR>
						</P>
					</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
<script language="JScript">
	function GridScroll() {
		if (document.all.ScrollHere!=null) {
		document.all.ScrollHere.scrollIntoView();
		}
	}
</script>