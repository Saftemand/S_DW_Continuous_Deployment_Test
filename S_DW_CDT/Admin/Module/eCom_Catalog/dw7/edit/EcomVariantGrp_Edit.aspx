<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EcomVariantGrp_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomVariantGrp_Edit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1" />
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1" />
    <meta name="vs_defaultClientScript" content="JavaScript" />
    <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5" />
    <link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css" />
    
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
            background: #DFE9F5 url(/Admin/Images/Ribbon/UI/List/Pipe.gif) repeat-x scroll left bottom;
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

        input.disabled {
            user-select : none;
            -moz-user-select : none;
            -webkit-user-select : none;
            color: gray;
            cursor: pointer;
        }
    </style>

    <script type="text/javascript" src="../images/functions.js"></script>
    <script type="text/javascript" src="../images/addrows.js"></script>
    <script type="text/javascript" src="../images/layermenu.js"></script>
    <script type="text/javascript" src="/Admin/FileManager/FileManager_browse2.js"></script>

    <script type="text/javascript">
        strHelpTopic = 'ecom.settings.variants.edit';
		var isDefaultLanguage = '<%=eCommerce.Common.Context.LanguageID%>' != '<%=Dynamicweb.eCommerce.Common.Application.DefaultLanguage.LanguageID%>';

		$(document).observe('dom:loaded', function () {
		    window.focus(); // for ie8-ie9 
		    document.getElementById('NameStr').focus();
		}); 

		function TabHelpTopic(tabName) {
			switch(tabName) {
				case 'GENERAL':
					strHelpTopic = 'ecom.settings.variants.edit.general';
					break;
				case 'ATTRIBUTES':
					strHelpTopic = 'ecom.settings.variants.edit.attributes';
					break;
				case 'RELATIONS':
					strHelpTopic = 'ecom.settings.variants.edit.relations';
					break;
				default:
					strHelpTopic = 'ecom.settings.variants.edit';
			}
		}
	
        function SaveVariantGroup() {
			submitTabID();
			document.getElementById('Form1').SaveButton.click();
		}

		function submitTabID() {
			var setTabID = "";
			
			var allDivs;
			if (isDefaultLanguage)
                allDivs = document.getElementsByTagName("DIV")
			
			try {
				for (var a = 0; a < allDivs.length; a++) {
					if (allDivs[a].className != "" && 
					    (allDivs[a].style.display == "" || allDivs[a].style.display == "block") &&
					    allDivs[a].className.indexOf("Tab") > -1
					) {
            			setTabID = allDivs[a].id;
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
			document.getElementById('Form1').Tab.value = setTabID
		}	
	
		function EnableVariantOptionLine(LineNumb) {
			var shadowField = document.getElementById('VariantOptionShadowLine'+ LineNumb);
			var normalField = document.getElementById('VariantOptionNormalLine'+ LineNumb);
			var valueField = document.getElementById('VARGRP_Name'+ LineNumb);

			var shadowButton = document.getElementById('VariantOptionShadowButton'+ LineNumb);
			var normalButton = document.getElementById('VariantOptionNormalButton'+ LineNumb);


			if (shadowField.style.display == "") {
			    shadowField.style.display = "none";
			    normalField.style.display = "";
			    
			    shadowButton.style.display  = "none"
			    normalButton.style.display = "";
			    
			    valueField.disabled = false;
			    
				valueField.focus();
				valueField.select();
			}
		
		}
		
        function DisableVariantOptionLine(LineNumb) {
		    var shadowField = document.getElementById('VariantOptionShadowLine'+ LineNumb);
			var normalField = document.getElementById('VariantOptionNormalLine'+ LineNumb);
			var valueField = document.getElementById('VARGRP_Name'+ LineNumb);
			
			var shadowButton = document.getElementById('VariantOptionShadowButton'+ LineNumb);
			var normalButton = document.getElementById('VariantOptionNormalButton'+ LineNumb);			

            try {
			    if (normalField.style.display == "") {
			        shadowField.style.display = "";
			        normalField.style.display = "none";
    			    
			        shadowButton.style.display  = ""
			        normalButton.style.display = "none";			    
	    	    }
			} catch(e) {
				//Nothing
			}	    	

			valueField.disabled = true;			
		}	
		
        var xhttp = false;
        function getXHTTPObject() {     
	        if (window.ActiveXObject) {  
                try {  
			        // IE 6 and higher 
			        xhttp = new ActiveXObject("MSXML2.XMLHTTP"); 
			        xhttp.onreadystatechange=getParameters_callback; 
                } catch (e) { 
                    try { 
                        // IE 5 
                        xhttp = new ActiveXObject("Microsoft.XMLHTTP"); 
				        xhttp.onreadystatechange=getParameters_callback; 
                    } catch (e) { 
                        xhttp=false; 
                    } 
                } 
	        } 
            else if (window.XMLHttpRequest) { 
                try { 
                    // Mozilla, Opera, Safari ... 
                    xhttp = new XMLHttpRequest();
                    /* little hack */
                    xhttp.onreadystatechange = function () {
				        getParameters_callback();
			        };

                } catch (e) { 
                    xhttp=false;
                } 
            } 
        }

        function getParameters_callback() {
            var value;                 
            if (xhttp.readyState == 4) {
		        if(xhttp.status==200) {
			        try {
				        value = xhttp.responseText
				        execScripts(parameterdiv.innerHTML);
			        } catch(e) {
				        //alert('exception' + e);
				        /*parameterdiv.innerHTML = "Error in AJAX" + e.Message;*/
			        }
		        }
            }

            return value;
        }		
        		
        function getAjaxPage(url) {
	        getXHTTPObject();
        	
	        if (!xhttp) { 
                return; 
            } 
        	
	        /* lets get data */
	        xhttp.open("GET",url,false);
	        xhttp.setRequestHeader("Cache-Control", "no-store, no-cache, must-revalidate");
            xhttp.send(null);
            
            return xhttp.responseText;
        }
        		
		
		function SetDefaultOptionName(VarID, LineId) {
		    var valueField = document.getElementById('VARGRP_Name'+ LineId);
		    var valueShadowField = document.getElementById('VARSHADOWGRP_Name'+ LineId);
		    var defaultValue = ""
		    
		    try {
		        defaultValue = getAjaxPage("EcomUpdator.aspx?CMD=GetDefaultVariantOption&ID="+ VarID + "&CacheKiller=" + new Date().getTime());
	        } catch(e) {
                //Nothing
	        }		    
	        
		    valueField.value = defaultValue;
		    valueShadowField.value = defaultValue;
        }		    
		
		function deleteVariantOption(optionId, rowCnt, varGrpId, varCnt) {
		    var msg = '';

		    if (isDefaultLanguage) {
                showMessage = false; // Used in DeleteDWRow
                msg = '<%=Translate.JsTranslate("Slet?\nDette sletter kun den oversatte variant.\nHvis varianten ønskes slettet, skal dette gøres fra standard sproget.")%>';
            }
		
		    if (msg != '') {
			    if (confirm(msg)) {
    		        DeleteDWRow(optionId, rowCnt, 'VARIANT', varGrpId, '', '', '');
    		        SetDefaultOptionName(optionId, varCnt)
                    DisableVariantOptionLine(varCnt);
        	    }
        	} else {
        	    showMessage = true;
  		        if (DeleteDWRow(optionId, rowCnt, 'VARIANT', varGrpId, '', '', ''))
  		            DeleteTR('DWRowLineTable', 'DWRowLineTR', rowCnt, '', '');
  		    }
  		    showMessage = true;
  		}

  		function save(close) {
  		    var alertmsg = '<%=Translate.JsTranslate("Add variants before saving a variant group")%>';
  		    var alertmsgfill = '<%=Translate.JsTranslate("Fill or remove empty variant group before saving")%>';
  		    if ($('DWRowLineTable').select('tr').length > 1) {
  		        if ($('DWRowLineTable').select('input[id^=VARGRP_Name][value=]').length == 0) {
  		            $("Close").value = close ? 1 : 0;
  		            $('Form1').SaveButton.click();
  		        } else 
  		            alert(alertmsgfill);
  		        
  		    } else 
  		        alert(alertmsg);  		    
        }

        var deleteMsg = '<%= DeleteMessage %>';
        function deleteVariant() {
            if (confirm(deleteMsg)) document.getElementById('Form1').DeleteButton.click();
        }        		
    </script>

    <script type="text/javascript" src="/Admin/FormValidation.js"></script>

</head>
<body style="background: #DFE9F5 url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;">
    <asp:Literal ID="BoxStart" runat="server"></asp:Literal>
    <form id="Form1" method="post" runat="server">
        <input type="hidden" name="Tab" />
        <input id="Close" type="hidden" name="Close" value="0" />
        <asp:Literal ID="NoVarsExistsForLanguageBlock" runat="server"></asp:Literal>
        <dw:TabHeader ID="TabHeader1" runat="server" TotalWidth="100%"></dw:TabHeader>
        <table border="0" cellpadding="0" cellspacing="0" class="tabTable100" id="DW_Ecom_tableTab">
            <tr>
                <td valign="top">
                    <div id="Tab1" class="Tab1Div">
                        <br />
                        
                            <table border="0" cellpadding="0" cellspacing="0" width='95%' style='width: 95%;'>
                                <tr>
                                    <td>
                                        <fieldset style='width: 100%; margin: 5px;'>
                                            <legend class="gbTitle"><%=Translate.Translate("Variantgruppe")%>&nbsp;</legend>
                                            <table border="0" cellpadding="2" cellspacing="0" width='100%' style='width: 100%;'>
                                                <tr>
                                                    <td>
                                                        <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                                            <tr>
                                                                <td width="170">
                                                                    <dw:TranslateLabel ID="tLabelName" runat="server" Text="Navn" />
                                                                </td>
                                                                <td>
                                                                    <div id="errNameStr" style="color: Red;"></div>
                                                                    <asp:TextBox ID="NameStr" CssClass="NewUIinput" runat="server"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="170">
                                                                    <dw:TranslateLabel ID="tLabelDescription" runat="server" Text="Beskrivelse" />
                                                                </td>
                                                                <td>
                                                                    <div id="errDescriptionStr" style="color: Red;"></div>
                                                                    <asp:TextBox ID="DescriptionStr"  CssClass="NewUIinput" runat="server"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                        <br />
                                        <br />
                                    </td>
                                </tr>
                            </table>
                            <br />
                        
                        <asp:Button ID="SaveButton" Style="display: none;" runat="server"></asp:Button>
                        <asp:Button ID="DeleteButton" Style="display: none;" runat="server"></asp:Button>
                    </div>
                    <div id="Tab2" class="Tab2Div" style="display: none;">
                        <asp:Literal ID="variantList" runat="server"></asp:Literal>
                    </div>
                    <div id="Tab3" class="Tab3Div" style="display: none;">
                        <dw:List runat="server" Title="Relations" ID="varGroupRelations" ShowPaging="True" PageSize="25" HandlePagingManually="True" PageNumber="1" UseCountForPaging="True" ShowCount="True">
                            <Columns>
		                        <dw:ListColumn runat="server" Name="Product name" ItemAlign="Left" HeaderAlign="Left" />
                            </Columns>
                        </dw:List>
                    </div>
                </td>
            </tr>
        </table>
    </form>
    <asp:Literal ID="BoxEnd" runat="server"></asp:Literal>
    <iframe name="EcomUpdator" id="EcomUpdator" width="1" height="1" align="right" marginwidth="0" marginheight="0" frameborder="0" src="EcomUpdator.aspx"></iframe>

    <script type="text/javascript">
        addMinLengthRestriction('NameStr', 1, '<%=Translate.JsTranslate("A name needs to be specified")%>');
        activateValidation('Form1');
    </script>
</body>
</html>
<%=Dynamicweb.Gui.SelectTab()%>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()%>