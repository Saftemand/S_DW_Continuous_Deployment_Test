<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Menu.aspx.vb" Inherits="Dynamicweb.Admin.ForumV2.Menu" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<HTML>
  <HEAD>
		<TITLE> <%=Translate.JsTranslate("ForumV2")%>
		</TITLE>
		<meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		<script type="text/javascript" src="Menu.js"></script>
</HEAD>
	<body style="MARGIN: 0px; BACKGROUND-COLOR: #ece9d8">
		<table cellspacing="0" cellpadding="0" border="0" height="96%" width="100%" ID="MenuTable">
			<tr>
				<td width="0" bgColor="#ece9d8" rowspan="2" nowrap></td>
				<td valign="top" style="WIDTH:200px" nowrap>
					<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
						<tr height="23" bgColor="#ece9d8" ID="TreeStart">
							<td>&nbsp;<strong><%=Translate.Translate("Kategorier")%></strong></td>
						</tr>
						<tr bgColor="#aca899" height="1">
							<td></td>
						</tr>
						<tr>
							<td>
								<iframe width="100%" height="100%" name="ForumV2Category" bordercolor="#ece9d8" frameborder="0"
									src="Category_List.aspx" marginheight="0" marginwidth="0"></iframe>
							</td>
						</tr>
					</table>
				</td>
				<td width="5" bgColor="#ece9d8" rowspan="2" nowrap></td>
				<td valign="top" nowrap>
					<table height="100%" cellSpacing="0" cellPadding="0" width="100%" border="0">
						<tr bgColor="#ece9d8" height="50">
							<td valign="top" align="left">
								<iframe width="100%" height="60" name="ForumV2Panel" src="Panel.aspx" frameborder="0" noresize scrolling="no" marginheight="0" marginwidth="0"></iframe>
							</td>
						</tr>
						<tr bgColor="#ece9d8" height="4">
							<td background="/Admin/images/SpacerBG.gif"></td>
						</tr>
						<tr>
							<td valign="top" align="left">
								<table cellspacing="0" cellpadding="0" border="0"  width="100%" height="100%">
									<tr>
										<td>
											<iframe width="100%" height="100%" name="ForumV2Main" id="ForumV2Main" frameborder="0" bordercolor="#ece9d8"
												src="" marginheight="0" marginwidth="0"></iframe>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</TD>
			</TR>
			<tr>
				<td colspan="4" valign="bottom" style="height: 36px">
					<table cellSpacing="0" cellPadding="0" width="100%" height="100%" border="0">
						<tr>
							<td style="WIDTH:205px;"></td>
							<td valign="bottom" align="left" style="WIDTH:130px;">
								<input type="text" id="SearchField" name="SearchField" onkeypress="return IsEnter(event);" size="15" style="BORDER-RIGHT: #666666 1px solid; BORDER-TOP: #666666 1px solid; FONT-SIZE: 11px; Z-INDEX: 10; BORDER-LEFT: #666666 1px solid; WIDTH: 130px; COLOR: #333333; BORDER-BOTTOM: #666666 1px solid; FONT-FAMILY: Verdana, Helvetica, Arial, Tahoma, Verdana, Arial; BACKGROUND-COLOR: #f4f4f4">
							</td>
							<td valign="bottom" align="left">
								&nbsp;<input type="button" id="quickSearch" class="buttonSubmit" onclick="QuickSearch();" value="<%=Translate.Translate("Søg")%>"> 
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</TABLE>
	</body>
</HTML>
<%
	Translate.GetEditOnlineScript()
%>