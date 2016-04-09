<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CheckList.aspx.vb" inherits="Dynamicweb.Admin.CheckList"%>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="ad" TagName="AnalyzedData" Src="AnalyzedData.ascx" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
	<head>
		<title></title>
		<script type="text/javascript" src="AnalyzedData.js"></script>
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<script language="javascript">
		    function InitializeForm() {
                var areas = null;
                
                SeoForm.AttachEvent('click', document.getElementById('analyzedData_cmdSave'), SeoForm.Submit);
                
                SeoForm.AddField(new SeoField('analyzedData_txTitle', 'Title'));
                SeoForm.AddField(new SeoField('analyzedData_txKeywords', 'Keywords'));
                SeoForm.AddField(new SeoField('analyzedData_txDescription', 'Description'));
                
                areas = document.getElementsByTagName('textarea');
                if(areas) {
                    for(var i = 0; i < areas.length; i++) {
                        if(areas[i].id.indexOf('Paragraph_') >= 0)
                            SeoForm.AddField(new SeoField(areas[i].id, areas[i].id.replace('analyzedData_', '')));
                    }
                }
            }
		
			function send(){
				if(document.forms.urls){
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
				width:90%;
				font-family:verdana;
				font-size:10px;
				background-color:#d1d1d1;
			}
			
			.bar {
				height:100%;
				filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#2059CE', EndColorStr='#11356F');
			}
			.r{background-color:#e4622e;}
			.y{background-color:#fad551;}
			.g{background-color:#a5c65d;}
			
			.hiddentab{width:287px;}
			#GetHtmlTableTabs{width:649px;}
		</style>
	</head>
	<body onload="parent.ac1(parent.document.getElementById('CheckList')); InitializeForm();">
		<dw:tabheader id="TabHeader1" runat="server" title="Check list" returnwhat="All" headers="Check list"></dw:tabheader>
		<table border="0" cellpadding="0" cellspacing="0" class="tabTable" style="width:650px;">
			<tr>
				<td valign="top">
				<br>
					<form action="CheckList.aspx" method="get" id="urlsForm" name="urls" runat="server">
					<input type="hidden" value="<%=Base.Request("ID")%>" name="ID">
					<table border="0" cellpadding="0" width="598">
						<tr>
							<td>
							<%=Gui.GroupBoxStart(Translate.Translate("Legend"))%>
							<br />
							<table cellspacing="0" class="t">
								<tr>
									<td width="25" class="g">&nbsp;</td>
									<td><dw:TranslateLabel ID="lbNoActionNeeded" Text="No action needed" runat="server" /></td>
								</tr>
								<tr>
									<td width="25" class="y">&nbsp;</td>
									<td><dw:TranslateLabel ID="lbPossibleAction" Text="Possible problem" runat="server" /></td>
								</tr>
								<tr>
									<td width="25" class="r">&nbsp;</td>
									<td><dw:TranslateLabel ID="NeedsAction" Text="Needs action" runat="server" /></td>
								</tr>
							</table>
							<%=Gui.GroupBoxEnd()%>
							</td>
						</tr>
						<tr>
							<td>
								<ad:AnalyzedData EnableParagraphEditing="false" ID="analyzedData" runat="server" />
							</td>
						</tr>
						<tr>
							<td><%=getCheckList()%></td>
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
</html>