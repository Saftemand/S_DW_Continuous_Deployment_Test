<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<%
Dim sql As String
Dim DW_MEDIA_MAX_CUSTOMFIELDS As Integer
Dim i As Integer
Dim ID As Integer
Dim blnHasRows As Boolean

DW_MEDIA_MAX_CUSTOMFIELDS = 100

'**************************************************************************************************
'	Current version:	1.0
'	Created:			23-09-2002
'	Last modfied:		23-09-2002
'
'	Purpose: List fields
'
'	Revision history:
'		1.0 - 23-09-2002 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************

If Not IsNothing(request.QueryString("ID")) Then
	ID = request.QueryString("ID")
Else
	ID = 0
End If
%>
<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
	<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	<script language="JavaScript">

	function del(ID, strName){
		if (confirm('<%=Translate.Translate("Slet %%?", "%%", Translate.JSTranslate("felt"))%>\n(' + strName + ')')){
			location='Media_Field_Delete.aspx?ID=' + ID;
		}
	}

	</script>
</HEAD>
<%=Gui.MakeHeaders(Translate.Translate("Felter"), Translate.Translate("Felter"), "all")%>
<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
	<tr>
		<td valign="top">
			<div id="Tab1" style="width:598;">
			<table border="0" cellpadding="0" width="598">
			<%
			Dim MediaConn As IDbConnection = Database.CreateConnection("DWMedia.mdb")
			Dim cmdMedia As IDbCommand = MediaConn.CreateCommand

			sql = "SELECT MediaDBField.*, MediaDBFieldType.MediaDBFieldTypeName FROM MediaDBFieldType RIGHT JOIN MediaDBField ON MediaDBFieldType.MediaDBFieldTypeID = MediaDBField.MediaDBFieldTypeID"
			cmdMedia.CommandText = SQL
			Dim drFieldTypeReader As IDataReader = cmdMedia.ExecuteReader

			Dim opMediaDBFieldLocked As Integer = drFieldTypeReader.getordinal("MediaDBFieldLocked")
			Dim opMediaDBFieldName As Integer = drFieldTypeReader.getordinal("MediaDBFieldName")
			Dim opMediaDBFieldTemplateName As Integer = drFieldTypeReader.getordinal("MediaDBFieldTemplateName")
			Dim opMediaDBFieldTypeName As Integer = drFieldTypeReader.getordinal("MediaDBFieldTypeName")
			Dim opMediaDBFieldID As Integer = drFieldTypeReader.getordinal("MediaDBFieldID")

			i = 0
			
			blnHasRows = False
			
			Do While drFieldTypeReader.Read 'Then we list the fields
				If Not blnHasRows 'first iteration
				%>
					<tr>
						<td><img src="/Admin/images/Nothing.gif" width="15" height="1" alt="" border="0"> <strong><%=Translate.Translate("Feltnavn")%></strong></td>
						<td width="150"><strong><%=Translate.Translate("Templatetag")%></strong></td>
						<td width="150"><strong><%=Translate.Translate("Felttype")%></strong></td>
						<td width=30 align="right"><strong><%=Translate.Translate("Slet")%></strong></td>
					</tr>
					<tr>
						<td colspan="4" bgcolor="#C4C4C4"><img src="/Admin/images/nothing.gif" width=1 height=1 alt="" border="0"></td>
					</tr>
				<%
				End If

				i = i + 1
				If drFieldTypeReader(opMediaDBFieldLocked) And Session("DW_Admin_UserID") > 2 Then
					%>
					<TR>
						<td><img src="/Admin/images/icons/Module_Form_small.gif" border="0" align=absmiddle>&nbsp;<%=drFieldTypeReader(opMediaDBFieldName)%></td>
						<td><%=drFieldTypeReader(opMediaDBFieldTemplateName)%></td>
						<td><%=drFieldTypeReader(opMediaDBFieldTypeName)%></td>
						<td align="center"></td>
					</TR>
				<%			
				Else
				%>
					<TR>
						<td><a href="Media_Field_Edit.aspx?ID=<%=drFieldTypeReader(opMediaDBFieldID)%>"><img src="/Admin/images/icons/Module_Form_small.gif" border="0" align=absmiddle>&nbsp;<%=drFieldTypeReader(opMediaDBFieldName)%></a></td>
						<td><%=drFieldTypeReader(opMediaDBFieldTemplateName)%></td>
						<td><%=Translate.Translate(drFieldTypeReader(opMediaDBFieldTypeName))%></td>
						<!--<td align="center"><a href="javascript:if(confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("felt"))%>')){location='Media_Field_Delete.aspx?ID=<%=drFieldTypeReader(opMediaDBFieldID)%>';}"><img src="../../images/Delete.gif" border="0" alt="<%=Translate.JSTranslate("Slet %%", "%%", Translate.JSTranslate("felt"))%>"></a></td>-->
						<td align="center"><a href="javascript:del(<%=drFieldTypeReader(opMediaDBFieldID)%>, '<%=drFieldTypeReader(opMediaDBFieldName)%>')"><img src="../../images/Delete.gif" border="0" alt="<%=Translate.JSTranslate("Slet %%", "%%", Translate.JSTranslate("felt"))%>"></a></td>
					</TR>
				<%
				End If
				%>
				<tr>
					<td colspan="4" bgcolor="#C4C4C4"><img src="/Admin/images/nothing.gif" width=1 height=1 alt="" border="0"></td>
				</tr>
				<%		
				blnHasRows = True
			Loop

			If Not blnHasRows Then
			%>
				<tr>
					<td><strong><br>&nbsp;<%=Translate.Translate("Ingen felter")%></strong></td>
				</tr>
			<%
			End If

			drFieldTypeReader.Dispose
			MediaConn.Dispose
			%>
			</TABLE>
			</div>
		</td>
	</tr>
	<%If Not CShort(i) >= DW_MEDIA_MAX_CUSTOMFIELDS Then%>
	<tr>
		<td align=right valign=bottom id=functionsbutton>
			<table>
				<tr>
					<td><%=Gui.Button(Translate.Translate("Nyt felt"), "location='Media_Field_edit.aspx';", 0)%></td>
				</tr>
			</table>
		</td>
	</tr>
	<%End If%>
</table>
</HTML>
<%
Translate.GetEditOnlineScript()
%>
