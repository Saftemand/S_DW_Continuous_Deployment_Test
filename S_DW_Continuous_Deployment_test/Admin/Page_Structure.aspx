<%@ Page ValidateRequest="false" codebehind="Page_Structure.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Page_Structure" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<HTML>
	<HEAD>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
		<TITLE></TITLE>
		<link rel="STYLESHEET" type="text/css" href="Stylesheet.css">
		
		<script>
		function Send(FileToHandle){
			document.getElementById('PageStructureForm').submit();
		}
		
		function ApproveStruct() {
			document.getElementById('PageStructureForm').submit();
		}
		</script>
		
		<style>
		.dtree 					{white-space: nowrap;}
		.dtree img 				{border: 0px; vertical-align: middle;}
		.dtree a 				{text-decoration: none;}
		.dtree a.node			{white-space: nowrap;}
		.dtree a.nodeSel 		{white-space: nowrap;}
		.dtree a.node:hover		{text-decoration: none;}
		.dtree a.nodeSel:hover	{text-decoration: none;} 
		.dtree a.nodeSel 		{white-space: nowrap;}
		.dtree .clip 			{overflow: hidden;}
		</style>
		
	</HEAD>
	<BODY rightmargin="0">
		<span id="bodyheight">
		<form method="post" name="PageStructureForm" id="PageStructureForm">
		<input type=hidden name=PageStructCMD value=1>
		<%If PageStructCMD = 1 Then%>
			<%=Gui.MakeHeaders(Translate.Translate("Opret %% - %s%", "%%", Translate.Translate("sidestruktur"), "%s%", Translate.Translate("Preview")), Translate.Translate("Indstillinger"), "all")%>
		<%Else If PageStructCMD = 2 Then%>
			<%=Gui.MakeHeaders(Translate.Translate("Opret %% - %s%", "%%", Translate.Translate("sidestruktur"), "%s%", Translate.Translate("Luk")), Translate.Translate("Indstillinger"), "all")%>
		<%Else%>
			<%=Gui.MakeHeaders(Translate.Translate("Opret %%", "%%", Translate.Translate("sidestruktur")), Translate.Translate("Indstillinger"), "all")%>
		<%End If%>
		<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
		<tr>
		<td valign=top>
			<div ID="Tab1" STYLE="display:; width:598;">
			<br>
			<asp:Literal id="StructureBox" runat="server"></asp:Literal>
			</div>
		</td>
		</tr>
		<tr>
			<td align=right valign=bottom id=functionsbutton>
				<table>
				<tr>
				<%If PageStructCMD = 0 Then%>
				    <td>
				    <%
				        If CanCreateLightVersionPages Then
				            Response.Write(Gui.Button(Translate.Translate("Preview"), "Send('Page_Structure.aspx" & Base.IIf(Not IsNothing(Request.QueryString.GetValues("source")), "?source=" & Request.QueryString.Item("source"), "") & "');", 0))
				        Else
				            Response.Write(Gui.Button(Translate.Translate("Preview"), "Send('GoFish.aspx');", 0, True))
				        End If
				    %>
				    </td>
					<td><%=Gui.Button(Translate.Translate("Annuller"), "document.location.href='/Admin/MyPage/Default.aspx';", 0)%></td>
				<%Else If PageStructCMD = 1 Then%>
					<%If errCode = "" And ContinuePaging Then%>
					<td><%=Gui.Button(Translate.Translate("Opret"), "ApproveStruct();", 0)%></td>					
					<%End If%>
					<td><%=Gui.Button(Translate.Translate("Tilbage"), "history.back();", 0)%></td>
				<%Else If PageStructCMD = 2 Then%>
					<td><%=Gui.Button(Translate.Translate("Afslut"), "document.location.href='MyPage/default.aspx';", 0)%></td>					
				<%End If%>
				<%=Gui.HelpButton("", "page.structure")%>
				</tr>
				</table>
			</td>
		</tr>
		</table>
		</form>
		</span>
	</BODY>
</HTML>
<%
Translate.GetEditOnlineScript()
%>
