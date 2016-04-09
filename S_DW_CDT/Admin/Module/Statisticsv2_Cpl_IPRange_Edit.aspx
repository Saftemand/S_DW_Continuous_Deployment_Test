<%@ Page CodeBehind="Statisticsv2_Cpl_IPRange_Edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Statisticsv2_Cpl_IPRange_Edit" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<script language="VB" runat="Server">
Dim Statv2ExcludeFromIP As String
Dim Statv2ExcludeDescription As String
Dim Navigation As Boolean
Dim Statv2ExcludeID As String
Dim Statv2ExcludeToIp As String
Dim sql As String
</script>

<%
If Request.QueryString("Statv2ExcludeID") <> "" Then

	Dim Statisticsv2Conn As System.Data.IDbConnection = Database.CreateConnection("Statisticsv2.mdb")
	Dim sCmdStatisticsv2 As IDbCommand = Statisticsv2Conn.CreateCommand

	sql = "SELECT * FROM Statv2Exclude WHERE Statv2ExcludeID=" & Request.QueryString("Statv2ExcludeID")

	sCmdStatisticsv2.CommandText = sql

	Dim drSettingsReader As IDataReader = sCmdStatisticsv2.ExecuteReader()

	Dim opStatv2ExcludeID As Integer  = drSettingsReader.getordinal("Statv2ExcludeID")
	Dim opStatv2ExcludeDescription As Integer = drSettingsReader.getordinal("Statv2ExcludeDescription")
	Dim opStatv2ExcludeFromIP As Integer = drSettingsReader.getordinal("Statv2ExcludeFromIP")
	Dim opStatv2ExcludeToIp As Integer = drSettingsReader.getordinal("Statv2ExcludeToIp")

		If drSettingsReader.Read Then
			Statv2ExcludeID = drSettingsReader(opStatv2ExcludeID)
			Statv2ExcludeDescription = drSettingsReader(opStatv2ExcludeDescription)
			Statv2ExcludeFromIP = drSettingsReader(opStatv2ExcludeFromIP)
			Statv2ExcludeToIp = drSettingsReader(opStatv2ExcludeToIp)
		End If

	drSettingsReader.Dispose
	sCmdStatisticsv2.Dispose
	Statisticsv2Conn.Dispose

End If

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="STYLESHEET" type="text/css" href="../Stylesheet.css">
	<SCRIPT language="javascript">
		<!--
			function ValidateIPv4(strIp) {
                var re_ip = /\b(([01]?\d?\d|2[0-4]\d|25[0-5])\.){3}([01]?\d?\d|2[0-4]\d|25[0-5])\b/;
                if (strIp.search(re_ip) == -1){
                    return false;
                }
                return true;
 			}
			
			function ValidateIPRange(strIpFrom, strIpTo) {
				var arOctetFrom = strIpFrom.split(".");
				var arOctetTo = strIpTo.split(".");
				
				if ((arOctetFrom.length == 4) && (arOctetTo.length == 4)) {
					if (parseInt(arOctetFrom[0]) > parseInt(arOctetTo[0])) {
						// alert(11);
						return false;
					}
					if (parseInt(arOctetFrom[1]) > parseInt(arOctetTo[1])) {
						// alert(111);
						return false;
					}
					if (parseInt(arOctetFrom[2]) > parseInt(arOctetTo[2])) {
						// alert(1111);
						return false;
					}
					if (parseInt(arOctetFrom[3]) > parseInt(arOctetTo[3])) {
						return false;
					}
					return true;
				}
				else {
					return false;
				}
			}

			function Send() {
				if (document.getElementById('Statv2ExcludeDescription').value == "") {
					alert("<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Beskrivelse"))%>");
					document.getElementById('Statv2ExcludeDescription').focus();
					return false;
				}
				else if (!ValidateIPv4(document.getElementById('Statv2ExcludeFromIP').value)) {
					alert("<%=Translate.JSTranslate("Ugyldig værdi i: %%", "%%", Translate.JsTranslate("Fra adresse"))%>");
					document.getElementById('Statv2ExcludeFromIP').focus();
					return false;
				}
				else if (!ValidateIPv4(document.getElementById('Statv2ExcludeToIp').value)) {
					alert("<%=Translate.JSTranslate("Ugyldig værdi i: %%","%%", Translate.JsTranslate("Til adresse"))%>");
					document.getElementById('Statv2ExcludeToIp').focus();
					return false;
				}
				else if (!ValidateIPRange(document.getElementById('Statv2ExcludeFromIP').value, document.getElementById('Statv2ExcludeToIp').value)) {
					alert("<%=Translate.JSTranslate("´%f%´ må ikke være større end ´%t%´!", "%f%", Translate.JSTranslate("Fra adresse"), "%t%", Translate.JSTranslate("Til adresse"))%>");
					document.getElementById('Statv2ExcludeFromIP').focus();
					return false;
				}
				else {
					document.getElementById('StatisticsExclusionEdit').submit();
				}
			}
			
			function transferAddress() {
				if (ValidateIPv4(document.getElementById("Statv2ExcludeFromIP").value) == true) {
					if (document.getElementById("Statv2ExcludeToIp").value.length == 0) {
						document.getElementById("Statv2ExcludeToIp").value = document.getElementById("Statv2ExcludeFromIP").value;
					}
				}
				else {
					document.getElementById("Statv2ExcludeFromIP").focus();
					alert("<%=Translate.JSTranslate("Den angivne adresse er forkert")%>");
				}
			}
		//-->
	</SCRIPT>
</head>
<%
Navigation = True
%>
<%=Gui.MakeHeaders(Translate.Translate("Rediger %%","%%",Translate.Translate("IP-interval")), Translate.Translate("IP-interval"), "all", true)%>

<table border="0" cellpadding="0" cellspacing="0" class="tabTable" style="width:512px;">
	<form name="StatisticsExclusionEdit" id="StatisticsExclusionEdit" method="post" action="Statisticsv2_Cpl_IPRange_Save.aspx">
	<input type=hidden name="filtering" value="true">
	<input type=hidden name="Statv2ExcludeID" value="<%=Statv2ExcludeID%>">
	<tr>
		<td valign="top">
		<br>
		<div id="Tab1">
			<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
			<table cellpadding="0">
				<tr>
					<td width=170>&nbsp;<%=Translate.Translate("Beskrivelse")%></td>
					<td><input class="std" maxlength="255" type="Text" value="<%=Server.HtmlEncode(Statv2ExcludeDescription)%>" name="Statv2ExcludeDescription" id="Statv2ExcludeDescription"></td>
				</tr>
				<tr>
					<td>&nbsp;<%=Translate.Translate("Fra adresse")%></td>
					<td><input class="std" maxlength="255" type="Text" onChange="transferAddress();" value="<%=Statv2ExcludeFromIP%>" name="Statv2ExcludeFromIP" id="Statv2ExcludeFromIP"></td>
				</tr>
				<tr>
					<td valign="top">&nbsp;<%=Translate.Translate("Til adresse")%></td>
					<td><input class="std" maxlength="255" type="Text" value="<%=Statv2ExcludeToIp%>" name="Statv2ExcludeToIp" id="Statv2ExcludeToIp"></td>
				</tr>
			</table>
			<%=Gui.GroupBoxEnd%>
		</div>
		</form>
		</td>
	</tr>
	<tr valign="bottom">
		<td colspan="4" align="right">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td colspan="6"><br></td>
				</tr>
				<tr>
					<td align="right"><%=Gui.Button(Translate.Translate("Ok"), "javascript:Send();", 0)%></td>
					<td width="5"></td>
					<td align="right"><%=Gui.Button(Translate.Translate("Annuller"), "location='Statisticsv2_Cpl.aspx?Tab=2';", 0)%></td>
					<td width="10"></td>
				</tr>
				<tr>
					<td colspan="4" height="5"></td>
				</tr>			
			</table>
		</td>
	</tr>
</table>
<SCRIPT language="javascript">
<!--
    document.getElementById("Statv2ExcludeDescription").focus();
//-->
</SCRIPT>

</body>
</HTML>
<%
Translate.GetEditOnlineScript()
%>
