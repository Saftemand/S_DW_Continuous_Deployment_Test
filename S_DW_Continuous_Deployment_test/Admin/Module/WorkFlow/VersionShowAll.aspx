<%@ Page Language="vb" AutoEventWireup="false" Codebehind="VersionShowAll.aspx.vb" Inherits="Dynamicweb.Admin.VersionShowAll" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
  <head>
    <title>VersionCompare</title>
    <LINK rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
  </head>

<%=Gui.MakeHeaders(strTitleString, Translate.Translate("Versioner"), "all")%>

<table border="0" cellpadding="0" cellspacing="0" class="TabTable">
	<tr>
		<td valign="top"><br>
			<DIV id="Tab1" style="Display:;">
				<BR>
				<table border="0" cellpadding="0" width="100%">
					<tr>
						<td colspan=2>
							<%=Gui.GroupBoxStart(Translate.Translate("Versioner"))%>
							<table cellpadding=2 cellspacing=0 width="100%" ID="Table1">
								<tr valign="top">
									<td>
										<%= Gui.ShowVersionsNew(ObjectDatabase, ObjectTableName, ObjectFieldName, ObjectID, ObjectShowTextField, ObjectApprovalType, ObjectOrigFieldName, True) %>
									</td>
								</tr>
								<tr valign="top">
									<td>&nbsp;
									</td>
								</tr>
							</table>
							<%=Gui.GroupBoxEnd%>
						</td>
					</tr>
				</TABLE>
			</DIV>
		</td>
	</tr>

  </body>
</html>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>