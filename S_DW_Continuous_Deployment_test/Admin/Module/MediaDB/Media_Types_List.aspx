<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>



<%
Dim sql As String
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
<TITLE></TITLE>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<script language="JavaScript">
function del(ID,  strName){
	if (confirm('<%=Translate.Translate("Slet %%?", "%%", Translate.JSTranslate("medietype"))%>\n(' + strName + ')')){
		location = "Media_Types_Delete.aspx?ID=" + ID;
	}
}
</script>

</HEAD>
<%= Gui.MakeHeaders(Translate.Translate("Medietyper"), Translate.Translate("Medietyper"), "all")%>
<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
	<tr>
		<td valign="top">
			<div id="Tab1" style="width:598;">
			<table border="0" cellpadding="0" width="598">
			<%
			Dim MediaConn As IDbConnection = Database.CreateConnection("DWMedia.mdb")
			Dim cmdMedia As IDbCommand = MediaConn.CreateCommand

			sql = "SELECT * FROM MediaDBFiletypes ORDER BY MediaDBFiletypesName"
			cmdMedia.CommandText = SQL
			Dim drFiletypeReader As IDataReader = cmdMedia.ExecuteReader

			Dim opMediaDBFiletypesID As Integer = drFiletypeReader.getordinal("MediaDBFiletypesID")
			Dim opMediaDBFiletypesName As Integer = drFiletypeReader.getordinal("MediaDBFiletypesName")
			Dim opMediaDBFiletypesExtensions As Integer = drFiletypeReader.getordinal("MediaDBFiletypesExtensions")
			
			%>
				<tr>
					<td width=150><strong><%=Translate.Translate("Navn")%></strong></td>
					<td><strong><%=Translate.Translate("Filtyper")%></strong></td>
					<td width=50 align="right"><strong><%=Translate.Translate("Slet")%></strong></td>
				</tr>
				<tr>
					<td colspan="5" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
			    </tr>

			<%
			Do While drFiletypeReader.Read  'Then we list the types
				%>
				<tr height=20>
					<td><a href="Media_Types_Edit.aspx?ID=<%=drFiletypeReader(opMediaDBFiletypesID)%>"><%=drFiletypeReader(opMediaDBFiletypesName)%></a></td>
					<td><%=drFiletypeReader(opMediaDBFiletypesExtensions)%></td>
					<td align="right"><a href="JavaScript:del(<%=drFiletypeReader(opMediaDBFiletypesID)%>, '<%=Base.JSEnable(drFiletypeReader(opMediaDBFiletypesName))%>')"><img src="../../images/Delete.gif" border="0"></a></td>
				</tr>
				<tr>
					<td colspan="5" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
			    </tr>
				<%	
			Loop 
			
			drFiletypeReader.Dispose
			MediaConn.Dispose			
			%>
			</table>
			</div>
		</td>
	</tr>
	<tr>
		<td align="right" valign="bottom">
			<table>
				<tr>
					<td>
					<%=Gui.Button(Translate.JSTranslate("Ny medietype"), "location='Media_types_edit.aspx';", 0)%>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</HTML>
<%
Translate.GetEditOnlineScript()
%>
