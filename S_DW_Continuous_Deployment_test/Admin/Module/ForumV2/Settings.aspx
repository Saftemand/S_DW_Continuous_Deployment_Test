<%@ Page ValidateRequest="false" Language="vb" AutoEventWireup="false" Codebehind="Settings.aspx.vb" Inherits="Dynamicweb.Admin.ForumV2.Settings" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register Assembly="Dynamicweb.Admin" Namespace="Dynamicweb.Admin.ModulesCommon" TagPrefix="mc" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Blog_List</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<script language="javascript">
			function ConfirmEmoticonDelete(emoticon)
			{
				return confirm("<%=Translate.Translate("Slet emoticon")%> \"" + emoticon.ClientCommandArgument + "\"?");
			}
			
			function ConfirmRankDelete(rank)
			{
				return confirm("<%=Translate.Translate("Slet rang")%> \"" + rank.ClientCommandArgument + "\"?");	
			}
			function ConfirmWordDelete(word)
			{
				return confirm("<%=Translate.Translate("Slet ord")%> \"" + word.ClientCommandArgument + "\"?");
			}
	
			function ConfirmBanDelete(ban)
			{
				return confirm("<%=Translate.Translate("Slet udelukket adresse")%> \"" + ban.ClientCommandArgument + "\"?");
			}
			function test(val,args)
			{
				alert('You must choose a client for the order!');
				return true;	
			}
		</script>
		<style>
			#GetHtmlTableTabs
			{ 
				WIDTH:575px;			
			} 	
			#GetHtmlTableTop	
			{ 
				WIDTH:575px;			
			} 
		</style>
	</HEAD>
	<body MS_POSITIONING="GridLayout" style="MARGIN-LEFT: 10px;">
		<form id="ListBlog" method="post" runat="server">
			<dw:tabheader id="Tabs" title="Settings" headers="1,2,3,4,5,6,7,8" runat="server"></dw:tabheader>
			<div id="Tab1">
				<table class="tabTable" cellSpacing="0" cellPadding="0" style="WIDTH:575px" border="0">
					<tr>
						<td vAlign="top">
							<asp:repeater id="lsEmoticonList" Runat="server">
								<HeaderTemplate>
									<table border="0" cellpadding="0" style="WIDTH:575px">
										<tr valign="top">
											<td colspan="3"><br>
											</td>
										</tr>
										<tr>
											<td align="left" width="300"><strong>&nbsp;<%=Translate.Translate("Kombination")%></strong></td>
											<td align="center" width="400"><strong><%=Translate.Translate("Ikon")%></strong></td>
											<td align="center" nowrap><strong><%=Translate.Translate("Slet")%>&nbsp;</strong></td>
										</tr>
										<tr>
											<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
										</tr>
								</HeaderTemplate>
								<ItemTemplate>
									<tr>
										<td align="left">&nbsp;<a href='Emoticon_Edit.aspx?EmoticonID=
										 <%# DataBinder.Eval(Container.DataItem, "ID") %>
										'><%# DataBinder.Eval(Container.DataItem, "Combination") %></a></td>
										<td align="center"><img alt="<%# DataBinder.Eval(Container.DataItem, "Icon") %>" border=0 src="/Files/<%=Dynamicweb.Content.Management.Installation.ImagesFolderName%>/<%# DataBinder.Eval(Container.DataItem, "Icon") %>"/></td>
										<td align="center">
											<a runat="server"
														    OnServerClick="OnEmoticonDelete" CommandArgument='
															<%# DataBinder.Eval(Container.DataItem, "ID")%>' 
															OnClick='return ConfirmEmoticonDelete(this);' 
															ClientCommandArgument='<%# HttpContext.Current.Server.HtmlDecode(DataBinder.Eval(Container.DataItem, "Combination"))%>' ID="A1">
												<img src="/Admin/Images/Delete.gif" alt="<%=Translate.Translate("Slet") & " " & Translate.Translate("Emoticon")%>" border="0"></a>
										</td>
									</tr>
								</ItemTemplate>
								<SeparatorTemplate>
									<tr>
										<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
									</tr>
								</SeparatorTemplate>
							</asp:repeater></td>
					</tr>
					<tr>
						<td vAlign="top">&nbsp;<dw:translatelabel id="tlEmoticonNotFound" runat="server" Text="No emoticons found."></dw:translatelabel>
						</td>
					</tr>
				</table>
				</TD></TR><tr>
					<td colspan="3" align="right" valign="bottom">
						<table cellSpacing="0" cellPadding="0" border="0">
							<tr>
								<td><%=Gui.Button(Translate.Translate("Tilføj"), "location='Emoticon_Edit.aspx'", 0)%></td>
								<td width="5">&nbsp;</td>
								<td><%=Gui.Button(Translate.Translate("Annuller"), "location='Category_List.aspx'", 0)%></td>
								<td width="10">&nbsp;</td>
							</tr>
							<tr>
								<td colSpan="3" height="5"></td>
							</tr>
						</table>
					</td>
				</tr>
				</TABLE></div>
			<div id="Tab2" style="DISPLAY: none">
				<table class="tabTable" cellSpacing="0" cellPadding="0" style="WIDTH:575px" border="0">
					<tr>
						<td vAlign="top"><asp:repeater id="lsRankList" Runat="server">
								<HeaderTemplate>
									<table border="0" cellpadding="0" style="WIDTH:575px">
										<tr valign="top">
											<td colspan="3"><br>
											</td>
										</tr>
										<tr>
											<td align="left" width="300"><strong>&nbsp;<%=Translate.Translate("Titel")%></strong></td>
											<td align="center" width="400"><strong><%=Translate.Translate("Point")%></strong></td>
											<td align="center" nowrap><strong><%=Translate.Translate("Slet")%>&nbsp;</strong></td>
										</tr>
										<tr>
											<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
										</tr>
								</HeaderTemplate>
								<ItemTemplate>
									<tr>
										<td align="left">&nbsp;<a href='Rank_Edit.aspx?RankID=
										 <%# DataBinder.Eval(Container.DataItem, "ID") %>
										'><%# DataBinder.Eval(Container.DataItem, "Name") %></a></td>
										<td align="center"><%# DataBinder.Eval(Container.DataItem, "Count") %></td>
										<td align="center">
											<a runat="server"
														    OnServerClick="OnRankDelete" CommandArgument='
															<%# DataBinder.Eval(Container.DataItem, "ID")%>' 
															OnClick='return ConfirmRankDelete(this);' 
															ClientCommandArgument='<%# HttpContext.Current.Server.HtmlDecode(DataBinder.Eval(Container.DataItem, "Name"))%>' ID="A2">
												<img src="/Admin/Images/Delete.gif" alt="<%=Translate.Translate("Slet") & " " & Translate.Translate("rang")%>" border="0"></a>
										</td>
									</tr>
								</ItemTemplate>
								<SeparatorTemplate>
									<tr>
										<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
									</tr>
								</SeparatorTemplate>
							</asp:repeater></td>
					</tr>
					<tr>
						<td vAlign="top">&nbsp;<dw:translatelabel id="tlRankNotFound" runat="server" Text="No rank found."></dw:translatelabel>
						</td>
					</tr>
				</table>
				</TD></TR><tr>
					<td colspan="3" align="right" valign="bottom">
						<table cellSpacing="0" cellPadding="0" border="0">
							<tr>
								<td><%=Gui.Button(Translate.Translate("Tilføj"), "location='Rank_Edit.aspx'", 0)%></td>
								<td width="5">&nbsp;</td>
								<td><%=Gui.Button(Translate.Translate("Annuller"), "location='Category_List.aspx'", 0)%></td>
								<td width="10">&nbsp;</td>
							</tr>
							<tr>
								<td colSpan="3" height="5"></td>
							</tr>
						</table>
					</td>
				</tr>
				</TABLE></div>
			<div id="Tab3" style="DISPLAY: none">
				<table class="tabTable" cellSpacing="0" cellPadding="0" style="WIDTH:575px" border="0">
					<tr>
						<td vAlign="top" style="HEIGHT: 217px">
							<table cellPadding="0" border="0" style="WIDTH: 575px; HEIGHT: 205px">
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td style="HEIGHT: 74px">
										<dw:groupboxstart id="gbPruneAutoStart" runat="server" Height="4px" Width="568px"></dw:groupboxstart>
										<table width="100%">
											<tr>
												<td width="210"><%=Translate.Translate("Prune gamle indlæg efter")%></td>
												<td style="WIDTH: 254px"><asp:textbox id="txPruneAutoOld" Runat="server" CssClass="std"></asp:textbox></td>
												<td style="WIDTH: 58px" width="58"><%=Translate.Translate("dage")%></td>
												<td><asp:comparevalidator id="vlPruneAutoOldValidator" runat="server" ErrorMessage="Enter number" Type="Integer"
														ControlToValidate="txPruneAutoOld" Operator="DataTypeCheck"></asp:comparevalidator></td>
											</tr>
											<tr>
												<td width="210"><%=Translate.Translate("Prune ubesvarede indlæg efter")%></td>
												<td style="WIDTH: 254px"><asp:textbox id="txPruneAutoUnanswered" Runat="server" CssClass="std"></asp:textbox></td>
												<td style="WIDTH: 58px" width="58"><%=Translate.Translate("dage")%></td>
												<td><asp:comparevalidator id="vlPruneAutoUnansweredValidator" runat="server" ErrorMessage="Enter number" Type="Integer"
														ControlToValidate="txPruneAutoUnanswered" Operator="DataTypeCheck"></asp:comparevalidator></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td><dw:groupboxstart id="gbPruneManualStart" runat="server" Height="18px" Width="568px"></dw:groupboxstart>
										<table width="100%">
											<tr>
												<td width="350"><%=Translate.Translate("Prune indlæg efter")%></td>
												<td style="WIDTH: 253px"><asp:textbox id="txPruneManual" Runat="server" CssClass="std"></asp:textbox></td>
												<td style="WIDTH: 61px" width="61"><%=Translate.Translate("dage")%></td>
												<td><asp:comparevalidator id="vlPruneManualValidator" runat="server" ErrorMessage="Enter number" Type="Integer"
														ControlToValidate="txPruneManual" Operator="DataTypeCheck"></asp:comparevalidator></td>
											</tr>
											<tr>
												<td colspan="2">
													<asp:checkbox id="chkPruneManualOld" Runat="server"></asp:checkbox>
													<asp:checkbox id="chkPruneManualUnanswered" Runat="server"></asp:checkbox>
												</td>
											</tr>
											<tr>
												<td colspan="4" align="right">
													<asp:Button ID="cmdManualPrune" Runat="server" Text="Prune" Class="ButtonSubmit" CausesValidation="False"></asp:Button>&nbsp;
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td vAlign="bottom" align="right" colSpan="2">
							<table cellSpacing="0" cellPadding="0" border="0">
								<tr>
									<td><asp:button id="cmdPruneOK" Runat="server" CssClass="ButtonSubmit" CausesValidation="True"></asp:button></td>
									<td width="5">&nbsp;</td>
									<td><%=Gui.Button(Translate.Translate("Annuller"), "location='Category_List.aspx'", 0)%></td>
									<td width="10">&nbsp;</td>
								</tr>
								<tr>
									<td colSpan="2" height="5"></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			<div id="Tab4" style="DISPLAY: none">
				<table class="tabTable" cellSpacing="0" cellPadding="0" style="WIDTH:575px" border="0">
					<tr>
						<td vAlign="top"><asp:repeater id="lsWordList" Runat="server">
								<HeaderTemplate>
									<table border="0" cellpadding="0" style="WIDTH:575px">
										<tr valign="top">
											<td colspan="3"><br>
											</td>
										</tr>
										<tr>
											<td align="left" width="700"><strong>&nbsp;<%=Translate.Translate("Ord", 2)%></strong></td>
											<td align="center" nowrap><strong><%=Translate.Translate("Slet")%>&nbsp;</strong></td>
										</tr>
										<tr>
											<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
										</tr>
								</HeaderTemplate>
								<ItemTemplate>
									<tr>
										<td align="left">&nbsp;<a href='Word_Edit.aspx?WordID=
										 <%# DataBinder.Eval(Container.DataItem, "ID") %>
										'><%# DataBinder.Eval(Container.DataItem, "Word") %></a></td>
										<td align="center">
											<a runat="server"
														    OnServerClick="OnWordDelete" CommandArgument='
															<%# DataBinder.Eval(Container.DataItem, "ID")%>' 
															OnClick='return ConfirmWordDelete(this);' 
															ClientCommandArgument='<%# HttpContext.Current.Server.HtmlDecode(DataBinder.Eval(Container.DataItem, "Word"))%>' ID="A3">
												<img src="/Admin/Images/Delete.gif" alt="<%=Translate.Translate("Slet ord")%>" border="0"></a>
										</td>
									</tr>
								</ItemTemplate>
								<SeparatorTemplate>
									<tr>
										<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
									</tr>
								</SeparatorTemplate>
							</asp:repeater></td>
					</tr>
					<tr>
						<td vAlign="top">&nbsp;<dw:translatelabel id="tlWordNotFound" runat="server"></dw:translatelabel>
						</td>
					</tr>
				</table>
				</TD></TR><tr>
					<td colspan="3" align="right" valign="bottom">
						<table cellSpacing="0" cellPadding="0" border="0">
							<tr>
								<td><%=Gui.Button(Translate.Translate("Tilføj"), "location='Word_Edit.aspx'", 0)%></td>
								<td width="5">&nbsp;</td>
								<td><%=Gui.Button(Translate.Translate("Annuller"), "location='Category_List.aspx'", 0)%></td>
								<td width="10">&nbsp;</td>
							</tr>
							<tr>
								<td colSpan="3" height="5"></td>
							</tr>
						</table>
					</td>
				</tr>
				</TABLE></div>
			<div id="Tab5" style="DISPLAY: none">
				<table class="tabTable" cellSpacing="0" cellPadding="0" style="WIDTH:575px" border="0">
					<tr>
						<td vAlign="top"><asp:repeater id="lsBanList" Runat="server">
								<HeaderTemplate>
									<table border="0" cellpadding="0" style="WIDTH:575px">
										<tr valign="top">
											<td colspan="3"><br>
											</td>
										</tr>
										<tr>
											<td align="left" width="300"><strong>&nbsp;<%=Translate.Translate("IP address")%> / <%=Translate.Translate("Hostname")%></strong>
											</td>
											<td align="center" width="400"><strong><%=Translate.Translate("Aktiv")%></strong></td>
											<td align="center" nowrap><strong><%=Translate.Translate("Slet")%>&nbsp;</strong></td>
										</tr>
										<tr>
											<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
										</tr>
								</HeaderTemplate>
								<ItemTemplate>
									<tr>
										<td align="left">&nbsp;<a href='Ban_Edit.aspx?BanID=
										 <%# DataBinder.Eval(Container.DataItem, "ID") %>
										'><%# DataBinder.Eval(Container.DataItem, "Address") %></a></td>
										<td align="center">
											<asp:ImageButton AlternateText="Change activity" ID="btnActive" Runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID") %>' OnCommand="ChangeActive" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ActiveImage") %>'>
											</asp:ImageButton>
										</td>
										<td align="center">
											<a runat="server"
														    OnServerClick="OnBanDelete" CommandArgument='
															<%# DataBinder.Eval(Container.DataItem, "ID")%>' 
															OnClick='return ConfirmBanDelete(this);' 
															ClientCommandArgument='<%# HttpContext.Current.Server.HtmlDecode(DataBinder.Eval(Container.DataItem, "Address"))%>' ID="A4">
												<img src="/Admin/Images/Delete.gif" alt="Delete ban" border="0"></a>
										</td>
									</tr>
								</ItemTemplate>
								<SeparatorTemplate>
									<tr>
										<td colspan="3" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
									</tr>
								</SeparatorTemplate>
							</asp:repeater></td>
					</tr>
					<tr>
						<td vAlign="top">&nbsp;<dw:translatelabel id="tlBanNotFound" runat="server"></dw:translatelabel>
						</td>
					</tr>
				</table>
				</TD></TR><tr>
					<td colspan="3" align="right" valign="bottom">
						<table cellSpacing="0" cellPadding="0" border="0">
							<tr>
								<td><%=Gui.Button(Translate.Translate("Tilføj"), "location='Ban_Edit.aspx'", 0)%></td>
								<td width="5">&nbsp;</td>
								<td><%=Gui.Button(Translate.Translate("Annuller"), "location='Category_List.aspx'", 0)%></td>
								<td width="10">&nbsp;</td>
							</tr>
							<tr>
								<td colSpan="3" height="5"></td>
							</tr>
						</table>
					</td>
				</tr>
				</TABLE></div>
			<div id="Tab7" style="DISPLAY: none">
				<table class="tabTable" cellSpacing="0" cellPadding="0" border="0" style="WIDTH: 575px; HEIGHT: 130px">
					<TBODY>
						<tr>
							<td vAlign="top" style="HEIGHT: 97px">
								<table cellPadding="0" border="0" style="WIDTH: 575px; HEIGHT: 90px">
									<TBODY>
										<tr>
											<td>
												<dw:groupboxstart id="gbHotStatusStart" runat="server"></dw:groupboxstart>
												<table width="100%">
													<TBODY>
														<tr>
															<td style="WIDTH: 119px" width="119"><%=Translate.Translate("Antal svar")%></td>
															<td style="WIDTH: 188px"><asp:textbox id="txRepliesCount" Runat="server" CssClass="std"></asp:textbox></td>
															<td><asp:comparevalidator id="vlRepliesCountValidator" runat="server" ErrorMessage="Enter number." Type="Integer"
																	ControlToValidate="txRepliesCount" Operator="DataTypeCheck"></asp:comparevalidator></td>
														</tr>
														<tr>
															<td style="WIDTH: 119px" width="119"><%=Translate.Translate("Hot timer")%></td>
															<td style="WIDTH: 188px"><asp:textbox id="txHotHours" Runat="server" CssClass="std"></asp:textbox></td>
															<td><asp:comparevalidator id="vlHotHoursValidator" runat="server" ErrorMessage="Enter number." Type="Integer"
																	ControlToValidate="txHotHours" Operator="DataTypeCheck"></asp:comparevalidator></td>
														</tr>
													</TBODY>
												</table>
												<dw:groupboxend id="gbHotStatusEnd" runat="server" />
												<br />
												<dw:groupboxstart id="gbUploadStart" Title="Vedhæftede_filer" runat="server" />
												<table width="100%">
													<TBODY>
														<tr>
															<td style="WIDTH: 119px" width="119"><%=Translate.Translate("Upload_til")%></td>
															<td><dw:FolderManager ID="UploadDir" Name="UploadDir" runat="server" /></td>
															<td>&nbsp;</td>
														</tr>
													</TBODY>
												</table>
												<dw:groupboxend id="gbUploadEnd" runat="server" />
											</td>
										</tr>
									</TBODY>
								</table>
							</td>
						</tr>
						<tr>
							<td vAlign="bottom" align="right" colSpan="2">
								<table cellSpacing="0" cellPadding="0" border="0">
									<tr>
										<td><asp:button id="cmdHotStatusOK" Runat="server" Text="OK" CssClass="ButtonSubmit"></asp:button></td>
										<td width="5">&nbsp;</td>
										<td><%=Gui.Button("Cancel", "location='Category_List.aspx'", 0)%></td>
										<td width="10">&nbsp;</td>
									</tr>
									<tr>
										<td colSpan="2" height="5"></td>
									</tr>
								</table>
							</td>
						</tr>
					</TBODY>
				</table>
			</div>
			<div id="Tab6" style="DISPLAY: none">
				<table class="tabTable" cellSpacing="0" cellPadding="0" border="0" style="WIDTH: 575px; HEIGHT: 182px">
					<TBODY>
						<tr>
							<td vAlign="top" style="HEIGHT: 130px">
								<table cellPadding="0" border="0" style="WIDTH: 575px; HEIGHT: 136px">
									<TBODY>
										<tr>
											<td>
												<dw:groupboxstart id="gbHotSubscribeStart" title="Subscribe" runat="server" Height="32px"></dw:groupboxstart>
												<table width="100%">
													<TBODY>
														<tr>
															<td style="WIDTH: 144px; HEIGHT: 17px" width="144"><%=Translate.Translate("Emne")%></td>
															<td style="WIDTH: 188px; HEIGHT: 17px"><asp:textbox id="txSubscribeSubject" Runat="server" CssClass="std" maxLength = "255"></asp:textbox></td>
															<td style="HEIGHT: 17px"></td>
														</tr>
														<tr>
															<td style="WIDTH: 144px" width="144"><%=Translate.Translate("Fra adresse")%></td>
															<td style="WIDTH: 188px"><asp:textbox id="txSubscribeFromEmail" Runat="server" CssClass="std" maxLength = "255"></asp:textbox><br/><mc:EmailValidator ID="emailValidator" runat="server" ErrorMessage="incorrect email"
                        ControlToValidate="txSubscribeFromEmail" Display="Dynamic" /></td>
															<td></td>
														</tr>
														<tr>
															<td><%=Translate.Translate("Link til side")%></td>
															<td><%=Gui.LinkManager(_page, "lnkPage", "")%></td>
														</tr>
														<TR>
															<td style="WIDTH: 144px" width="144"><%=Translate.Translate("Template")%></td>
															<td><dw:filemanager id="fmSubscribeTemplate" name="txSubscribeTemplate" Folder="Templates/ForumV2/Subscribe"
																	runat="server"></dw:filemanager></td>
															<td></td>
														</TR>
													</TBODY>
												</table>
											</td>
										</tr>
									</TBODY>
								</table>
						<tr>
							<td vAlign="bottom" align="right" colSpan="2">
								<table cellSpacing="0" cellPadding="0" border="0">
									<tr>
										<td><asp:button id="cmdSubscribeOK" Runat="server" Text="OK" CssClass="ButtonSubmit"></asp:button></td>
										<td width="5">&nbsp;</td>
										<td><%=Gui.Button(Translate.Translate("Annuller"), "location='Category_List.aspx'", 0)%></td>
										<td width="10">&nbsp;</td>
									</tr>
									<tr>
										<td colSpan="2" height="5"></td>
									</tr>
								</table>
							</td>
						</tr>
					</TBODY>
				</table>
			</div>
		</form>
		<%=Gui.SelectTab()%>
		</TBODY></TABLE></TR></TBODY></TABLE></TR></TBODY>
		<DIV></DIV>
		</FORM>
	</body>
</HTML>

<%Translate.GetEditOnlineScript()%>