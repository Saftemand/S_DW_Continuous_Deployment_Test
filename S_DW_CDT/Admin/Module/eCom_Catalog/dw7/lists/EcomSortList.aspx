<%@ Page Language="vb" AutoEventWireup="false" Codebehind="EcomSortList.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.SortList" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
		<meta content="JavaScript" name="vs_defaultClientScript" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	
	<dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
	
	<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css" />
	<link rel="STYLESHEET" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
		
		<style type="text/css">
		    body.margin {
			    margin-top: 0px;
			    margin-left: 0px;
			    margin-right: 0px;
			    margin-bottom: 0px;
		    }
    		
		    input,select,textarea {font-size: 11px; font-family: verdana,arial;}
		</style>		
		
		<script type="text/javascript">
		    function checkSortInput() {
			    document.getElementById('Form1').ElemSort.multiple = true;
			    setTimeout('submitSort()', 200);
		    }

		    function submitSort(){
			    for (i = 0; i < document.getElementById('Form1').ElemSort.length; i++) {
				    document.getElementById('Form1').ElemSort.options[i].selected = true;
			    }
			    document.getElementById('Form1').SaveButton.click();
		    }
    		
		    function MoveUp(){
			    ID = document.getElementById('Form1').ElemSort.selectedIndex;
			    if (ID > 0) {
				    val1 = document.getElementById('Form1').ElemSort[ID - 1].value;
				    val2 = document.getElementById('Form1').ElemSort[ID - 1].text;
				    document.getElementById('Form1').ElemSort.options[ID - 1] = new Option(document.getElementById('Form1').ElemSort[ID].text, document.getElementById('Form1').ElemSort[ID].value);
				    document.getElementById('Form1').ElemSort.options[ID] = new Option(val2, val1);
				    document.getElementById('Form1').ElemSort.options[ID - 1].selected = true;
				    ToggleImage(ID - 1);
			    }
		    }
    		
		    function MoveDown(){
			    ID = document.getElementById('Form1').ElemSort.selectedIndex;
			    if (ID >= 0 && ID != document.getElementById('Form1').ElemSort.length - 1) {
				    val1 = document.getElementById('Form1').ElemSort[ID + 1].value;
				    val2 = document.getElementById('Form1').ElemSort[ID + 1].text;
				    document.getElementById('Form1').ElemSort.options[ID + 1] = new Option(document.getElementById('Form1').ElemSort[ID].text, document.getElementById('Form1').ElemSort[ID].value);
				    document.getElementById('Form1').ElemSort.options[ID] = new Option(val2, val1);
				    document.getElementById('Form1').ElemSort.options[ID + 1].selected = true;
				    ToggleImage(ID + 1);
			    }
		    }
    		
		    function ToggleImage(ID){
			    if (ID > -1) {
				    if (ID == 0) {
					    document.images("up").src = '/Admin/images/Collapse_inactive.gif';
					    document.images("up").alt = '';
				    } else {
					    document.images("up").src = '/Admin/images/Collapse.gif';
					    document.images("up").alt = '<%=Translate.JsTranslate("Flyt op")%>';
				    }
    			
				    if (ID == document.getElementById('Form1').ElemSort.length - 1) {
					    document.images("down").src = '/Admin/images/Expand_inactive.gif';
					    document.images("down").alt = '';
				    } else {
					    document.images("down").src = '/Admin/images/Expand_active.gif';
					    document.images("down").alt = '<%=Translate.JsTranslate("Flyt ned")%>';
				    }
			    } else {
				    document.images("up").src = "/Admin/images/Collapse_inactive.gif";
				    document.images("up").alt = "";
				    document.images("down").src = "/Admin/images/Expand_inactive.gif";
				    document.images("down").alt = "";
			    }
		    }
		</script>		
		
	</head>
	<body MS_POSITIONING="GridLayout" style="background: #DFE9F5 url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;">
	
	<asp:Literal id="BoxStart" runat="server"></asp:Literal>
	
		<form id="Form1" method="post" runat="server">
		<dw:TabHeader id="TabHeader1" runat="server" TotalWidth="100%"></dw:TabHeader>
		
			<table border="0" cellpadding="0" cellspacing="0" class="tabTable100" id="DW_Ecom_tableTab">
			<tr>
			<td valign="top">
		
			<div id="Tab1">
				<table>
					<tr>
						<td></td>
						<td rowspan="2" align="left" valign="middle">
							<a href='JavaScript:MoveUp();'>
							    <img src='/Admin/images/Collapse_inactive.gif' width="16" height="16" border="0" name="up" alt="" />
							</a>
							<br />
							<a href='JavaScript:MoveDown();'>
							    <img src='/Admin/images/Expand_inactive.gif' width="16" height="16" border="0" name="down" alt="" />
							</a>
						</td>
					</tr>
					<tr>
						<td>
							<asp:Literal id="SortedList" runat="server"></asp:Literal>
						</td>
					</tr>
					<tr>
						<td colspan=2>
							<asp:Button id="SaveButton" style="display:none;" runat="server" />
						</td>
					</tr>
				</table>
			</div>
			
			</td>
			</tr>
			</table>

		</form>

	<asp:Literal id="BoxEnd" runat="server"></asp:Literal>

	</body>
</html>

<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>