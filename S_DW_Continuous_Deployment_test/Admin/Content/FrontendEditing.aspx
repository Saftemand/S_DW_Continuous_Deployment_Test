<%@ Page Language="vb" ValidateRequest="false" AutoEventWireup="false" CodeBehind="FrontendEditing.aspx.vb" Inherits="Dynamicweb.Admin.FrontendEditing" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>Frontend Editing</title>
	<dw:ControlResources runat="server" IncludePrototype="true" IncludeScriptaculous="true">
	</dw:ControlResources>
	<link href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" rel="stylesheet" />
	<link href="FrontendEditing.css" rel="stylesheet" />
	<% If Request("close") = "true" AndAlso ExecutingContext.FrontendEditingState = ExecutingContext.FrontendEditingStates.Disabled Then%>
	<script>try { close(); } catch(ex) {}</script>
	<% Else%>
	<script>
		var dwFrontendEditing = {};

		<%
	    Dim messages As New Generic.Dictionary(Of String, String)()
		For Each message As String In New String() {
				"Inline editing enabled",
				"Inline editing disabled",
				"Frontend editing ready",
				"Saving content …",
				"Save failed",
				"Content saved",
				"Save changes?",
				"You have unsaved changes",
				"Save changes",
				"Return to editor",
				"Discard changes"
			}
			messages(message) = Backend.Translate.JsTranslate(message)
		Next
		%>

		dwFrontendEditing.messages = <%= New System.Web.Script.Serialization.JavaScriptSerializer().Serialize(messages) %>;
	</script>
	<script type="text/javascript" src="FrontendEditing.js"></script>
	<%End If%>
</head>
<body>
	<%
		Dim pageID = 0
		If Not String.IsNullOrEmpty(Request("PageID")) Then
			pageID = Base.ChkInteger(Request("PageID"))
		ElseIf Not String.IsNullOrEmpty(Request("AreaID")) Then
	        Dim area = Dynamicweb.Frontend.Area.GetAreaById(Request("AreaID"))
			pageID = Base.ChkInteger(area.Value("AreaFirstPage"))
		End If
	%>

	<div id="topbar">
		<div class="Toolbar">
			<ul>
				<li>
					<%= Translate.Translate("Frontend editing") %>
				</li>
				<li>
					<a id="btn-close" class="toolbar-button" href="#">
						<span class="toolbar-button-container">
							<img class="icon" alt="Close" src="/Admin/Images/Ribbon/Icons/Small/Delete.png" />
							<%= Translate.Translate("Close Frontend editing") %>
						</span>
					</a>
				</li>
				<li>
					<a class="toolbar-button" href="#">
						<span class="toolbar-button-container">
							<label>
								<input type="checkbox" <%= IIf(ExecutingContext.FrontendEditingState = ExecutingContext.FrontendEditingStates.Edit, " checked", "")%> id="toggle-editing" />
								<%= Translate.Translate("Enable inline editing") %></label>
						</span>
					</a>
				</li>
				<li class="help">
					<a id="btn-help" class="toolbar-button" title="Help" href="#">
						<span class="toolbar-button-container">
							<img class="icon" alt="Help" src="/Admin/Images/Ribbon/Icons/Small/Help.png" />
							<%= Translate.Translate("Help") %>
						</span>
					</a>
				</li>
			</ul>
			<div id="status">
				<div class="content"></div>
			</div>
		</div>
		<div class="version-info"><%= Translate.Translate("Frontend Editing Draft")%></div>
	</div>

	<div id="content" style="display: none">
		<% If pageID > 0 Then
				Dim editingState As String = "disable"
				Select Case ExecutingContext.FrontendEditingState
					Case ExecutingContext.FrontendEditingStates.Browse
						editingState = "browse"
					Case ExecutingContext.FrontendEditingStates.Edit
						editingState = "edit"
				End Select
		        
				Dim queryString = HttpUtility.ParseQueryString("")
				queryString("ID") = pageID
				queryString("FrontendEditingState") = editingState
		%>
		<iframe src="/Default.aspx?<%= queryString.ToString()%>" id="contentFrame" style="border: none" frameborder="0"></iframe>
		<% Else%>
		Invalid page ID: <%= pageID%>
		<% End If%>
	</div>

	<span id="mSaveChanges" style="display: none">
		<dw:TranslateLabel ID="lbSaveChanges" Text="Save changes before reloading?" runat="server" />
	</span>

	<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</body>
</html>
