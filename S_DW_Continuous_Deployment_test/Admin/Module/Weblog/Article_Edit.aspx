<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" Codebehind="Article_Edit.aspx.vb" Inherits="Dynamicweb.Admin.Weblog.Article_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Article_Edit</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
		<meta content="JavaScript" name="vs_defaultClientScript" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET" />
		<script language="javascript" type="text/javascript">
			function ConfirmCommentDelete(comment)
			{
				return confirm("Delete comment \"" + comment.ClientCommandArgument + "\" ?");
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
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<dw:tabheader id="Tabs" title="Weblog" runat="server" Headers="Edit article, Comments" ToolTip="Edit article"></dw:tabheader>
			<div id="Tab1">
				<table border="0" cellpadding="0" cellspacing="0" class="tabTable" width="598">
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top">
							<dw:groupboxstart id="CategoryStart" title="Category" runat="server"></dw:groupboxstart>
							<table cellspacing="0" cellpadding="0" border="0" width="100%">
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td width="150">&nbsp;<dw:translatelabel id="CategoryLabel" runat="server" Text="Category"></dw:translatelabel></td>
									<td><asp:DropDownList ID="lstCategory" CssClass="std" Runat="server"></asp:DropDownList></td>
								</tr>
								<tr>
									<td>&nbsp;</td>
								</tr>
							</table>
							<dw:groupboxend id="CategoryEnd" runat="server"></dw:groupboxend>
							<br>
							<dw:groupboxstart id="SettingsStart" title="Title" runat="server"></dw:groupboxstart>
							<table cellspacing="0" cellpadding="0" border="0" width="100%">
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td width="150">&nbsp;<dw:translatelabel id="HeadlineLabel" runat="server" Text="Headline"></dw:translatelabel>
									<td><asp:TextBox ID="txHeadline" MaxLength="100" CssClass="std" Runat="server"></asp:TextBox></td>
									<td><asp:RequiredFieldValidator ID="HeadlineValidator" ControlToValidate="txHeadline" ErrorMessage="- required field"
											Runat="server"></asp:RequiredFieldValidator>&nbsp;</td>
								</tr>
								<tr>
									<td width="150">&nbsp;<dw:translatelabel id="DescriptionLabel" runat="server" Text="Description"></dw:translatelabel></td>
									<td><asp:TextBox ID="txDescription" CssClass="std" MaxLength="255" Runat="server"></asp:TextBox></td>
									<td><asp:RequiredFieldValidator ID="DescriptionValidator" ControlToValidate="txDescription" ErrorMessage="- required filed"
											Runat="server"></asp:RequiredFieldValidator>&nbsp;</td>
								</tr>
								<tr>
									<td width="150">&nbsp;<dw:translatelabel id="DateLabel" runat="server" Text="Date"></dw:translatelabel></td>
									<td><%=Dates.DateSelect(_date, false, false, false, "dtDate")%></td>
								</tr>
								<tr>
									<td width="150">&nbsp;<dw:translatelabel id="PubDateLabel" runat="server" Text="Publication date"></dw:translatelabel></td>
									<td><%=Dates.DateSelect(_pubDate, false, false, false, "dtPubDate")%></td>
								</tr>
								<tr>
									<td width="150">&nbsp;<dw:translatelabel id="DraftLabel" runat="server" Text="This is a draft"></dw:translatelabel></td>
									<td><asp:CheckBox ID="chkDraft" Runat="server"></asp:CheckBox></td>
								</tr>
								<tr>
									<td>&nbsp;</td>
								</tr>
							</table>
							<dw:groupboxend id="SettingsEnd" runat="server"></dw:groupboxend>
							<br>
							<dw:groupboxstart id="TextStart" title="Text" runat="server"></dw:groupboxstart>
							<table cellspacing="0" cellpadding="0" border="0" width="100%">
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td align="center"><%=Gui.Editor("_Editor", 550, 300, _text)%></td>
								</tr>
								<tr>
									<td>&nbsp;</td>
								</tr>
							</table>
							<dw:groupboxend id="TextEnd" runat="server"></dw:groupboxend>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td align="right" valign="bottom">
							<table border="0" cellpadding="0" cellspacing="0">
								<tr>
									<td><input type="submit" name="btnSubmit" id="btnSubmit" class="ButtonSubmit" onclick="Send(); Validate(); if (ValidatorOnSubmit()) return true;"
											value="OK"></td>
									<td width="5">&nbsp;</td>
									<td><%=Gui.Button("Close", "location='Article_List.aspx?BlogID=" & _blogID & "&Page=-1'", 0)%></td>
									<td width="10">&nbsp;</td>
								</tr>
								<tr>
									<td colspan="3" height="5"></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
			<div id="Tab2" style="DISPLAY: none">
				<table border="0" cellpadding="0" cellspacing="0" class="tabTable" width="598">
					<tr>
						<td valign="top">
							<asp:Repeater ID="CommentList" Runat="server">
								<HeaderTemplate>
									<table border="0" cellpadding="0" width="598">
										<tr valign="top">
											<td colspan="4"><br>
											</td>
										</tr>
										<tr>
											<td align="left" width="200"><strong>&nbsp;<dw:translatelabel id="DraftLabel" runat="server" Text="Headline" /></strong></td>
											<td align="left" width="150"><strong><dw:translatelabel id="Translatelabel1" runat="server" Text="Author" /></strong></td>
											<td align="center" width="200"><strong><dw:translatelabel id="Translatelabel2" runat="server" Text="Creation date" /></strong></td>
											<td align="center"><strong><dw:translatelabel id="Translatelabel3" runat="server" Text="Delete" />&nbsp;</strong></td>
										</tr>
										<tr>
											<td colspan="4" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
										</tr>
								</HeaderTemplate>
								<ItemTemplate>
									<tr>
										<td align="left">&nbsp;<a href='Comment_Edit.aspx?CommentID=<%# DataBinder.Eval(Container.DataItem, "ID") %>&ArticleID=<%=_articleID%>&BlogID=<%=_blogID%>'><%# DataBinder.Eval(Container.DataItem, "Headline") %></a></td>
										<td align="left"><%# DataBinder.Eval(Container.DataItem, "Author") %></td>
										<td align="center"><%# DataBinder.Eval(Container.DataItem, "CreationDateMedium") %></td>
										<td align="center">
											<a runat="server" OnServerClick="OnCommentDelete" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID")%>' OnClick='return ConfirmCommentDelete(this);' ClientCommandArgument='<%# Server.HtmlDecode(DataBinder.Eval(Container.DataItem, "Headline"))%>'>
												<img src="/Admin/Images/Delete.gif" alt="Delete comment" border="0"></a>
										</td>
									</tr>
								</ItemTemplate>
								<SeparatorTemplate>
									<tr>
										<td colspan="4" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
									</tr>
								</SeparatorTemplate>
							</asp:Repeater>
						</td>
					</tr>
					<tr>
						<td valign="top">
							&nbsp;<dw:translatelabel id="CommentNotFound" runat="server" Text="No comments found."></dw:translatelabel>
						</td>
					</tr>
				</table>
				</TD></TR><tr>
					<td valign="bottom" colspan="4" align="left">
						<table border="0" cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td><asp:Literal ID="PagesComments" Runat="server"></asp:Literal></td>
							</tr>
							<tr>
								<td colspan="4" height="5"></td>
							</tr>
						</table>
					</td>
				</tr>
			</div>
		</form>
		<%=Gui.SelectTab()%>
<% 
	Translate.GetEditOnlineScript()
%>
	</body>
</HTML>
