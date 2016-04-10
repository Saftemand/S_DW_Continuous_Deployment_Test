<%@ Page CodeBehind="Form_Module_List.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Form_Module_List" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
	

<%

Dim sql As String

%>
<html>
<head>
<script language="JavaScript">
 function helpLink()
         {
            <%= Gui.Help("news", "modules.news.general.list")%>;
         }
var HasPermissions = '<%=Base.HasAccess("FormEdit", "")%>';
function DeleteForm(FormID,FormName){
	if (confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("formular"))%>\n(' + FormName + ')')){
		location = "Form_Module_Del.aspx?FormID=" + FormID;
	}
}
function CopyForm(FormID, FormName){
	FormName = prompt("<%=Translate.JsTranslate("Angiv %%: ", "%%", Translate.JsTranslate("navn"))%>", "<%=Translate.Translate("Kopi af ")%>&nbsp;" + FormName);
	if(FormName != null){
		location = "Form_Module_Copy.aspx?FormID=" + FormID + "&FormName=" + FormName;
	}
}
</script>
<dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
</head>        
<title></title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<link rel="Stylesheet" type="text/css" href="Form.css" />
<%=Gui.MakeHeaders(Translate.Translate("Formularer",9), Translate.Translate("Formularer"), "all")%>
                    <dw:Toolbar ID="SurveyToolbar" runat="server" ShowStart="true"  ShowEnd="false">
                       <dw:ToolbarButton ID="tbNewForm" runat="server" OnClientClick="if(HasPermissions=='True'){window.location.href = 'Form_Module_Edit.aspx';}" Image="AddDocument" Text="New Form">
                       </dw:ToolbarButton>
                       <dw:ToolbarButton ID="tbHelp" runat="server" Image="Help" Text="Help" OnClientClick="helpLink();">
                       </dw:ToolbarButton>
                    </dw:Toolbar>
<table border="0" cellpadding="0" cellspacing="0" class="TabTable">
<tr class="WhiteBackground"><td valign="top">
<div ID="Tab1">
<table border="0" cellpadding="0" style="width:100%;margin-left:10px">
	<tr>
		<td><strong><%=Translate.Translate("Formular")%></strong></td>
		<%If Base.HasVersion("18.8.1.0") Then%>
		<td width="30" align="center"><strong><%=Translate.Translate("Kopi")%></strong></td>		
		<%End If%>
		<td width="30" align="center"><strong><%=Translate.Translate("Slet")%></strong></td>		
	</tr>
	<%
Dim cnForm		As IDbConnection = Database.CreateConnection("Dynamic.mdb")
Dim cmdSelect	As IDbCommand	 = cnForm.CreateCommand
cmdSelect.CommandText = "SELECT FormID, FormName FROM Form ORDER BY FormName ASC"
Dim drForm		As IDataReader	 = cmdSelect.ExecuteReader()


Dim blnHasRow as Boolean = false

Do While drForm.Read()
	If Not blnHasRow Then blnHasRow = True
	If Base.HasAccess("FormCategories", drForm("FormID").ToString) Then
		%>
		    <tr>
		      	<td colspan="6" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
		    </tr>
			<tr>
				<%If Base.HasAccess("FormEdit", "") Then%>
				<td title="" OnClick="Javascript:self.location='Form_Module_Edit.aspx?FormID=<%=drForm("FormID").ToString%>'"><a href="Form_Module_Edit.aspx?FormID=<%=drForm("FormID").ToString%>"><%=Server.HtmlEncode(drForm("FormName").ToString())%></a></td>
				<%		Else%>
				<td><%=Server.HtmlEncode(drForm("FormName").ToString())%></td>
				<%End If%>
				<%If Base.HasVersion("18.8.1.0") And Base.HasAccess("FormEdit", "") Then%>
					<td width="30" align="center"><strong><a href="#" onClick="CopyForm(<%=drForm("FormID").ToString%>, '<%=Base.JSEnable(Server.HtmlEncode(drForm("FormName").ToString()))%>');"><img src="../../Images/Icons/Page_Copy.gif" width="15" height="17" border="0" alt="<%=Translate.Translate("Kopier")%>"></a></strong></td>		
				<%	End If%>
				<td align="center">
					<%If Base.HasAccess("FormDelete", "") Then%>
					<a href="JavaScript:DeleteForm('<%=drForm("FormID").ToString%>','<%=Base.JSEnable(Server.HtmlEncode(drForm("FormName").ToString()))%>')"><img src="../../images/Delete.gif" alt="<%=Translate.JsTranslate("Slet %%", "%%", Translate.JSTranslate("formular"))%>" border=0></a>
					<%End If%>
				</td>
			</tr>
			<%		
	End If
Loop 

%>
    <tr>
      	<td colspan="6" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
    </tr>
	<tr>
		<td colspan="6">&nbsp;</td>
	</tr>
	<%If Not blnHasRow Then%>
	<tr>
		<td colspan="6"><%=Translate.Translate("Der er ikke oprettet nogen %c%", "%c%", Translate.Translate("formularer"))%></td>
	</tr>
	<%End If%>

</table>
</div>
</td>
	</tr>

</table>
</html>
<%
drForm.Close()
drForm.Dispose()
cmdSelect.Dispose()
cnForm.Dispose()	

Translate.GetEditOnlineScript()
%>
