<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PhraseAlternativesStart.aspx.vb" Inherits="Dynamicweb.Admin.PhraseAlternativesStart"%>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
	<head>
		<title></title>
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<script language="javascript">
		function redirect(){
			setTimeout('void(0);', 200);
			location = '<%=getRedirectUrl()%>';
		}
		
		var timerID = 0;
		var timerStart  = null;

		function UpdateTimer() {
			if(timerID) {
				clearTimeout(timerID);
				clockID  = 0;
			}

			if(!timerStart){
				timerStart   = new Date();
			}
			
			var tDate = new Date();
			var tDiff = tDate.getTime() - timerStart.getTime();

			tDate.setTime(tDiff);

			document.getElementById("timer").innerHTML = "" 
											+ formatTime(tDate.getMinutes().toString()) + ":" 
											+ formatTime(tDate.getSeconds().toString());
			   
			timerID = setTimeout("UpdateTimer()", 1000);
		}
		
		function formatTime(value){
			if(value.length==1){
				return '0'+value;
			}else{
				return value;
			}
		}

		function Start() {
			timerStart = new Date();

			document.getElementById("timer").innerHTML = "00:00";

			timerID = setTimeout("UpdateTimer()", 1000);
		}

		function Stop() {
			if(timerID) {
				clearTimeout(timerID);
				timerID  = 0;
			}
			timerStart = null;
		}

		function Reset() {
			timerStart = null;
			document.getElementById("timer").innerHTML = "00:00";
		}
		</script>
  </head>
  <body onload="Start();redirect();">
  <dw:tabheader id="TabHeader1" runat="server" title="Alternatives" returnwhat="All" headers="Alternatives"></dw:tabheader>
		<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
			<tr>
				<td valign="center">
					<table border="0" cellpadding="0" width="598">
						<tr>
							<td align="center"><%=Translate.Translate("Finder alternativer - dette kan tage op til 5 minutter.")%><br><br></td>
						</tr>
						<tr>
							<td align="center"><img src="Dynamicweb_wait.gif"></td>
						</tr>
						<tr>
							<td align="center"><span id="timer"></span>&nbsp;<dw:TranslateLabel ID="lbSeconds" Text="sekunder" runat="server" />.</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
  </body>
</html>
