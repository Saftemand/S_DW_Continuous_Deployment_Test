<%@ Page Language="vb" AutoEventWireup="false"%>
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
	if (confirm('<%=Translate.Translate("Slet %%?", "%%", Translate.JSTranslate("orientering"))%>\n(' + strName + ')')){
		location = "Media_Orientation_Delete.aspx?ID=" + ID;
	}
}
</script>

</HEAD>
<%= Gui.MakeHeaders(Translate.Translate("Orientering"), Translate.Translate("Orientering"), "all")%>
<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
	<tr>
		<td valign="top">
			<div id="Tab1" style="width:598;">
			<table border="0" cellpadding="0" width="598">
			<%
			Dim connMedia As IDbConnection = Database.CreateConnection("DWMedia.mdb")
			Dim cmdMedia As IDbCommand = connMedia.CreateCommand

			sql = "SELECT * FROM MediaDBOrientation ORDER BY MediaDBOrientationMinratio"
			
			cmdMedia.CommandText = SQL

			Dim drOrientationReader As IDataReader = cmdMedia.ExecuteReader
			%>
				<tr>
					<td><strong><%=Translate.Translate("Navn")%></strong></td>
					<td width=100 align="right"><strong><%=Translate.Translate("Min. ratio")%></strong></td>
					<td width=100 align="right"><strong><%=Translate.Translate("Maks. ratio")%></strong></td>
					<td width=50 align="right"><strong><%=Translate.Translate("Slet")%></strong></td>
				</tr>
				<tr>
					<td colspan="4" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
			    </tr>
			<%
			Do While drOrientationReader.Read 'Then we list the orientations
			%>
				<tr height=20>
					<td><a href="Media_Orientation_Edit.aspx?ID=<%=drOrientationReader("MediaDBOrientationID")%>"><%=drOrientationReader("MediaDBOrientationName")%></a></td>
					<td align="right"><%=drOrientationReader("MediaDBOrientationMinratio")%></td>
					<td align="right"><%=drOrientationReader("MediaDBOrientationMaxratio")%></td>
					<td align="right"><a href="JavaScript:del(<%=drOrientationReader("MediaDBOrientationID")%>, '<%=Base.JSEnable(drOrientationReader("MediaDBOrientationName"))%>')"><img src="../../images/Delete.gif" border="0"></a></td>
				</tr>
				<tr>
					<td colspan="4" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
			    </tr>
			<%	
			Loop 
			%>
			</table>
			</div>
		</td>
	</tr>
	<tr>
		<td align=right valign=bottom>
			<table>
				<tr>
					<td>
					<%=Gui.Button(Translate.JSTranslate("Ny orientering"), "location='Media_Orientation_edit.aspx';", 0)%>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</BODY>
</HTML>
<%
Translate.GetEditOnlineScript()
%>
