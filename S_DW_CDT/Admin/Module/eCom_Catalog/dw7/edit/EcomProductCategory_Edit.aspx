<%@ Page Language="vb" ValidateRequest="false" AutoEventWireup="false" CodeBehind="EcomProductCategory_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomProductCategory_Edit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1" runat="server">
        <title></title>

    	<dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
		<link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
		<script type="text/javascript" src="/Admin/FormValidation.js"></script>

        <style type="text/css">
            body 
            {
            	background: #DFE9F5 url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;
            }
            
            table.tabTable
            {
            	background: none;
            	background-color: #ffffff;
            }
            
            fieldset
            {
                margin: 0px;
                padding: 0px;
                width: 500px;
            }
        </style>

        <script type="text/javascript">

            $(document).observe('dom:loaded', function () {
                var fieldsets = $("Form1").select('fieldset');

                for (var i = 0; i < fieldsets.length; i++) {
                    fieldsets[i].style.width = (1275 - parent.document.getElementById("treeContainer").offsetWidth) + "px";
                }

                window.focus(); // for ie8-ie9 
                document.getElementById('NameStr').focus(); 
            });

            function showUsage() {
                dialog.show("UsageDialog");
            }
            
            function checkUsage() {
                if (<%= UsageCount %> > 0 ) {
                    dialog.show("DeleteDialog");
                }
                else {
                    if (confirm('<%= Translate.JsTranslate("Do you want delete category?") %>')) {
                        document.getElementById('Form1').DeleteButton.click(); 
                    }
                }
            }

            var selectedRow = null;
            function editField(link) {
                selectedRow = dwGrid_FieldsGrid.findContainingRow(link);

                if (selectedRow) {
                    var fieldName = selectedRow.findControl('Name').value
                    var fieldTag = selectedRow.findControl('TemplateTag').value;
                    var fieldType = selectedRow.findControl('Type').value;
                    var fieldTypeLock = selectedRow.findControl('Type').disabled ? "True" : "False";
                    var fieldDefault = selectedRow.findControl('DefaultValue').value;
                    var presentation = selectedRow.findControl('Presentation').value;
                    var fieldOptions = selectedRow.findControl('Options').value;

                    var ctrlPoUp = <%= FieldEditPopUpClientInstanceName %>;
                    if (ctrlPoUp) {
                        ctrlPoUp.hide();
                        
                        var sessionTicket;
                        new Ajax.Request("/Admin/Module/eCom_Catalog/dw7/edit/EcomProductCategory_Edit.aspx", {
                            asynchronous: false,
                            method: 'post',
                            parameters: {AjaxCmd: 'StoreOptions', Options: fieldOptions},
                            onSuccess: function (request) {
                                sessionTicket = request.responseText;
                            }
                        });

                        var contentURL = "/Admin/Module/eCom_Catalog/dw7/edit/EcomProductCategoryField_Edit.aspx?catfldName=".concat(fieldName, "&catfldTag=", fieldTag, "&catfldType=", fieldType, "&catfldTypeLock=", fieldTypeLock, "&catfldDefault=", fieldDefault, "&catfldPresentation=", presentation, "&catfldOptions=", sessionTicket);
                        ctrlPoUp.set_contentUrl( contentURL );
                        ctrlPoUp.set_width("720"); 
                        ctrlPoUp.show();                                               
                    }
                }
            }

            //  If returns by OK from 'Edit field' dialog
            function OnFieldEditOk(sender, args) {
                var validated = true; 
                if (selectedRow)
                {
                    var ctrlPoUp = <%= FieldEditPopUpClientInstanceName %>;
                    if (ctrlPoUp) {
                        var dlg = ctrlPoUp.get_contentDocument();
                        var frame = ctrlPoUp.get_contentFrame();
                        var wnd = frame.window || frame.contentWindow;
                        // Remove any error messages
                        removeErrorMsgs( dlg );

                        var txtName = dlg.getElementById('NameStr');
                        var txtTag = dlg.getElementById('TemplateNameStr');
                        var txtType = dlg.getElementById('ddTypeValue'); //selectedItemIndex_ddTypes
                        var chkDefault = dlg.getElementById('chkDefaultValue');
                        var txtPresentation = dlg.getElementById('selectedItemIndex_ddPresentations');
                        var txtUniqueValues = (typeof(wnd.CheckUniquenessOfValues) == "function") ? wnd.CheckUniquenessOfValues() : "";
                        var txtOptions = "";
                        try{ 
                            txtOptions = getOptions( dlg ); 
                        }
                        catch(err){
                           validated = false;
                           dlg.getElementById('errFieldOptions').innerHTML = err;
                        }
                        if (txtName.value == ''){
                            validated = false;
                            dlg.getElementById('errNameStr').innerHTML = '<%=Translate.JsTranslate("A name is needed")%>';
                        }
                        if (txtTag.value == ''){
                            validated = false;
                            dlg.getElementById('errTemplateNameStr').innerHTML = '<%=Translate.JsTranslate("A templatetag-name is needed")%>';
                        }
                        if (txtUniqueValues != ""){
                            validated = false;
                            var errField = dlg.getElementById('errFieldOptions');
                            if (errField.innerHTML != "")
                                errField.innerHTML += "<br />";
                                
                            errField.innerHTML += txtUniqueValues;
                        }

                        if (validated)
                        {
                            selectedRow.findControl('Name').value = txtName.value;
                            selectedRow.findControl('TemplateTag').value = txtTag.value;
                            selectedRow.findControl('Type').value = txtType.value;
                            selectedRow.findControl('DefaultValue').value = chkDefault.checked ? "True" : "";
                            selectedRow.findControl('Presentation').value = txtPresentation.value;
                            selectedRow.findControl('Options').value = txtOptions; 
                        }
                        else{
                            args._cancel = true;
                        }
                    }

                }      

            }

            //  If returns by Cancel from 'Edit field' dialog
            function OnFieldEditCancel(sender, args) {
               var ctrlPoUp = <%= FieldEditPopUpClientInstanceName %>;
               if (ctrlPoUp) {
                   ctrlPoUp.set_contentUrl( "" );
                   ctrlPoUp.reload();
               }
            }

            function removeErrorMsgs( dlg ) {
               try {
                   dlg.getElementById('errNameStr').innerHTML = '';
                   dlg.getElementById('errTemplateNameStr').innerHTML = '';
                   dlg.getElementById('errFieldOptions').innerHTML = '';
               } catch(ex) {}
            }

            // Make option string from grid control
            function getOptions( dlg ) {
                var strOptions = '<Options>';  
                var optionRows = dlg.getElementById('optionsList_optionsGrid').rows;

                if (optionRows){
                    for (var i = 2; i < optionRows.length - 1; i++) 
                    {
                        var oName = dlg.getElementById( optionRows[i].id + '_txName').value;
                        var oValue = dlg.getElementById( optionRows[i].id + '_txValue').value;
                        var oDefault = dlg.getElementById( optionRows[i].id + '_chkDefault').checked ? 'True' : '';
                        if (!oName) throw '<%= Translate.Translate("Empty field option name")%>';
                        if (oValue && oValue.match(/[^a-z0-9_]+/i)){
                            throw '<%= Translate.Translate("Option value could contain only a-z, 0-9 characters")%>';
                        }

                        var strOption = '<Option '.concat(
                            'Name = "', encodeAttribute(oName), '" ',
                            'Value = "', escape(oValue), '" ',
                            'Default = "', oDefault, '" ',
                            ' />' );
                        strOptions = strOptions.concat( strOption ); 
                    }
                }
                strOptions = strOptions.concat( '</Options>' ); 
                
                return strOptions;
            }

            function encodeAttribute(attribute) {
                return attribute.replace(/&/g, '&amp;')
                           .replace(/</g, '&lt;')
                           .replace(/>/g, '&gt;')
                           .replace(/"/g, '&quot;')
                           .replace(/'/g, '&apos;');
            };
           
            //  Delete row
            function delField(link) {
                var row = dwGrid_FieldsGrid.findContainingRow(link);

                if (row) {
                    if (confirm('<%= Translate.JsTranslate("Do you want delete field?") %>' )) {
                        dwGrid_FieldsGrid.deleteRows([row]);
                        if (row.findControl('Type').disabled){
                            dwGrid_FieldsGrid.footerRow.element.stopObserving('click');
                            $('FieldsGrid_footerText').innerHTML = '<%= Translate.JsTranslate("Save product category before adding new fields")%>';
                        }
                    }
                }
            }

            function setSystemName(fromObject, toObject) {
                var nameBox;
                var sysNameBox;
                if (typeof(fromObject) == 'string' && typeof(toObject) == 'object') {
                    nameBox = dwGrid_FieldsGrid.findContainingRow(toObject).findControl(fromObject);
                    sysNameBox = toObject;
                }else if (typeof(fromObject) == 'object' && typeof(toObject) == 'string') {
                    nameBox = fromObject;
                    sysNameBox = dwGrid_FieldsGrid.findContainingRow(fromObject).findControl(toObject);
                }else if (typeof(fromObject) == 'object' && typeof(toObject) == 'object') {
                    nameBox = fromObject;
                    sysNameBox = toObject;
                }else {return;}

                var sysName;
                if ($F(sysNameBox).strip().empty()) {
                    sysName = $F(nameBox);
                }else{
                    sysName = $F(sysNameBox);
                }
                sysNameBox.value = sysName.strip().replace(/\s+/g, "_").replace(/[^a-zA-Z0-9_]+/g, "");
            }

            function validateEditType(obj, spanID) {
                var spanObj = dwGrid_FieldsGrid.findContainingRow(obj).findControl(spanID);
                spanObj.style.visibility = (obj.options[obj.selectedIndex].value == "15") ? "visible" : "hidden";
            }
	    function save(close) {
	        document.getElementById("Close").value = close ? 1 : 0;
	        document.getElementById('Form1').SaveButton.click();
	    }
        </script>

    </head>
	<body>
		<asp:Literal id="BoxStart" runat="server"></asp:Literal>
		<form id="Form1" method="post" runat="server">
            <input id="Close" type="hidden" name="Close" value="0" />
			<asp:Literal id="TableIsBlocked" runat="server"></asp:Literal>
		    <table border="0" cellpadding="2" cellspacing="2" width='100%' style='width:100%; background-color: #FFFFFF;'>
			    <tr>
				    <td>
					    <fieldset>
                            <legend class="gbTitle"><%=Translate.Translate("Indstillinger")%></legend>
						    <table border="0" cellpadding="2" cellspacing="2" width='100%' style='width:100%'>
							    <tr>
								    <td>
									    <table border="0" cellpadding="2" cellspacing="2" width="100%">
										    <tr>
											    <td width="170"><dw:TranslateLabel id="tLabelName" runat="server" Text="Navn" /></td>
											    <td>
				                                    <div id="errNameStr" style="color: Red;"></div>
				                                    <asp:textbox id="NameStr" CssClass="NewUIinput" runat="server" onblur="setSystemName(this, $('SystemNameStr'));" />
				                                </td>
										    </tr>
										    <tr>
											    <td width="170"><dw:TranslateLabel id="tLabelSystemName" runat="server" Text="Systemnavn" /></td>
											    <td>
                                                    <div id="errSystemNameStr" style="color: Red;"></div>
				                                    <asp:textbox id="SystemNameStr" CssClass="NewUIinput" runat="server" onblur="setSystemName($('NameStr'), this);" />
				                                </td>
										    </tr>
									    </table>
								    </td>
							    </tr>
						    </table>
					    </fieldset>
					    <fieldset>
                            <legend class="gbTitle"><%= Translate.Translate("Fields")%></legend>
						    <table border="0" cellpadding="2" cellspacing="2" width='100%' style='width:100%'>
							    <tr>
								    <td>
                                        <dw:EditableGrid runat="server" ID="FieldsGrid">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:TextBox runat="server" ID="Name" Text="" CssClass="NewUIinput" style="margin-left: 5px;" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:TextBox runat="server" ID="SystemName" Text="" CssClass="NewUIinput" />
                                                        <asp:HiddenField runat="server" ID="SystemNameHidden" Value="" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:TextBox runat="server" ID="TemplateTag" Text="" CssClass="NewUIinput" />
                                                        <asp:HiddenField runat="server" ID="TemplateTagHidden" Value="" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:DropDownList runat="server" ID="Type" CssClass="NewUIinput" Width="190">
                                                        </asp:DropDownList>
                                                        <asp:HiddenField runat="server" ID="TypeHidden" Value="" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <div id="ErrorMessage" runat="server" style="color: Red;"></div>
                                                        <input runat="server" ID="DefaultValue" type="hidden"/>
                                                        <input runat="server" ID="Presentation" type="hidden"/>
                                                        <input runat="server" ID="Options" type="hidden"/>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ItemStyle-Width="20px">
                                                    <ItemTemplate>
                                                        <span runat="server" id="EditImage" class="option-field-offset">
                                                            <a href="javascript:void(0);" onclick="javascript:editField(this);">
                                                                <img src="/Admin/Images/Ribbon/Icons/Small/Edit.png" alt="" title="<%= Translate.Translate("Edit")%>" border="0" />
                                                            </a>
                                                        </span>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField ItemStyle-Width="20px">
                                                    <ItemTemplate>
                                                        <span class="option-field-offset">
                                                            <a href="javascript:void(0);" onclick="javascript:delField(this);">
                                                                <img src="/Admin/Images/Ribbon/Icons/Small/Delete.png" alt="" title="<%= Translate.Translate("Delete")%>" border="0" />
                                                            </a>
                                                        </span>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </dw:EditableGrid>
								    </td>
							    </tr>
						    </table>
					    </fieldset>
				    </td>
			    </tr>
		    </table>
		    <br />
							
		    <asp:Button id="SaveButton" style="display:none" UseSubmitBehavior="true" runat="server"></asp:Button>
		    <asp:Button id="DeleteButton" style="display:none" UseSubmitBehavior="true" runat="server"></asp:Button>
            <asp:HiddenField runat="server" ID="hiddenCategoryID" Value="" />

            <dw:Dialog runat="server" ID="UsageDialog" AllowDrag="true" OkAction="dialog.hide('UsageDialog');" ShowCancelButton="false" ShowClose="false" ShowOkButton="true" Title="Usage" TranslateTitle="true">
                <div>
                    <asp:Literal runat="server" ID="UsageContent" />
                </div>
            </dw:Dialog>

            <dw:Dialog runat="server" ID="DeleteDialog" AllowDrag="true" OkAction="dialog.hide('DeleteDialog');" ShowCancelButton="false" ShowClose="false" ShowOkButton="true" Title="Cannot delete" TranslateTitle="true">
                <div>
                    <asp:Literal runat="server" ID="DeleteContent" />
                </div>
            </dw:Dialog>

            <dw:PopUpWindow runat="server" ID="fieldEditPopUp" AllowDrag="true" OnClientOk="OnFieldEditOk"  OnClientCancel="OnFieldEditCancel" ShowCancelButton="true" ShowClose="false" ShowOkButton="true" 
                 UseTabularLayout="true" AllowContentTransparency="true" Title="Edit field" TranslateTitle="true" IsModal="true" AutoReload="false" Width="720" Height="400" />
		</form>
		<asp:Literal id="BoxEnd" runat="server"></asp:Literal>

	    <script type="text/javascript">
	        addMinLengthRestriction('NameStr', 1, '<%=Translate.JsTranslate("A name is needed")%>');
	        addRegExRestriction('SystemNameStr', '^[a-zA-Z]+[a-zA-Z0-9_]*$', '<%=Translate.JsTranslate("System name is incorrect")%>');
	        activateValidation('Form1');
        </script>

		<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
	</body>
</html>
