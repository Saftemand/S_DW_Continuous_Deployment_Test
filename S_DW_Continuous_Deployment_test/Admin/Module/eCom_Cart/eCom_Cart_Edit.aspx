<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" codePage="65001" CodeBehind="eCom_Cart_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eCom_Cart_Edit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script type="text/javascript" src="/Admin/Module/eCom_Catalog/images/permission/prototype.js"></script>    

<script type="text/javascript">
function ShowGroupBox(layerA, layerB) {
	if (document.getElementById(layerA).style.display == "none") {
		document.getElementById(layerA).style.display = "";
		document.getElementById(layerB).style.display = "none";
	} else {
		document.getElementById(layerA).style.display = "none";
		document.getElementById(layerB).style.display = "";
	}
}

function Toggle_UseValidation(obj) {
	if(obj.checked) {
		document.getElementById("UseValSection").style.display = "";
	} else {
		document.getElementById("UseValSection").style.display = "none";
	}	
}

function Toggle_UseUseNewsletterSubscription(obj) {
	if(obj.checked) {
		document.getElementById("UseNewsletterSubcrSection").style.display = "";
	} else {
		document.getElementById("UseNewsletterSubcrSection").style.display = "none";
	}	
}

function AddNewsletterSubcrCats() {
    window.open('/Admin/module/NewsLetterV3/CategorySelector.aspx?paragraph=true','catSelector','toolbar=0,menubar=0,resizable=0,scrollbars=0,height=400,width=300,directories=0,location=0');   
}

function CartNewsletterSubcription() {
    var d = new Date(); 
    var divId = "AttachNewsletterSubcriptions";
    var url = "/Admin/Module/eCom_Cart/GetNewsletterCategories.aspx?ajax=getCats&Time=" + d.getMilliseconds();

    $(divId).update('<img src=\'/Admin/Module/eCom_Catalog/images/ajaxloading.gif\' style=\'text-align:center;margin:5px;padding:5px;\' /> <span class=\'disableText\'><%=Translate.JsTranslate("Requesting content...")%></span>');

    new Ajax.Updater(divId, url, {
        asynchronous: true, 
        evalScripts: false,
        method: 'get'
        
    } );    
}

function CheckForExistingValiationGroups(newGroup) {
    var exists = false;
    try {
        if (document.paragraph_edit.ValidationGroups && !document.paragraph_edit.ValidationGroups.length) {
            if(document.paragraph_edit.ValidationGroups.value == newGroup) {
                exists = true;
            }
        }

        for( i = 0; i < document.paragraph_edit.ValidationGroups.length; i++ ) {
            if(document.paragraph_edit.ValidationGroups[i].value == newGroup) {
                exists = true;
            }
        }
	} catch(e) {
		// Nothing
	}	
	
	return exists;	
}

var newDiv = "AttachNewValidationGroup";
function AddValidationGroup() {
    if (document.getElementById("Val_fields").style.display == "none") {
        document.getElementById("Val_fields").style.display = "";
    }
    
    var SelectedGroup = document.getElementById("ValidationGroupSelector").value;
    if (SelectedGroup == "") {
        alert('<%=Translate.JsTranslate("Please select a group") %>');
        return;
    }

    var grpExists = CheckForExistingValiationGroups(SelectedGroup);
    if (grpExists) {
        alert('<%=Translate.JsTranslate("The group is already attached.") %>');
        return;
    }
    
    var d = new Date();
    var url = "/Admin/Module/eCom_Cart/GetValidationGroups.aspx?ajax=getGroup&GroupId=" + SelectedGroup + "&Time=" + d.getMilliseconds();
    ajaxLoader_Validation(url, newDiv, SelectedGroup);
}



function RemoveValiationGroup(grpId) {
    try {
    	if (document.getElementById("ValidationGroupTable" + grpId)) {
    	    var table = document.getElementById("ValidationGroupTable" + grpId);
            table.parentElement.removeChild(table);
    	    HandleValidationMsg();
    	}
	} catch(e) {
	    //alert(e);
		// Nothing
	}
}

function CheckAllValidations(groupID) {
    var allCheckBoxes = document.getElementsByName("ValidationFields");
    var isAllChecked = true;
    //First check if all checkboxes are checked. If so then uncheck all, else check all
    for (var i = 0; i < allCheckBoxes.length; i++) {
        var checkBox = allCheckBoxes[i];
        // parentNode.parentNode is the table row with this checkbox
        if (!checkBox.checked && checkBox.parentNode.parentNode.id.startsWith('ValidationGroupTable' + groupID + 'TR')) {
            isAllChecked = false;
            break;
        }
    }
    // Check / uncheck all
    for (var i = 0; i < allCheckBoxes.length; i++) {
        var checkBox = allCheckBoxes[i];
        // parentNode.parentNode is the table row with this checkbox
        if (checkBox.parentNode.parentNode.id.startsWith('ValidationGroupTable' + groupID + 'TR')) {
            checkBox.checked = !isAllChecked;
            updateCheckBoxes(checkBox);
        }
    }
}

function toggleRulesDiv(valID) {
    var div = document.getElementById('RulesBox_' + valID);
    div.style.display = div.style.display == 'none' ? '' : 'none';
}

function ExpandAllRules(groupID) {
    var rows = document.getElementById('ValidationGroupTable' + groupID).rows;
    var isAllExpanded = true;
    for (var i = 0; i < rows.length; i++) {
        if (rows[i].id.startsWith('ValidationRulesBox')) {
            var div = rows[i].getElementsByTagName('div')[0];
            if (div.style.display == 'none') {
                isAllExpanded = false;
                break;
            }
        }
    }
    for (var i = 0; i < rows.length; i++) {
        if (rows[i].id.startsWith('ValidationRulesBox')) {
            var div = rows[i].getElementsByTagName('div')[0];
            div.style.display = isAllExpanded ? 'none' : '';
        }
    }
}
function updateCheckBoxes(changedBox) {
    var checked = changedBox.checked;
    if (!checked)
        return;
        
    var fieldName = getFieldNameFromCheckboxID(changedBox.id);
    var allCheckBoxes = document.getElementsByName('ValidationFields');
    for (var i = 0; i < allCheckBoxes.length; i++) {
        if (allCheckBoxes[i].id == changedBox.id)
            continue;
        var thisFieldName = getFieldNameFromCheckboxID(allCheckBoxes[i].id);
        if (thisFieldName && thisFieldName == fieldName) {
            allCheckBoxes[i].checked = !checked;
        }
    }
}
function getFieldNameFromCheckboxID(id) {
    var hidden = document.getElementById(id + '_fieldName');
    if (hidden)
        return hidden.value;
    return null;
}

function ajaxLoader_Validation(url,divId,grpId) {
    // Loading gif
    $(divId).update('<img src=\'/Admin/Module/eCom_Catalog/images/ajaxloading.gif\' style=\'text-align:center;margin:5px;padding:5px;\' /> <span class=\'disableText\'><%=Translate.JsTranslate("Requesting content...")%></span>');
    
    new Ajax.Request(url, {
        asynchronous: true, 
        evalScripts: false,
        method: 'get',

        onComplete: function(request) {
            $(divId).update(request.responseText);
            ChangeDiv();
            HandleValidationMsg();
        }
        
    } );

}    
var valgroupCnt = 1;
function ChangeDiv() {
    var div_node = document.getElementById(newDiv);
    div_node.id = newDiv + valgroupCnt;
    valgroupCnt++;
    
    div_node.innerHTML += "<div id='"+ newDiv +"'></div>";
}    

function HandleValidationMsg() {
    var fields = document.getElementById("ValidationFieldErrMsgs")
    var field = "";
    var msg = "";
    
    var elems = document.getElementById("paragraph_edit").elements;
    for(var i = 0; i < elems.length; i++) {
        if (elems[i].type == 'text') {
            if (elems[i].name.indexOf("ValidationFieldMsg") != -1) {
                msg = elems[i].name.replace(/ValidationFieldMsg/, "").replace(/msg/, elems[i].value);
                
                if (field == "") {
                    field = msg
                } else {
                    field += "#;#" + msg
                }               
                
            }            
        }            
    } 
    fields.value = field;
} 

</script>
<input type="hidden" name="eCom_Cart_settings" value="CartTemplate, CustomerTemplate, MethodTemplate, AcceptCartTemplate, OrderConfimationTemplate, OrderEmailTemplate, OrderConfirmFromMail, OrderConfirmFromName, OrderConfirmSubject, OrderConfimationShopTemplate, OrderFromMail, OrderFromName, OrderSubject, OrderRecipient, OrderRecipientCC, OrderMailEncoding, OrderPayment, OrderShipment, CartEmptyPage, OrderShopID, GatewayError, GatewayCancel, ExtranetGroups, UseValidation, ValidationGroups, ValidationFields, ValidationFieldErrMsgs, UseNewsletterSubscription, NewsletterSubscribers">
<tr>
	<td>
		<%=Gui.MakeModuleHeader("eCom_Cart", "eCom indkøbskurv")%>
	</td>
</tr>
<tr>
	<td>
		<br />
		
		<!-- Settings -->
		<dw:groupboxstart id="Groupboxstart7" runat="server" title="Indstillinger" OnClick="ShowGroupBox('step7','step7H');" />
		<div id="step7">
			<table cellpadding="2" cellspacing="0" border="0">
				<tr>
					<td width="170" valign="top">
					    <dw:TranslateLabel runat="server" Text="Shop" />
					</td>
					<td>
					    <select id="OrderShopID" name="OrderShopID" runat="server" size="1" class="std" />
					</td>
				</tr>
				<tr>
					<td width="170" valign="top">
					    <dw:TranslateLabel runat="server" Text="Tom indkøbskurv" />
					</td>
					<td>
					    <dw:LinkManager id="CartEmptyPage" runat="server" disableparagraphselector disablefilearchive />
					</td>
				</tr>
			</table>
		</div>
		
		<div id="step7H" style="display:none">
		    <span class="disableTextItalic"><%=settingsTxt%></span>
		</div>
		
		<dw:groupboxend id="Groupboxend7" runat="server" />
		
		
		
		<dw:groupboxstart id="Groupboxstart9" runat="server" title="E-mail" OnClick="ShowGroupBox('step9','step9H');" />
		<div id="step9">
			<table cellpadding="2" cellspacing="0" border="0">
				<tr>
					<td width="170"><%=Translate.Translate("Encoding")%></td>
					<td><asp:Literal id="EncodingList" runat="server"></asp:Literal></td>
				</tr>

				<tr>
					<td height="5" colspan="2"><strong><%=Translate.Translate("Kunde")%></strong></td>
				</tr>
				<tr>
					<td><%=Translate.Translate("Emne")%></td>
					<td><input type="text" id="OrderConfirmSubject" maxlength="255" class="std" runat="server" NAME="OrderConfirmSubject"></td>
				</tr>
				<tr>
					<td><%=Translate.Translate("Afsender navn")%></td>
					<td><input type="text" id="OrderConfirmFromName" maxlength="255" class="std" runat="server" NAME="OrderConfirmFromName"></td>
				</tr>
				<tr>
					<td><%=Translate.Translate("Afsender e-mail")%></td>
					<td><input type="text" id="OrderConfirmFromMail" maxlength="255" class="std" runat="server" NAME="OrderConfirmFromMail"></td>
				</tr>
				<tr>
					<td valign="top"><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Ordrebekræftelse"))%></td>
					<td><dw:FileManager runat="server" id="OrderEmailTemplate" Folder="Templates/eCom/Cart" FullPath=True></dw:FileManager></td>
				</tr>

				<tr>
					<td height="5" colspan="2"><strong><%=Translate.Translate("Butiksansvarlig")%></strong></td>
				</tr>
				<tr>
					<td><%=Translate.Translate("Emne")%></td>
					<td><input type="text" id="OrderSubject" maxlength="255" class="std" runat="server" NAME="OrderSubject"></td>
				</tr>
				<tr>
					<td><%=Translate.Translate("Modtager e-mail")%></td>
					<td><input type="text" id="OrderRecipient" maxlength="255" class="std" runat="server" NAME="OrderRecipient"></td>
				</tr>
				<tr>
					<td><%=Translate.Translate("Modtager CC e-mail")%></td>
					<td><input type="text" id="OrderRecipientCC" maxlength="255" class="std" runat="server" NAME="OrderRecipientCC"></td>
				</tr>
				<tr>
					<td><%=Translate.Translate("Afsender navn")%></td>
					<td><input type="text" id="OrderFromName" maxlength="255" class="std" runat="server" NAME="OrderFromName"></td>
				</tr>
				<tr>
					<td><%=Translate.Translate("Afsender e-mail")%></td>
					<td><input type="text" id="OrderFromMail" maxlength="255" class="std" runat="server" NAME="OrderFromMail"></td>
				</tr>
			</table>
		</div>
		<div id="step9H" style="DISPLAY:none"><span class="disableTextItalic"><%=settingsTxt%></span></div>
		<dw:groupboxend id="Groupboxend9" runat="server" />

		<dw:groupboxstart id="Groupboxstart1" runat="server" doTranslation=false OnClick="ShowGroupBox('step1','step1H');" />
		<div id="step1">
			<table cellpadding="2" cellspacing="0" border="0">
				<tr>
					<td width="170" valign="top"><%=templateTxt%></td>
					<td><dw:FileManager runat="server" id="CartTemplate" Folder="Templates/eCom/Cart" FullPath=True></dw:FileManager></td>
				</tr>
			</table>
		</div>
		<div id="step1H" style="display:none"><span class="disableTextItalic"><%=settingsTxt%></span></div>
		<dw:groupboxend id="Groupboxend1" runat="server" />
		<br />
		<dw:groupboxstart id="Groupboxstart2" runat="server" doTranslation=false OnClick="ShowGroupBox('step2','step2H');" />
		<div id="step2">
			<table cellpadding="2" cellspacing="0" border="0">
				<tr>
					<td width="170" valign="top"><%=templateTxt%></td>
					<td><dw:FileManager runat="server" id="CustomerTemplate" Folder="Templates/eCom/Cart" FullPath=True></dw:FileManager></td>
				</tr>
			</table>
		</div>
		<div id="step2H" style="display:none;"><span class="disableTextItalic"><%=settingsTxt%></span></div>
		<dw:groupboxend id="Groupboxend2" runat="server" />
		<br>
		<dw:groupboxstart id="Groupboxstart3" runat="server" doTranslation=false OnClick="ShowGroupBox('step3','step3H');" />
		<div id="step3">
			<table cellpadding="2" cellspacing="0" border="0">
				<tr>
					<td width="170" valign="top"><%=templateTxt%></td>
					<td><dw:FileManager runat="server" id="MethodTemplate" Folder="Templates/eCom/Cart" FullPath=True></dw:FileManager></td>
				</tr>
			</table>
		</div>
		<div id="step3H" style="display:none"><span class="disableTextItalic"><%=settingsTxt%></span></div>
		<dw:groupboxend id="Groupboxend3" runat="server" />
		<br>
		<dw:groupboxstart id="Groupboxstart4" runat="server" doTranslation=false OnClick="ShowGroupBox('step4','step4H');" />
		<div id="step4">
			<table cellpadding="2" cellspacing="0" border="0">
				<tr>
					<td width="170" valign="top"><%=templateTxt%></td>
					<td><dw:FileManager runat="server" id="AcceptCartTemplate" Folder="Templates/eCom/Cart" FullPath=True></dw:FileManager></td>
				</tr>
			</table>
		</div>
		<div id="step4H" style="display:none"><span class="disableTextItalic"><%=settingsTxt%></span></div>
		<dw:groupboxend id="Groupboxend4" runat="server" />
		<br>
		
		<dw:groupboxstart id="Groupboxstart8" runat="server" doTranslation=false OnClick="ShowGroupBox('step8','step8H');" />
		<div id="step8">
			<table cellpadding="2" cellspacing="0" border="0">
				<tr>
					<td width="170" valign="top"><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Fejl"))%></td>
					<td><dw:FileManager runat="server" id="GatewayError" Folder="Templates/eCom/Cart" FullPath=True></dw:FileManager></td>
				</tr>
				<tr>
					<td valign="top"><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Annuller"))%></td>
					<td><dw:FileManager runat="server" id="GatewayCancel" Folder="Templates/eCom/Cart" FullPath=True></dw:FileManager></td>
				</tr>
			</table>
		</div>
		<div id="step8H" style="display:none"><span class="disableTextItalic"><%=settingsTxt%></span></div>
		<dw:groupboxend id="Groupboxend8" runat="server" />
		<br>

		<dw:groupboxstart id="Groupboxstart5" runat="server" doTranslation=false OnClick="ShowGroupBox('step5','step5H');" />
		<div id="step5" >
			<table cellpadding="2" cellspacing="0" border="0">
				<tr>
					<td width="170" valign="top"><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Kunde"))%></td>
					<td><dw:FileManager runat="server" id="OrderConfimationTemplate" Folder="Templates/eCom/Cart" FullPath=True></dw:FileManager></td>
				</tr>
				<tr>
					<td valign="top"><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Butiksansvarlig"))%></td>
					<td><dw:FileManager runat="server" id="OrderConfimationShopTemplate" Folder="Templates/eCom/Cart" FullPath=True></dw:FileManager></td>
				</tr>

			</table>
		</div>
		<div id="step5H" style="DISPLAY:none"><span class="disableTextItalic"><%=settingsTxt%></span></div>
		<dw:groupboxend id="Groupboxend5" runat="server" />
		
		<%=Gui.GroupBoxStart(UseValCheckTxt)%>&nbsp;
		<table id="UseValSection" cellpadding="2" cellspacing="0" border="0" style="<%=IIF(cs.UseValidation = 1, "Display: ;", "Display:none;")%>">
			<tr id="Val_Groups">
				<td width="170"><%=Translate.Translate("Validation group")%></td>
				<td><select id="ValidationGroupSelector" name="ValidationGroupSelector" runat="server" size="1" class="std"></select></td>
				<td width="25" valign="middle"><button onclick="AddValidationGroup(); return false;"><%=Translate.JsTranslate("Add")%></button></td>
			</tr>
			<tr id="Val_fields" style="display:<%=IIF(cs.ValidationGroups.Length > 0, "", "none;")%>; vertical-align:text-top;">
				<td width="170"><dw:TranslateLabel runat="server" Text="Validation fields"/></td>
				<td colspan="2">
				    <asp:Literal id="ValidationList" runat="server"></asp:Literal>
                    <div id="AttachNewValidationGroup"></div>
				</td>
			</tr>
		</table>         
		<%=Gui.GroupboxEnd%>
		
		<%=Gui.GroupBoxStart(UseNewsletterSubscrCheckTxt)%>&nbsp;
		<table id="UseNewsletterSubcrSection" cellpadding="2" cellspacing="0" border="0" style="<%=IIF(cs.UseNewsletterSubscription = 1, "Display: ;", "Display:none;")%>">
			<tr id="Newsletter_Cats"">
				<td width="170" valign="top"><%=Translate.Translate("Kategorier")%></td>
		        <td>
			        <div class=stdnowidth style="border:#cccccc 1px solid; PADDING:3px; HEIGHT:125px; WIDTH:250px; overflow:auto">
				        <asp:Literal id="NewsletterSubscriberList" runat="server" />
			        </div>
		        </td>
		    </tr>		
			<tr>
			    <td width="170"></td>
				<td width="25" valign="top"><button onclick="AddNewsletterSubcrCats();"><%=Translate.JsTranslate("Add") + "/" + Translate.JsTranslate("Remove")%></button></td>
			</tr>
			<tr><td>&nbsp;</td></tr>
        </table>    		
		<%=Gui.GroupboxEnd%>
		
		<script type="text/javascript">
		    HandleValidationMsg();
		</script>
		


	</TD>
</TR>
<%
Translate.GetEditOnlineScript()
%>
