<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PageCompare.aspx.vb" Inherits="Dynamicweb.Admin.PageCompare" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>
		<dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Compare" />
	</title>
	<dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true">
	</dw:ControlResources>

	<script type="text/javascript">
		function publish() {
			pageID = <%=Dynamicweb.Base.ChkInteger(Dynamicweb.Base.request("PageID")) %>;
			new Ajax.Request('/Admin/Module/Workflow/WorkflowApprove.aspx?VCP=v2&cmd=&PageID=' + pageID + '&publish=true', {
				method: 'get',
				onComplete: function(response) {
					try{
						top.opener.location.reload(true);
					}catch(err){
					}
					var topLocation = top.location.toString() + "&published=true";
					top.location = topLocation;
				}
			});
		}
	</script>

</head>
<%			If Dynamicweb.Base.Request("show") = "draftheading" Then%>
<%				If Dynamicweb.Base.ChkBoolean(Dynamicweb.Base.Request("VersionCompare")) Then%>
<h1 class="title">
	<dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Version" /> (<%=New DateTime(Dynamicweb.Base.ChkLong(Dynamicweb.Base.Request("Date"))).ToString(Dynamicweb.Dates.DateFormatStringFull)%>)
</h1>
<%Else %>
<h1 class="title">
	<dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Kladde" />
</h1>
<div style="position: fixed; top: 0px; right: 0px;">
	<dw:Toolbar ID="Toolbar1" runat="server" ShowEnd="false" ShowStart="false">
		<dw:ToolbarButton ID="cmdPublish" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_ok.png" Text="Approve" OnClientClick="publish();">
		</dw:ToolbarButton>
		<dw:ToolbarButton ID="ToolbarButton2" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/Error.png" Text="Luk" OnClientClick="top.close();top.opener.focus();">
		</dw:ToolbarButton>
	</dw:Toolbar>
</div>
<%End If%>
<%				ElseIf Dynamicweb.Base.Request("show") = "publishedheading" Then%>
<h1 class="title">
	<dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Publiceret" />
</h1>
<%					ElseIf Dynamicweb.Base.Request("show") = "masterheading" Then%>
<h1 class="title">
	<dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Master" />
</h1>
<%					ElseIf Dynamicweb.Base.Request("show") = "languageheading" Then%>
<h1 class="title">
	<dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="Sprog" />
</h1>
<%	Else%>
<frameset cols="50%,*" frameborder="1" border="1" framespacing="1" runat="server" id="frame">
	<%
		Dim leftframeShow As String = "publishedheading"
		Dim rightframeShow As String = "draftheading"
		If Dynamicweb.Base.Request("lang") = "True" Then
			leftframeShow = "masterheading"
			rightframeShow = "languageheading"
		End If
		%>
		<frameset rows="26,*" frameborder="0" border="0" framespacing="0">
			<frame name="originalHeading" scrolling="no" noresize="noresize" marginwidth="0" marginheight="0" src="PageCompare.aspx?show=<%=leftframeShow %>" />
			<frame name="original" scrolling="auto" noresize="noresize" marginwidth="0" marginheight="0" runat="server" id="original" />
		</frameset>
		<frameset rows="26,*" frameborder="0" border="0" framespacing="0">
			<frame name="draftHeading" scrolling="no" noresize="noresize" marginwidth="0" marginheight="0" src="PageCompare.aspx?show=<%=rightframeShow %>&VersionCompare=<%=Dynamicweb.Base.request("VersionCompare") %>&Date=<%=Dynamicweb.Base.Request("Date")%>&PageID=<%=Dynamicweb.Base.ChkInteger(Dynamicweb.Base.request("PageID")) %>&published=<%=Dynamicweb.Base.request("published") %>" />
			<frame name="draft" scrolling="auto" noresize="noresize" marginwidth="0" marginheight="0" runat="server" id="draft" />
			</frameset>
	</frameset>
<%	End If%>
</html>
