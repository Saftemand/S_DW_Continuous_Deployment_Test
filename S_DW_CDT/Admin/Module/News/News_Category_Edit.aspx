<%@ Page CodeBehind="News_Category_Edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.News_Category_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
	
<%

Dim CategoryAccess() As String
Dim SettingsArray() as String
Dim DWAccess_UseExtManager As String = Base.GetGS("/Globalsettings/Modules/Users/UseExtendedComponent").ToString()
Dim CategoryID As String
Dim CategoryName As String
Dim CategoryWorkflowID As Object
Dim NewsCategoryApprovalType as integer
Dim intTypes As Integer

CategoryID			= Base.ChkNumber(Request.QueryString.Item("CategoryID"))
CategoryName		= ""
intTypes			= -1

Dim cnNews		As IDbConnection = Database.CreateConnection("Dynamic.mdb")
Dim cmdSelect	As IDbCommand	 = cnNews.CreateCommand
cmdSelect.CommandText = "SELECT * FROM NewsCategory WHERE NewsCategoryID = " & CategoryID
Dim drNews		As IDataReader	 = cmdSelect.ExecuteReader()

If drNews.Read() Then
	CategoryID = drNews("NewsCategoryID")
	CategoryName = drNews("NewsCategoryName")
	If InStr(drNews("NewsCategoryAccess") & "", ",") Then
		CategoryAccess = Split(drNews("NewsCategoryAccess").ToString(), ",")
	Else
		If drNews("NewsCategoryAccess") & "" <> "" Then
			CategoryAccess = Split(drNews("NewsCategoryAccess").ToString(), ",")
		End If
	End If
End If

%>
<script src="/Admin/Module/Common/Validation.js" type="text/javascript"></script>
<SCRIPT type="text/javascript">
<!--
function SendData() {
	<%If DWAccess_UseExtManager <> "True" Then%>
		if (document.all.AccessUserGroups) {
			for(i = 0; i < document.all.AccessUserGroups.options.length; i++) {
				document.all.AccessUserGroups.options[i].selected = true;
			}
		}
	<%End If%>
	
	var form = document.forms["CategoryForm"];
	var controlToValidate = form.elements["CategoryName"];
	
	ValidateForm(form, controlToValidate,
		"<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>");
}
   function helpLink()
         {
            <%= Gui.Help("news", "modules.news.general.list.edit")%>; 
         }
         //location='News_Category_List.aspx'
-->
</SCRIPT>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
    	<title></title>
		<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	      <dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
	</head>
	<body style="background-color:White">
    		<%=Gui.MakeHeaders(Translate.Translate("%m% - Rediger %c%", "%m%", Translate.Translate("Nyheder",9),"%c%",Translate.Translate("kategori")), Translate.Translate("Kategori"), "all")%>
		<form action="News_Category_Save.aspx" method="post" name="CategoryForm" id="CategoryForm">
          <dw:Toolbar ID="MainToolbar" runat="server" ShowStart="true"  ShowEnd="false">
                                     <dw:ToolbarButton ID="tbSave" runat="server" OnClientClick="SendData();" Image="SaveAndClose" Text="Save">
                                     </dw:ToolbarButton>
                                     <dw:ToolbarButton ID="tbClose" runat="server" OnClientClick="history.back(1);" Image="Cancel" Text="Close">
                                     </dw:ToolbarButton>
                                     <dw:ToolbarButton ID="tbHelp" runat="server" Image="Help" OnClientClick="helpLink();" Text="Help">
                                     </dw:ToolbarButton>
                    </dw:Toolbar>
			<table border="0" cellpadding="0" cellspacing="0" class="TabTable" style="height:180px;">
					<input type="Hidden" name="CategoryID" value="<%=CategoryID%>">
					<tr style="background-color:White">
						<td valign="top"><br>
							<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
							<table border="0" cellpadding="0" width="100%">
								<tr>
									<td width="170"><%=Translate.Translate("Navn")%></td>
									<td><input type="text" name="CategoryName" value="<%=Server.HtmlEncode(CategoryName)%>" maxlength="255" class="std"></td>
								</tr>
								<tr>
									<td colspan="2" height="6" />
								</tr>
							</table>
							<%=Gui.GroupBoxEnd%>
						
							<% If Base.HasVersion("18.5.1.0") AndAlso (Base.HasAccess("ExtranetExtended") OrElse Base.HasAccess("UserManagementFrontend") ) Then
							        Response.Write(Gui.GroupBoxStart(Translate.Translate("Rettigheder")))%>
							<table border="0" cellpadding="0" width="100%">
								<tr>
									<td width="35"></td>
									<td><%=Gui.UserGroupManager("AccessUserGroups", "AccessExtranetGroups", "CategoryForm", intTypes, CategoryAccess, SettingsArray)%></td>
								</tr>
								<tr>
									<td colspan="2" height="6" />
								</tr>
							</table>
							<%	
	Response.Write(Gui.GroupBoxEnd)
End If
%>
						</td>
					</tr>
		
			</table>
    	</form>
     </body>
</html>
<%
drNews.Dispose()
cmdSelect.Dispose()
cnNews.Dispose()

	Translate.GetEditOnlineScript()
%>
<script language="javascript">
	setTimeout("document.getElementById('CategoryForm').CategoryName.focus();", 500);
</script>