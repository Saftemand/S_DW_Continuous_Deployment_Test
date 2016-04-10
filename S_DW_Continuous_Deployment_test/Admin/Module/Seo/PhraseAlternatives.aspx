<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PhraseAlternatives.aspx.vb" inherits="Dynamicweb.Admin.PhraseAlternatives"%>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
	<head>
		<title></title>
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		
		<dw:ControlResources ID="ctrlResources" IncludePrototype="true" runat="server" />
		<script type="text/javascript" src="http://www.google.com/jsapi"></script>
        <script type="text/javascript" src="/Admin/Content/JsLib/dw/RequestQueue.js"></script>
        <script type="text/javascript" src="/Admin/Module/Seo/Seo.js"></script>
		
		<script language="javascript">
			function deletePhrase(PhraseId){
				location = "PhraseEdit.aspx?cmd=delete&ID=<%=Base.Request("ID")%>&PhraseId=" + PhraseId;
			}
			
			function send(btn){
				if(document.forms.words.w){
					if(!document.forms.words.w.length){
						if(document.forms.words.w.checked){
							btn.disabled = true;
							document.forms.words.submit();
							return;
						}
					}
					else{
						for(var i = 0;i<document.forms.words.w.length;i++){
							if(document.forms.words.w[i].checked){
								btn.disabled = true;
								document.forms.words.submit();
								return;
							}
						}
					}
					alert('<%=Translate.JSTranslate("Choose_at_least_one_phrase")%>');
				}
			}
		</script>
		<style>
			.t{
				border-left:1px solid #ccc;
				border-top:1px solid #ccc;
				width:100%;
			}
			
			.w{
				height:20px;
			}
			
			.w td{
				border-right:1px solid #ccc;
				border-bottom:1px solid #ccc;
				margin:3px;
			}
			.h{
				display:none;
			}
			.h td{
				border-bottom:1px solid #ccc;
			}
			.d{display:;}
			.p{cursor:pointer;}
			
			.barBG {
				height:18px;
				width:65%;
				float: left;
				font-family:verdana;
				font-size:10px;
				background-color:#d1d1d1;
			}
			
			.bar {
				height:100%;
				filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#2059CE', EndColorStr='#11356F');
			}
			
			.barCount
			{
				display: block;
				float: right;
			}
		</style>
	</head>
	<body onload="parent.ac1(parent.document.getElementById('PhraseAlternatives'))">
		<dw:tabheader id="TabHeader1" runat="server" title="Alternatives" returnwhat="All" headers="Alternatives"></dw:tabheader>
		<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
			<tr>
				<td valign="top">
				<br>
					<form action="PhraseEdit.aspx" method="get" name="words">
					<input type="hidden" value="<%=Base.Request("ID")%>" name="ID">
					
					<table border="0" cellpadding="0" width="598">
					    <tr id="progressContainer" style="display: none">
					        <td>
					            <dw:GroupBox ID="gbUpdating" Title="Competition" runat="server">
					                <table width="100%">
					                    <tr>
					                        <td align="center">
					                            <dw:TranslateLabel ID="lpPleaseWait" Text="Please wait while competition numbers are being retrieved..." runat="server" />
					                            (<span style="font-weight: bold" class="percentageValue">0%</span>)
					                        </td>
					                    </tr>
					                    <tr>
					                        <td align="center">
					                            <img src="Dynamicweb_wait.gif" alt="" border="0" />
					                        </td>
					                    </tr>
					                </table>
					            </dw:GroupBox>
					        </td>
					    </tr>
						<tr>
							<td><%=getAlternatviePhrases()%></td>
						</tr>
						<tr>
							<td colspan="2" align="right"></td>
						</tr>
					</table>
					</form>
				</td>
			</tr>
		</table>
		<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
	</body>
	
	<script type="text/javascript">
	    var lang = '<%=CurrentLanguage %>';
        var tabSpecific = new Seo.KeywordsList('tabMoreSpecific');
        var tabAdditional = new Seo.KeywordsList('tabAdditionalToConsider');
        var p = new Seo.Progress('progressContainer');
        
        tabSpecific.state = p;
        tabAdditional.state = p;

        setTimeout(function() {
            tabSpecific.fillCompetitions(
            {
                language: lang,
                onComplete: function() {
                    setTimeout(function() { tabAdditional.fillCompetitions({ language: lang }); }, 500);
                }
            });
        }, 500);
    </script>
</html>
