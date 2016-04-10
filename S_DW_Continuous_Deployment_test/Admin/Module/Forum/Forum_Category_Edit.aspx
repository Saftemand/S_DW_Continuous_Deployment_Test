<%@ Page CodeBehind="Forum_Category_Edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Forum_Category_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
Dim strForumActive As Object
Dim strForumCategoryDescription As String
Dim strCategoryID As Object
Dim strForumName As String

strCategoryID = "0"
strForumName = ""
strForumActive = True

If Not IsNothing(Request.QueryString.GetValues("categoryid")) And IsNumeric(Request.QueryString.Item("categoryid")) Then
	strCategoryID = Request.QueryString.Item("categoryid")
	
	Dim cnCategory			As IDbConnection	= Database.CreateConnection("Forum.mdb")
	Dim cmdCategory			As IDbCommand		= cnCategory.CreateCommand
	cmdCategory.CommandText = "SELECT * FROM ForumCategory WHERE ForumCategoryID=" & strCategoryID
	Dim drCategory			As IDataReader		= cmdCategory.ExecuteReader()	
	
	If drCategory.Read() Then
		strForumName = drCategory("ForumCategoryName").ToString
		strForumActive = drCategory("ForumCategoryActive").ToString
		strForumCategoryDescription = drCategory("ForumCategoryDescription").ToString
	End If
	
	drCategory.Close()
	drCategory.Dispose()
	cmdCategory.Dispose()
	cnCategory.Dispose()
	
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
			if (document.getElementById('frmCategory').ForumCategoryName.value == "") {
				alert('<%=Translate.JSTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>');
				document.getElementById('frmCategory').ForumCategoryName.focus();
			}
			else {
				document.getElementById('frmCategory').submit();
			}
		}
		//-->
	</SCRIPT>
	<BODY>
	<%=Gui.MakeHeaders(Translate.Translate("%m% - Rediger %c%", "%m%", Translate.Translate("Forum",9),"%c%",Translate.Translate("kategori")), Translate.Translate("Kategori"), "all")%>
	<TABLE border="0" cellpadding="0" cellspacing="0" class="TabTable">
		<FORM method="post" action="forum_category_save.aspx?categoryid=<%=strCategoryID%>" name="frmCategory" id="frmCategory">
		<tr>
			<td valign="top"><br />
				<div ID="Tab1" STYLE="display:;">
					<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
					<TABLE border="0" cellpadding="2" cellspacing="0" >
						<TR>
							<TD width="170"><%=Translate.Translate("Navn")%></TD>
							<TD><INPUT type="text" maxlength="250" name="ForumCategoryName" value="<%=Server.HtmlEncode(strForumName)%>" id="ForumCategoryName" class="std"></TD>
						</TR>
						
						<TR>
							<TD valign="top"><%=Translate.Translate("Beskrivelse")%></TD>
							<TD><TEXTAREA name="ForumCategoryDescription" rows="5" id="ForumCategoryDescription" class="std"><%=Server.HtmlEncode(strForumCategoryDescription)%></TEXTAREA></TD>
						</TR>
						<TR>
							<TD><%=Translate.Translate("Medtag")%></TD>
							<TD><INPUT type="CheckBox" maxlength="250" name="ForumCategoryActive" value="True" <%=Base.IIf(strForumActive = True, "checked", "")%> id="ForumCategoryActive"></TD>
						</TR>
					</TABLE>
					<%=Gui.GroupBoxEnd%>
				</div>
			</TD>
		</TR>
		<TR>
		<TR>
			<td align="right" valign="bottom">
				<%=Gui.MakeOkCancelHelp("CheckForm()", "javascript:history.back(1)", True, "modules.forum.general.list.edit", "forum")%>
			</td>
		</tr>

		</FORM>
	</table>
	<BODY>
</HTML>
<%
	Translate.GetEditOnlineScript()
%>