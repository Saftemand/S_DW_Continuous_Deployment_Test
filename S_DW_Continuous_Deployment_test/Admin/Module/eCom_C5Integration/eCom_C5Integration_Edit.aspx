<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="eCom_C5Integration_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eCom_C5Integration_Edit" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <link rel="STYLESHEET" type="text/css" href="/admin/Stylesheet.css" />
   	<script type="text/javascript" language="JavaScript" src="/Admin/Module/eCom_Catalog/images/ObjectSelector.js"></script>
    <script type="text/javascript" src="/Admin/Module/eCom_Catalog/images/permission/prototype.js"></script>    

    <script language="javascript" type="text/javascript">
    function importC5(importType) {
	    var d = new Date();
	    
	    var importFileName;
	    var shopID;
	    //var language;
	    var groupID;
	    var additionalUrl;
	    
	    
	    if (importType == "Products") {
	        importFileName = document.getElementById("C5SettingProductImportFileName").value;
	        //language = document.getElementById("C5SettingProductLanguage").value;; 
	        groupID = document.getElementById("C5SettingProductParentGroup").value;
	    
	        additionalUrl = "&parentGroupID_products=" + groupID + ""
	        
	    } else if (importType == "Groups") {
   	        importFileName = document.getElementById("C5SettingGroupImportFileName").value;
            shopID = document.getElementById("C5SettingGroupShop").value; 
	        //language = document.getElementById("C5SettingGroupLanguage").value; 
	        groupID = document.getElementById("C5SettingGroupParentGroup").value;
	        
	        additionalUrl = "&parentGroupID_groups=" + groupID + "&shopID=" + shopID + ""
	    }
	    
	    //var url = "/Admin/Module/Integration/Wizard.aspx?action=import" + importType + "&fileType=csv&importType=C5&importFileName=" + importFileName + "&language=" + language + "" + additionalUrl + "&ajax=doMessageCount&Time=" + d.getMilliseconds()
	    var url = "/Admin/Module/Integration/Wizard.aspx?action=import" + importType + "&fileType=csv&importType=C5&importFileName=" + importFileName + "" + additionalUrl + "&ajax=doMessageCount&Time=" + d.getMilliseconds()
	    
	    if (importFileName != "") {
    	    ajaxLoader(url, "ImportMessageFor" + importType)
	    } else {
       	    alert("<%=Translate.JsTranslate("Please select a file") %>");
	    }
	}
	
	function ChangeImportInterface() {
	    var method = getRadioValue("impType_radio");
	
	    if (method == "Products") {
	        document.getElementById("Block2").style.display = "none";
	        document.getElementById("Block3").style.display = "block";
	        
	        document.getElementById("ProductImpButTd").style.display = "block";
	        document.getElementById("GroupImpButTd").style.display = "none";
	    } else if (method == "Groups") {
	        document.getElementById("Block2").style.display = "block";
	        document.getElementById("Block3").style.display = "none";
	        
	        document.getElementById("ProductImpButTd").style.display = "none";
	        document.getElementById("GroupImpButTd").style.display = "block";
	        
	        var groupShopRadio = getRadioValue("groupShopRadio");
	        if (groupShopRadio == "group") {
	            document.getElementById("Selector_Shop").style.display = "none";
	            document.getElementById("Selector_ParentGroup").style.display = "block";
	        }
	        else if (groupShopRadio == "shop") {
	            document.getElementById("Selector_Shop").style.display = "block";
	            document.getElementById("Selector_ParentGroup").style.display = "none";
	        }
	        
	    }
	}
	
	function getRadioValue(radioName) {
	    var radios = document.getElementsByName(radioName);
	    for (var i = 0; i < radios.length; i++)
	        if (radios[i].checked)
	            return radios[i].value;
	    return "";
	}	
    
    function ajaxLoader(url,divId) {
    
        new Ajax.Updater(divId, url, {
            asynchronous: true, 
            evalScripts: true,
            method: 'get',
            
            onLoading: function(request) {
                $(divId).update("<img src='../eCom_Catalog/images/ajaxloading.gif' style='text-align:center;margin:5px;padding:5px;' /> <span class='disableText'><%=Translate.JsTranslate("Requesting content...")%></span>");
                changeCursor("load");
            },

            onFailure: function(request) {
                $(divId).update("<br/><span class='disableText' style='text-align:center;margin:5px;padding:5px;'><%=Translate.JsTranslate("Fejl")%> : "+ request.responseText +"</span>");
                changeCursor("");
            },

            onComplete: function(request) {
                var msg = "<%=Translate.JsTranslate("Fejl i import format")%>";
                if (request.responseText == "true") {
                    msg = "<%=Translate.JsTranslate("Import færdig")%>";
                } 
                $(divId).update("<br/><span style='text-align:center;margin:5px;padding:5px;'>" + msg + "</span>");
                changeCursor("");
            },

            onSuccess: function(request) {
                changeCursor("");
            },
            
            onException: function(request) {
                $(divId).update("<br/><span class='disableText' style='margin:5px;padding:5px;'><%=Translate.JsTranslate("Fejl")%> : "+ request.responseText +"</span>");
                changeCursor("");
            }
            
        } );

    }    
    
    
    function changeCursor(cursortype) {
        try {
            var filter = "progid:DXImageTransform.Microsoft.Alpha(opacity=30);progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);-moz-opacity: 0.4;";

            if (cursortype == "load") {
    	        document.body.style.filter = filter;
    	        document.body.disabled = true;
    	        document.getElementById("GroupImpBut").disabled = true;
    	        document.getElementById("ProductImpBut").disabled = true;
            } else {
                document.body.style.filter = "";
                document.body.disabled = false;
                document.getElementById("GroupImpBut").disabled = false;
                document.getElementById("ProductImpBut").disabled = false;
            }	
	        document.body.style.cursor = cursortype;
        } catch(e) {
	        //Nothing
        }	
    }    
    
    function submitForm() {
        document.getElementById("CMD").value = "SAVE"
        document.getElementById('Form1').submit();
    }
    
    function HideImportButton() {
        document.getElementById("GroupImpBut").disabled = true;
        document.getElementById("ProductImpBut").disabled = true;
    }
    function ShowImportButton() {
        document.getElementById("GroupImpBut").disabled = false;
        document.getElementById("ProductImpBut").disabled = false;
    }
    </script>    
    
</head>
<body>


<dw:TabHeader ID="TabHeaderC5" runat="server" ReturnWhat="All" Navigation="false" TotalWidth="" Title="C5 Integration" Headers="Import[#onmouseup=ShowImportButton();#], Notification[#onmouseup=HideImportButton();#]" />  

<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
    <tr>
        <td valign="top">
            
            <form id="form1" runat="server">
            <input name="CMD" id="CMD" type="hidden" value="" />
        
            <div id="Tab1" class="Tab1Div" style="display:block">
            
                <dw:groupboxstart id="Groupboxstart4" runat="server" title="Type" />
                <div id="Block0" style="display:block;">
                    <input id="impType_radio1" name="impType_radio" type="radio" onclick="ChangeImportInterface();" value="Products" /> <label for="impType_radio1"><%=Translate.JsTranslate("Import products")%>        </label><br />
                    <input id="impType_radio2" name="impType_radio" type="radio" onclick="ChangeImportInterface();" value="Groups" />   <label for="impType_radio2"><%=Translate.JsTranslate("Import product groups")%>  </label><br />
                </div>
                <dw:groupboxend id="Groupboxend4" runat="server" />      
            
		        <div id="Block2" style="display:none;">
                    <dw:groupboxstart id="Groupboxstart2" runat="server" title="Produktgrupper" />
			        <table cellpadding="5" cellspacing="0" border="0">
			            <!--GROUPS-->
				        <tr><td valign="top" colspan="2"><b><%=Translate.Translate("File settings")%></b></td></tr>			            
   				        <tr><td valign="top" colspan="2" style="height:5px;"></td></tr>
				        
				        <tr>
					        <td style="width:170px;" valign="top"><%=Translate.Translate("File")%></td>
					        <td><dw:FileManager runat="server" ID="C5SettingGroupImportFileName" FullPath="true" /></td>
				        </tr>
				        
   				        <tr><td valign="top" colspan="2" style="height:5px;"></td></tr>
				        <tr><td valign="top" colspan="2"><b><%=Translate.Translate("Additional settings")%></b></td></tr>			            
				        <tr><td valign="top" colspan="2" class="disableText"><%=Translate.Translate("These settings determine where the product groups are imported to. If these settings are not changed, then the product groups are imported to the shops/groups as specified in the selected file.")%></td>
  				        <tr><td valign="top" colspan="2" style="height:10px;"></td></tr>

				        <tr>
					        <td style="width:170px;" valign="top"><%=String.Format("{0} / {1}", Translate.JsTranslate("Group"), Translate.JsTranslate("shop"))%></td>
					        <td>
    				            
                                <div style="margin-left:1px;">
                                    <div style="width:100%;">
                                        <input type="radio" name="groupShopRadio" value="group" id="groupShopRadio_group" onclick="ChangeImportInterface();" checked="checked"/>
                                        <label for="groupShopRadio_group"><%=Translate.JsTranslate("Parent group")%></label>
                                        <div id="Selector_ParentGroup" style="margin-left:25px;">
                                            <%=IntegrationWizard.MakeGroupSelector("C5SettingGroupParentGroup")%>
                                        </div>
                                    </div>
                                    
                                    <div>
                                        <input type="radio" name="groupShopRadio" value="shop" id="groupShopRadio_shop" onclick="ChangeImportInterface();" />
                                        <label for="groupShopRadio_shop"><%=Translate.JsTranslate("Shop")%></label>
                                        <div id="Selector_Shop" style="margin-left:25px;">
                                            <%=IntegrationWizard.MakeShopDropDown("C5SettingGroupShop")%>
                                        </div>
                                    </div>
                                </div>    	
                                			            
				            </td>
				        </tr>				

                        <!--
                        <tr>
					        <td style="width:170px;" valign="top"><%'=Translate.Translate("Language")%></td>
					        <td><%'=IntegrationWizard.MakeLanguageDropDown("C5SettingGroupLanguage")%></td>
				        </tr>
				        -->				    
			        </table>
		            <dw:groupboxend id="Groupboxend2" runat="server" />  
		        </div>
		             
		        <div id="Block3" style="display:none;">
                    <dw:groupboxstart id="Groupboxstart3" runat="server" title="Produkter" />
			        <table cellpadding="5" cellspacing="0" border="0">
				        <!--PRODUCTS-->
   				        <tr><td valign="top" colspan="2"><b><%=Translate.Translate("File settings")%></b></td></tr>			            
   				        <tr><td valign="top" colspan="2" style="height:5px;"></td></tr>

				        <tr>
					        <td style="width:170px;" valign="top"><%=Translate.Translate("File")%></td>
					        <td><dw:FileManager runat="server" ID="C5SettingProductImportFileName" FullPath="true" /></td>
				        </tr>
				        
   				        <tr><td valign="top" colspan="2" style="height:5px;"></td></tr>
				        <tr><td valign="top" colspan="2"><b><%=Translate.Translate("Additional settings")%></b></td></tr>			            
				        <tr><td valign="top" colspan="2" class="disableText"><%=Translate.Translate("These settings determine where the products are imported to. If these settings are not changed, then the products are imported to the groups as specified in the selected file.")%></td>
   				        <tr><td valign="top" colspan="2" style="height:10px;"></td></tr>
				        
				        <tr>
					        <td style="width:170px;" valign="top"><%=Translate.Translate("Parent group")%></td>
					        <td><%=IntegrationWizard.MakeGroupSelector("C5SettingProductParentGroup")%></td>
				        </tr>
				        <!--
                        <tr>
					        <td style="width:170px;" valign="top"><%'=Translate.Translate("Language")%></td>
					        <td><%'=IntegrationWizard.MakeLanguageDropDown("C5SettingProductLanguage")%></td>
				        </tr>	
				        -->
			        </table>
    		        <dw:groupboxend id="Groupboxend3" runat="server" />  
		        </div>
		        
		        <div id="ImportMessageForProducts"></div>
            </div>
                    
            <div id="Tab2" class="Tab2Div" style="DISPLAY:none">
                <dw:groupboxstart id="Groupboxstart1" runat="server" title="Indstillinger" />
		        <div id="Block1" style="display:block;">
			        <table cellpadding="2" cellspacing="0" border="0">
				        <tr><td valign="top" colspan="2" style="height:5px;"></td></tr>
				        <tr>
					        <td style="width:170px;" valign="top"><%=Translate.Translate("E-mail subject")%></td>
					        <td><input type="text" id="C5SettingMailSubject" maxlength="255" class="std" runat="server" name="C5SettingMailSubject" /></td>
				        </tr>
				        <tr>
					        <td style="width:170px;"  valign="top"><%=Translate.Translate("Afsender navn")%></td>
					        <td><input type="text" id="C5SettingMailFromName" maxlength="255" class="std" runat="server" name="C5SettingMailFromName" /></td>
				        </tr>
                        <tr>
					        <td style="width:170px;"  valign="top"><%=Translate.Translate("Afsender e-mail")%></td>
					        <td><input type="text" id="C5SettingMailFrom" maxlength="255" class="std" runat="server" name="C5SettingMailFrom" /></td>
				        </tr>				    
                        <tr>
					        <td style="width:170px;"  valign="top"><%=Translate.Translate("Modtager e-mail")%></td>
					        <td><input type="text" id="C5SettingMailTo" maxlength="255" class="std" runat="server" name="C5SettingMailTo" /></td>
				        </tr>				    
			        </table>
		        </div>
		        <dw:groupboxend id="Groupboxend1" runat="server" />            
             </div>
        
            <div style="text-align:right; vertical-align:bottom; margin-top:15px;">
            <table>
				<tr>
				    <td><%=Gui.Button(Translate.JsTranslate("OK"), "submitForm();", "90")%></td>
					<td><%=Gui.Button(Translate.Translate("Annuller"), "location='../../Content/Moduletree/EntryContent.aspx'", "90")%></td>

					<td id="ProductImpButTd" style="display:none;"><button id="ProductImpBut" onclick="importC5('Products');"><%=Translate.Translate("Importer")%></button></td>
                    <td id="GroupImpButTd" style="display:none;"><button id="GroupImpBut" onclick="importC5('Groups');"><%=Translate.Translate("Importer")%></button></td>
                    
					<%=Gui.HelpButton("", "modules.c5integration")%>
					<td width="2"></td>
			    </tr>
            </table>
            </div>
        
            <div id="ImportMessageForGroups"></div>
        
            </form>
            
        </td>
    </tr>
</table>
    
</body>
</html>

<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>