<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="Dynamicweb.Admin.AdminDefault" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>
		<%=Base.IIf(Trim(Base.GetGs("/Globalsettings/Settings/CommonInformation/SolutionTitle")) <> "", Base.GetGs("/Globalsettings/Settings/CommonInformation/SolutionTitle") & " - " & Translate.JSTranslate("Dynamicweb administration"), Translate.JSTranslate("Dynamicweb administration"))%>
	</title>
<%
		Dim TopHeight As Integer = 50
		Dim LeftWidth As Integer = 200
		Dim BottomHeight As Integer = 6
		Dim bottomFile As String = "Bottom.html"
		Dim TopFile As String = "Top.aspx"
		If Gui.NewUI Then
			TopHeight = 36
			TopHeight = 66
			TopFile = "/Admin/Content/Top.aspx"
			TopFile = "/Admin/Content/Top2.aspx"
			LeftWidth = 250
			BottomHeight = 22
			bottomFile = "BottomNewUi.html"
		End If
	%>
	<script type="text/javascript">
	    var accordionActionEnable = true;

	    leftWidth = <%=LeftWidth %>;
		old = true
		if (parseInt(navigator.appVersion.charAt(0)) >= 4) {
			old = false
			isIE5 = (navigator.appName.indexOf("Microsoft") != -1) ? true : false;
		}
		if (old) {
			alert('<%=Translate.JSTranslate("Internet Explorer %% eller nyere!").replace("%%","5")%>')
			location = "Access/logoff.aspx";
		}

	</script>

	<meta http-equiv="x-ua-compatible" content="IE=EmulateIE9">
	<meta name="robots" content="noindex,noarchive,nofollow">
	<meta http-equiv="Pragma" content="no-cache">
	<meta name="Cache-control" content="no-cache">
	<meta http-equiv="Cache-control" content="no-cache">
	<meta http-equiv="Expires" content="Tue, 20 Aug 1996 14:25:27 GMT">
	<meta name="description" content="">
	<meta name="keywords" content="">
	<meta name="Author" content="Dynamicweb A/S (http://www.dynamicweb.dk, info@dynamicweb.dk)">
</head>
<frameset rows="<%=TopHeight %>,*,<%=BottomHeight %>" frameborder="0" border="0" framespacing="0" bordercolor="#cccccc">
		<frameset cols="*,0" frameborder="0" border="0" framespacing="0" bordercolor="#cccccc">
			<frame src="<%=TopFile %>" name="dwtop" scrolling="no" noresize marginwidth="0" marginheight="0" />
			<frame src="dummy.aspx" name="duh" scrolling="auto" noresize />
		</frameset>
		<frameset cols="<%=Iif(HideNavigation, 0, LeftWidth) %>,*" frameborder="0" border="0" framespacing="0" bordercolor="#cccccc" ID="MainFrame" name="MainFrame">
			<frame src="Menu.aspx?AreaID=<%=Base.ChkString(Session("DW_Area"))%>" name="left" scrolling="no" noresize />
			<frame src="MyPage/default.aspx" name="right" id="right" runat="server" scrolling="auto" frameborder="0" border="0" framespacing="0" noresize />
		</frameset>
		<frame src="<%=bottomFile %>" name="Bottom" scrolling="no" frameborder="0" border="0" framespacing="0" noresize />
	</frameset>
</html>