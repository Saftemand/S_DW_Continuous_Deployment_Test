<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EcomStockGrp_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomStockGrp_Edit" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		
			<dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
		<link rel="STYLESHEET" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
		
				<style type="text/css">
            BODY.margin
            {
                margin: 0px;
            }
            input, select, textarea
            {
                font-size: 11px;
                font-family: verdana,arial;
            }
            .Tab1Div, .Tab2Div, .Tab3Div {}
            
            #DWRowHeadLine
            {
                background: #DFE9F5 url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;
                height: 20px;
            }
            .OutlookHeaderStart
            {
                font: 11px Verdana, Helvetica, Arial, Tahoma;
                border-bottom: 0px !important;
                font-weight: normal;
                padding-left: 5px;
            }
            .OutlookHeader
            {
                font: 11px Verdana, Helvetica, Arial, Tahoma;
                border-bottom: 0px !important;
                font-weight: normal;
                border-left: 2px outset white;
                padding-left: 5px;
            }
        </style>
        
		<script type="text/javascript" language="JavaScript" src="../images/functions.js"></script>
		<script type="text/javascript" language="JavaScript" src="../images/addrows.js"></script>
		<script>
	document.attachEvent("onmouseup", enableAddDWRow);
	document.attachEvent("onclick", enableAddDWRow);
	window.onload=enableAddDWRow;
		</script>
		<script src="/Admin/FileManager/FileManager_browse2.js" type="text/javascript"></script>
		
	<script type="text/javascript">
		strHelpTopic = 'ecom.controlpanel.stockstate.edit';
		function TabHelpTopic(tabName) {
			switch(tabName) {
				case 'GENERAL':
					strHelpTopic = 'ecom.controlpanel.stockstate.edit.general';
					break;
				case 'STATES':
					strHelpTopic = 'ecom.controlpanel.stockstate.edit.states';
					break;
				default:
					strHelpTopic = 'ecom.controlpanel.stockstate.edit';
			}
		}

		$(document).observe('dom:loaded', function () {
		    window.focus(); // for ie8-ie9 
		    document.getElementById('NameStr').focus();
		}); 

		//
		function submitStock() {
			submitTabID();
			document.getElementById('Form1').SaveButton.click();
		}

		function submitTabID() {
			var setTabID = "";
			
			try {
				for (a=0; a < allDivs.length; a++) {
					if (allDivs[a].className != "" && (allDivs[a].style.display == "" || allDivs[a].style.display == "block")) {
						if (allDivs[a].id.indexOf("Tab") > -1) {
							setTabID = allDivs[a].id;
						}	
					} 
				}
				
				var oldURL = GetFileNameFromUrl(location.href);
				var newURL = "";
				var qsURL = GetQueryFromUrl(location.href);
				var qsURL2 = GetTabIDFromQs(qsURL);
		
				oldURL = ""+ oldURL.toLowerCase();
				newURL = oldURL +"?Tab="+ setTabID;
	
				if (qsURL2 != "") {
					newURL += "&"+ qsURL2;
				}
			
				if (setTabID != "") {
					document.getElementById('Form1').action = newURL;
				}
				
			} catch(e) {
				//Nothing
			}
			
			document.getElementById('Form1').Tab.value = setTabID;
		}
		//
		function toggleEditRow(rowId){
			mode = document.getElementById("DWRowLineTR" + rowId).disabled == true
			document.getElementById("DWRowLineTR" + rowId + "info").style.display = (mode) ? "none" : "";
			document.getElementById("DWRowLineTR" + rowId).disabled = (mode) ? false : true;
			document.getElementById("DWRowLineTR" + rowId).style.display = (mode) ? "" : "none";
		}
		function saveStockGrp(close) {
		    document.getElementById("Close").value = close ? 1 : 0;
		    document.getElementById('Form1').SaveButton.click();
		}

		var deleteMsg = '<%= DeleteMessage %>';
		function deleteStockGrp() {
		    if (confirm(deleteMsg)) document.getElementById('Form1').DeleteButton.click();
		}
		</script>
	    <script language="javascript" src="/Admin/FormValidation.js"></script>	
	</HEAD>
	
	<body MS_POSITIONING="GridLayout" style="background: #DFE9F5 url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;">
		<asp:Literal id="BoxStart" runat="server"></asp:Literal>
		<form id="Form1" method="post" runat="server">
		<input type="hidden" name="Tab">
        <input id="Close" type="hidden" name="Close" value="0" />
			<dw:TabHeader id="TabHeader1" runat="server" TotalWidth="100%"></dw:TabHeader>
			<table border="0" cellpadding="0" cellspacing="0" class="tabTable100" id="DW_Ecom_tableTab">
				<tr>
					<td valign="top">
						<div id="Tab1" class="Tab1Div" >
							<br>
							
								<table border="0" cellpadding="0" cellspacing="0" width='95%' style='WIDTH:95%'>
									<tr>
										<td>
											<fieldset style='MARGIN: 5px;WIDTH: 100%'><legend class="gbTitle"><%=Translate.Translate("Indstillinger")%></legend>
												<table border="0" cellpadding="2" cellspacing="0" width='100%' style='WIDTH:100%'>
													<tr>
														<td>
															<table border="0" cellpadding="2" cellspacing="2" width="100%">
																<tr>
																	<td width="170"><dw:TranslateLabel id="tLabelName" runat="server" Text="Navn"></dw:TranslateLabel></td>
																	<td>
					                                                    <div id="errNameStr" name="errNameStr" style="color: Red;"></div>
					                                                    <asp:textbox id="NameStr" CssClass="NewUIinput" runat="server"></asp:textbox>
					                                                </td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</fieldset>
											<br>
											<br>
										</td>
									</tr>
								</table>
								<br>
							
							<asp:Button id="SaveButton" style="DISPLAY:none" runat="server"></asp:Button>
							<asp:Button id="DeleteButton" style="DISPLAY:none" runat="server"></asp:Button>
						</div>
						<div id="Tab2" class="Tab2Div" style="DISPLAY:none">
							<asp:Literal id="stockList" runat="server"></asp:Literal>
						</div>
					</td>
				</tr>
			</table>
		</form>
		<asp:Literal id="BoxEnd" runat="server"></asp:Literal>
		<iframe frameborder="1" name="EcomUpdator" id="EcomUpdator" width="1" height="1" align="right"
			marginwidth="0" marginheight="0" border="0" src="EcomUpdator.aspx"></iframe>
    <script>
        addMinLengthRestriction('NameStr', 1, '<%=Translate.JsTranslate("A name needs to be specified")%>');
        activateValidation('Form1');
    </script>
    <%=Dynamicweb.Gui.SelectTab()%>
		<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
	</body>
</HTML>
