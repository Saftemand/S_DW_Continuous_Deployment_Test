<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Wizard.aspx.vb" Inherits="Dynamicweb.Admin.Integration.Wizard" %>


<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
    <title></title>
    
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">

    <link rel="STYLESHEET" type="text/css" href="/admin/Stylesheet.css">
    <!--<link rel="stylesheet" type="text/css" href="/Admin/Module/Common/Stylesheet.css" />-->
    <!--[if IE]> <style type="text/css" media="all">@import url('/Admin/Module/Common/StylesheetIE.css');</style> <![endif]-->

    
   	<script type="text/javascript" language="JavaScript" src="/Admin/Module/eCom_Catalog/images/ObjectSelector.js"></script>
   	<script type="text/javascript" src="/Admin/Module/eCom_Catalog/images/permission/prototype.js"></script>
   	<style type="text/css">
        input.btn {
	        height: 23px;
	        font-size: 11px;
	        padding-left: 5px;
	        padding-right: 5px;
	        font-family :Verdana, Helvetica, Arial, Tahoma;
        }
   	</style>
   	

	<script type="text/javascript">
	var numberOfPages = 3;
	var action = "<%=Request.Form("action") %>";
	
	function pageInit() {
	    // Disable the loading gif
        document.getElementById("div_working").style.display = "none";

        // Select to show the form or the 'done' div
	    if (action == "") {
	        document.getElementById("div_form").style.display = "";
	        document.getElementById("div_done").style.display = "none";
    	    updateDivsAndButtons();
    	}
    	else {
	        document.getElementById("div_form").style.display = "none";
	        document.getElementById("div_done").style.display = "";
    	    var groupBoxTitle = document.getElementById('Form1').getElementsByTagName("legend")[0];
    	    groupBoxTitle.innerHTML = "<%=Translate.Translate("Done") %>";
       	    document.getElementById("backButton").disabled = true;
   	        document.getElementById("forwardButton").disabled = true;
	        document.getElementById("submitButton").disabled = true;
    	}
    	
	}
	
	// This performs an AJAX call to see if the file exists
	// The result is put in the hidden div 'fileExists'
	function fillFileExistsDiv(filename) {
        new Ajax.Updater("fileExists", "Wizard.aspx?ajax=doFileExist&file=" + filename + "&Time=" + new Date().getMilliseconds(), {
            asynchronous: false, 
            evalScripts: true,
            method: 'get'
        } );
    }

	
	function nextPage() {
	    var pageIndexString = document.getElementById("pageIndex").value;
	    document.getElementById("pageIndex").value = parseInt(pageIndexString) + 1;
	    updateDivsAndButtons();
	}
	
	function previousPage() {
	    var pageIndexString = document.getElementById("pageIndex").value;
	    document.getElementById("pageIndex").value = parseInt(pageIndexString) - 1;
	    updateDivsAndButtons();
	}
	
	function getRadioValue(radioName) {
	    var radios = document.getElementsByName(radioName);
	    for (var i = 0; i < radios.length; i++)
	        if (radios[i].checked)
	            return radios[i].value;
	    return "";
	}
	
	function updateDivsAndButtons() {
	    <%If Not Base.Request("exportfromtree") = "true" Then%>
	
	    var pageIndexString = document.getElementById("pageIndex").value;
	    var pageIndex = parseInt(pageIndexString);
	    var page1RadioValue = getRadioValue("page1_radio");
	    var page2RadioValue = getRadioValue("page2_radio");
	    var groupSelector_groups = document.getElementById("page2_parentGroup_selector_groups");
	    var groupSelector_products = document.getElementById("page2_parentGroup_selector_products");
	    var importFileSelector = document.getElementById("page2_import_file_selector");
	    var exportFileSelector = document.getElementById("page2_export_file_selector");

        // Confirm message on page 3
        if (pageIndex == 3)
      	    writeConfirmMessage();

        // Page divs
	    for (var i = 1; i <= numberOfPages; i++)
    	    document.getElementById("page" + i).style.display = "none";
	    document.getElementById("page" + pageIndexString).style.display = "";
	    
	    // Subdivs
	    // Shop selector, only when importing or exporting groups
	    if (page1RadioValue == "importGroups" || page1RadioValue == "exportGroups") {
	        groupSelector_groups.style.display = "";
	        groupSelector_products.style.display = "none";
	    }
	    else {
	        groupSelector_groups.style.display = "none";
	        groupSelector_products.style.display = "";
	    }
	        
	    // Import or export file selector
	    if (page1RadioValue == "importProducts" || page1RadioValue == "importGroups") {
	        importFileSelector.style.display = "";
	        exportFileSelector.style.display = "none";
	    }
	    else if (page1RadioValue == "exportProducts" || page1RadioValue == "exportGroups") {
	        importFileSelector.style.display = "none";
	        exportFileSelector.style.display = "";
	    }
	        
	    
	    // Buttons
	    var backButton = document.getElementById("backButton");
	    var forwardButton = document.getElementById("forwardButton");
	    var submitButton = document.getElementById("submitButton");
	    switch (pageIndex) {
	        case 1:
	                backButton.disabled = true;
	                submitButton.disabled = true;
	                if (page1RadioValue != "")
	                    forwardButton.disabled = false;
	                else
	                    forwardButton.disabled = true;
	                break;
	        case 2:
	                submitButton.disabled = true;
	                backButton.disabled = false;
	                if (page2RadioValue != "") // Check if file is selected?
	                    forwardButton.disabled = false;
	                else
	                    forwardButton.disabled = true;
	                break;
	        case 3:
	                submitButton.disabled = false;
	                backButton.disabled = false;
	                forwardButton.disabled = true;
	    }
	    
	    
	    // GroupBox
	    var groupBoxTitle = document.getElementById('Form1').getElementsByTagName("legend")[0];
	    var title = "";
	    switch (pageIndex) {
            case 1:	    
    	        title = "<%=Translate.Translate("Select activity") %>";
    	        break;
	        case 2:
                if (page1RadioValue == "importProducts")
	                title = "<%=Translate.Translate("Import products") %>";
                else if (page1RadioValue == "importGroups")
	                title = "<%=Translate.Translate("Import product groups") %>";
                else if (page1RadioValue == "exportProducts")
	                title = "<%=Translate.Translate("Export products") %>";
                else if (page1RadioValue == "exportGroups")
    	            title = "<%=Translate.Translate("Export product groups") %>";
                break;
    	    case 3:
                title = "<%=Translate.Translate("Confirm") %>";
                break;
	    }
	    groupBoxTitle.innerHTML = title + " - " + pageIndex + "/" + numberOfPages;
	    
	    // Explanation for additional settings
	    var explanationParagraph = document.getElementById("AdditionalExplanation");
	    var explanation = "";
        if (page1RadioValue == "importProducts")
            //explanation = "<%=Translate.Translate("These settings determine where the products are imported to. If these settings are not changed, then the products are imported to the groups/languages as specified in the selected file.") %>";
            explanation = "<%=Translate.Translate("These settings determine where the products are imported to. If these settings are not changed, then the products are imported to the groups as specified in the selected file.") %>";
        else if (page1RadioValue == "importGroups")
            //explanation = "<%=Translate.Translate("These settings determine where the product groups are imported to. If these settings are not changed, then the product groups are imported to the shops/groups/languages as specified in the selected file.") %>";
            explanation = "<%=Translate.Translate("These settings determine where the product groups are imported to. If these settings are not changed, then the product groups are imported to the shops/groups as specified in the selected file.") %>";
        else if (page1RadioValue == "exportProducts")
            explanation = "<%=Translate.Translate("These settings determine which products are exported. If you want to export all products, then you don't need to change these settings.") %>";
        else if (page1RadioValue == "exportGroups")
            explanation = "<%=Translate.Translate("These settings determine which product groups are exported. If you want to export all product groups, then you don't need to change these settings.") %>";
	    explanationParagraph.innerHTML = explanation;
	    
	    
	    if (pageIndex == 2) {
	        var groupShopRadio = getRadioValue("groupShopRadio");
	        if (groupShopRadio == "group") {
	            document.getElementById("groupShopRadio_div_shop").style.display = "none";
	            document.getElementById("groupShopRadio_div_group").style.display = "";
	        }
	        else if (groupShopRadio == "shop") {
	            document.getElementById("groupShopRadio_div_shop").style.display = "";
	            document.getElementById("groupShopRadio_div_group").style.display = "none";
	        }
	    }
	    
	    
	    <%Else %> // This is done when calling the wizard from rightclick in ecom tree
	    
	    // Remove Elements we don't use
   	    document.getElementById("page1").style.display = "none";
   	    document.getElementById("page3").style.display = "none";
        document.getElementById("groupShopRadio_div_shop").style.display = "none";
	    document.getElementById("page2_import_file_selector").style.display = "none";
	    document.getElementById("page2_parentGroup_selector_groups").style.display = "none";
        document.getElementById('backButton').style.display = "none";
        document.getElementById('forwardButton').style.display = "none";
        document.getElementById('ContinueButton').style.display = "none";
        document.getElementById('ChangeUserTypeDiv').style.display = "none";
                
        // Set title
        document.getElementById('Form1').getElementsByTagName("legend")[0].innerHTML = '<%=Translate.Translate("Export products") %>';
        
	    <%End If %>
	}
	
	// Set the hidden values to be submitted
	function run() {
	    var isImport = getRadioValue("page1_radio").substring(0,6) == "import";
	    // Check if a file is selected
	    if ((!isImport && document.getElementById("page2_export_fileName_hidden").value == "unchanged") ||
	        (isImport && document.getElementById("FM_page2_import_fileName").value == ""))
	    {
	        alert("<%=Translate.JsTranslate("Please select a file") %>");
	        document.getElementById("pageIndex").value = "2";
	        updateDivsAndButtons();
	        document.getElementById("submitButton").disabled = true;
	        return;
	    }
	
	    // Fill hidden values
	    document.getElementById("action").value = getRadioValue("page1_radio");
	    document.getElementById("fileType").value = getRadioValue("page2_radio");
	    document.getElementById("importFileName").value = document.getElementById("FM_page2_import_fileName").value;
	    document.getElementById("parentGroupID_products").value = document.getElementById("page2_parentGroupID_products").value;
	    //document.getElementById("language").value = document.getElementById("page2_language").value;
	    document.getElementById("exportFileName").value = document.getElementById("FLDM_page2_export_folderName").value + "/" + document.getElementById("page2_export_fileName").value
	    
	    var groupShopRadio = getRadioValue("groupShopRadio");
	    if (groupShopRadio == "group") 
	        document.getElementById("parentGroupID_groups").value = document.getElementById("page2_parentGroupID_groups").value;
  	    else if (groupShopRadio == "shop") 
    	    document.getElementById("shopID").value = document.getElementById("page2_shop_dropdown").value;

	    
	    // Check if the export file exists - AJAX
	    if (!isImport) {
	        var filename = document.getElementById("exportFileName").value;
	        // The destination activities put extensions on the file!
	        if (filename.indexOf(".") < 0)
	            if (document.getElementById("fileType").value == "xml")
	                filename += ".xml";
	            else
	                filename += ".csv";
	        fillFileExistsDiv(filename);
	        if (document.getElementById("fileExists").innerHTML == "true")
                if (!confirm("<%=Translate.JsTranslate("The export file exists. Overwrite?") %>")) {
                    document.getElementById("submitButton").disabled = true;
                    document.getElementById("action").value = "";
	                document.getElementById("fileType").value = "";
	                document.getElementById("importFileName").value = "";
	                document.getElementById("parentGroupID_products").value = "";
	                //document.getElementById("language").value = "";
	                document.getElementById("exportFileName").value = "";
        	        document.getElementById("parentGroupID_groups").value = "";
            	    document.getElementById("shopID").value = "";
                    return;
                }
	    }
	    
        //Display the loading gif, change legend, and disable buttons
        document.getElementById("div_form").style.display = "none";
        document.getElementById("div_working").style.display = "";
        var groupBoxTitle = document.getElementById('Form1').getElementsByTagName("legend")[0];
        groupBoxTitle.innerHTML = "<%=Translate.Translate("Executing") %>";
        document.getElementById("backButton").disabled = true;
        document.getElementById("forwardButton").disabled = true;
        
	}
	
	function writeConfirmMessage() {
	    var msg = "";
	    var actionString = getRadioValue("page1_radio");

	    if (actionString.substring(0,6) == "import")
	        msg += "<%=Translate.JsTranslate("Du har valgt at importere fra en fil. Det er vigtigt at formatet af filen er korrekt. For mere hjælp tryk på 'Hjælp'") %>";
        else if (actionString.substring(0,6) == "export")
	        msg += "<%=Translate.JsTranslate("Du er nu klar til at eksportere.") %>";
    
	    document.getElementById("confirmMsg").firstChild.nodeValue = msg;
	    
	}
	
	function keypress(e) {
	    var key = 0;
	    if (e.keyCode) // IE
	        key = e.keyCode;
	    else if (e.which) // Netscape/Firefox/Opera 
	        key = e.which;
	     
	    if (key == 13) {// ENTER key
    	    var pageIndexString = document.getElementById("pageIndex").value;
	        var pageIndex = parseInt(pageIndexString);
   	        var forwardButton = document.getElementById("forwardButton");
	        var submitButton = document.getElementById("submitButton");
   	        
   	        if (!forwardButton.disabled)
   	            forwardButton.click();
   	        else if (!submitButton.disabled)
   	            submitButton.click();
   	            
	    }
	}
	
	</script>            
</head>


<body onload="pageInit();" onkeypress="keypress(event);">

<dw:TabHeader ID="TabHeader" runat="server" ReturnWhat="All" Navigation="false" TotalWidth="" />  
    <table border="0" cellpadding="0" cellspacing="0" class="tabTable">
        <tr>
            <td valign="top">
                
                <form id="Form1" runat="server" method="post">
                
                    <input type="hidden" id="pageIndex" value="1" />
                    <input type="hidden" id="action" name="action"/>
                    <input type="hidden" id="fileType" name="fileType"/>
                    <input type="hidden" id="shopID" name="shopID"/>
                    <input type="hidden" id="parentGroupID_products" name="parentGroupID_products"/>
                    <input type="hidden" id="parentGroupID_groups" name="parentGroupID_groups"/>
                    <!--<input type="hidden" id="language" name="language"/>-->
                    <input type="hidden" id="importFileName" name="importFileName"/>
                    <input type="hidden" id="exportFileName" name="exportFileName"/>
                    
                    <div id="fileExists" style="display:none;"></div>
                    
                    <dw:GroupBox id="GroupBox" runat="server">
                        
                        <div id="div_form">

                            <!-- Page 1 is for selecting the thing to do (e.g. 'Import products', 'Export groups', etc) -->
                            <div id="page1">
                                <div style="height:<%=divHeight %>px;">
                                    <div id="page1_activity_selector" style="margin:10px 10px 10px 10px">
                                        <div style="float:left">
                                            <%=Translate.JsTranslate("Activity")%>
                                        </div>
                                        <div style="margin-left:<%=secondDivMargin %>px">
                                            <input id="page1_radio1" name="page1_radio" type="radio" onclick="updateDivsAndButtons();" value="importProducts" /> <label for="page1_radio1"><%=Translate.JsTranslate("Import products")%>        </label><br />
                                            <input id="page1_radio2" name="page1_radio" type="radio" onclick="updateDivsAndButtons();" value="importGroups" />   <label for="page1_radio2"><%=Translate.JsTranslate("Import product groups")%>  </label><br />
                                            <input id="page1_radio3" name="page1_radio" type="radio" onclick="updateDivsAndButtons();" value="exportProducts" /> <label for="page1_radio3"><%=Translate.JsTranslate("Export products")%>        </label><br />
                                            <input id="page1_radio4" name="page1_radio" type="radio" onclick="updateDivsAndButtons();" value="exportGroups" />   <label for="page1_radio4"><%=Translate.JsTranslate("Export product groups")%>  </label><br />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Page 2 is for setting the parameters, such as the filetype (xml or csv) and the filename -->
                            <div id="page2">
                                <div style="height:<%=divHeight %>px">

                                    <!-- File settings -->
                                    <p style="font-weight:bold;margin:10px 10px 10px 10px"><%=Translate.Translate("File settings") %></p>

                                    <!-- File format -->
                                    <div id="page2_file_format_selector" style="margin:10px 10px 10px 10px">
                                        <div style="float:left">
                                            <%=Translate.JsTranslate("File format")%>
                                        </div>
                                        <div style="margin-left:<%=secondDivMargin %>px">
                                            <input id="page2_radio1" name="page2_radio" type="radio" onclick="updateDivsAndButtons();" value="csv" /><label for="page2_radio1"><%=Translate.JsTranslate("CSV format")%></label><br />
                                            <input id="page2_radio2" name="page2_radio" type="radio" onclick="updateDivsAndButtons();" value="xml" /><label for="page2_radio2"><%=Translate.JsTranslate("XML format")%></label><br />
                                        </div>
                                    </div>
                                    
                                    <!-- Import file -->
                                    <div id="page2_import_file_selector" style="margin:10px 10px 10px 10px">
                                        <div style="float:left">
                                            <%=Translate.JsTranslate("File")%>
                                        </div>
                                        <div style="margin-left:<%=secondDivMargin %>px">
                                            <dw:FileManager runat="server" ID="page2_import_fileName" FullPath="true" FixFieldName="true" />
                                        </div>
                                    </div>             
                                              
                                    <!-- Export file -->                 
                                    <div id="page2_export_file_selector" style="margin:10px 10px 10px 10px">
                                        <div style="float:left">
                                            <%=Translate.JsTranslate("Folder")%>
                                        </div>
                                        <div style="margin-left:<%=secondDivMargin %>px">
                                            <%= Gui.FolderManager("/" & Dynamicweb.Content.Management.Installation.FilesFolderName & "/Integration", "page2_export_folderName")%>
                                        </div>
                                        <div style="float:left">
                                            <%=Translate.JsTranslate("File")%>
                                        </div>
                                        <div style="margin-left:<%=secondDivMargin %>px">
                                            <input type="hidden" id="page2_export_fileName_hidden" value="unchanged"/>
                                            <input id="page2_export_fileName" value="<%=Translate.JsTranslate("File name") %>" type="text" class="std" onfocus="if (page2_export_fileName_hidden.value=='unchanged') {this.value=''; page2_export_fileName_hidden.value='changed';}" onblur="if (this.value=='') {this.value='<%=Translate.JsTranslate("File name") %>'; page2_export_fileName_hidden.value='unchanged';}" />
                                        </div>
                                    </div>                                        

                                    <!-- Additional settings -->
                                    <p style="font-weight:bold;margin:10px 10px 10px 10px"><%=Translate.Translate("Additional settings")%></p>
                                    <p style="margin:10px 10px 10px 10px;color:Gray" id="AdditionalExplanation"></p>

                                    
                                    <!-- Parent group / Products -->
                                    <div id="page2_parentGroup_selector_products" style="margin:10px 10px 10px 10px">
                                        <div style="float:left">
                                            <%=Translate.JsTranslate("Parent group")%>
                                        </div>
                                        <div style="margin-left:<%=secondDivMargin %>px">
                                            <%=MakeGroupSelector("page2_parentGroupID_products")%>
                                        </div>
                                    </div>
                                    
                                    <!-- Parent group / Groups -->
                                    <div id="page2_parentGroup_selector_groups" style="margin:10px 10px 10px 10px">
                                        <div style="float:left">
                                            <%=String.Format("{0} / {1}", Translate.JsTranslate("Group"), Translate.JsTranslate("shop"))%>
                                        </div>
                                        <div style="margin-left:<%=secondDivMargin %>px">
                                            <div>
                                                <input type="radio", name="groupShopRadio" value="group" id="groupShopRadio_group" onclick="updateDivsAndButtons();" checked="checked"/>
                                                <label for="groupShopRadio_group"><%=Translate.JsTranslate("Parent group")%></label>
                                                <div id="groupShopRadio_div_group" style="margin-left:25px;">
                                                    <%=MakeGroupSelector("page2_parentGroupID_groups")%>
                                                </div>
                                            </div>
                                            
                                            <div>
                                                <input type="radio", name="groupShopRadio" value="shop" id="groupShopRadio_shop" onclick="updateDivsAndButtons();" />
                                                <label for="groupShopRadio_shop"><%=Translate.JsTranslate("Shop")%></label>
                                                <div id="groupShopRadio_div_shop" style="margin-left:25px;">
                                                    <%=MakeShopDropDown("page2_shop_dropdown") %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Language -->
                                    <!--
                                    <div id="page2_language_selector" style="margin:10px 10px 10px 10px">
                                        <div style="float:left">
                                            <%=Translate.JsTranslate("Language")%>
                                        </div>
                                        <div style="margin-left:<%=secondDivMargin %>px">
                                            -------MakeLanguageDropDown("page2_language")------
                                        </div>
                                    </div>
                                    -->
                                    
                                </div>
                            </div>

                            <!-- Page 3 is for confirming the parameters and to press 'GO!' -->
                            <div id="page3">
                                <div style="height:<%=divHeight %>px">
                                    <div id="page3_confirm_msg" style="margin:10px 10px 10px 10px">
                                        <p id="confirmMsg">
                                            Confirm message here
                                        </p>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <!-- Working -->
                        <div id="div_working">
                            <div style="height:<%=divHeight %>px">
                                <img src="Images/loading.gif" alt="loading..." style="margin-left:5px;margin-top:5px"/>
                            </div>
                        </div>

                        <!-- Done -->
                        <div id="div_done">
                            <div style="height:<%=divHeight %>px">
                                <p style="margin-left:5px;margin-top:5px">
                                    <%=pipelineReport%>
                                </p>
                                <div style="float:right;margin-right:5px;">
                                    <input id="ContinueButton" onclick="window.location = 'Wizard.aspx';" type="button" value="<%=Translate.JsTranslate("Continue") %>" class="btn" />
                                </div>
                            </div>
                        </div>


                    </dw:GroupBox>


                    <!-- Button bar -->
                    <div style="margin-left:5px; float:left" id="ChangeUserTypeDiv">
                        <a href="/admin/module/Integration/UserTypeSelector.aspx?usertype=NULL" style="font-size:xx-small;color:Gray">
                            <%=Translate.JsTranslate("Change user type")%>
                        </a>
                    </div>
                    <div style="margin-right:5px; float:right">
                        <input id="backButton" type="button" value="<%=Translate.JsTranslate("Back") %>" onclick="previousPage();" class="btn"/>
                        <input id="forwardButton" type="button" value="<%=Translate.JsTranslate("Next") %>" onclick="nextPage();" class="btn"/>
                        <input id="submitButton" type="submit" value="<%=Translate.JsTranslate("Run")%>" onclick="run()" class="btn"/>
                        <input id="helpButton" type="button" value="<%=Translate.JsTranslate("Help")%>" onclick="<%=Gui.Help("modules.Integration.wizard", "modules.Integration.wizard") %>" class="btn"/>
                    </div>
                    
            
                </form>

            </td>
        </tr>
    </table>
    

    <%If Base.Request("exportfromtree") = "true" Then%>
    <script language="javascript" type="text/javascript">
    function ExportFromTree_Page1() {
        //Page 1
        var radioObj = document.forms['Form1'].elements['page1_radio'];
	    if(radioObj) {
            var radioLength = radioObj.length;
	        for(var i = 0; i < radioLength; i++) {
		        if(radioObj[i].id == "page1_radio3") {
			        radioObj[i].checked = true;
		        }
	        }
        }	        
     
        //setTimeout("ExportFromTree_Page2();", 100);      
        ExportFromTree_Page2();
    }
    
    var GroupToExportID = "<%=Base.Request("TreeGroupID")%>";
    function ExportFromTree_Page2() {
        //Page 2
        var radioObj = document.forms['Form1'].elements['page2_radio'];
	    if(radioObj) {
            var radioLength = radioObj.length;
	        for(var i = 0; i < radioLength; i++) {
		        if(radioObj[i].id == "page2_radio2") {
			        radioObj[i].checked = true;
		        }
	        }
        }	        
        
        if (GroupToExportID != "") {
            document.getElementById("page2_export_fileName_hidden").value = "changed";
            document.getElementById("page2_export_fileName").value = "ProductExport_" + GroupToExportID + "_" + new Date().getMilliseconds() +".xml";
            document.getElementById("page2_parentGroupID_products").value = GroupToExportID;
            GetGroupName();
        }
     
        updateDivsAndButtons();  
    }
    
	function GetGroupName() {
        new Ajax.Updater("", "Wizard.aspx?ajax=getGroupName&TreeGroupID=" + GroupToExportID + "&Time=" + new Date().getMilliseconds(), {
            asynchronous: true, 
            evalScripts: true,
            method: 'get',

            onComplete: function(request) {
                document.getElementById("GroupNamepage2_parentGroupID_products").value = request.responseText;
            }

        } );
    }
    
    
    
    setTimeout("ExportFromTree_Page1();", 100);
    </script>    
    <%End If%>
    
</body>
</html>

<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
