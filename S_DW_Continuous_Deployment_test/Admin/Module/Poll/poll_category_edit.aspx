<%@ Page CodeBehind="poll_category_edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.poll_category_edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<%

'**************************************************************************************************
'	Current version:	1.0.0
'	Created:			29-07-2002
'	Last modfied:		29-07-2002
'
'	Purpose: Edit categories of poll
'
'	Revision history:
'		1.0.0 - 29-07-2002
'		First version.
'
'		1.1.0 - 02-06-2004 - David Frandsen
'		Converted to .NET
'**************************************************************************************************
Dim intCategoryID As Integer
Dim strPollName As String

intCategoryID = 0
strPollName = ""

If Not IsNothing(Request.QueryString.GetValues("categoryid")) Then
	intCategoryID = Request.QueryString.Item("categoryid")
	
	Dim cnQuestion As System.Data.IDbConnection = Database.CreateConnection("Poll.mdb")
	Dim cmdQuestionSelect As IDbCommand = cnQuestion.CreateCommand
	cmdQuestionSelect.CommandText = "SELECT * FROM PollCategory WHERE PollCategoryID=" & intCategoryID
	Dim drQuestion as IDataReader = cmdQuestionSelect.ExecuteReader()

	If drQuestion.Read() Then
		strPollName = drQuestion("PollCategoryName").ToString
	End If
	drQuestion.Close()
	drQuestion.Dispose()
	cmdQuestionSelect.Dispose()
	cnQuestion.Dispose()
	
End If

%>
<HTML>
	<HEAD>
		<TITLE></TITLE>
		<LINK rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	</HEAD>
	<SCRIPT LANGUAGE="javascript">
		<!--
		function CheckForm() {
			if (document.getElementById('frmCategory').PollCategoryName.value == "") {
			alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>');
				document.getElementById('frmCategory').PollCategoryName.focus();
			}
			else if (document.getElementById('frmCategory').PollCategoryName.value.length > 100) {
				alert("<%=Translate.JSTranslate("Max %% tegn i: ","%%","100")%><%=Translate.JSTranslate("Navn")%>");
				document.getElementById('frmCategory').PollCategoryName.focus();
			}
			else {
				document.getElementById('frmCategory').submit();
			}
		}
		//-->
	</SCRIPT>
	<BODY>
	<%=Gui.MakeHeaders(Translate.Translate("%m% - Rediger %c%", "%m%", Translate.Translate("Afstemning",9),"%c%",Translate.Translate("kategori")), Translate.Translate("Kategori"), "all")%>
	<table border="0" cellpadding="0" cellspacing="0" class="TabTable" style="height:180px;">
		<form method="post" action="poll_category_save.aspx?categoryid=<%=intCategoryID%>" name="frmCategory" id="frmCategory">
		<tr>
			<td valign="top"><br />
				<div ID="Tab1" STYLE="display:;">
				<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
					<table border="0" cellpadding="0" cellspacing="0">
						<TR>
							<TD width="170"><%=Translate.Translate("Navn")%></TD>
							<TD><INPUT type="text" maxlength="250" name="PollCategoryName" value="<%=strPollName%>" id="PollCategoryName" class="std"></TD>
						</TR>
					</TABLE>
				<%=Gui.GroupBoxend%>
				</div>
			</TD>
		</TR>
		<TR>
			<td align="right" valign="bottom">
				<%=Gui.MakeOkCancelHelp("CheckForm()", "javascript:history.back(1)", True, "modules.poll.general.list.edit", "poll")%>
			</td>
		</tr>
		</form>
	</table>
	<BODY>
</HTML>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>