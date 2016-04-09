<%@ Register TagPrefix="cc1" Namespace="Dynamicweb.ScheduledTask" Assembly="Dynamicweb" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ClassBrowser.aspx.vb" Inherits="Dynamicweb.Admin.ScheduledTask_cpl.ClassBrowser" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Class Browser</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
		<script lang="jscript" src="ClassBrowser.js"></script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="TheForm" method="post" runat="server">
			<table width="100%">
				<tr>
					<td valign="top">
						<fieldset style="WIDTH:370px">
							<dw:TranslateLabel id="LibraryLabel" runat="server" Text="Load user library:"></dw:TranslateLabel><br>
							<dw:FileManager id="CustomLibrary" runat="server"></dw:FileManager>&nbsp;&nbsp;<asp:Button id="BtnLoad" runat="server" CssClass="buttonSubmit"></asp:Button><br>
							<asp:CustomValidator id="LibraryValidator" runat="server" OnServerValidate="ValidateFile" Display="Dynamic">
							    <dw:TranslateLabel ID="dwTransError" runat="server" Text="File doesn't exist or is not a .NET assembly" />	
							</asp:CustomValidator>
						</fieldset>
						<br>
						<br>
						<cc1:ClassTreeCtrl id="Tree" runat="server"></cc1:ClassTreeCtrl>
					</td>
					<td width="40" valign="top">
						<fieldset title="Legend"><legend><dw:TranslateLabel ID="dwTransLegend" runat="Server" Text="Legend" /></legend>
							<table>
								<tr>
									<td width="20">
										<img src="/Admin/Images/Scheduler/Assembly.gif" alt="Assembly">
									</td>
									<td><dw:TranslateLabel ID="dwTransAssembly" runat="server" Text="Assembly" /></td>
								</tr>
								<tr>
									<td>
										<img src="/Admin/Images/Scheduler/Namespace.gif" alt="Namespace">
									</td>
									<td><dw:TranslateLabel ID="dwTransNamespace" runat="server" Text="Namespace" /></td>
								</tr>
								<tr>
									<td>
										<img src="/Admin/Images/Scheduler/Class.gif" alt="Class">
									</td>
									<td><dw:TranslateLabel ID="dwTransClass" runat="server" Text="Class" /></td>
								</tr>
								<tr>
									<td>
										<img src="/Admin/Images/Scheduler/Method.gif" alt="Method">
									</td>
									<td><dw:TranslateLabel ID="dwTransMethod" runat="server" Text="Method" /></td>
								</tr>
								<tr>
									<td>
										<img src="/Admin/Images/Scheduler/MethodStatic.gif" alt="Static Method">
									</td>
									<td><dw:TranslateLabel ID="dwTransStaticMethod" runat="server" Text="Static method" /></td>
								</tr>
							</table>
						</fieldset>
					</td>
				</tr>
			</table>
		</form>
		<%  Translate.GetEditOnlineScript()%>
	</body>
</HTML>
