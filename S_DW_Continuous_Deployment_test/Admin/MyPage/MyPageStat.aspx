<%@ Page Language="vb" AutoEventWireup="false" Codebehind="MyPageStat.aspx.vb" Inherits="Dynamicweb.Admin.MyPageStat" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
		<META HTTP-EQUIV="Cache-control" CONTENT="no-cache">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META NAME="Cache-control" CONTENT="no-cache">
		<META HTTP-EQUIV= "Expires" CONTENT = "Tue, 20 Aug 1996 14:25:27 GMT">

		<TITLE><%=Translate.JSTranslate("Min side")%></TITLE>
		<LINK rel="STYLESHEET" type="text/css" href="../Stylesheet.css">

		<STYLE type="text/css">
			
			.MyPageSection {
				border: 1px solid #E6E6E6;
				padding: 4px;
				background-color: #FFFFFF;
			}
			.MyPageSectionHeader {
				border: 1px solid #E6E6E6;
				padding-left: 5px;
				background-color: #FFFFFF;
				height: 25px;
			}			.MyPageSectionHeader A {
				font-weight: bold;
				font-size: 12px;
			}
			.InfoBox A {
				color: #003366;
				text-decoration: none;
			}
			.InfoBox A:hover {
				color: #003366;
				text-decoration: underline;
			}
			.h1 {
				font-family: Verdana;
				font-size: 14px;
				font-weight: bold;
			}
		</STYLE>

		<style type="text/css">
			.barBG {
				height:18px;
				width:240px;
				font-family:verdana;
				font-size:10px;
				background-color:#d1d1d1;
			}
			
			.bar {
				height:100%;
				filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#2059CE', EndColorStr='#11356F');
			}
		</style>
		
	</HEAD>
	<BODY style="background-color:#FFFFFF;margin:0px;" topmargin="0" leftmargin="0" onContextMenu="<%=IIf(Session("DW_Admin_UserID") = 1, "", "return false;")%>">
		<%=GetMyPageStats()%>
	</BODY>
</HTML>
<% ' BBR 01/2005
'	Translate.GetEditOnlineScript()
%>