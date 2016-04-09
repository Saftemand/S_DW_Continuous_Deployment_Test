<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ActionLog.aspx.vb" Inherits="Dynamicweb.Admin.ActionLog" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		<title>ActionLog</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
        <style type="text/css">
            .dis
            {
                background-color: transparent;
                -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=40)";
                filter: alpha(opacity=40);
                -moz-opacity: 0.4;
                opacity: 0.4;
                color: Gray;
            }
        </style>

        <script type="text/javascript">
            function LoadEntity() {
                location = "/Admin/Module/ActionLog/ActionLog.aspx?entity=" + document.getElementById("EntityLister").value;
            }
        </script>
	</HEAD>
	<body>
	<%=Dynamicweb.Gui.MakeHeaders(Dynamicweb.backend.Translate.Translate("Actionlog",9), Dynamicweb.backend.Translate.Translate("Actionlog"), "Html", false, "")%>
	<table border="0" cellpadding="0" cellspacing="0" class="tabTable" width="100%">
		<tr>
			<td valign="top">
				<div ID="Tab1" STYLE="display:;">
					<form id="Form1" method="post" runat="server">
						<table width="100%">
							<tr>
								<td>
									<asp:dropdownlist id="EntityLister" runat="server" onchange="LoadEntity()"></asp:dropdownlist>
								</td>
							</tr>
							<tr>
								<td>
									<asp:literal id="ActionList" Runat="server"></asp:literal>
								</td>
							</tr>
						</table>
					</form>
				</div>
			</td>
		</tr>
	</table>
	</body>
	<% Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</HTML>
