<%@ Page CodeBehind="FAQ_Item_List.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.FAQ_Item_List" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
Dim i As Integer
Dim style As String
Dim span As String
Dim ActiveImage As String
Dim CategoryName As Object
Dim CategoryID As String
Dim sql As String

CategoryID = request.QueryString.Item("CategoryID")

Dim cn	As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
Dim cmd As IDbCommand		= cn.CreateCommand

If request.QueryString.Item("SetActiveInactive") = "Active" Then
	cmd.CommandText = "UPDATE FAQItem SET FAQItemActive = 0 WHERE FAQItemID=" & request.QueryString.Item("FAQID")
	cmd.ExecuteNonQuery()
ElseIf request.QueryString.Item("SetActiveInactive") = "Inactive" Then 
	cmd.CommandText = "UPDATE FAQItem SET FAQItemActive = 1 WHERE FAQItemID=" & request.QueryString.Item("FAQID")	
	cmd.ExecuteNonQuery()
End If

cmd.Dispose()
cn.Close()
cn.Dispose()

Dim cnFaq			As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
Dim cmdFaq			As IDbCommand		= cnFaq.CreateCommand
cmdFaq.CommandText = "SELECT FAQCategoryName FROM FAQCategory WHERE FAQCategoryID=" & CategoryID
Dim drFaqCategory	As IDataReader		= cmdFaq.ExecuteReader()

If drFaqCategory.Read() Then
	CategoryName = drFaqCategory("FAQCategoryName")
End If

drFaqCategory.Close()
cmdFaq.CommandText = "SELECT Count(FAQItemCategoryID) FROM [FAQItem] WHERE [FAQItemCategoryID]=" & CategoryID

Dim recordCount as Integer = 0
recordCount = cmdFaq.ExecuteScalar()



%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<script language="JavaScript">
function DeleteFAQ(FAQID, FAQName, CategoryID){
	if (confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("indlæg"))%>\n(' + FAQName + ')')){
		location = "FAQ_Item_Del.aspx?FAQID=" + FAQID + "&CategoryID=" + CategoryID;
	}
}
</script>
<title></title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<%=Gui.MakeHeaders(Translate.Translate("%m% kategori - %c%", "%m%", Translate.Translate("FAQ",9), "%c%", CategoryName), Translate.Translate("Indlæg",1), "all")
%>
<table border="0" cellpadding="0" cellspacing="0" class="TabTable">
	<tr>
		<td valign="top">
			<br>
			<div ID="Tab1" STYLE="display:;">
				<table border="0" cellpadding="0" width="598">
					<tr>
						<td width="270"><strong><%=Translate.Translate("Indlæg")%></strong></td>
						<td width="65" align="center"><strong><%=Translate.Translate("Sorter")%></strong></td>
						<td width="35"><strong><%=Translate.Translate("Aktiv")%></strong></td>
						<td width="73" align="center"><strong><%=Translate.Translate("Dato")%></strong></td>
						<td width="30" align="center"><strong><%=Translate.Translate("Slet")%></strong></td>		
					</tr><%

sql = " SELECT	* " & _
	  " FROM	FAQItem " & _
	  " WHERE	FAQItemCategoryID = " & CategoryID & _
	  " ORDER BY FAQItemSort"

cmdFaq.CommandText = sql
'Dim drFaq As IDataReader = cmdFaq.ExecuteReader()

Dim drFaqHasRows As Boolean = false

Dim ds As DataSet = New DataSet
Dim da As IDbDataAdapter = Database.CreateAdapter()
da.SelectCommand = cmdFaq
da.Fill(ds)

Dim drFaq As DataRow

'Dim drFaq	as IDataReader		= cmdSelect.ExecuteReader()
Dim x as integer = 0 
Do While x < ds.Tables(0).Rows.Count
		drFaq = ds.Tables(0).Rows(i)

		x = x + 1
	If Not drFaqHasRows Then drFaqHasRows = True
	i = i + 1
	span = "<span>"
	style = ""
	If drFaq("FAQItemActive") Then
		If Base.HasAccess("FAQEdit", "") Then
			ActiveImage = "<a href=""FAQ_Item_List.aspx?FAQID=" & drFaq("FAQItemID") & "&SetActiveInactive=Active&CategoryID=" & drFaq("FAQItemCategoryID") & """><img src=""../../images/Check.gif"" border=0></a>"
		Else
			ActiveImage = "<img src=""../../images/Check.gif"" border=0>"
		End If
	Else
		span = "<span style=""color:#C1C1C1;"">"
		style = " STYLE=""filter:progid:DXImageTransform.Microsoft.Alpha(opacity=30)progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);"""
		If Base.HasAccess("FAQEdit", "") Then
			ActiveImage = "<a href=""FAQ_Item_List.aspx?FAQID=" & drFaq("FAQItemID") & "&SetActiveInactive=Inactive&CategoryID=" & drFaq("FAQItemCategoryID") & """><img src=""../../images/Minus.gif"" border=0></a>"
		Else
			ActiveImage = "<img src=""../../images/Minus.gif"" border=0>"
		End If
	End If%>
				    <tr>
				      	<td colspan="6" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
				    </tr>
					<tr>
						<%If Base.HasAccess("FAQEdit", "") Then%>
							<td title="" OnClick="Javascript:self.location='FAQ_Item_Edit.aspx?CategoryID=<%=CategoryID%>&FAQID=<%=drFaq("FAQItemID")%>'"><a href="FAQ_Item_Edit.aspx?CategoryID=<%=CategoryID%>&FAQID=<%=drFaq("FAQItemID")%>"><%=span & drFaq("FAQItemQHeader")%></span></a></td>
						<%	Else%>
							<td><%=span & drFaq("FAQItemQHeader")%></span></td>
						<%	End If%>
						
						<%If i = 1 And i = recordCount Then%>
							<td align="center"></td>
						<%	ElseIf i = 1 Then %>
							<td align="center"><img src="../../images/nothing.gif" width="15" border="0"><a href="FAQ_Item_Sort.aspx?FAQItemID=<%=drFaq("FAQItemID")%>&CategoryID=<%=CategoryID%>&MoveDirection=down"><img src="../../images/pilned.gif" alt="<%=Translate.JsTranslate("Flyt ned")%>" border="0"<%=style%>></a></td>
						<%	ElseIf i = recordCount Then %>
							<td align="center"><a href="FAQ_Item_Sort.aspx?FAQItemID=<%=drFaq("FAQItemID")%>&CategoryID=<%=CategoryID%>&MoveDirection=up"><img src="../../images/pilop.gif" alt="<%=Translate.JsTranslate("Flyt op")%>" border="0"<%=style%>></a><img src="../../images/nothing.gif" width="15" border="0"></td>
						<%	Else%>
							<td align="center"><a href="FAQ_Item_Sort.aspx?FAQItemID=<%=drFaq("FAQItemID")%>&CategoryID=<%=CategoryID%>&MoveDirection=up"><img src="../../images/pilop.gif" alt="<%=Translate.JsTranslate("Flyt op")%>" border="0"<%=style%>></a><a href="FAQ_Item_Sort.aspx?FAQItemID=<%=drFaq("FAQItemID")%>&CategoryID=<%=CategoryID%>&MoveDirection=down"><img src="../../images/pilned.gif" alt="<%=Translate.JsTranslate("Flyt ned")%>" border="0"<%=style%>></a></td>
						<%	End If%>
						<td align="center"><%=ActiveImage%></td>
						<td align="center"><%=span & Dates.ShowDate(CDate(drFaq("FAQItemDate")), Dates.Dateformat.Short, False)%></span></td>
						<td align="center">
							<%If Base.HasAccess("FAQDelete", "") Then%>
							<a href="JavaScript:DeleteFAQ('<%=drFaq("FAQItemID").toString%>','<%=Base.JSEnable(Server.HtmlEncode(drFaq("FAQItemQHeader").toString()))%>','<%=CategoryID%>');"><img src="../../images/Delete.gif" border=0<%=style%> alt="<%=Translate.JsTranslate("Slet %%", "%%", Translate.JSTranslate("indlæg"))%>"></a>		
							<%	End If%>
						</td>
					</tr>
					<%	
Loop%> 
				    <tr>
				      	<td colspan="6" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
				    </tr>
					<tr>
						<td colspan="6">&nbsp;</td>
					</tr>
					<%If Not drFaqHasRows Then%>
					<tr>
						<td colspan="6"><strong><%=Translate.Translate("Der er ikke oprettet nogen %c%", "%c%", Translate.Translate("indlæg"))%></strong></td>
					</tr>
					<%End If%>
				</table>
			</div>
		</td>
	</tr>
	<tr>
		<td align="right" valign="bottom">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<%If Base.HasAccess("FAQCreate", "") Then%>
					<td><%=Gui.Button(Translate.Translate("Nyt indlæg"), "location='FAQ_Item_Edit.aspx?CategoryID=" & CategoryID & "'", 100)%></td>
					<td width="5"></td>
					<%End If%>
					<%If Base.HasAccess("FAQEdit", "") Then%>
					<td><%=Gui.Button(Translate.Translate("Rediger %%", "%%", Translate.Translate("kategori")), "location='FAQ_Category_Edit.aspx?CategoryName=" & Base.JSEnable(Server.URLEncode(CategoryName)) & "&CategoryID=" & CategoryID & "'", 0)%></td>
					<td width="5"></td>
					<%End If%>
					<td><%=Gui.Button(Translate.Translate("Luk"), "location='FAQ_Category_List.aspx'", 0)%></td>
					<%=Gui.HelpButton("faq_qcreate", "modules.faq.general.list.item",,5)%>
					<td width="10"></td>
				</tr>
				<tr>
					<td colspan="4" height="5"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</html>
<%
'Cleanup
cmdFaq.Dispose()
cnFaq.Dispose()
ds.Dispose()
cmd.Dispose()
cn.Close()
cn.Dispose()

Translate.GetEditOnlineScript()
%>