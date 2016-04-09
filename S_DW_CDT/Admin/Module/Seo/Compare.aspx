<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Compare.aspx.vb" inherits="Dynamicweb.Admin.Compare"%>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
	<head>
		<title></title>
		
		<dw:ControlResources ID="ctrlResources" IncludePrototype="true" runat="server" />
		<script type="text/javascript" src="http://www.google.com/jsapi"></script>
		<script type="text/javascript" src="/Admin/Module/Seo/Seo.js"></script>
		
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<script language="javascript">
			function send(){
				if(document.forms.urls){
					document.forms.urls.submit();
				}
			}
			
			function sendAlternatives(){
				if(document.forms.urls){
					document.forms.urls.action = "PhraseAlternatives.aspx";
					document.forms.urls.submit();
				}
			}
			
			function t(RowId, img){
				if(document.getElementById(RowId).className=='h'){
					document.getElementById(RowId).className='d';
					img.src="/Admin/Images/Expand_off.gif"
				}
				else{
					document.getElementById(RowId).className='h';
					img.src="/Admin/Images/Expand.gif"
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
			
			.ddList
			{
				width: 250px;
				margin-bottom: 2px;
			}
			
			.w td,
			.w td.competitorData
			{
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
				width:90%;
				font-family:verdana;
				font-size:10px;
				background-color:#d1d1d1;
			}
			
			.bar {
				height:100%;
				filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#2059CE', EndColorStr='#11356F');
			}
			.r{background-color:#CC3300;}
			.y{background-color:#FFCC00;}
			.g{background-color:#339900;}
		</style>
		
		<script type="text/javascript">
		    var lang = '<%=CurrentLanguage %>';
		    var tab = new Seo.CompareTable('tabCompare');
		    
		    tab.set_state(new Seo.Progress('progressContainer'));
		    tab.set_phrasesListID('ddPhrase');
		    tab.set_competitorsListID('ddCompetitors');
		    tab.set_competitorTableContainerID('divCompetitorTable');

		    function loadCompareList(loadDropDown) {
		        if (tab.get_phrasesListObject().options.length > 0) {
		            if (loadDropDown) {
		                tab.renderDropDownList({
		                    language: lang,
		                    onComplete: function() { updateCompetitor(); }
		                });
		            } else {
		                updateCompetitor();
		            }
		        }
		    }

		    function updateCompetitor(params) {
		        if(!params) {
		            params = {}
		        }

		        tab.fillCompetitorData({ onComplete: params.onComplete });
		    }
		</script>
		
	</head>
	<body onload="parent.ac1(parent.document.getElementById('Compare'))">
		<dw:tabheader id="TabHeader1" runat="server" title="Check list" returnwhat="All" headers="Check list"></dw:tabheader>
		<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
			<tr>
				<td valign="top">
				<br>
					<form action="Compare.aspx" method="get" name="urls">
					<input type="hidden" value="<%=Base.Request("ID")%>" name="ID">
					<table border="0" cellpadding="0" width="598">
				        <tr id="progressContainer" style="display: none">
				            <td>
				                <dw:GroupBox ID="gbUpdating" Title="Updating" runat="server">
                                    <table width="100%">
                                        <tr>
                                            <td align="center">
                                                <dw:TranslateLabel ID="lpPleaseWait" Text="Please wait while data is being retrieved..." runat="server" />
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
							<td>
							    <%=getList()%>
							    <div id="divCompetitorTable"></div>
							</td>
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
	    loadCompareList(true);
	</script>
</html>