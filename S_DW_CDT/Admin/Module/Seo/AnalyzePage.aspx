<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AnalyzePage.aspx.vb" inherits="Dynamicweb.Admin.AnalyzePage" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb.Analytics.Seo" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb.Modules.Seo" %>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><dw:TranslateLabel ID="lbTitle" Text="Optimer" runat="server" /></title>
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<style type="text/css">
html, body {height: 100%; margin: 0; padding: 0; }

.RNO{ /*Report Normal*/
	cursor:hand;
	margin:2px;
	margin-bottom:5px;
}

.RMO{ /*Report Mouse Over*/
	cursor:pointer;
	margin:2px;
	margin-bottom:5px;
	text-decoration:underline;
}

.RAC{ /*Report Active*/
	cursor:pointer;
	margin:2px;
	margin-bottom:5px;
	font-weight:bold;
}

#MName{
	color:white;
	font-weight:bold;
	font-size:10px;
}

.MyPageSection {
	border: 1px solid #E6E6E6;
	padding: 4px;
	margin-left:5px;
	margin-top:5px;
	width:175px;
}
.MyPageSectionHeader {
	border: 1px solid #E6E6E6;
	padding-left: 5px;
	background-color: #E6E6E6;
	height: 25px;
	font-weight: bold;
	font-size: 12px;
}

form{
	margin:2px;
}

			
.top {
	background: url("/Admin/Content/TopBgClean.png") repeat-x left top rgb(225, 234, 244); height: 38px;
}
</style>
<script language="javascript" type="text/javascript">
activeObj = "";
function mo(obj){
	if(activeObj != obj){
		obj.className = "RMO";
	}
}

function no(obj){
	if(activeObj != obj){
		obj.className = "RNO";
	}
}

function ac(obj, reportScript){
	ac2(obj, reportScript, "");
}

function ac1(obj){
	ac2(obj, "", "");
}

function ac2(obj, reportScript, Parms){
	activeObj.className = "RNO";
	obj.className = "RAC";
	activeObj = obj;
	if(reportScript != ''){
		document.getElementById("content").src = reportScript + '?ID=<%=Base.Request("ID")%>' + Parms;
	}
}

function res(){
	activeObj.className = "RNO";
	activeObj = "";
}

function toggle(obj){
	if(document.getElementById(obj.id + 'r').style.display == ""){
		document.getElementById(obj.id + 'i').src = "/Admin/Images/Expand2.gif"
		document.getElementById(obj.id + 'r').style.display = "none";
	}
	else{
		document.getElementById(obj.id + 'i').src = "/Admin/Images/Expand_off2.gif"
		document.getElementById(obj.id + 'r').style.display = "";
	}
}
function send(){
	document.forms.Pages.submit();
}

function show(){
	window.open("/Default.aspx?ID=" + document.forms.Pages.ID.value);
}
</script>

	</head>
	<body style="background-color:#ECE9D8;margin:0px;">
		<table cellspacing="0" cellpadding="0" border="0" width="100%" style="height:100%;">
			<tr class="top" style="height: 38px;">
				<td colspan="3">
					<table border="0" cellpadding="0" cellspacing="0" align="right">
						<tr>
							<td><img src="/Admin/access/DW_logo_wheel_115_white.png" alt="" class="h" /></td>
						</tr>
						<tr>
							<td><span id="MName" style="color: #006699"><dw:TranslateLabel id="lbMName" Text="Søgemaskineoptimering" runat="server" /></span></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr bgColor="#FFFFFF">
				<td valign="top" style="width:200px; border-top: 1px solid #9faec2;">
					<table cellspacing="0" cellpadding="0" border="0" style="height:100%;">
						<tr>
							<td>
								<div style="width:200px;height:100%;overflow:auto;margin:0px;" id="ContentCell">
						        <table class="MyPageSection" cellspacing="0" cellpadding="0" height="80">
							    <tr>
								    <td class="MyPageSectionHeader">
									    <img src="/Admin/images/MyPageBullit.gif" border="0" align="absmiddle">&nbsp;<%=Translate.Translate("Sider")%>
								    </td>
							    </tr>
							    <tr>
								    <td valign="top">
									    <form id="Pages" action="AnalyzePage.aspx" method="get">
										    <%=getOptimizedPages()%><br />
										    <img align="absmiddle" src="/Admin/Images/Icons/Page_preview.gif" /><a href="javascript:show();"><dw:TranslateLabel ID="lbShowPage" Text="Vis_side" runat="server" /></a><br />
									    </form>
								    </td>							
							    </tr>
						    </table>
						<br />
						<table cellpadding="0" cellspacing="0" class="MyPageSection" height="80">
							<tr>
								<td class="MyPageSectionHeader">
									<img align="absmiddle" border="0" src="/Admin/images/MyPageBullit.gif">&nbsp;<%=Translate.Translate("Indstillinger")%> (<span id="Culture"><%=Google.getLanguage()%>-<%=Google.getCountry(True)%></span>)
								</td>
							</tr>
							<tr>
								<td valign="top">
									<form id="SetSessionVar" action="SetSession.aspx" method="get" target="SetSessionVar">
										<%=Translate.Translate("Sprog") %>:<%=Google.getLanguage()%><br />
										<%=LanguageList(Google.getLanguage(), "Language")%>
										<%=Translate.Translate("Land") %>:<%=Google.getCountry(False)%> <br />
										<%=CountryList(Google.getCountry(True), "Country")%>
										
									</form>
								</td>
							</tr>
						</table>
						<br />
						<table class="MyPageSection" cellspacing="0" cellpadding="0" height="120">
							<tr>
								<td class="MyPageSectionHeader">
									<img src="/Admin/images/MyPageBullit.gif" border="0" align="absmiddle">&nbsp;<%=Translate.Translate("Optimering")%>
								</td>
							</tr>
							<tr>
								<td valign="top">
									<div class="RNO" onmouseover="mo(this)" onmouseout="no(this);" onclick="ac(this, 'PhraseAnalyzer.aspx');" id="PhraseAnalyzer"><img src="text_view.png" alt="" border="0" align="absmiddle"> 1. <%=Translate.Translate("Side tema")%></div>
									<div class="RNO" onmouseover="mo(this)" onmouseout="no(this);" onclick="ac(this, 'PhraseEdit.aspx');" id="PhraseEdit"><img src="text_view.png" alt="" border="0" align="absmiddle"> 2. <%=Translate.Translate("Valgte søgeord")%></div>
									<div class="RNO" onmouseover="mo(this)" onmouseout="no(this);" onclick="ac(this, 'CheckList.aspx');" id="CheckList"><img src="text_view.png" alt="" border="0" align="absmiddle"> 3. <%=Translate.Translate("Tjekliste")%></div>
								</td>							
							</tr>
						</table>
						<br />
						<table class="MyPageSection" cellspacing="0" cellpadding="0" height="80">
							<tr>
								<td class="MyPageSectionHeader">
									<img src="/Admin/images/MyPageBullit.gif" border="0" align="absmiddle">&nbsp;<%=Translate.Translate("Konkurrent analyse")%>
								</td>
							</tr>
							<tr>
								<td valign="top">
									<div class="RNO" onmouseover="mo(this)" onmouseout="no(this);" onclick="ac(this, 'Top10.aspx');" id="Top10"><img src="text_view.png" alt="" border="0" align="absmiddle"> <%=Translate.Translate("Top 10")%></div>
									<div class="RNO" onmouseover="mo(this)" onmouseout="no(this);" onclick="ac(this, 'Compare.aspx');" id="Compare"><img src="text_view.png" alt="" border="0" align="absmiddle"> <%=Translate.Translate("Sammenlign")%></div>
								</td>							
							</tr>
						</table>
						<br />
						<table class="MyPageSection" cellspacing="0" cellpadding="0" height="160">
							<tr>
								<td class="MyPageSectionHeader">
									<img src="/Admin/images/MyPageBullit.gif" border="0" align="absmiddle">&nbsp;<%=Translate.Translate("Statistik")%>
								</td>
							</tr>
							<tr>
								<td valign="top">
									<div class="RNO" onmouseover="mo(this)" onmouseout="no(this);" onclick="ac2(this, 'Report.aspx', '&Report=PhraseReferers');"><img src="text_view.png" alt="" border="0" align="absmiddle"> <%=Translate.Translate("Phrase referers")%></div>
									<div class="RNO" onmouseover="mo(this)" onmouseout="no(this);" onclick="ac2(this, 'Report.aspx', '&Report=Referers');"><img src="text_view.png" alt="" border="0" align="absmiddle"> <%=Translate.Translate("All referers")%></div>
									<div class="RNO" onmouseover="mo(this)" onmouseout="no(this);" onclick="ac2(this, 'Report.aspx', '&Report=Searchphrases');"><img src="text_view.png" alt="" border="0" align="absmiddle"> <%=Translate.Translate("All phrases")%></div>
									<!--
									<div class="RNO" onmouseover="mo(this)" onmouseout="no(this);" onclick="ac2(this, 'Report.aspx', '&Report=Placement');"><img src="text_view.png" alt="" border="0" align="absmiddle"><%=Translate.Translate("Placering")%></div>
									-->
									<div class="RNO" onmouseover="mo(this)" onmouseout="no(this);" onclick="ac2(this, 'Report.aspx', '&Report=Searchengines');"><img src="text_view.png" alt="" border="0" align="absmiddle"> <%=Translate.Translate("Søgemaskiner")%></div>
									<div class="RNO" onmouseover="mo(this)" onmouseout="no(this);" onclick="ac2(this, 'Report.aspx', '&Report=Indexing');"><img src="text_view.png" alt="" border="0" align="absmiddle"> <%=Translate.Translate("Indeksering")%></div>
									<div class="RNO" onmouseover="mo(this)" onmouseout="no(this);" onclick="ac2(this, 'Report.aspx', '&Report=IndexingAll');"><img src="text_view.png" alt="" border="0" align="absmiddle"> <%=Translate.Translate("Alle indekseringer")%></div>
								</td>							
							</tr>
						</table>
						<br />
						<table cellspacing="0" cellpadding="0">
							<%=Gui.HelpButton("SEO", "modules.seo.general")%>
						</table>
								</div>
							</td>
						</tr>
					</table>
				</td>
				<td style="border-right: 1px solid #9faec2;"></td>
				<td valign="top">
					<table cellspacing="0" cellpadding="0" border="0" width="100%" style="height:100%;">
						<tr>
                            <td colspan="2" style=" border-bottom: 1px solid #9faec2; height: 1px;"></td>
						</tr>
						<tr>
							<td width="5" bgColor="#F9F8F3"></td>
							<td>
								<iframe width="100%" height="100%" id="content" src="about:blank" leftmargin="10" topmargin="0" marginheight="0" marginwidth="0" border="0" frameborder="0"></iframe>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<script type="text/javascript">
		<%
		Dim pc As PhraseCollection
		pc = Phrase.getPhrasesByPage(Base.ChkNumber(Base.Request("ID")))
		If pc.Count > 0 Then
		%>
		ac(this, 'CheckList.aspx');
		<%Else%>
		ac(this, 'PhraseAnalyzer.aspx');
		<%End If%>
			
		</script>
		<iframe name="SetSessionVar" width="1" height="1" style="display: none;"></iframe>
	</body>
</html>
<%
 Translate.GetEditOnlineScript()
%>