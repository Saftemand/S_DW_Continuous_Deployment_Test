<%@ Page CodeBehind="NewsletterExtended_cpl.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_cpl" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%

Dim NLTimeout As String
Dim NLShowAllOnList As String
Dim NLRowNumbers As String
Dim NLsmtpserver As Object
Dim NLAllwaysSearchInAllCategories As String
Dim NLShowAllUsersCategory As String
Dim NLDropbox_Path As String
Dim NLCDOPort As String
Dim NLSMTPport As String


If NLSMTPport = "" Then
	NLSMTPport = "25"
End If

If NLCDOPort = "" Then
	NLCDOPort = "2"
End If

If NLTimeout = "" Then
	NLTimeout = "60"
End If

If NLDropbox_Path = "" Then
	NLDropbox_Path = "C:\Inetpub\mailroot\Pickup\"
End If

If NLRowNumbers = "" Then
	NLRowNumbers = "20"
End If

%>
<TABLE border="0" cellpadding="5" cellspacing="0" width="95%">
	<TR>
		<TD></TD>
		<TD height="50" width="38"><IMG src="../images/Icons/Module_NewsletterExtended.gif"></TD>
	</TR>
</TABLE>
<%If Session("DW_Admin_UserType") < 4 Then%>
<%=Gui.GroupBoxStart(Translate.Translate("Mailserver"))%>
	<TABLE border="0" cellpadding="0" cellspacing="0">
		<TR>
			<TD width="150"><%=Translate.Translate("Udgående SMTP server")%></TD>
			<TD><%=Translate.Translate("Vælges under fanebladet Indstillinger")%></TD>
		</TR>
		<TR>
			<TD width="150"><%=Translate.Translate("SMTP port")%></TD>
			<TD><INPUT type="text" name="NLSMTPport" id="NLSMTPport" value="<%=NLSMTPport%>" class="std"></TD>
		</TR>
		<TR>
			<TD width="150"><%=Translate.Translate("CDO Port")%></TD>
			<TD><INPUT type="text" name="NLCDOPort" id="NLCDOPort" value="<%=NLCDOPort%>" class="std"></TD>
		</TR>
		<TR>
			<TD width="150"><%=Translate.Translate("Timeout")%></TD>
			<TD><INPUT type="text" name="NLTimeout" id="NLTimeout" value="<%=NLTimeout%>" class="std"></TD>
		</TR>
	</TABLE>
<%=Gui.GroupBoxEnd%>
<%=Gui.GroupBoxStart(Translate.Translate("Dropbox/Pickup"))%>
	<TABLE border="0" cellpadding="0" cellspacing="0">
		<TR>
			<TD width="150"><%=Translate.Translate("Sti til folder")%></TD>
			<TD><INPUT type="text" name="NLDropbox_Path" id="NLDropbox_Path" value="<%=NLDropbox_Path%>" class="std"></TD>
		</TR>
	</TABLE>
<%=Gui.GroupBoxEnd%>
<%=Gui.GroupBoxStart(Translate.Translate("Lister"))%>
	<TABLE border="0" cellpadding="0" cellspacing="0">
		<TR>
			<TD width="150"><%=Translate.Translate("Antal rækker i lister")%></TD>
			<TD><INPUT type="text" name="NLRowNumbers" id="NLRowNumbers" value="<%=NLRowNumbers%>" class="std"></TD>
		</TR>
		<TR>
			<TD FOR="NLShowAllOnList" width="150"><%=Translate.Translate("Vis alle rækker i lister")%></TD>
			<TD><INPUT type="Gui.CheckBox" name="NLShowAllOnList" id="NLShowAllOnList" value="1" <%
			If NLShowAllOnList = "1" Then
				Response.Write("CHECKED")
			End If
			%>
		</TR>		
		<TR>
			<TD FOR="NLAllwaysSearchInAllCategories" width="150"><%=Translate.Translate("Søg i alle lister")%></TD>
			<TD><INPUT type="Gui.CheckBox" name="NLAllwaysSearchInAllCategories" id="NLAllwaysSearchInAllCategories" value="1" <%	
			If NLAllwaysSearchInAllCategories = "1" Then
				Response.Write("CHECKED")
			End If 
			%>
	
		</TR>		
		<TR>
			<TD FOR="NLShowAllUsersCategory" width="150"><%=Translate.Translate("Vis ´Alle bruger´ listen")%></TD>
			<TD><INPUT type="Gui.CheckBox" name="NLShowAllUsersCategory" id="NLShowAllUsersCategory" value="1" <%
			If NLShowAllUsersCategory = "1" Then
				Response.Write("CHECKED")
			End If 
			%>
	
		</TR>		
	</TABLE>
<%=Gui.GroupBoxEnd%>
<%Else%>
	<INPUT type="hidden" name="NLRowNumbers" id="NLRowNumbers" value="<%=NLRowNumbers%>">
	<INPUT type="hidden" name="NLDropbox_Path" id="NLDropbox_Path" value="<%=NLDropbox_Path%>">
	<INPUT type="hidden" name="NLTimeout" id="NLTimeout" value="<%=NLTimeout%>">
	<INPUT type="hidden" name="NLCDOPort" id="NLCDOPort" value="<%=NLCDOPort%>">
	<INPUT type="hidden" name="NLSMTPport" id="NLSMTPport" value="<%=NLSMTPport%>">
	<INPUT type="hidden" name="NLsmtpserver" id="NLsmtpserver" value="<%=NLsmtpserver%>">
<%End If%>
<%
Translate.GetEditOnlineScript()
%>
