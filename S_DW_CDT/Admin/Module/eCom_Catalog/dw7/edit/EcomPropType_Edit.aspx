<%@ Page Language="vb" ValidateRequest="false" AutoEventWireup="false" Codebehind="EcomPropType_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.PropTypeEdit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
	<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">

    <asp:Literal ID="propOptionsScript" runat="server" />

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
	function AddPropLine(method, type) {
		if (propGrpAdd && method == "PROPGROUP" && levelA == true) {
			enableClick = true;
			RemoveNoneline("DWRowNoDetailLine1");
			AddDWRowLine("PROPGRP", "_A_");
		}

		if (propFieldAdd && method == "PROPFIELD" && levelB == true) {
			enableClick = true;
			RemoveNoneline("DWRowNoDetailLine2");
			AddDWRowLine("PROPFLD", "_B_");
		}

		if (propOptionAdd && method == "PROPOPTION" && levelC == true) {
			enableClick = true;
			RemoveNoneline("DWRowNoDetailLine3");
			AddDWRowLine("PROPOPT", "_C_");
		}
	}
	
	function saveProperty(close) {
		var typeId = "<%=typeID%>";
		var gId = document.getElementById("groupId");
		var fId = document.getElementById("fieldId");
		var groupId = '';
		var fieldId = '';
		if (gId) {
		    groupId = gId.value;
		}
		if (fId) {
		    fieldId = fId.value;
		}

		document.getElementById('Close').value = close ? 1 : 0;
		document.getElementById('Form1').action = "EcomPropType_Edit.aspx?ID=" + typeId + "&groupId=" + groupId + "&fieldId="+ fieldId
		document.getElementById('Form1').SaveButton.click();
	}	

	function EditPropLine(method, type, key, typeId, langId, activeCnt, totalCnt, postFix) {
			FillDivLayer("LOADING", "", method);
			
			if (parseInt(activeCnt) >= 0) {
				for (var i = 0; i < totalCnt; i++) {
					try {
						var elemArrow = "LineEditDWRow"+ postFix + i;
						if (i == activeCnt) {
							document.getElementById(elemArrow).setAttribute("src","../images/editarrow_small.gif");
						} else {
							document.getElementById(elemArrow).setAttribute("src","../images/editarrow_small_empty.gif");
						}	
							
					} catch(e) {
						//Nothing
					}				
				}
			}
	
			if (type == "GET" && method == "FIELD") {
				var gId = document.getElementById("groupId");
				var fId = document.getElementById("fieldId");
				if (gId != null) {
				    gId.value = key;
				}
				if (fId != null) {
				    fId.value = "";
				}
				window.setTimeout( function() { AddDWRowFromArry("GETPROPFIELD", typeId, "", "", key, langId) }, 10);			
				var txt = "<span style=height:25px; id=DWRowNoDetailLine3><em><%=Translate.JsTranslate("Intet felt valgt.")%></em></span>";
				FillDivLayer('DWEMPTY',txt,'OPTION');

				levelB = true;
				levelC = false;
			}	
			if (type == "GET" && method == "OPTION") {
			    var fId = document.getElementById("fieldId");
				if (fId != null) {
				    fId.value = key;
				}
				window.setTimeout( function() { AddDWRowFromArry("GETPROPOPTION", typeId, "", "", key, langId) }, 10);			

				levelB = true;
				levelC = true;
			}	
			
			enablePropertyButtons();
	}

	
	
	function FillDivLayer(typeStr, fillData, fillLayer) {
		var fillStr = ""
		
		if (typeStr == "LOADING") {
			fillStr = '<br><table border=0 cellpadding=5 cellspacing=0 width="100%"><tr><td align=left valign=middle><img src="../images/loading.gif" border="0"></td></tr></table>';
		}

		if (typeStr == "DWNONE") {
			fillStr = '<br>';
		}
	
		if (fillData != "") {
			fillStr = fillData;
		}

		if (fillLayer == "GROUP") {
			groupListLayer.innerHTML = fillStr;
		}	

		if (fillLayer == "FIELD") {
			if (typeStr == "EMPTY") {
				//fieldListLayer.innerHTML = emptyFields;
			} else {
				fieldListLayer.innerHTML = fillStr;
			}	
		}	

		if (fillLayer == "OPTION") {
			if (typeStr == "EMPTY") {
				//optionListLayer.innerHTML = emptyOption;
			} else {
				optionListLayer.innerHTML = fillStr;
			}	
			
		}	
	}	
	
	</script>	
	
	<script>
	//document.attachEvent("onmouseup", enablePropertyButtons);
	//document.attachEvent("onclick", enablePropertyButtons);
	//window.onload=enablePropertyButtons;
	</script>	
	    <script language="javascript" src="/Admin/FormValidation.js"></script>
	
  </head>
  <body MS_POSITIONING="GridLayout" style="background: #DFE9F5 url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;">

	<asp:Literal id="BoxStart" runat="server"></asp:Literal>
	
		<form id="Form1" method="post" runat="server">
            <input id="Close" type="hidden" name="Close" value="0" />
			<input type="hidden" id="groupId" name="groupId" />
			<input type="hidden" id="fieldId" name="fieldId" />
			<dw:TabHeader id="TabHeader1" runat="server" TotalWidth="100%"></dw:TabHeader>

			<table border="0" cellpadding="0" cellspacing="0" class="tabTable100" id="DW_Ecom_tableTab">
			<tr>
			<td valign="top">
		
			<div id="Tab1">
				<br>

				<table border=0 cellpadding=0 cellspacing=0 width='95%' style='width:95%;'>
				<tr><td>

				<fieldset style='width: 100%;margin:5px;'><legend class=gbTitle><%=Translate.Translate("Gruppefelt")%>&nbsp;</legend>

				<table border=0 cellpadding=2 cellspacing=0 width='100%' style='width:100%;'>
				<tr><td>
					<table border=0 cellpadding=2 cellspacing=2 width="100%">
					<tr>
					<td width="100"><dw:TranslateLabel id="tLabelName" runat="server" Text="Name"></dw:TranslateLabel></td>
					<td>
				        <div id="errNameStr" name="errNameStr" style="color: Red;"></div>
				        <asp:textbox id="NameStr" CssClass="NewUIinput" runat="server"></asp:textbox>
					</td>
					</tr>
					</table>
				</td></tr>
				</table>
				</fieldset><br><br>

		        <fieldset style="width: 100%;margin:5px;"><legend class=gbTitle><%=Translate.Translate("Grupper")%>&nbsp;</legend>
					<div height='100%' id="PropDivList_A_" style='height:100px;width:100%;overflow:yes;overflow-x:hidden;'>
					<div id="groupListLayer" style='display:;'>
						<asp:Literal id="groupList" runat="server"></asp:Literal>
					</div>
					</div>
				</fieldset><br><br>

		        <fieldset style="width: 100%;margin:5px;"><legend class=gbTitle><%=Translate.Translate("Felter")%>&nbsp;</legend>
					<div height='100%' id="PropDivList_B_" style='height:100px;width:100%;overflow:yes;overflow-x:hidden;'>
					<div id="fieldListLayer" style='display:;'>		        
						<asp:Literal id="fieldList" runat="server"></asp:Literal>
					</div>
					</div>	
		        </fieldset><br><br>

		        <fieldset style="width: 100%;margin:5px;"><legend class=gbTitle><%=Translate.Translate("Valgmuligheder")%>&nbsp;</legend>
					<div height='100%' id="PropDivList_C_" style='height:100px;width:100%;overflow:yes;overflow-x:hidden;'>
					<div id="optionListLayer" style='display:;'>
						<asp:Literal id="optionList" runat="server"></asp:Literal>
					</div>
					</div>	
		        </fieldset><br><br>
				
				</td></tr>
				</table>

				<br>								
				
				<asp:Button id="SaveButton" style="display:none;" runat="server"></asp:Button>
				<asp:Button id="DeleteButton" style="display:none;" runat="server"></asp:Button>

			</div>
			
			</td>
			</tr>
			</table>			

		<iframe frameborder="1" name="EcomUpdator" id="EcomUpdator" width="1" height="1" align="right" marginwidth="0" marginheight="0" border="0" frameborder="0" src="EcomUpdator.aspx" border="0"></iframe>	

		</form>
	
	<asp:Literal id="BoxEnd" runat="server"></asp:Literal>
	<asp:Literal id="buttonEnables" runat="server"></asp:Literal>
	<asp:Literal id="hiddenFieldValues" runat="server"></asp:Literal>
	<script>
        addMinLengthRestriction('NameStr', 1, '<%=Translate.JsTranslate("A name is needed")%>');
        activateValidation('Form1');
    </script>
	
  </body>
</html>


<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>