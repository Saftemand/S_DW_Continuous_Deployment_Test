<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Page_Preview.aspx.vb" Inherits="Dynamicweb.Admin.Page_Preview" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title><%=Translate.JsTranslate("Preview side")%></title>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<link rel="STYLESHEET" type="text/css" href="Stylesheet.css">
	
	<script language="JavaScript" type="text/javascript">
	
	function ChangeCheck(strName, strID) {
		document.getElementById('z' + strID).checked = false;
		<%If Base.HasAccess("VersionControl", "") Then%>
		document.getElementById('x' + strID).checked = false;
		<%End if%>
		document.getElementById('c' + strID).checked = false;
		
		document.getElementById(strName + strID).checked = true;
	}
	
<%
If Request.Form("PageID") <> "" Then
%>
	window.open('../Default.aspx?ID=<%=strPageID%>&Purge=True&Preview=True&showorig=<%=strshoworig%>&showvs=<%=strshowvs%>&notshow=<%=strnotshow%>');
	window.close();
<%
End If
%>

	
	</script>

<%=Gui.MakeHeaders(Translate.Translate("Preview side - %%", "%%", PageName), Translate.Translate("Afsnit",1), "all")%>

<table border="0" cellpadding="0" cellspacing="0" width="600" class="tabTable" style="width:600;">
	<form name="PagePreview" method="post" action="Page_Preview.aspx">
	<input type="Hidden" value="<%=PageID%>" name="PageID">
	<tr>
		<td valign="top">
		<div id="Tab1" style="display:;">
			<br>
			<table cellspacing="0" border="0" cellpadding="4" width="580">
				<tr>
					<td>&nbsp;</td>
					<td colspan="2">&nbsp;
						<table cellpadding=0 cellspacing=0 width="550px">
							<tr>
								<td>&nbsp;</td>
								<td>
									<table cellpadding=2 cellspacing=0 width="550px">
										<%=GetParagraphs()%>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>	
		</div>
		</td>
	</tr>
	<tr>
		<td align="right" valign="bottom">
		<table cellpadding="0" cellspacing="0">
			<tr>
				<td colspan="6"><br></td>
			</tr>
			<tr>
				<td align="right"><%=Gui.Button(Translate.Translate("OK"), "javascript:PagePreview.submit();", 0)%></td>
				<td width="5"></td>
				<td align="right"><%=Gui.Button(Translate.Translate("Annuller"), "window.close();", 0)%></td>
				<td width="10"></td>
			</tr>
			<tr>
				<td colspan="4" height="5"></td>
			</tr>			
		</table>
		</td>
	</tr>
	</form>
</table>
</body>
<%
Translate.GetEditOnlineScript()
%>
