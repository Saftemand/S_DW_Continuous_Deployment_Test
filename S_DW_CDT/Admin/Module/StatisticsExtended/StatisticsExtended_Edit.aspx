<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="StatisticsExtended_Edit.aspx.vb" Inherits="Dynamicweb.Admin.StatisticsExtended_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb.Controls" %>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<script language="javascript" type="text/javascript">
	function toggleNews(){
		if (document.paragraph_edit.ObjectType[document.paragraph_edit.ObjectType.selectedIndex].text == "News"){
			document.getElementById("NewsSpecific").style.display = "";
		}else{
			document.getElementById("NewsSpecific").style.display = "none";
		}
	}
</script>
<input type="Hidden" name="StatisticsExtended_settings" value="ObjectType, ListCount, TemplateList, DestinationPage">
<%
	Dim ParagraphID As Integer
	If Request("ID") <> "" Then
		ParagraphID = Base.ChkNumber(Request("ID"))
	ElseIf Request("ParagraphID") <> "" Then
		ParagraphID = Base.ChkNumber(Request("ParagraphID"))
	Else
		ParagraphID = 0
	End If

	Dim prop As New Properties

    If Base.ChkString(Request.QueryString("ParagraphModuleSystemName")) = "" Then 'ParagraphID > 0 Then
        prop = Base.GetParagraphModuleSettings(ParagraphID, True)
    Else
        prop.Values.Add("ObjectType", "")
        prop.Values.Add("ListCount", "10")
        prop.Values.Add("TemplateList", "DefaultList.html")
    End If
	%>
<TR>
	<TD>
		<%=Gui.MakeModuleHeader("Statistics", "Statistics")%>
	</TD>
</TR>
<tr>
	<td>
		<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
		<table border="0" cellpadding="2" cellspacing="0">
			<tr>
				<td width="170"><%=Translate.Translate("Type")%></td>
				<td>
					<select name="ObjectType" class="std" onchange="toggleNews();">
						<option value=""><%=Translate.translate("Nothing selected") %></option>
						<option value="Page"<%=Base.IIf(prop.Value("ObjectType") = "Page", " selected", "") %>><%=Translate.Translate("Page")%></option>
						<option value="News"<%=Base.IIf(prop.Value("ObjectType") = "News", " selected", "") %>><%=Translate.Translate("News")%></option>
					</select>
				<td>
			</tr>
			<tr>
				<td><%=Translate.Translate("List count")%></td>
				<td><input type="text" name="ListCount" class="std" style="text-align: right; width: 55px;" value="<%=Prop.Value("ListCount") %>" /></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Template")%></td>
				<td><%=Gui.FileManager(Prop.Value("TemplateList"), "Templates/StatisticsExtended", "TemplateList") %></td>
			</tr>
			<tr id="NewsSpecific"<%=Base.IIf(Prop.Value("ObjectType") <> "News", " style=""display: none;""", "")%>>
				<td><%=Translate.Translate("Show on page")%></td>
				<td><%=Gui.LinkManager(prop.Value("DestinationPage"), "DestinationPage", "", "0", "0", False, "on", False)%></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd()%>
	</td>
</tr>
<%Translate.GetEditOnlineScript()%>