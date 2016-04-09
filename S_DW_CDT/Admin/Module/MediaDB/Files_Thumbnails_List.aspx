<%@ Page Language="vb" AutoEventWireup="false" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
Dim intTest As Integer
Dim sql As String
Dim OptionNames() As String

%>
<HTML>
<HEAD>
	<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
	<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	<script language="JavaScript">
	function del(ID, strName){
		if(confirm('<%=Translate.Translate("Slet %%?", "%%", Translate.JSTranslate("miniature"))%>\n(' + strName + ')')){
			location = "Files_Thumbnails_Delete.aspx?ID=" + ID;
		}
	}
	</script>
</HEAD>
<%= Gui.MakeHeaders(Translate.Translate("Thumbnails"), Translate.Translate("Thumbnails"), "all")%>
<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
	<tr>
		<td valign="top">
			<div id="Tab1" style="width:598;">
			<table border="0" cellpadding="0" width="598">
			<%
			OptionNames = New String(){Translate.Translate("Max bredde og højde"), Translate.Translate("Samme bredde"), Translate.Translate("Samme højde"), Translate.Translate("Stræk")}

			Dim MediaConn As IDbConnection = Database.CreateConnection("DWMedia.mdb")
			Dim cmdMedia As IDbCommand = MediaConn.CreateCommand

			sql = "SELECT * FROM MediaDBThumbnails"
			cmdMedia.CommandText = SQL
			Dim drThumbnailsReader As IDataReader = cmdMedia.ExecuteReader
			%>
				<tr>
					<td><strong><%=Translate.Translate("Navn")%></strong></td>
					<td width=150><strong><%=Translate.Translate("Type")%></strong></td>
					<td width=100 align="right"><strong><%=Translate.Translate("Størrelse")%></strong></td>
					<td width=70 align="right"><strong><%=Translate.Translate("Kvalitet")%></strong></td>
					<td width=50 align="right"><strong><%=Translate.Translate("Slet")%></strong></td>
				</tr>
				<tr>
					<td colspan="5" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
			    </tr>
			<%
			Do While drThumbnailsReader.Read 
				%>
				<tr height=20>
					<td><a href="Files_Thumbnails_Edit.aspx?ID=<%=drThumbnailsReader("MediaDBThumbnailsID")%>"><%=drThumbnailsReader("MediaDBThumbnailsName")%></a></td>
					<td><%=OptionNames(drThumbnailsReader("MediaDBThumbnailsResizePatern") - 1)%></td>
					<td align="right"><%=drThumbnailsReader("MediaDBThumbnailsMaxwidth")%> x <%=drThumbnailsReader("MediaDBThumbnailsMaxheight")%> <%=Translate.Translate("px")%></td>
					<td align="right"><%=drThumbnailsReader("MediaDBThumbnailsQuality")%></td>
					<td align="right"><a href="JavaScript:del(<%=drThumbnailsReader("MediaDBThumbnailsID")%>, '<%=Base.JSEnable(drThumbnailsReader("MediaDBThumbnailsName"))%>')"><img src="../../images/Delete.gif" border="0"></a></td>
				</tr>
				<tr>
					<td colspan="5" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
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
					<%=Gui.Button(Translate.JSTranslate("Ny thumbnail"), "location='Files_Thumbnails_edit.aspx';", 0)%>
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
