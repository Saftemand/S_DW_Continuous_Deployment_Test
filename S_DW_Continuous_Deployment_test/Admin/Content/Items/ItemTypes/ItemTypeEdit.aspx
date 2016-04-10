<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ItemTypeEdit.aspx.vb" Inherits="Dynamicweb.Admin.ItemTypeEdit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
	    <title></title>
        <dw:ControlResources CombineOutput="false" IncludePrototype="true" IncludeScriptaculous="true" runat="server">
            <Items>
                <dw:GenericResource Url="/Admin/Content/Items/js/Default.js" />
                <dw:GenericResource Url="/Admin/Content/Items/js/ItemTypeEdit.js" />
                <dw:GenericResource Url="/Admin/Content/Items/js/ItemTypeEditGroupVisibilityRule.js" />
                <dw:GenericResource Url="/Admin/Images/Ribbon/UI/RulesEditor/RulesEditor.Model.js" />
                <dw:GenericResource Url="/Admin/Content/Items/css/Default.css" />
                <dw:GenericResource Url="/Admin/Content/Items/css/ItemTypeEdit.css" />
            </Items>
        </dw:ControlResources> 
        <script type="text/javascript">
            Event.observe(document, 'dom:loaded', function () {
                $('cmdUsage').toggleClassName('disabled');
                $('cmdName').toggleClassName('disabled');
            });
        </script>
        <%= ConfigurableEditorAddin.Jscripts%>
    </head>
    <body>
        <form id="MainForm" onsubmit="return  Dynamicweb.Items.ItemTypeEdit.get_current().validateItem();" runat="server" style="overflow: hidden">
            <input type="hidden" id="Save" name="Save" value="" />
            <input type="hidden" id="Close" name="Close" value="" />
            <input type="hidden" id="Layout" name="Layout" value="" />
            <input type="hidden" id="AdvancedSettings" name="AdvancedSettings" value="" />
            <input type="hidden" class="editor-types-json" value='<%=RenderEditorTypes()%>'/>
            <input type="hidden" id="CustomSmallIcon" value="" runat="server"/>
            <input type="hidden" id="CustomLargeIcon" value="" runat="server"/>
            <input type="hidden" id="Inherits" value="" runat="server" />

	        <div style="min-width:1000px;overflow:hidden">
		    <dw:Ribbonbar runat="server" ID="myribbon">
			    <dw:RibbonbarTab Active="true" Name="Item type" runat="server">
				    <dw:RibbonbarGroup runat="server" ID="toolsGroup" Name="Funktioner">
					    <dw:RibbonbarButton runat="server" Text="Gem" Size="Small" Image="Save" KeyboardShortcut="ctrl+s" ID="cmdSave" OnClientClick="Dynamicweb.Items.ItemTypeEdit.get_current().save();" ShowWait="true" WaitTimeout="500">
					    </dw:RibbonbarButton>
					    <dw:RibbonbarButton runat="server" Text="Gem og luk" Size="Small" Image="SaveAndClose" ID="cmdSaveAndClose" OnClientClick="Dynamicweb.Items.ItemTypeEdit.get_current().save(true);" ShowWait="true" WaitTimeout="500">
					    </dw:RibbonbarButton>
					    <dw:RibbonbarButton runat="server" Text="Annuller" Size="Small" Image="Cancel" ID="cmdCancel" OnClientClick="Dynamicweb.Items.ItemTypeEdit.reloadPageTree(true);" ShowWait="true" WaitTimeout="500">
					    </dw:RibbonbarButton>
				    </dw:RibbonbarGroup>
				    <dw:RibbonbarGroup ID="itemGroup" runat="server" Name="Item type">
					    <dw:RibbonbarButton ID="cmdAddField" runat="server" Size="Small" Text="New field" Image="AddDocument" OnClientClick="Dynamicweb.Items.ItemTypeEdit.get_current().add_field();">
					    </dw:RibbonbarButton>
					    <dw:RibbonbarButton ID="cmdAddGroup" runat="server" Size="Small" Text="New group" Image="Form_Add" OnClientClick="Dynamicweb.Items.ItemTypeEdit.get_current().add_group();">
					    </dw:RibbonbarButton>
                    </dw:RibbonbarGroup>
				    <dw:RibbonbarGroup ID="settingsGroup" runat="server" Name="Settings">
					    <dw:RibbonbarButton ID="cmdRestriction" runat="server" Size="Small" Text="Restrictions" Image="key" OnClientClick="Dynamicweb.Items.ItemTypeEdit.showRestrictions();">
					    </dw:RibbonbarButton>
					    <dw:RibbonbarButton ID="cmdName" runat="server" Size="Small" Text="Settings" Image="EditGear" OnClientClick="Dynamicweb.Items.ItemTypeEdit.get_current().openGeneralSetting();" Disabled="True">
					    </dw:RibbonbarButton>
                    </dw:RibbonbarGroup>
                    <dw:RibbonbarGroup ID="usageGroup" runat="server" Name="Usage">
					    <dw:RibbonbarButton ID="cmdUsage" runat="server" Size="Small" ImagePath="../img/ItemTypeUsage.png" OnClientClick="Dynamicweb.Items.ItemTypeEdit.show_usage();" Text="Item type usage" Disabled="True" />
					    </dw:RibbonbarButton>
                    </dw:RibbonbarGroup>
				    <dw:RibbonbarGroup ID="helpGroup" runat="server" Name="Help">
					    <dw:RibbonbarButton ID="cmdHelp" runat="server" Size="Large" Text="Help" Image="Help"  OnClientClick="Dynamicweb.Items.ItemTypeEdit.help();">
					    </dw:RibbonbarButton>
                    </dw:RibbonbarGroup>
                </dw:RibbonbarTab>
            </dw:Ribbonbar>
            </div>
		    <div id="breadcrumb" runat="server"></div>
        	<dw:Infobar ID="infoCodeFirst" runat="server" Type="Information" Message="This is CodeFirst item. Some properties are not editable" Visible="false" />
            <div class="list">
                <asp:Repeater runat="server" ID="groupsRepeater">
			        <HeaderTemplate>
			        <ul>
				        <li class="header">
					        <span class="C0"><input type="checkbox" onclick="Dynamicweb.Items.ItemTypeEdit.get_current().toggleAllSelected(this.checked);" style="margin-left:19px; margin-right:2px" /></span>
					        <span class="pipe"></span><span class="C1"><%=Translate.Translate("Name")%></span> 
					        <span class="pipe"></span><span class="C2"><%=Translate.Translate("System name")%></span> 
					        <span class="pipe"></span><span class="C3"><%=Translate.Translate("Type")%></span> 
                            <span class="pipe"></span><span class="C4"><%=Translate.Translate("Inherited from")%></span> 
				        </li>
			        </ul>
			        <div id="_contentWrapper" class="<%= If(IsCodeFirst, "source-code-first", "")%>">
			        <ul id="items">
			        </HeaderTemplate>
                    <ItemTemplate>
                        <li class="ContainerDummy">
                            <div class="Container" oncontextmenu="return ContextMenu.show(event, 'mnuGroups', this, '<%# DataBinder.Eval(Container.DataItem, "SystemName")%>');">
                                <a href="javascript:void(0);" onclick="Dynamicweb.Items.ItemTypeEdit.get_current().openGroupSettings(this);">
                                    <img src="/Admin/Images/Ribbon/Icons/Small/form.png" alt="" />&nbsp;
                                    <span class="group-name"><%# DataBinder.Eval(Container.DataItem, "Name")%></span>
                                </a>
                            </div>
                            <input type="hidden" class="group-system-name" value="<%# DataBinder.Eval(Container.DataItem, "SystemName")%>" />
                            <input type="hidden" class="group-collapsible" value="<%# CInt(DataBinder.Eval(Container.DataItem, "CollapsibleState")).ToString().ToLower()%>" />
                            <input type="hidden" class="group-visibility-field" value="<%# DataBinder.Eval(Container.DataItem, "VisibilityField")%>" />
                            <input type="hidden" class="group-visibility-condition" value="<%# DataBinder.Eval(Container.DataItem, "VisibilityCondition")%>" />
                            <input type="hidden" class="group-visibility-condition-value-type" value="<%# DataBinder.Eval(Container.DataItem, "VisibilityConditionValueType")%>" />
                            <input type="hidden" class="group-visibility-condition-value" value="<%# DataBinder.Eval(Container.DataItem, "VisibilityConditionValue")%>" />
                            <ul style="position:relative;min-height:5px" id="fields_<%# DataBinder.Eval(Container.DataItem, "SystemName")%>">
                            <asp:Repeater ID="groupFieldsRepeater" runat="server">
                                <ItemTemplate>
                                    <li class="item-field <%# If(String.Compare(DataBinder.Eval(Container.DataItem, "Parent"), Me.ItemType.SystemName, StringComparison.InvariantCultureIgnoreCase) = 0, "", "inherited")%>" style="position:relative;" oncontextmenu="return ContextMenu.show(event, 'mnuFields', this);">
					                    <span class="C0">
                                            <a href="javascript:void(0);" onclick="Dynamicweb.Items.ItemTypeEdit.get_current().openAdvancedSettings(this);">
                                                <img src="/Admin/Images/Ribbon/Icons/Small/document.png" alt="">
                                            </a>
                                            <input type="checkbox" onclick="Dynamicweb.Items.ItemTypeEdit.get_current().handleCheckboxes(this);" class="<%# GetFieldCheckboxClass(CType(Container.DataItem, Dynamicweb.Content.Items.Metadata.ItemField))%>" />
                                            <input type="hidden" class="field-advanced-settings" value="<%# GetFieldAdvancedSettings(CType(Container.DataItem, Dynamicweb.Content.Items.Metadata.ItemField))%>" />
                                        </span>
                                        <span class="C1">
					                        <a href="javascript:void(0);" onclick="Dynamicweb.Items.ItemTypeEdit.get_current().openAdvancedSettings(this);">
                                                <span class="inner field-name"><%# DataBinder.Eval(Container.DataItem, "Name")%></span>
                                            </a>
                                        </span> 
                                        <span class="C2">
                                        <a href="javascript:void(0);" onclick="Dynamicweb.Items.ItemTypeEdit.get_current().openAdvancedSettings(this);">
                                    	    <span class="inner field-system-name"><%# DataBinder.Eval(Container.DataItem, "SystemName")%></span>
                                        </a>
                                        </span>
					                    <span class="C3 field-editor-type">
                                            <%# GetFieldType(CType(Container.DataItem, Dynamicweb.Content.Items.Metadata.ItemField))%>
                                        </span> 
                                        <span class="C4">
                                            <%# GetInheritanceInfo(CType(Container.DataItem, Dynamicweb.Content.Items.Metadata.ItemField))%>
                                        </span>
                                    </li>
                                </ItemTemplate>
                             </asp:Repeater>
                            </ul>
                        </li>
                    </ItemTemplate>
			        <FooterTemplate>
				    </ul>
                        <div style="margin: 5px; color: darkGray; position:relative;">
                            <dw:TranslateLabel ID="TranslateLabel6" Text="Hint: Drag rows to change the order of the fields." runat="server" />
                        </div>
				    </div>
 			        </FooterTemplate>
                </asp:Repeater>
		        </div>
            <ul id="newGroupTemplate" style="display: none">
                <li class="ContainerDummy" style="position: relative;" >
                    <div class="Container" oncontextmenu="return ContextMenu.show(event, 'mnuGroups', this, '__NewGroupSystemName__');">
                        <a href="javascript:void(0);" onclick="Dynamicweb.Items.ItemTypeEdit.get_current().openGroupSettings(this);">
                            <img src="/Admin/Images/Ribbon/Icons/Small/form.png" alt="" />&nbsp;<span class="group-name">__NewGroup__</span>
                        </a>
                    </div>
                    <input type="hidden" class="group-system-name" value="__NewGroupSystemName__" />
                    <input type="hidden" class="group-collapsible" value="__NewGroupCollapsible__" />

                    <input type="hidden" class="group-visibility-field" value="__NewVisibilityField__" />
                    <input type="hidden" class="group-visibility-condition" value="__NewVisibilityCondition__" />
                    <input type="hidden" class="group-visibility-condition-value-type" value="__NewVisibilityConditionValueType__" />
                    <input type="hidden" class="group-visibility-condition-value" value="__NewVisibilityConditionValue__" />

                    <ul style="position:relative;min-height:5px" id="fields___NewGroupSystemName__">
                    </ul>
                </li>
            </ul>
            <ul id="newFieldTemplate" style="display: none">
                <li class="item-field" style="position: relative;" oncontextmenu="return ContextMenu.show(event, 'mnuFields', this);">
					<span class="C0">
                        <a href="javascript:void(0);" onclick="Dynamicweb.Items.ItemTypeEdit.get_current().openAdvancedSettings(this);">
                            <img src="/Admin/Images/Ribbon/Icons/Small/document.png" alt="" />
                        </a>
                        <input type="checkbox" onclick="Dynamicweb.Items.ItemTypeEdit.get_current().handleCheckboxes(this);" />
                        <input type="hidden" class="field-advanced-settings" value="" />
                    </span>
					<span class="C1">
					    <a href="javascript:void(0);" onclick="Dynamicweb.Items.ItemTypeEdit.get_current().openAdvancedSettings(this);">
                            <span class="inner field-name"></span>
                        </a>
                    </span>
                    <span class="C2">
                        <a href="javascript:void(0);" onclick="Dynamicweb.Items.ItemTypeEdit.get_current().openAdvancedSettings(this);">
                            <span class="inner field-system-name"></span>
                        </a>
                    </span>
					<span class="C3 field-editor-type"></span> 
                </li>
            </ul>
	        <div id="BottomInformationBg" class="BottomInformation" runat="server">
	            <table border="0" cellpadding="0" cellspacing="0">
		            <tr>
			            <td rowspan="2"><img src="/Admin/Images/Ribbon/Icons/Paragraph.png" alt="" onclick="pageProperties2();" class="h" id="icon" /></td>
			            <td align="right">
                            <span class="label"><dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Navn" />:</span>
                        </td>
			            <td width="150"><span id="_itemName" runat="server"></span></td>
			            <td align="right">
				            <span class="label"><dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Field count" />:</span>
			            </td>
			            <td width="300"><span id="_fieldCount" runat="server"></span></td>
			            <td align="right"></td>
			            <td width="50%"></td>
    	                <td></td>
		            </tr>
		            <tr>
		                <td align="right">
                            <span class="label"><dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="System name" />:</span>
                        </td>
			            <td><span id="_systemName" runat="server"></span>
			            </td>
			            <td align="right"></td>
			            <td><span id="_dateCreated" runat="server"></span></td>
			            <td align="right"></td>
			            <td><span></span></td>
		            </tr>
	            </table>
	        </div>

            <dw:PopUpWindow ID="dlgFieldOptions" Title="Edit field options" AutoCenterProgress="true" TranslateTitle="true" ShowOkButton="true" ShowCancelButton="true" ShowHelpButton="false" 
                ShowClose="true" Width="575" Height="360" AutoReload="true" UseTabularLayout="true" runat="server" />

            <dw:Dialog ID="dlgEditRestrictions" Title="Edit restrictions" UseTabularLayout="true" Width="450" OkAction="Dynamicweb.Items.ItemTypeEdit.get_current().dialogER_Okaction();" ShowOkButton="true" ShowCancelButton="false" ShowClose="true" ShowHelpButton="false" runat="server">
                <div class="restrictions-container">
                    <dw:GroupBox ID="gbRestrictions" Title="Restrictions" runat="server"></dw:GroupBox>
                </div>
                <div class="separator-10">&nbsp;</div>
            </dw:Dialog>

            <dw:Dialog ID="dlgAdvanced" Title="Edit settings" UseTabularLayout="true" Width="465" OkAction="Dynamicweb.Items.ItemTypeEdit.get_current().saveAdvancedSettings();" 
                ShowOkButton="true" ShowCancelButton="true" ShowClose="true" ShowHelpButton="false" runat="server">

                <input type="hidden" id="param-token" value="" />
                <input type="hidden" id="param-parent" value="" />
                <div class="inheritance-info hidden">
                </div>
                <dw:GroupBox Title="General settings" runat="server">
                    <table border="0">
                        <tr>
                            <td style="width: 170px">
                                <label>
                                    <dw:TranslateLabel Text="Name" runat="server" />
                                </label>
                            </td>
                            <td>
                                <input type="text" class="std" id="param-name" style="width: 200px" onkeyup="Dynamicweb.Items.ItemTypeEdit.get_current().onAfterEditFieldName(this);" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>
                                    <dw:TranslateLabel Text="System name" runat="server" />
                                </label>
                            </td>
                            <td>
                                <input type="text" class="std" id="param-systemname" style="width: 200px" onblur="Dynamicweb.Items.ItemTypeEdit.get_current().onAfterEditSystemName(this);" />
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <label>
                                    <dw:TranslateLabel Text="Description" runat="server" />
                                </label>
                            </td>
                            <td>
                                <textarea class="std" id="param-description" style="width: 200px" rows="5" cols="100"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>
                                    <dw:TranslateLabel Text="Type" runat="server" />
                                </label>
                            </td>
                            <td>
                                <div class="field-and-link editor-types-outer clearfix">
                                    <select id="param-editortype" class="std field-type" style="width: 200px;"></select>
                                    <a href="javascript:void(0);" id="edit-options-activator" title="<%=Dynamicweb.Backend.Translate.Translate("Edit field options")%>">
                                        <img src="/Admin/Images/Ribbon/Icons/Small/View_edit.png" alt="" title="<%=Dynamicweb.Backend.Translate.Translate("Edit field options")%>" />
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
                <div id="param-editor-configuration">
                    <de:AddInSelector    
								    runat="server" 
								    ID="ConfigurableEditorAddin" 
                                    useNewUI="true" 
                                    AddInParameterWidth="auto"
                                    AddInShowSelector="false"
                                    AddInShowNothingSelected="false" 
								    AddInGroupName="Configurable editor" 
								    AddInTypeName="Dynamicweb.Content.Items.Editors.Editor"
                                    AddInParameterName="Parameters"
                                    onafterUpdateSelection="Dynamicweb.Items.ItemTypeEdit.onEditorChanges()" 
								    />                   
                </div>
                <div class="separator-10">&nbsp;</div>
                <dw:GroupBox Title="Layout" runat="server">
                    <table border="0">
                        <tr>
                            <td style="width: 170px">
                                <label>
                                    <dw:TranslateLabel Text="Group" runat="server" />
                                </label>
                            </td>
                            <td>
                                <select id="ddGroup" class="std" style="width: 200px" onchange="Dynamicweb.Items.ItemTypeEdit.get_current()._updatePositionList(this.value)" ><option value=""></option></select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="ddPosition">
                                    <dw:TranslateLabel Text="Position" runat="server" />
                                </label>
                            </td>
                            <td>
                                <select id="ddPosition" class="std" style="width: 50px">
                                    <option value="1">1</option>
                                </select>
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
                <div class="separator-10">&nbsp;</div>   
                  
                <div id="AdvDialog_DataSettings">           
                <dw:GroupBox Title="Data" runat="server">
                    <table border="0">
                        <tr>
                            <td style="width: 170px">
                                <label for="param-defaultvalue">
                                    <dw:TranslateLabel Text="Default value" runat="server" />
                                </label>
                            </td>
                            <td>
                                <div class="field-and-link clearfix">
                                    <input type="text" class="std" id="param-defaultvalue" style="width: 200px" onblur="Dynamicweb.Items.ItemTypeEdit.get_current()._validateFieldDefaultValue();" />
                                    <a href="javascript:void(0);" id="validate-defaultvalue-activator" title="<%=Dynamicweb.Backend.Translate.Translate("Validate and update")%>">
                                        <img src="/Admin/Images/Ribbon/Icons/Small/refresh.png" alt="" title="<%=Dynamicweb.Backend.Translate.Translate("Validate and update")%>" />
                                    </a>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 170px">
                                <label for="param-required">
                                    <dw:TranslateLabel Text="Do not search" runat="server" />
                                </label>
                            </td>
                            <td>
                                <input type="checkbox" id="param-excludefromsearch" />
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
                </div>

                <div class="separator-10">&nbsp;</div>

                <div id="AdvDialog_ValidationSettings">
                <dw:GroupBox Title="Validation" runat="server">
                    <table border="0">
                        <tr>
                            <td style="width: 170px">
                                <label for="param-required">
                                    <dw:TranslateLabel Text="Required" runat="server" />
                                </label>
                            </td>
                            <td>
                                <input type="checkbox" id="param-required" onclick="Dynamicweb.Items.ItemTypeEdit.get_current()._validateFieldDefaultValue();" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="param-validationexpression">
                                    <dw:TranslateLabel Text="Validation expression" runat="server" />
                                </label>
                            </td>
                            <td>
                                <div class="field-and-link clearfix">
                                    <input type="text" class="std" id="param-validationexpression" style="width: 200px" />
                                    <a href="javascript:void(0);" id="insert-regex-activator" title="<%=Dynamicweb.Backend.Translate.Translate("Choose regular expression")%>">
                                        <img id="insert-regex-image" src="/Admin/Images/Ribbon/Icons/Small/scroll2.png" alt="" title="<%=Dynamicweb.Backend.Translate.Translate("Choose regular expression")%>" />
                                    </a>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="param-errormessage">
                                    <dw:TranslateLabel Text="Error message" runat="server" />
                                </label>
                            </td>
                            <td>
                                <input type="text" class="std" id="param-errormessage" style="width: 200px" />
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
                </div>

                <div class="separator-10">&nbsp;</div>
            </dw:Dialog>

            <dw:Dialog ID="dlgGeneralSettings" Title="Settings" Width="550" UseTabularLayout="true" OkAction="Dynamicweb.Items.ItemTypeEdit.get_current().saveGeneralSettings();" 
                ShowOkButton="true" ShowCancelButton="true" ShowClose="False" ShowHelpButton="false" runat="server">
                <dw:GroupBox ID="GroupBox2" Title="Settings" runat="server">
                
                    <div runat="server" id="pageViewSelectContainer">
                        <label ID="pageViewSelectLabel" style="margin-right:5px;" class="item-option-label" runat="server"><%=Translate.Translate("Default view") %></label>
                        <select runat="server" id="pageViewSelect" style="vertical-align:-webkit-baseline-middle;"></select>
                    </div>
                
                    <table border="0">
                        <colgroup>
                            <col style="width:170px;"/>
                        </colgroup>
                        <tr>
                            <td>
                                <label>
                                    <dw:TranslateLabel ID="TranslateLabel2" Text="Name" runat="server" />
                                </label>
                            </td>
                            <td>
                                <input id="txName" type="text" class="std name" style="width: 300px" runat="server" onkeyup="Dynamicweb.Items.ItemTypeEdit.get_current().onAfterEditItemName(this);" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>
                                    <dw:TranslateLabel ID="TranslateLabel4" Text="System name" runat="server" />
                                </label>
                            </td>
                            <td>
                                <input id="txSystemName" type="text" class="std system-name" style="width: 300px" runat="server" onblur="Dynamicweb.Items.ItemTypeEdit.get_current().onAfterEditSystemName(this);" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>
                                    <dw:TranslateLabel ID="lbDescription" Text="Description" runat="server" />
                                </label>
                            </td>
                            <td>
                                <textarea  id="txDescription" class="std" style="width: 300px" runat="server" rows="5" cols="100" />
                            </td>
                        </tr>
                        <tr id="general-restrictions-row">
                            <td colspan="2">
                                <asp:Literal id="GeneralRestrictions" runat="server"></asp:Literal>
                             </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <div style="display:inline-block; vertical-align:top">
                                    <img src="/Admin/Images/Ribbon/Icons/Small/information.png" alt="" class="hintImage" />
                                </div>
                                <div style="display:inline-block; width:275px; word-wrap:break-word" class="hintText">
                                    <dw:TranslateLabel ID="TranslateLabel7" runat="server" Text="The item type is not available until a selection is made" />
                                </div>  
                            </td>
                        </tr>
                        <tr><td style="height:8px;"></td></tr>
                        <tr>
					        <td>
							    <dw:TranslateLabel ID="lbIcon" Text="Icon" runat="server" />
					        </td>
					        <td>
						        <dw:Richselect ID="SmallIcon" runat="server" Height="30" Itemheight="30" Itemwidth="300"></dw:Richselect>
					        </td>
				        </tr>
                        <tr>
					        <td>
							    <dw:TranslateLabel ID="lblThumbnail" Text="Thumbnail" runat="server" />
					        </td>
					        <td>
						        <dw:Richselect ID="LargeIcon" runat="server" Height="39" Itemheight="39" Itemwidth="300"></dw:Richselect>
					        </td>
				        </tr>
                        <tr>
					        <td>
							    <dw:TranslateLabel Text="Customized URLs" runat="server" />
					        </td>
					        <td>
                                <div style="display:inline-block"><dw:CheckBox ID="cbIncludeInUrlIndex" Value="True" runat="server" CssClass="dlgChekboxCustomURLs"/></div>
                                <div style="display:inline-block; position:absolute; margin-left: 2px; margin-top: 3px;"><label for="cbIncludeInUrlIndex"><dw:TranslateLabel Text="Generate" runat="server" /></label></div>
					        </td>
				        </tr>
                        <tr>
					        <td>
							    <dw:TranslateLabel Text="Item cache" runat="server" />
					        </td>
					        <td>
						        <div style="display:inline-block"><dw:CheckBox ID="cbUseItemCache" Value="True" CssClass="std" runat="server"/></div>
                                <div style="display:inline-block; position:absolute; margin-left: 2px; margin-top: 3px;"><label for="cbUseItemCache"><dw:TranslateLabel Text="Enable" runat="server" /></label></div>
					        </td>
				        </tr>
                        <tr>
                            <td>
                                <label>
                                    <dw:TranslateLabel Text="Category" runat="server" />
                                </label>
                            </td>
                            <td>
                                <input type="text" class="std" style="width: 300px" id="txCategory" autocomplete="false" runat="server"/>
                                <div id="txCategoryAutocompleteIndicator" class="autocomplete autocomplete-indicator" style="display: none">
                                    <ul>
                                        <li><span><img src="/Admin/Images/Progress/wait.gif" alt="Working..." /></span></li>
                                    </ul>
                                </div>
                                <div id="txCategoryAutocompleteMenu" class="autocomplete"></div>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <div style="display:inline-block; vertical-align:top">
                                    <img src="/Admin/Images/Ribbon/Icons/Small/information.png" alt="" class="hintImage" />
                                </div>
                                <div style="display:inline-block; width:275px; word-wrap:break-word" class="hintText">
                                    <dw:TranslateLabel runat="server" Text="Write path like this: 'folder/sub folder/etc' to create category" />
                                </div>  
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel25" runat="server" Text="Use field for title" />
                            </td>
							<td>
                                <select id="ddFieldForTitle" class="std" style="width: 304px"></select>
                                <input id="txFieldForTitle" type="hidden" runat="server"/>
							</td>
						</tr>
                        <tr>
                            <td>
							    <dw:TranslateLabel ID="TranslateLabel8" Text="Title" runat="server" />
                            </td>
							<td>
                                <input type="text" class="std" style="width: 300px" id="txTitle" autocomplete="false" runat="server"/>
                                <div style="display:inline-block; vertical-align:top">
                                    <img src="/Admin/Images/Ribbon/Icons/Small/information.png" alt="" class="hintImage" />
                                </div>
                                <div style="display:inline-block; width:275px; word-wrap:break-word" class="hintText">
                                    <dw:TranslateLabel runat="server" text="Define the title by adding parameters like this: {{FieldSystemName}}. When this field is in use then 'Use field for title' will be ignored." />
                                </div>
                            </td>
						</tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel Text="Inherited from" runat="server"/>
                            </td>
                            <td>
                                <select id="txBase" class="std" style="width: 304px" onchange="Dynamicweb.Items.ItemTypeEdit.get_current().onAfterSelectBase(this);" runat="server"></select>
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
                <input type="hidden" id="SystemNameIsValid" />
                <input type="hidden" id="SystemNameOrigin" />
                <div class="separator-10">&nbsp;</div>
            </dw:Dialog>

            <dw:Dialog ID="dlgGroupSetting" Title="Group settings" Width="450" OkAction="Dynamicweb.Items.ItemTypeEdit.get_current().init_group();" 
                ShowOkButton="true" ShowCancelButton="true" ShowClose="true" UseTabularLayout="true" ShowHelpButton="false" runat="server">
                <dw:GroupBox Title="Group settings" runat="server">
                    <table border="0">
                        <tr>
                            <td style="width: 170px">
                                <label>
                                    <dw:TranslateLabel Text="Name" runat="server" />
                                </label>
                            </td>
                            <td>
                                <input id="GroupName" type="text" class="std name" style="width: 200px" runat="server" onkeyup="Dynamicweb.Items.ItemTypeEdit.get_current().onAfterEditGroupName(this);"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>
                                    <dw:TranslateLabel Text="System name" runat="server" />
                                </label>
                            </td>
                            <td>
                                <input id="GroupSystemName" type="text" class="std system-name" style="width: 200px" runat="server" onblur="Dynamicweb.Items.ItemTypeEdit.get_current().onAfterEditSystemName(this);" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>
                                    <dw:TranslateLabel Text="Collapsible state" runat="server" />
                                </label>
                            </td>
                            <td>
                                <select id="GroupCollapsibleState" class="std" style="width: 200px">
                                    <option value="0"><%=Translate.Translate("None")%></option>
                                    <option value="1"><%=Translate.Translate("Collapsed")%></option>
                                    <option value="2"><%=Translate.Translate("Expanded")%></option>
                                </select>
                            </td>
                        </tr>
                        <tr id="visibilitySettingsTab">
                            <td class="visibilitySettings">
                                <label>
                                    <dw:TranslateLabel Text="Show only if" runat="server" />
                                </label>
                            </td>
                            <td>
                                <div>                                          
                                    <div id="GroupVisibilityField"></div>
                                    <div id="GroupVisibilityCondition" display: none;"></div>
                                    <div id="GroupVisibilityConditionValue" display: none;"></div>
                                </div> 
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
                <div class="separator-10">&nbsp;</div>
            </dw:Dialog>

            <dw:Dialog ID="dlgRegularExpressions" Title="Regular expressions" Width="450" ShowOkButton="false" ShowCancelButton="true" ShowClose="true" ShowHelpButton="false" UseTabularLayout="true" runat="server">
                <dw:GroupBox Title="Choose regular expression" runat="server">
                    <table border="0" width="100%">
                        <tr>
                            <td>
                                <ul class="regex-library">
                                    <li data-regex="^$|^[0-9]+">
                                        <h3><dw:TranslateLabel Text="Numbers" runat="server" /></h3>
                                        <span>^$|^[0-9]+</span>
                                    </li>
                                    <li data-regex="^$|^[a-zA-Z0-9]+">
                                        <h3><dw:TranslateLabel Text="Alpha-numeric characters" runat="server" /></h3>
                                        <span>^$|^[a-zA-Z0-9]+</span>
                                    </li>
                                    <li data-regex="^$|^(0?[1-9]|1[012])[- /.](0?[1-9]|[12][0-9]|3[01])[- /.](19|20)?[0-9]{2}">
                                        <h3><dw:TranslateLabel Text="Date (MM/DD/YYYY)" runat="server" /></h3>
                                        <span>^$|^(0?[1-9]|1[012])[- /.](0?[1-9]|[12][0-9]|3[01])[- /.](19|20)?[0-9]{2}</span>
                                    </li>
                                    <li data-regex="^$|^(19|20)?[0-9]{2}[- /.](0?[1-9]|1[012])[- /.](0?[1-9]|[12][0-9]|3[01])">
                                        <h3><dw:TranslateLabel Text="Date (YYYY/MM/DD)" runat="server" /></h3>
                                        <span>^$|^(19|20)?[0-9]{2}[- /.](0?[1-9]|1[012])[- /.](0?[1-9]|[12][0-9]|3[01])</span>
                                    </li>
                                    <li data-regex="^$|^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}">
                                        <h3><dw:TranslateLabel Text="Email (simplified)" runat="server" /></h3>
                                        <span>^$|^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}</span>
                                    </li>
                                    <li data-regex="^$|^[a-z0-9_-]{6,18}">
                                        <h3><dw:TranslateLabel Text="Password" runat="server" /></h3>
                                        <span>^$|^[a-z0-9_-]{6,18}</span>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
                <div>&nbsp;</div>
            </dw:Dialog>

            <dw:ContextMenu ID="mnuGroups" runat="server" Translate="true">
	            <dw:ContextmenuButton ID="btneditgroup" runat="server" DoTranslate="True" Text="Edit group" Image="Form_Edit" Divide="After" OnClientClick="Dynamicweb.Items.ItemTypeEdit.get_current().openGroupSettings(ContextMenu.callingID);">
	            </dw:ContextmenuButton>
	            <dw:ContextmenuButton ID="btnaddfield" runat="server" DoTranslate="True" Text="New field" Image="AddDocument" OnClientClick="Dynamicweb.Items.ItemTypeEdit.get_current().add_field(ContextMenu.callingItemID);">
	            </dw:ContextmenuButton>
            </dw:ContextMenu>
            <dw:ContextMenu ID="mnuFields" runat="server" Translate="true" OnClientSelectView="Dynamicweb.Items.ItemTypeEdit.onContextMenuView">
                <dw:ContextmenuButton ID="btnViewField" Views="readonly" runat="server" DoTranslate="True" Text="View field" Image="Document" OnClientClick="Dynamicweb.Items.ItemTypeEdit.get_current().openAdvancedSettings(ContextMenu.callingID);">
	            </dw:ContextmenuButton>
	            <dw:ContextmenuButton ID="btneditfield" Views="mixed,common" runat="server" DoTranslate="True" Text="Edit field" Image="EditDocument" OnClientClick="Dynamicweb.Items.ItemTypeEdit.get_current().openAdvancedSettings(ContextMenu.callingID);">
	            </dw:ContextmenuButton>
	            <dw:ContextmenuButton ID="btndelfield" Views="common" runat="server" DoTranslate="True" Text="Delete field" Image="DeleteDocument" OnClientClick="Dynamicweb.Items.ItemTypeEdit.get_current().deleteField(ContextMenu.callingID);">
	            </dw:ContextmenuButton>
                <dw:ContextMenuButton ID="btnDeleteSelected" Views="mixed,selection" runat="server" DoTranslate="True" Text="Delete selected" Image="DeleteDocument" Divide="Before" OnClientClick="Dynamicweb.Items.ItemTypeEdit.get_current().deleteSelectedFields();"/>
            </dw:ContextMenu>
        </form>
        <dw:Overlay ID="ItemTypeEditOverlay" runat="server"></dw:Overlay>

        <%Translate.GetEditOnlineScript()%>
    </body>
</html>
