<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DBPub_View.aspx.vb" Inherits="Dynamicweb.Admin.DBPub.DBPub_View"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb.DBPub" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
  <HEAD>
		<title>DBPub_View</title>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<meta content="True" name="vs_snapToGrid">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<script language="javascript">
			var isOK = false;
		function ConfirmDelete(elm)
		{
			return confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("Subscriber"))%>\n(' + elm.ClientCommandArgument + ')');
		}

		</script>
		<script type="text/javascript" src="DBPubView.js"></script>
		<%If Not view.CustomSQL And view.Lock > 1 Then%>
			<style>
				#GetHtmlTableTabs { WIDTH: 675px }
				#GetHtmlTableTop { WIDTH: 675px }
			</style>
		<%end if%>
</HEAD>
	<body>
		<%fillFields()%>
		<%prepareTabs()%>
		<%FillTemplateTab(ViewID)%>
		<%CheckBoxActions()%>
		<%IsConnectSelected()%>
		<%WriteInfo()%>
		<%IsSorting()%>
		<%ReInit()%>
		<%=Gui.MakeHeaders("DBView", tabs, "", false, "")%>
		<table class="tabTable" cellSpacing="0" cellPadding="0" <%=IIf(view.CustomSQL Or view.Lock = 1, "", "style='WIDTH:675px'")%> border="0">
  <TBODY>
			<tr vAlign="top">
				<td height="370"><br>
					<form id="Form1" method="post" runat="server">
						<asp:panel id="Tab1" Runat="server" Width="100%">
<asp:Table id=Table1 Width="100%" Runat="server">
								<asp:TableRow Runat="server">
									<asp:TableCell Runat="server">
										<asp:Table Runat="server" Width="100%">
											<asp:TableRow Runat="server" ID="Tablerow1">
												<asp:TableCell Runat="server" ColumnSpan="2" ID="Tablecell24">
													<asp:Table Width="100%" Runat="server" ID="Table19">
														<asp:TableRow>
															<asp:TableCell Runat="server" Width="170" ID="NameRow_Cell_Label">
																<asp:Label Runat="server" ID="NameRow_Lable">Name</asp:Label>
															</asp:TableCell>
															<asp:TableCell Runat="server" ID="NameRow_Cell_TextBox">
																<asp:TextBox Runat="server" id="ViewName" Width="300" />
															</asp:TableCell>
														</asp:TableRow>
													</asp:Table>
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="TypeRow" VerticalAlign="Top">
												<asp:TableCell Runat="server" ColumnSpan="2" ID="Tablecell23">
													<asp:Table Width="100%" Runat="server" ID="Table18">
														<asp:TableRow>
															<asp:TableCell Runat="server" Width="170" ID="TypeRow_Cell_Label" style="padding-top: 5px;" VerticalAlign="Top">
																<asp:Label Runat="server" ID="TypeRow_Label">Database type</asp:Label>
															</asp:TableCell>
															<asp:TableCell Runat="server" ID="TypeRow_Cell_Radiobuttons">
																<asp:radiobutton id="Type1" Runat="server" AutoPostBack="True" Checked="False" GroupName="ViewType" Text="Dynamicweb database"></asp:radiobutton>
																<br>
																<asp:radiobutton id="Type2" Runat="server" AutoPostBack="True" Checked="False" GroupName="ViewType" Text="Access from filearchive"></asp:radiobutton>
																<br>
																<asp:radiobutton id="Type3" Runat="server" AutoPostBack="True" Checked="False" GroupName="ViewType" Text="External SQL Database"></asp:radiobutton>
																<br>
																<asp:radiobutton id="Type4" Runat="server" AutoPostBack="True" Checked="False" GroupName="ViewType" Text="CSV file"></asp:radiobutton>
															</asp:TableCell>
														</asp:TableRow>
													</asp:Table>
												</asp:TableCell>
												</asp:TableRow>
												<asp:TableRow Runat="server" ID="Tablerow42">
												<asp:TableCell Runat="server" ColumnSpan="2" ID="Tablecell37">
													<asp:Table Width="100%" Runat="server" ID="Table21">
														<asp:TableRow>
															<asp:TableCell Runat="server" Width="170" ID="Tablecell38">
																<asp:Label Runat="server" ID="Label7">&nbsp;</asp:Label>
															</asp:TableCell>
															<asp:TableCell Runat="server" ID="Tablecell39">
																<asp:checkbox Runat="server" id="chkCustomSql" BorderStyle="None" AutoPostBack="True" Text="Use custom sql" Checked="false"></asp:checkbox>
															</asp:TableCell>
														</asp:TableRow>
													</asp:Table>
												</asp:TableCell>
											</asp:TableRow>
												<asp:TableRow Runat="server" ID="DatabaseRowType1" Visible="False">
												<asp:TableCell Runat="server" ColumnSpan="2" ID="Tablecell22">
													<asp:Table Width="100%" Runat="server" ID="Table15555">
														<asp:TableRow>
															<asp:TableCell Runat="server" Width="170" ID="DatabaseRow_Cell_Text">
																<asp:Label Runat="server" ID="DatabaseRow_Label"><%=Translate.Translate("Database")%></asp:Label>
															</asp:TableCell>
															<asp:TableCell Runat="server" ID="DatabaseRow_Cell_DropDown">
																<asp:DropDownList Runat="server" id="ViewDatabaseType1" AutoPostBack="True" Width="300" />
															</asp:TableCell>
														</asp:TableRow>
													</asp:Table>
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="DatabaseRowType2" Visible="False">
												<asp:TableCell Runat="server" ColumnSpan="2" ID="Tablecell4">
													<asp:Table Width="100%" Runat="server" ID="Table2">
														<asp:TableRow>
															<asp:TableCell Runat="server" Width="170" ID="Tablecell1">
																<asp:Label Runat="server" ID="Label1"><%=Translate.Translate("Database")%></asp:Label>
															</asp:TableCell>
															<asp:TableCell Runat="server" ID="Tablecell2">
																<%= Gui.FileManager(ViewDatabaseType2, Dynamicweb.Content.Management.Installation.FilesFolderName, "ViewDatabaseType2", "mdb")%>
															</asp:TableCell>
														</asp:TableRow>
														<asp:TableRow>
															<asp:TableCell width="170" Runat="server" ID="Tablecell8"></asp:TableCell>
															<asp:TableCell Runat="server" ID="Tablecell6">
																<asp:Button ID="SaveDatabaseType2" Text="Connect" CssClass="buttonSubmit" Runat="server" OnCommand="OnSaveConnection" />
															</asp:TableCell>
														</asp:TableRow>
													</asp:Table>
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="DatabaseRowType4" Visible="False">
												<asp:TableCell Runat="server" ColumnSpan="2" ID="Tablecell17">
													<asp:Table Width="100%" Runat="server" ID="Table3">
														<asp:TableRow>
															<asp:TableCell Runat="server" Width="170" ID="Tablecell18">
																<asp:Label Runat="server" ID="Label3">Folder</asp:Label>
															</asp:TableCell>
															<asp:TableCell Runat="server" ID="Tablecell19">
																<%=Gui.FolderManager(fmJobDS2File, "ViewDatabaseType4", True, True) %>
															</asp:TableCell>
														</asp:TableRow>
														<asp:TableRow>
															<asp:TableCell Width="170"></asp:TableCell>
															<asp:TableCell>
																<asp:checkbox id="ChbJobDS2" runat="server" BorderStyle="None" Text="First line column names" Checked="True"></asp:checkbox>
															</asp:TableCell>
														</asp:TableRow>
														<asp:TableRow>
															<asp:TableCell Width="170">
																<asp:Label Runat="server" ID="Label4">Decimal symbol</asp:Label>
															</asp:TableCell>
															<asp:TableCell>
																<asp:textbox id="TbJobDS2Decimal" runat="server" Width="300"></asp:textbox>
																<asp:CustomValidator id="CvJobDS2Decimal" runat="server" ClientValidationFunction="validateDecimal" ErrorMessage="allowed not more one symbol"></asp:CustomValidator>
															</asp:TableCell>
														</asp:TableRow>
														<asp:TableRow>
															<asp:TableCell Width="170">
																<asp:Label Runat="server" ID="Label5">Character set</asp:Label>
															</asp:TableCell>
															<asp:TableCell>
																<asp:dropdownlist id="DdlJobDS2Character" runat="server" Width="300">
																	<asp:ListItem Value="Unicode">Unicode</asp:ListItem>
																	<asp:ListItem Value="OEM">OEM</asp:ListItem>
																	<asp:ListItem Value="ANSI">ANSI</asp:ListItem>
																</asp:dropdownlist>
															</asp:TableCell>
														</asp:TableRow>
														<asp:TableRow>
															<asp:TableCell Width="170">
																<asp:Label Runat="server" ID="Label6">Delimiter</asp:Label>
															</asp:TableCell>
															<asp:TableCell>
																<asp:dropdownlist id="DdlJobDS2Delimiter" runat="server" Width="300">
																	<asp:ListItem Value="TabDelimited">Tab Delimited</asp:ListItem>
																	<asp:ListItem Value="CSVDelimited">CSV Delimited</asp:ListItem>
																	<asp:ListItem Value="FixedLength">Fixed Length</asp:ListItem>
																	<asp:ListItem Value="Custom">Custom Delimited</asp:ListItem>
																</asp:dropdownlist>
																<br>
																<span id="SpanJobDS2Delimiter" style="DISPLAY:none">
																	<asp:textbox id="TbJobDS2Delimiter" runat="server" Width="300"></asp:textbox>
																	<asp:CustomValidator id="CvJobDS2Delimiter" runat="server" ErrorMessage="allowed only one symbol" ClientValidationFunction="validateDelimiter_custom"></asp:CustomValidator>
																</span>
															</asp:TableCell>
														</asp:TableRow>
														<asp:TableRow>
															<asp:TableCell width="170" Runat="server" ID="Tablecell20"></asp:TableCell>
															<asp:TableCell Runat="server" ID="Tablecell21">
																<asp:Button ID="BtnJobDS2" Text="Connect" Runat="server" CssClass="buttonSubmit" OnCommand="OnSaveConnection" />
															</asp:TableCell>
														</asp:TableRow>
													</asp:Table>
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="DatabaseRowType3" Visible="False">
												<asp:TableCell Runat="server" ColumnSpan="2" ID="Tablecell3">
													<asp:Table Width="100%" Runat="server">
														<asp:TableRow>
															<asp:TableCell Width="170">
																<asp:Label Runat="server" ID="DatabaseRowType3_Server">Server</asp:Label>
															</asp:TableCell>
															<asp:TableCell>
																<asp:TextBox ID="ViewServer" Runat="server" Width="300" />
															</asp:TableCell>
														</asp:TableRow>
														<asp:TableRow>
															<asp:TableCell Width="170">
																<asp:Label Runat="server" ID="ViewDBType3_Label">Database</asp:Label>
															</asp:TableCell>
															<asp:TableCell>
																<asp:TextBox ID="ViewDBType3" Runat="server" Width="300" />
															</asp:TableCell>
														</asp:TableRow>
														<asp:TableRow>
															<asp:TableCell Width="170">
																<asp:Label Runat="server" ID="ViewUser_label">User</asp:Label>
															</asp:TableCell>
															<asp:TableCell>
																<asp:TextBox ID="ViewUser" Runat="server" Width="300" />
															</asp:TableCell>
														</asp:TableRow>
														<asp:TableRow>
															<asp:TableCell Width="170">
																<asp:Label Runat="server" ID="ViewPassword_Label">Password</asp:Label>
															</asp:TableCell>
															<asp:TableCell>
																<asp:TextBox ID="ViewPassword" Runat="server" Width="300" TextMode="Password" />
															</asp:TableCell>
														</asp:TableRow>
														<asp:TableRow>
															<asp:TableCell width="170" Runat="server" ID="Tablecell7"></asp:TableCell>
															<asp:TableCell Runat="server" ID="Tablecell5">
																<asp:Button ID="Button1" Text="Connect" Runat="server" CssClass="buttonSubmit" OnCommand="OnSaveConnection" />
															</asp:TableCell>
														</asp:TableRow>
													</asp:Table>
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="TableRow">
												<asp:TableCell Runat="server" ColumnSpan="2" ID="Tablecell25">
													<asp:Table Width="100%" Runat="server" ID="Table20">
														<asp:TableRow>
															<asp:TableCell Runat="server" Width="170" ID="TableRow_Cell_Label">
																<asp:Label Runat="server" ID="TableRow_Label">Table</asp:Label>
															</asp:TableCell>
															<asp:TableCell Runat="server" ID="TableRow_Cell_Dropdown">
																<asp:DropDownList Runat="server" id="ViewTable" AutoPostBack="True" Width="300" />
															</asp:TableCell>
														</asp:TableRow>
													</asp:Table>
												</asp:TableCell>
											</asp:TableRow>
										</asp:Table>
									</asp:TableCell>
								</asp:TableRow>
							</asp:Table>
						</asp:panel>
						<asp:panel id="Tab2" style="DISPLAY: none" Runat="server">
<asp:Table id="Table6" Width="100%" Runat="server">
								<asp:TableRow Runat="server" ID="Tablerow6">
									<asp:TableCell Runat="server" ID="Tablecell12">
										<asp:Table Runat="server" Width="100%" ID="Table7" NAME="Table5">
											<asp:TableRow Runat="server" ID="Tablerow11">
												<asp:TableCell Width="170">
													<%=Translate.Translate("Join Type")%></asp:TableCell>
												<asp:TableCell>
													<asp:DropDownList ID="JoinType" Runat="server" AutoPostBack="True"></asp:DropDownList>
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="Tablerow7">
												<asp:TableCell Width="170">
													<%=Translate.Translate("Table to join")%></asp:TableCell>
												<asp:TableCell>
													<asp:DropDownList ID="JoinJoinTable" Runat="server" AutoPostBack="True"></asp:DropDownList>
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="Tablerow8">
												<asp:TableCell Width="170">
													<%=Translate.Translate("ON")%></asp:TableCell>
												<asp:TableCell></asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="Tablerow9">
												<asp:TableCell Width="170">
													<%=Translate.Translate("Field from original table")%></asp:TableCell>
												<asp:TableCell>
													<asp:Label Runat="server" ID="JoinOriginalTableName"></asp:Label>
													<asp:DropDownList ID="JoinOriginalField" Runat="server" AutoPostBack="False"></asp:DropDownList>
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="Tablerow12">
												<asp:TableCell Width="170">
													=</asp:TableCell>
												<asp:TableCell></asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="Tablerow10">
												<asp:TableCell Width="170">
													<%=Translate.Translate("Field from join table")%></asp:TableCell>
												<asp:TableCell>
													<asp:Label Runat="server" ID="JoinJoinTableName"></asp:Label>
													<asp:DropDownList ID="JoinJoinField" Runat="server" AutoPostBack="False"></asp:DropDownList>
												</asp:TableCell>
											</asp:TableRow>
										</asp:Table>
									</asp:TableCell>
								</asp:TableRow>
							</asp:Table>
						</asp:panel><asp:panel id="Tab3" style="DISPLAY: none" Runat="server">
<asp:Table id=Table4 Width="100%" Runat="server">
								<asp:TableRow Runat="server" ID="Tablerow5" NAME="Tablerow5">
									<asp:TableCell Runat="server" ID="Tablecell11" NAME="Tablecell11">
										<asp:Table Runat="server" Width="100%" ID="Table5" NAME="Table5">
											<asp:TableRow Runat="server">
												<asp:TableCell Width="170">
													<%=Translate.Translate("Felt")%></asp:TableCell>
												<asp:TableCell>
													<asp:DropDownList ID="WhereField" Runat="server" AutoPostBack="False"></asp:DropDownList>
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="Tablerow3">
												<asp:TableCell Width="170">
													<%=Translate.Translate("Sammenligning")%></asp:TableCell>
												<asp:TableCell>
													<asp:DropDownList ID="WhereComparison" Runat="server" AutoPostBack="False"></asp:DropDownList>
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="Tablerow4">
												<asp:TableCell Width="170">
													<%=Translate.Translate("Værdi")%></asp:TableCell>
												<asp:TableCell VerticalAlign="Top">
													<asp:TextBox id="WhereValueText" Runat="server"></asp:TextBox>&#32;
<asp:DropDownList ID="WhereValue" Runat="server" AutoPostBack="False"></asp:DropDownList>
												</asp:TableCell>
											</asp:TableRow>
										</asp:Table>
									</asp:TableCell>
								</asp:TableRow>
							</asp:Table>
						</asp:panel>
						<asp:panel id="Tab4" style="DISPLAY: none" Runat="server">
<asp:Table id=Table8 Width="100%" Runat="server">
								<asp:TableRow Runat="server" ID="Tablerow13" NAME="Tablerow5">
									<asp:TableCell Runat="server" ID="Tablecell13" NAME="Tablecell11">
										<asp:Table Runat="server" Width="100%" ID="Table9" NAME="Table5">
											<asp:TableRow Runat="server" ID="Tablerow14" NAME="Tablerow14">
												<asp:TableCell Width="170">
													<%=Translate.Translate("Sorter efter")%></asp:TableCell>
												<asp:TableCell>
													<asp:DropDownList ID="OrderByClause" Runat="server" AutoPostBack="False"></asp:DropDownList>
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="Tablerow15">
												<asp:TableCell Width="170">
													<%=Translate.Translate("Rækkefølge")%></asp:TableCell>
												<asp:TableCell>
													<asp:DropDownList ID="OrderByOrder" Runat="server" AutoPostBack="False"></asp:DropDownList>
												</asp:TableCell>
											</asp:TableRow>
										</asp:Table>
									</asp:TableCell>
								</asp:TableRow>
							</asp:Table>
						</asp:panel><asp:panel id="Tab5" style="DISPLAY: none" Runat="server">
<asp:Table id=Table10 Width="100%" Runat="server">
								<asp:TableRow Runat="server" ID="Tablerow16">
									<asp:TableCell Runat="server" ID="Tablecell14">
										<asp:Table Runat="server" Width="100%" ID="Table11">
											<asp:TableRow Runat="server" ID="Tablerow17">
												<asp:TableCell>
													<asp:PlaceHolder ID="fieldHolder" Runat="server"></asp:PlaceHolder>
												</asp:TableCell>
											</asp:TableRow>
										</asp:Table>
									</asp:TableCell>
								</asp:TableRow>
							</asp:Table>
						</asp:panel><asp:panel id="Tab6" style="DISPLAY: none" Runat="server">
<asp:Table id=Table12 Width="100%" Runat="server">
								<asp:TableRow Runat="server" ID="Tablerow18">
									<asp:TableCell Runat="server" ID="Tablecell15">
										<asp:Table Runat="server" Width="100%" ID="Table13">
											<asp:TableRow Runat="server" ID="Tablerow19">
												<asp:TableCell Width="70" Runat="server" VerticalAlign="Top">
													SQL
												</asp:TableCell>
												<asp:TableCell>
													<asp:TextBox Runat="server" ID="ShowSQL" TextMode="MultiLine" Rows="10" Columns="70"></asp:TextBox>
												</asp:TableCell>
												<asp:TableCell>
													<asp:Button ID="Update" Text="Update" Runat="server" OnCommand="OnUpdateSql" CssClass="buttonSubmit" />
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow>
												<asp:TableCell>
													<asp:Label id="Label2" runat="server"></asp:Label>
												</asp:TableCell>
											</asp:TableRow>
										</asp:Table>
									</asp:TableCell>
								</asp:TableRow>
							</asp:Table>
						</asp:panel><asp:panel id="Tab7" style="DISPLAY: none" Runat="server">
<asp:Table id=Table14 Width="100%" Runat="server">
								<asp:TableRow Runat="server" ID="Tablerow20">
									<asp:TableCell Runat="server" ID="Tablecell16">
										<asp:Table Runat="server" Width="100%" ID="Table15">
											<asp:TableRow Runat="server" ID="Tablerow29">
												<asp:TableCell Width="170"><%=Translate.Translate("Mappe")%></asp:TableCell>
												<asp:TableCell>
													<%=Gui.FolderManager(TemplateFolder, "TemplateFolder", True, True) %>
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="Tablerow25">
												<asp:TableCell Width="170"><%=Translate.Translate("Liste")%></asp:TableCell>
												<asp:TableCell>
													<asp:Literal id="MasterListTemplate" runat="server" />
													<%'<!--asp:TextBox id="MasterListTemplate" runat="server"></asp:TextBox-->%>
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="Tablerow26">
												<asp:TableCell Width="170"><%=Translate.Translate("Række")%></asp:TableCell>
												<asp:TableCell>
													<asp:Literal id="RowTemplate" Runat="server" />
													<%'<!--asp:TextBox id="RowTemplate" runat="server"></asp:TextBox-->%>
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="Tablerow24">
												<asp:TableCell Width="170"><%=Translate.Translate("Rækkeadskiller")%></asp:TableCell>
												<asp:TableCell>
													<asp:Literal id="DelimiterTempl" runat="server" />
													<%'=Gui.FileManager(DelimiterTempl, "Templates", "DelimiterTempl") %>
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="Tablerow27">
												<asp:TableCell Width="170"><%=Translate.Translate("Detalje")%></asp:TableCell>
												<asp:TableCell>
													<asp:Literal id="ViewTemplate" runat="server" />
													<%'<asp:TextBox id="ViewTemplate" runat="server"></asp:TextBox>%>
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="Tablerow28">
												<asp:TableCell Width="170"><%=Translate.Translate("Redigering")%></asp:TableCell>
												<asp:TableCell>
													<asp:Literal ID="EditTemplate" Runat="server" />
													<%'<asp:TextBox id="EditTemplate" runat="server"></asp:TextBox>%>
												</asp:TableCell>
											</asp:TableRow>
											
											
											
											
											<asp:TableRow Runat="server" ID="Tablerow30">
												<asp:TableCell Width="170"><%=Translate.Translate("Visningstyper")%></asp:TableCell>
												<asp:TableCell Width="170">
													<asp:CheckBox id="CheckView" runat="server" Text="View"></asp:CheckBox>
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="Tablerow35">
												<asp:TableCell Width="170"></asp:TableCell>
												<asp:TableCell Width="170">
													<asp:CheckBox id="CheckAdd" runat="server" Text="Add"></asp:CheckBox>
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="Tablerow31">
												<asp:TableCell Width="170"></asp:TableCell>
												<asp:TableCell Width="170">
													<asp:CheckBox id="CheckEdit" runat="server" Text="Edit"></asp:CheckBox>
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="Tablerow34">
												<asp:TableCell Width="170"></asp:TableCell>
												<asp:TableCell Width="170">
													<asp:CheckBox id="CheckSearch" runat="server" Text="Search"></asp:CheckBox>
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="Tablerow32">
												<asp:TableCell Width="170"></asp:TableCell>
												<asp:TableCell Width="170">
													<asp:CheckBox id="CheckDelete" runat="server" Text="Delete"></asp:CheckBox>
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="Tablerow33">
												<asp:TableCell Width="170"></asp:TableCell>
												<asp:TableCell Width="170">
													&nbsp;
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="Tablerow43">
												<asp:TableCell Width="170"><%=Translate.Translate("Funktioner")%></asp:TableCell>
												<asp:TableCell Width="170">
													<asp:CheckBox id="HtmlEncode" runat="server" Text="HTML encoding"></asp:CheckBox>
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="Tablerow21">
												<asp:TableCell Width="170"></asp:TableCell>
												<asp:TableCell Width="170">
													<asp:CheckBox id="CheckPaging" runat="server" Text="Paging"></asp:CheckBox>
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="Tablerow22">
												<asp:TableCell Width="170"></asp:TableCell>
												<asp:TableCell Width="170">
													<asp:CheckBox id="CheckSorting" runat="server" Text="Sorting"></asp:CheckBox>
												</asp:TableCell>
											</asp:TableRow>
											<asp:TableRow Runat="server" ID="Tablerow23">
												<asp:TableCell Width="170"></asp:TableCell>
												<asp:TableCell Width="170">
													<asp:CheckBox id="CheckAlternative" runat="server" Text="Alternative row"></asp:CheckBox>
												</asp:TableCell>
											</asp:TableRow>
										</asp:Table>
									</asp:TableCell>
								</asp:TableRow>
							</asp:Table>
						</asp:panel>
						<asp:panel id="Tab8" style="DISPLAY: none" Runat="server">	
							<asp:Table id="Table212223" Width="100%" Runat="server" BorderWidth="0">
								<asp:TableRow Runat="server" ID="Tablerow36">
									<asp:TableCell Runat="server" ID="Tablecell26">
										<asp:Table Runat="server" id="Table8547" Width="100%" BorderWidth="0">
											<asp:TableRow Runat="server">
												<asp:TableCell Runat="server"></asp:TableCell>
												<asp:TableCell Runat="server">
													<asp:CheckBox id="chkIsChild" runat="server" Text="Is child"></asp:CheckBox>
												</asp:TableCell>
											</asp:TableRow>
											</asp:Table>
											<asp:Table Runat=server>
											<asp:TableRow Runat="server" ID="Tablerow37" style="DISPLAY: none" Width="100%">
												<asp:TableCell ColumnSpan="2">
													<asp:Panel Runat="server">
														<fieldset>
															<asp:Table Runat="server">
																<asp:TableRow Runat=server>
																	<asp:TableCell Runat=server ColumnSpan=2>&nbsp;</asp:TableCell>
																</asp:TableRow>	 
																<asp:TableRow Runat="server" ID="Tablerow38">
																	<asp:TableCell Runat="server" Width="170" ID="Tablecell29"><%=Translate.Translate("Parent datasource")%></asp:TableCell>
																	<asp:TableCell Runat="server" ID="Tablecell30">
																		<asp:DropDownList ID="DropdownParent" Runat="server" AutoPostBack="True" CssClass="std"></asp:DropDownList>
																	</asp:TableCell>
																</asp:TableRow>
																<asp:TableRow Runat="server" ID="Tablerow41">
																	<asp:TableCell Runat="server" Width="170" ID="Tablecell33">&nbsp;</asp:TableCell>
																	<asp:TableCell Runat="server" ID="Tablecell34">
																		 <asp:CheckBox id="ShowParentDetail" runat="server" Text="Show parent detail"></asp:CheckBox>
																	</asp:TableCell>
																</asp:TableRow>
																<asp:TableRow Runat=server ID="Tablerow39">
																	<asp:TableCell Runat=server ColumnSpan=2 ID="Tablecell31">&nbsp;</asp:TableCell>
																</asp:TableRow>
																<asp:TableRow Runat="server">
																	<asp:TableCell Runat="server" ColumnSpan = 2 HorizontalAlign="Center">
																		<asp:repeater id="RelationList" runat="server">
											<HeaderTemplate>
												<table border="0" cellpadding="0" cellspacing="2" width="100%">
													<tr>
																						<td align="left" width="230"><strong><%=Translate.Translate("Parent key field")%></strong></td>
																						<td align="left" width="190"><strong><%=Translate.Translate("Parent key field caption")%></strong></td>
														<td align="left"></td>
																						<td align="left" width="190"><strong><%=Translate.Translate("Child felt")%></strong></td>
													</tr>
													<tr>
																						<td colspan="4" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
													</tr>
											</HeaderTemplate>
											<ItemTemplate>
												<tr>
													<td align="left"><%# DataBinder.Eval(Container.DataItem, "RelationParent") %></td>
																					<td align="left"><%# MakeDropdown(Consts.RelationCaptionDropDownPrfx + Base.ChkString(DataBinder.Eval(Container.DataItem, "ID")), _parentView.Fields.GetAllFields(), Base.ChkString(DataBinder.Eval(Container.DataItem, "RelationParentCaption"))) %></td>
													<td align="left"><img src="/Admin/Images/Icons/Page_MoveTo.gif" alt="" border="0"></td>
													<td align="left"><%# MakeDropdown(Consts.RelationDropDownPrfx + Base.ChkString(DataBinder.Eval(Container.DataItem, "ID")), view.Fields.GetAllFields(), Base.ChkString(DataBinder.Eval(Container.DataItem, "RelationChild"))) %></td>
												</tr>
											</ItemTemplate>
											<SeparatorTemplate>
												<tr>
																					<td colspan="4" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
												</tr>
											</SeparatorTemplate>
											<FooterTemplate>
												<tr>
													<td colspan="4" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
												</tr>
												</table>
											</FooterTemplate>
										</asp:repeater>
																	</asp:TableCell>
																</asp:TableRow>
																<asp:TableRow Runat=server ID="Tablerow40" NAME="Tablerow40">
																	<asp:TableCell Runat=server ColumnSpan=2 ID="Tablecell32" NAME="Tablecell32">&nbsp;</asp:TableCell>
																</asp:TableRow>
															</asp:Table>
														</fieldset>
													</asp:Panel>
												</asp:TableCell>
											</asp:TableRow>
										</asp:Table>
									</asp:TableCell>
								</asp:TableRow>
							</asp:Table></asp:panel>
							<asp:panel id="Tab9" style="DISPLAY: none" Runat="server">
      <TABLE cellSpacing=2 cellPadding=0 width="100%" border=0>
        <TR>
		  <TD>&nbsp;</TD>
          <TD width="170"><%=Translate.Translate("Upload folder")%></TD>
          <TD><%=Gui.FolderManager(view.UploadFolder, "UploadFolder", True, True) %></TD>
        </TR>
        <tr>
			<td>&nbsp;</td>
			<td width="170"><%=Translate.Translate("Export folder") %></td>
			<td><%=Gui.FolderManager(view.ExportFolder, "ExportFolder", True, True) %></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td width="170"><%=Translate.Translate("Export file type") %></td>
			<td>
				<asp:DropDownList ID="ddExportType" Runat="server" CssClass="std">
					<asp:ListItem Value="csv" Selected="True">CSV document</asp:ListItem>
					<asp:ListItem Value="xls">Excel document</asp:ListItem>
					<asp:ListItem Value="xml">XML document</asp:ListItem>
				</asp:DropDownList>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td width="170">&nbsp;</td>
			<td align="left"><asp:Button ID="btnExport" Runat="server" CssClass="ButtonSubmit" Visible="True" Text="Export" Runat="server"></asp:Button></td>
		</tr>
      </TABLE>
          <br/><br/>
			<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
			<TR>
				<TD>&nbsp;</TD>
				<TD width=170><%=Translate.Translate("Add Subscriber") %></TD>
				<TD>
					<asp:DropDownList Runat="server" id="DdlSubscribers" AutoPostBack="False" Width="220" CssClass="std" />
					<asp:Button id="btnAddSubscriber" Text="Add" runat="server" CssClass="buttonSubmit"></asp:Button>				
				</TD>
			</TR>
			<tr>
				<td colspan="3" align="center" valign="top">
				<table border="0" cellpadding="0" width="500">
					<asp:repeater id="SubscriberRepeater" runat="server">
						<HeaderTemplate>
							<tr>
								<td colspan="4">&nbsp;</td>
							</tr>
							<tr>
								<td align="left" width="85%"><strong><%=Translate.Translate("Subsriber") %></strong></td>
								<td align="center"><strong><%=Translate.Translate("Delete") %></strong></td>
							</tr>
							<tr>
								<td colspan="4" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
							</tr>
						</HeaderTemplate>
						<ItemTemplate>
							<tr>
								<td align="left"><%# DataBinder.Eval(Container.DataItem, "Name")%></td>
								<td align="center">
									<a runat="server" OnServerClick="OnDeleteSubscriber" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "UserID")%>' OnClick='if (!ConfirmDelete(this)) return false;' ClientCommandArgument='<%# DataBinder.Eval(Container.DataItem, "Name")%>' ID="A1">
										<img src="/Admin/Images/Delete.gif" alt="<%=Translate.Translate("Slet")%>" border="0">
									</a>
								</td>
							</tr>
						</ItemTemplate>
						<SeparatorTemplate>
							<tr>
								<td colspan="4" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
							</tr>
						</SeparatorTemplate>
					</asp:repeater>
					<tr>
						<td colspan="4"><asp:Label id="NoSubscriber" runat="server" Visible=False><%=Translate.Translate("No subscribers found") %></asp:Label></td>
					</tr>
					<tr>
						<td colspan="4" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
					</tr>
					<tr>
						<td colspan="4">&nbsp;</td>
					</tr>
				</table>
			</td>
			</tr>
			</TABLE>
							</asp:panel>
						<asp:panel id="NoTab" Runat="server">
<asp:Table id=Table16 Width="100%" Runat="server">
								<asp:TableRow Runat="server" VerticalAlign="Bottom">
									<asp:TableCell Runat="server" ColumnSpan="2" ID="Tablecell9"></asp:TableCell>
								</asp:TableRow>
								<asp:TableRow Runat="server" VerticalAlign="Bottom">
									<asp:TableCell Runat="server" ColumnSpan="2" HorizontalAlign="Right" VerticalAlign="Bottom">
										<asp:Table Runat="server" ID="Table17" Width="100%">
											<asp:TableRow Runat="server" ID="Tablerow2" VerticalAlign="Bottom">
												<asp:TableCell Runat="server" ColumnSpan="2" ID="Tablecell10" HorizontalAlign="Right">												
													
												</asp:TableCell>
											</asp:TableRow>
										</asp:Table>
									</asp:TableCell>
								</asp:TableRow>
							</asp:Table>
						</asp:panel>
						<input type="hidden" id="SortID" name="SortID"> <input type="hidden" id="SortWay" name="SortWay">
						<input type="hidden" id="SortProcID" name="SortProcID"></TD></TR>
			<tr width="100%">
				<td><asp:label id="ErrorMessage" Runat="server">&nbsp;</asp:label></td>
			</tr>
			<tr width="100%">
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td width="100%" align=right>
					<asp:Button Runat="server" ID="Save" Text="OK" CssClass="buttonSubmit"></asp:Button>
					
					<asp:Button Runat="server" ID="Back" Text="Cancel" CssClass="buttonSubmit"></asp:Button>
					&nbsp;
                    <TD><%=Gui.HelpButton("dbpub", "modules.dbpub.general.publication.edit")%></TD>
					&nbsp;
				</td>
			</tr>
			<tr width="100%">
				<td>&nbsp;</td>
			</tr></FORM>
			<tr width="100%" valign="bottom">
				<td>
					<span class="std" style="WIDTH: 100%; HEIGHT: 5px">
						<asp:label id="StatusMessage" Runat="server">&nbsp;</asp:label></span></td>
			</tr></TBODY></TABLE>
			
		<%If Base.ChkBoolean(Base.Request("generateTmpls")) Then%>
			<script language="javascript">
			 <% if view.ID > 0 %>
			     if(confirm("Rewrite templates?\n"))
			     {
				    location = "DBPub_Save.aspx?generate=true";
			     }
			     else
			     {
			        location = "DBPub_Save.aspx?generate=false";
			     }
			<%else%>
			    location = "DBPub_Save.aspx?generate=true";
		    <%end if%>	 
			 </script>
		<%end if%>
			
		<%=Gui.SelectTab(guiTabID)%>
		<%=CustDelimiter%>
		<%=CustomJavaScript()%>
		<%Translate.GetEditOnlineScript()%>
	</body>
</HTML>
