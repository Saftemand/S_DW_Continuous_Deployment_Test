<%@ Page Language="vb" AutoEventWireup="false" Codebehind="500.aspx.vb" Inherits="Dynamicweb.Admin._500" codePage="65001"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<TITLE>The page cannot be displayed</TITLE>
	</HEAD>
	<!--body bgColor="#003366" link="#666666" vlink="#666666" text="#e4e4e4"-->
	<!--base font="verdana"-->
	<table width="410" cellpadding="3" cellspacing="5" ID="Table1">
		<tr>
			<td align="left" valign="middle" width="360">
				<h1 style="FONT:13pt/15pt verdana; COLOR:#000000"><!--Problem--> The page cannot be 
					displayed</h1>
			</td>
		</tr>
		<tr>
			<td width="400" colspan="2">
				<font style="FONT:8pt/11pt verdana; COLOR:#000000">There is a problem with the page 
					you are trying to reach and it cannot be displayed.</font></td>
		</tr>
		<tr>
			<td width="400" colspan="2">
				<hr color="#c0c0c0" noshade>
				<br>
				<font style="FONT:8pt/11pt verdana; COLOR:#000000">This error has been sent to the 
					responsible technical personnel and will be taken care off shortly.</font></td>
		</tr>
		<tr>
			<td width="400" colspan="2">
				<font style="FONT:8pt/11pt verdana; COLOR:#000000">
				<a href="http://<%=Request.ServerVariables("SERVER_NAME")%>"><%=Request.ServerVariables("SERVER_NAME")%></a></font></td>
		</tr>
	</table>
	<!--/body-->
</HTML>
