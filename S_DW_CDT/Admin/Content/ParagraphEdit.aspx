<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" CodeBehind="ParagraphEdit.aspx.vb" Inherits="Dynamicweb.Admin.ParagraphEdit" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls.OMC" TagPrefix="omc" %>
<%@ Register TagPrefix="paragraph" TagName="TemplateSelector" Src="/Admin/Content/TemplateSelector/TemplateSelector.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <meta http-equiv="x-ua-compatible" content="IE=EmulateIE9" />
    <dw:ControlResources ID="ctrlResources" runat="server" IncludeUIStylesheet="true" CombineOutput="false">
        <Items>
            <dw:GenericResource Url="/Admin/Content/Items/js/Default.js" />
            <dw:GenericResource Url="/Admin/Content/Items/css/Default.css" />
            <dw:GenericResource Url="/Admin/Content/JsLib/dw/Utilities.js" />
            <dw:GenericResource Url="/Admin/Content/JsLib/dw/Validation.js" />
            <dw:GenericResource Url="/Admin/Content/ParagraphEdit.js" />
            <dw:GenericResource Url="/Admin/Content/ParagraphEdit.css" />
        </Items>
    </dw:ControlResources>
    <script type="text/javascript">
        var paragraphNotSavedText = "<%=paragraphNotSavedText %>";
        var paragraphCancelWarnText = "<%=paragraphCancelWarnText %>";
        var paragraphCancelWarn = <%=paragraphCancelWarn.ToString.ToLower %>;

        $(document).observe('keydown', function (e) {
            if (e.keyCode == 13) {
                var srcElement = e.srcElement ? e.srcElement : e.target;
                if (srcElement.type != 'textarea') {
                    e.preventDefault();
                    Save();
                }
            }
        });
        
    </script>
    <style type="text/css">
        body {
            overflow: hidden;
        }
    </style>
</head>
<body onload="myInit($('ParagraphPageID').value);">
    <form id="ParagraphForm" runat="server" action="ParagraphEdit.aspx" method="post">
        <input type="hidden" runat="server" id="previewUrl" />
        <input type="hidden" runat="server" id="itemParagraphTitle" />
        <input type="hidden" id="changeItemTypeConfirm" value="<%=Translate.JsTranslate("Are you sure that you want to change the Item type? All existing item data will be completely removed and cannot be restored!")%>" />
        <input type="hidden" id="moduleConfirmText" value="<%=Translate.JsTranslate("The attached module may be removed.")%>" />

        <div style="min-width: 900px; overflow: hidden">
            <dw:RibbonBar runat="server" ID="myribbon">
                <dw:RibbonBarTab Active="true" Name="Content" runat="server">
                    <dw:RibbonBarGroup runat="server" ID="toolsGroup" Name="Funktioner">
                        <dw:RibbonBarButton runat="server" Text="Gem" KeyboardShortcut="ctrl+s" Size="Small" Image="Save" OnClientClick="Save();" ID="Save" ShowWait="true" WaitTimeout="500">
                        </dw:RibbonBarButton>
                        <dw:RibbonBarButton runat="server" Text="Gem og luk" Size="Small" Image="SaveAndClose" ID="SaveAndClose" ShowWait="true" WaitTimeout="500">
                        </dw:RibbonBarButton>
                        <dw:RibbonBarButton runat="server" Text="Annuller" Size="Small" Image="Cancel" ID="Cancel" ShowWait="true" WaitTimeout="500">
                        </dw:RibbonBarButton>

                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup ID="RibbonbarGroup2" runat="server" Name="Content">
                        <dw:RibbonBarButton ID="RibbonbarButton1" runat="server" Size="Large" Text="Vis" Image="Preview" OnClientClick="showPage();">
                        </dw:RibbonBarButton>
                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup ID="groupView" Name="Show" runat="server">
                        <dw:RibbonBarRadioButton ID="cmdViewText" Group="GroupView" Size="Large" Image="Paragraph" Text="Text" runat="server" OnClientClick="ParagraphView.switchMode(ParagraphView.mode.text);" />
                        <dw:RibbonBarRadioButton ID="cmdViewItem" Group="GroupView" Size="Large" Image="DocumentOk" Text="Item" runat="server" OnClientClick="ParagraphView.switchMode(ParagraphView.mode.item);" />
                        <dw:RibbonBarRadioButton ID="cmdViewModule" Group="GroupView" Size="Large" Image="Module" Text="Modul" runat="server" OnClientClick="ParagraphView.switchMode(ParagraphView.mode.module);" />
                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup ID="groupTemplates" Name="Template" runat="server">
                        <dw:RibbonBarPanel ID="panelTemplates" runat="server">
                            <paragraph:TemplateSelector ID="selTemplates" Category="Afsnit" OnClientTemplateSelected="onTemplateSelected" runat="server" />
                            <dw:Richselect ID="ParagraphTemplate" runat="server" Height="60" Itemheight="60" Itemwidth="300" Width="300" Visible="false">
                            </dw:Richselect>
                            <span runat="server" id="MasterParagraphTemplateContainer" visible="false">
                                <img src="/Admin/Images/Ribbon/Icons/Small/document_down.png" id="MasterParagraphTemplateNoMatch" runat="server" visible="true" alt="" align="absmiddle" onclick="RichSelect.setselected($(document.getElementById('MasterParagraphTemplate').value).firstDescendant(), 'ParagraphTemplate');" style="cursor: pointer;" />
                                <img src="/Admin/Images/Ribbon/Icons/Small/Check.png" id="MasterParagraphTemplateMatch" runat="server" alt="" align="absmiddle" />
                                <input type="hidden" name="MasterParagraphTemplate" id="MasterParagraphTemplate" runat="server" value="" />
                            </span>
                        </dw:RibbonBarPanel>
                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup ID="RibbonbarGroup8" runat="server" Name="Sprog" Visible="false">
                        <dw:RibbonBarButton ID="RibbonbarButton2" runat="server" Active="false" ImagePath="/Admin/Images/Flags/flag_dk.png" Disabled="false" Size="Large" Text="Sprog" ContextMenuId="languageSelector">
                        </dw:RibbonBarButton>
                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup ID="PrimaryLanugageSelectorGrp" runat="server" Name="Sprog" Visible="false">
                        <dw:RibbonBarButton ID="languageSelector" runat="server" Active="false" ImagePath="/Admin/Images/Flags/flag_dk.png" Disabled="false" Size="Large" Text="Sprog" ContextMenuId="languageSelectorContext"></dw:RibbonBarButton>
                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup runat="server" Name="Help">
                        <dw:RibbonBarButton runat="server" Text="Help" Image="Help" OnClientClick="help();">
                        </dw:RibbonBarButton>
                    </dw:RibbonBarGroup>
                </dw:RibbonBarTab>
                <dw:RibbonBarTab ID="optionsTab" Active="false" Name="Options" runat="server">
                    <dw:RibbonBarGroup runat="server" ID="toolsGroup2" Name="Funktioner">
                        <dw:RibbonBarButton runat="server" Text="Gem" Size="Small" Image="Save" OnClientClick="Save();" ID="Save2">
                        </dw:RibbonBarButton>
                        <dw:RibbonBarButton runat="server" Text="Gem og luk" Size="Small" Image="SaveAndClose" OnClientClick="SaveAndClose();" ID="SaveAndClose2">
                        </dw:RibbonBarButton>
                        <dw:RibbonBarButton runat="server" Text="Annuller" Size="Small" Image="Cancel" OnClientClick="Cancel();" ID="Cancel2">
                        </dw:RibbonBarButton>
                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup ID="RibbonbarGroup1" runat="server" Name="Publicering">
                        <dw:RibbonBarPanel runat="server">
                            <span class="ribbonItem" style="height: 45px; margin-top: 5px;">
                                <dw:DateSelector runat="server" EnableViewState="false" ID="ParagraphValidFrom" />
                                <span style="font-size: 3px;">
                                    <br />
                                    <br />
                                </span>
                                <dw:DateSelector runat="server" EnableViewState="false" ID="ParagraphValidTo" />
                            </span>
                        </dw:RibbonBarPanel>
                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup ID="RibbonbarGroup4" runat="server" Name="Tilgængelighed">
                        <dw:RibbonBarCheckbox runat="server" Size="Small" Text="Hide for phones" Image="Tree" RenderAs="FormControl" ID="ParagraphHideForPhones">
                        </dw:RibbonBarCheckbox>
                        <dw:RibbonBarCheckbox runat="server" Size="Small" Text="Hide for tablets" Image="Tree" RenderAs="FormControl" ID="ParagraphHideForTablets">
                        </dw:RibbonBarCheckbox>
                        <dw:RibbonBarCheckbox runat="server" Size="Small" Text="Hide for desktops" Image="Tree" RenderAs="FormControl" ID="ParagraphHideForDesktops">
                        </dw:RibbonBarCheckbox>
                    </dw:RibbonBarGroup>
                </dw:RibbonBarTab>
                <dw:RibbonBarTab ID="advancedTab" Active="false" Name="Advanced" runat="server">
                    <dw:RibbonBarGroup runat="server" ID="RibbonbarGroup3" Name="Funktioner">
                        <dw:RibbonBarButton runat="server" Text="Gem" Size="Small" Image="Save" OnClientClick="Save();" ID="RibbonbarButton3">
                        </dw:RibbonBarButton>
                        <dw:RibbonBarButton runat="server" Text="Gem og luk" Size="Small" Image="SaveAndClose" OnClientClick="SaveAndClose();" ID="RibbonbarButton4">
                        </dw:RibbonBarButton>
                        <dw:RibbonBarButton runat="server" Text="Annuller" Size="Small" Image="Cancel" OnClientClick="Cancel();" ID="RibbonbarButton5">
                        </dw:RibbonBarButton>
                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup runat="server" ID="settingsGroup1" Name="Settings">
                        <dw:RibbonBarButton runat="server" Version="19.1.0.0" Text="Permissions" ImagePath="/Admin/Images/Icons/user1_lock.png" ID="PermissionsButton" Size="Small" OnClientClick="openEditPermissions();" />
                        <dw:RibbonBarButton runat="server" ID="Versions" Version="19.1.0.0" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/Documents.png" Text="Versions" Visible="false" OnClientClick="ShowVersions();" />
                        <dw:RibbonBarButton runat="server" ID="Layout" Size="Small" Image="DocumentProperties" Text="Layout" OnClientClick="dialog.show('LayoutDialog');"></dw:RibbonBarButton>
                        <dw:RibbonBarButton runat="server" ID="ItemTypeButton" Text="Item type" Image="ItemType" Size="Small" OnClientClick="Dynamicweb.Paragraph.ItemEdit.get_current().openItemType();" />
                        <dw:RibbonBarButton runat="server" ID="GE" Size="Small" Image="InsertGlobalElement" Text="Global element" OnClientClick="ShowGlobals();"></dw:RibbonBarButton>
                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup runat="server" ID="ribbonGrpMaster" Name="Language management" Visible="false" Version="19.1.0.0">
                        <dw:RibbonBarCheckbox runat="server" Size="Small" Text="Lock language versions" RenderAs="FormControl" ID="ParagraphMasterType">
                        </dw:RibbonBarCheckbox>
                        <dw:RibbonBarButton ID="languagemgmtInherit" runat="server" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/earth_lock.png" Text="Languages" Visible="false" OnClientClick="ShowLanguages();">
                        </dw:RibbonBarButton>
                        <dw:RibbonBarButton ID="cmdCompare" runat="server" Size="Small" Text="Compare" ImagePath="/Admin/Images/Ribbon/Icons/Small/window_split_hor.png" OnClientClick="compareToMaster();" Visible="false"></dw:RibbonBarButton>
                    </dw:RibbonBarGroup>
                </dw:RibbonBarTab>

                <dw:RibbonBarTab ID="tabMarketing" Active="false" Name="Marketing" Visible="true" runat="server">
                    <dw:RibbonBarGroup ID="groupMarketingSave" Name="Funktioner" runat="server">
                        <dw:RibbonBarButton Text="Gem" Size="Small" Image="Save" OnClientClick="Save();" ID="cmdMarketingSave" ShowWait="true" WaitTimeout="500" runat="server" />
                        <dw:RibbonBarButton Text="Gem og luk" Size="Small" Image="SaveAndClose" OnClientClick="SaveAndClose();" ID="cmdMarketingSaveAndClose" ShowWait="true" runat="server" />
                        <dw:RibbonBarButton Text="Annuller" Size="Small" Image="Cancel" OnClientClick="Cancel();" ID="cmdMarketingCancel" ShowWait="true" runat="server" />
                    </dw:RibbonBarGroup>

                    <dw:RibbonBarGroup ID="groupMarketingRestrictions" Name="Personalization" runat="server">
                        <dw:RibbonBarButton Text="Personalize" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/star_yellow.png" OnClientClick="ParagraphEdit.openContentRestrictionDialog();" runat="server" />
                        <dw:RibbonBarButton Text="Add profile points" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/line-chart.png" OnClientClick="ParagraphEdit.openProfileDynamicsDialog();" runat="server" />
                    </dw:RibbonBarGroup>

                    <dw:RibbonBarGroup ID="groupVariation" Name="Content" runat="server">
                        <dw:RibbonBarPanel ID="VariationPanel" runat="server">
                            <span class="ribbonItem" style="height: 20px; margin-top: 1px; text-align: left;">
                                <dw:TranslateLabel runat="server" Text="Variation" />
                                <br />
                                <select runat="server" id="ParagraphVariation" class="NewUIinput" style="width: 120px;">
                                </select>
                            </span>
                        </dw:RibbonBarPanel>
                    </dw:RibbonBarGroup>

                    <dw:RibbonBarGroup ID="groupMarketingHelp" Name="Help" runat="server">
                        <dw:RibbonBarButton ID="cmdMarketingHelp" Text="Help" Image="Help" Size="Large" OnClientClick="help();" runat="server">
                        </dw:RibbonBarButton>
                    </dw:RibbonBarGroup>
                </dw:RibbonBarTab>
            </dw:RibbonBar>
        </div>
        <div id="breadcrumb" runat="server"></div>

        <div id="textContent" class="formArea">
            <table width="100%" border="0" cellpadding="0" cellspacing="1" id="formTable">

                <tr>
                    <td style="width: 170px;">
                        <div>
                            <dw:TranslateLabel Text="Afsnitsnavn" runat="server" />
                            <span runat="server" id="MasterParagraphHeaderContainer" visible="false">
                                <img src="/Admin/Images/Ribbon/Icons/Small/document_down.png" id="ParagraphHeaderNoMatch" runat="server" visible="false" alt="" align="absmiddle" onclick="setMasterValue('ParagraphHeader', document.getElementById('MasterParagraphHeader').value);" style="cursor: pointer;" />
                                <img src="/Admin/Images/Ribbon/Icons/Small/Check.png" id="ParagraphHeaderMatch" runat="server" alt="" align="absmiddle" />
                                <input type="hidden" name="MasterParagraphHeader" id="MasterParagraphHeader" runat="server" value="" />
                            </span>
                        </div>
                    </td>
                    <td style="padding-right: 5px;">
                        <input type="text" name="ParagraphHeader" id="ParagraphHeader" runat="server" enableviewstate="false" maxlength="255" class="NewUIinput" onkeyup="updateBreadCrumb();" /></td>
                </tr>
                <tr>
                    <td>
                        <div>
                            <dw:TranslateLabel Text="Billede" runat="server" />
                            <span runat="server" id="MasterParagraphImageContainer" visible="false">
                                <img src="/Admin/Images/Ribbon/Icons/Small/document_down.png" id="ParagraphImageNoMatch" runat="server" visible="false" alt="" align="absmiddle" onclick="setMasterValue('ParagraphImage', document.getElementById('MasterParagraphImage').value);" style="cursor: pointer;" />
                                <img src="/Admin/Images/Ribbon/Icons/Small/Check.png" id="ParagraphImageMatch" runat="server" alt="" align="absmiddle" />
                                <input type="hidden" name="MasterParagraphImage" id="MasterParagraphImage" runat="server" value="" />
                            </span>
                        </div>
                    </td>
                    <td style="padding-right: 5px;">
                        <dw:FileManager ID="ParagraphImage" Name="ParagraphImage" runat="server" Extensions="jpg,gif,png,swf" CssClass="NewUIinput" />
                        <img src="/Admin/Images/Ribbon/Icons/Small/DocumentProperties.png" onclick="dialog.show('ImageSettingsDialog');" runat="server" id="SmageSettingsImg" alt="" class="h" />
                    </td>
                </tr>
                <%   If Me.Paragraph.IsGlobal Or Me.Paragraph.HasGlobal Then%>
                <tr>
                    <td colspan="2">
                        <table bgcolor="#FEFEFE" style="border: 1px solid #ABADB3; width: 100%; cursor: pointer;">
                            <tr>
                                <td onclick="ShowGlobals();">
                                    <img src="/Admin/Images/Ribbon/icons/Small/warning.png" align="absmiddle" alt="" />&nbsp;<%=Translate.JsTranslate("Global element med %% referencer.", "%%", Me.Paragraph.GlobalCount)%></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <%  End If%>
                <tr id="MasterParagraphTextContainer" runat="server" visible="false">
                    <td colspan="2">
                        <div>
                            <dw:TranslateLabel ID="TranslateLabel1" Text="Text" runat="server" />
                            <img src="/Admin/Images/Ribbon/Icons/Small/document_down.png" id="ParagraphTextNoMatch" runat="server" visible="false" alt="" align="absmiddle" onclick="setMasterValue('ParagraphText', document.getElementById('MasterParagraphText').value);" style="cursor: pointer;" />
                            <img src="/Admin/Images/Ribbon/Icons/Small/Check.png" id="ParagraphTextMatch" runat="server" alt="" align="absmiddle" />
                            <input type="hidden" name="ParagraphText" id="MasterParagraphText" runat="server" value="" />
                        </div>
                    </td>
                </tr>
            </table>
            <dw:Editor runat="server" ID="ParagraphText" name="ParagraphText" Width="100" Height="100" ForceNew="true" InitFunction="true" WindowsOnLoad="false" GetClientHeight="false" />
        </div>

        <div id="moduleContent" class="formArea" style="display: none; padding-right: 0px; margin-right: 0px">
            <div id="imgProcessing" style="display: block">
                <img src="/Admin/Module/Seo/Dynamicweb_wait.gif" border="0" alt="" />
            </div>
            <div id="modueInnerContent" style="display: none">
                <iframe id="ParagraphModule__Frame" width="99%" src="" style="border: 1px solid #6593CF" frameborder="0"></iframe>
            </div>
        </div>

        <div id="itemContent" class="formArea" style="display: none;">
            <div id="content-inner" >

                <table cellpadding="1" cellspacing="1" width="100%">
                    <% If IsNothing(TargetItemMeta) OrElse String.IsNullOrEmpty(TargetItemMeta.FieldForTitle) Then%>



                    <tr>
                        <td>
                            <dw:GroupBox ID="itemContentGb" runat="server" Title="Name" >
                                <table width="100%" style="border: 0px;">
                                    <tr>
                                        <td style="width: 170px;">
                                            <span style="display: block;">
                                                <dw:TranslateLabel ID="TranslateLabel9" Text="Afsnitsnavn" runat="server" />
                                            </span>
                                        </td>
                                        <td>
                                            <input type="text" id="ParagraphHeader2" name="ParagraphHeader2" runat="server" enableviewstate="false" maxlength="255" class="std NewUIinput" />
                                        </td>
                                    </tr>
                                </table>
                            </dw:GroupBox>
                        </td>
                    </tr>
                    <% End If%>
                    <% If Me.Paragraph.IsGlobal Or Me.Paragraph.HasGlobal Then%>
                    <tr>
                        <td style="padding: 10px">
                                <table width="100%" style="border: 0px;">
                                    <tr>
                                        <td colspan="2">
                                            <table bgcolor="#FEFEFE" style="border: 1px solid #ABADB3; width: 100%; cursor: pointer;">
                                                <tr>
                                                    <td onclick="ShowGlobals();">
                                                        <img src="/Admin/Images/Ribbon/icons/Small/warning.png" align="absmiddle" alt="" />&nbsp;<%=Translate.JsTranslate("Global element med %% referencer.", "%%", Me.Paragraph.GlobalCount)%></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                        </td>
                    </tr>
                    <% End If%>
                </table>
                <asp:Literal ID="litFields" runat="server" />

            </div>
        </div>

        <div id="footer">
            <table border="0">
                <tr>

                    <td rowspan="2">
                        <img class="icon" src="<%=If(Not IsNothing(TargetItemMeta), "/Admin/Images/Ribbon/Icons/Document_ok.png", "/Admin/Images/Ribbon/Icons/Paragraph.png")%>" alt="" title="" /></td>

                    <td class="label">
                        <div>
                            <dw:TranslateLabel ID="TranslateLabel2" Text="Name" runat="server" />
                            :
                        </div>
                    </td>
                    <td class="value bold">
                        <div id="footerParagraphHeader"><%=Paragraph.Header%></div>
                    </td>
                    <%If Not IsNothing(TargetItemMeta) Then%>
                    <td class="label">
                        <div>
                            <dw:TranslateLabel ID="TranslateLabel3" Text="Item type" runat="server" />
                            :
                        </div>
                    </td>
                    <td class="value">
                        <div><%=If(Not IsNothing(TargetItemMeta), TargetItemMeta.Name, "")%></div>
                    </td>
                    <%End If%>
                    <td class="label">
                        <div>
                            <dw:TranslateLabel ID="TranslateLabel4" Text="Created" runat="server" />
                            :
                        </div>
                    </td>
                    <td class="value">
                        <div id="statusPanelEdited"><%=Paragraph.CreatedDate.ToString("ddd, dd MMM yyyy HH':'mm", Dynamicweb.Base.GetCulture())%></div>
                    </td>
                    <td class="label">
                        <div>
                            <dw:TranslateLabel ID="TranslateLabel10" Text="Template" runat="server" />
                            :
                        </div>
                    </td>
                    <td class="value">
                        <div id="statusPanelTemplate" class="large"><%=LayoutPath%></div>
                    </td>
                </tr>
                <tr class="sub">
                    <td class="label">
                        <div>
                            <dw:TranslateLabel ID="TranslateLabel5" Text="ID" runat="server" />
                            :
                        </div>
                    </td>
                    <td class="value">
                        <div><%=Paragraph.ID%></div>
                    </td>
                    <%If Not IsNothing(TargetItemMeta) Then%>
                    <td class="label">
                        <div>
                            <dw:TranslateLabel ID="TranslateLabel7" Text="Item ID" runat="server" />
                            :
                        </div>
                    </td>
                    <td class="value">
                        <div><%=If(Not IsNothing(TargetItem), TargetItem.Id, "")%></div>
                    </td>
                    <%End If%>
                    <td class="label">
                        <div>
                            <dw:TranslateLabel ID="TranslateLabel8" Text="Edited" runat="server" />
                            :
                        </div>
                    </td>
                    <td class="value">
                        <div id="statusPanelUpdated"><%=Paragraph.UpdatedDate.ToString("ddd, dd MMM yyyy HH':'mm", Dynamicweb.Base.GetCulture())%></div>
                    </td>
                    <td colspan="2"></td>
                </tr>
            </table>
        </div>

        <iframe id="SaveFrame" name="SaveFrame" style="display: none;"></iframe>

        <span id="mSpecifyName" style="display: none">
            <%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>
        </span>

        <span id="mConfirmDelete" style="display: none">
            <dw:TranslateLabel ID="lbConfirmDelete" Text="Fjern modul?" runat="server" />
        </span>


        <dw:Dialog ID="LayoutDialog" runat="server" Title="Layout" ShowOkButton="true">
            <dw:GroupBox ID="GB_Layout" runat="server" Title="Layout">
                <table cellpadding="1" cellspacing="1">
                    <%  If Dynamicweb.Base.GetGs("/Globalsettings/Settings/Paragraph/HideSpaceSetting") = "True" Then%>
                    <tr>
                        <td>
                            <input type="hidden" id="ParagraphBottomSpace" runat="server" name="ParagraphBottomSpace" value="" />
                        </td>
                    </tr>
                    <% Else%>
                    <tr>
                        <td width="170">
                            <dw:TranslateLabel runat="server" Text="Mellemrum inden afsnit" />
                        </td>
                        <td>
                            <select id="ParagraphBottomSpaceSelect" name="ParagraphBottomSpaceSelect" runat="server" class="std" style="width: 35px;">
                            </select>
                        </td>
                    </tr>
                    <% End If%>
                    <tr id="paragraphIndexRow" runat="server">
                        <td width="170"></td>
                        <td>
                            <dw:CheckBox runat="server" Value="1" ID="ParagraphIndex" FieldName="ParagraphIndex" />
                            <label for="ParagraphIndex">
                                <dw:TranslateLabel runat="server" Text="Indeks" />
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td width="170">
                            <dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="Layout" />
                        </td>
                        <td>
                            <asp:ListBox runat="server" Rows="1" ID="ParagraphContainer" CssClass="NewUIinput" Width="250" />
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
        </dw:Dialog>

        <dw:Dialog runat="server" ID="ParagraphPermissionDialog" Width="300" Title="Paragraph permissions" HidePadding="true">
            <iframe id="ParagraphPermissionDialogIFrame" src="" height="370px" width="280px"></iframe>
        </dw:Dialog>

        <%   If Me.Paragraph.HasGlobal Then%>
        <dw:Dialog ID="GlobalsDialog" runat="server" Title="Global element" HidePadding="true" Width="525">
            <iframe id="GlobalsFrame" style="width: 100%; height: 300px; border: solid 0px red;" src="about:blank" frameborder="0"></iframe>
        </dw:Dialog>
        <script type="text/javascript">
            GlobalUrl = 'ParagraphGlobalElements.aspx?ParagraphID=<%=Me.Paragraph.ID %>';
        </script>
        <% End If%>

        <%    If Me.Paragraph.IsMaster Then%>
        <dw:Dialog ID="LanguageDialog" runat="server" Title="Language management" HidePadding="true" Width="525">
            <iframe id="LanguageFrame" style="width: 100%; height: 300px; border: solid 0px red;" src="about:blank" frameborder="0"></iframe>
        </dw:Dialog>
        <script type="text/javascript">
            LanguageUrl = '/Admin/Content/Paragraph/Languages.aspx?ParagraphID=<%=Me.Paragraph.ID %>';
        </script>
        <% End If%>

        <%   If Me.Paragraph.ID > 0 Then%>
        <dw:Dialog ID="VersionsDialog" runat="server" Title="Versioner" HidePadding="true" Width="600">
            <iframe id="VersionsFrame" style="width: 100%; height: 300px; border: solid 0px red;" src="about:blank" frameborder="0"></iframe>
        </dw:Dialog>
        <script type="text/javascript">
            VersionUrl = 'ParagraphVersions.aspx?ParagraphID=<%=Me.Paragraph.ID %>';
        </script>
        <% End If%>

        <dw:Dialog runat="server" ID="ImageSettingsDialog" Title="Indstillinger for billede" ShowOkButton="true">

            <input type="hidden" id="imageSettingsValidationMessage" value='<%= Translate.JsTranslate("Please type the image caption and alt-text.") %>' />

            <dw:GroupBox runat="server" DoTranslation="True" Title="Skalering">

                <table cellpadding="2" cellspacing="0">
                    <tr>
                        <td></td>
                        <td>
                            <dw:CheckBox runat="server" FieldName="ParagraphImageResize" ID="ParagraphImageResize" />
                            <label for="ParagraphImageResize">
                                <dw:TranslateLabel Text="Tilpas billede" runat="server" />
                            </label>
                        </td>
                    </tr>
                </table>

            </dw:GroupBox>

            <dw:GroupBoxStart ID="boxAlignmentStart" Title="Justering" runat="server" />
            <table cellpadding="2" cellspacing="0">
                <tr>
                    <td width="120">
                        <dw:TranslateLabel ID="lbHorizontalAlignment" Text="Horisontal" runat="server" />
                    </td>
                    <td width="80">
                        <input type="text" id="ImageHSpaceNew" runat="server" class="std" style="width: 30px" />
                        <dw:TranslateLabel ID="lbHSpacePx" Text="px. fra" runat="server" />
                    </td>
                    <td width="120">
                        <select id="ImageHAlignNew" name="ImageHAlignNew" runat="server" class="std" style="width: 90px"></select>
                    </td>
                </tr>
                <tr>
                    <td width="120">
                        <dw:TranslateLabel ID="lbVerticalAlignment" Text="Vertikal" runat="server" />
                    </td>
                    <td width="80">
                        <input type="text" id="ImageVSpaceNew" runat="server" class="std" style="width: 30px" />
                        <dw:TranslateLabel ID="lbVSpacePx" Text="px. fra" runat="server" />
                    </td>
                    <td width="120">
                        <select id="ImageVAlignNew" name="ImageVAlignNew" runat="server" class="std" style="width: 90px"></select>
                    </td>
                </tr>
            </table>
            <dw:GroupBoxEnd ID="boxAlignmentEnd" runat="server" />

            <dw:GroupBox runat="server" Title="Link">

                <table cellpadding="2" cellspacing="0">
                    <tr>
                        <td width="130" valign="top">
                            <dw:TranslateLabel Text="Link" runat="server" />
                        </td>
                        <td>
                            <dw:LinkManager ID="ParagraphImageURL" runat="server" DisableFileArchive="False" DisableParagraphSelector="True" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel Text="Billedetekst" runat="server" />
                        </td>
                        <td>
                            <input type="text" runat="server" id="ParagraphImageCaption" name="ParagraphImageCaption" maxlength="255" class="NewUIinput" /></td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel Text="Alt-tekst" runat="server" />
                        </td>
                        <td>
                            <input type="text" runat="server" id="ParagraphImageMouseOver" name="ParagraphImageMouseOver" maxlength="255" class="NewUIinput" /></td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel Text="Target" runat="server" />
                        </td>
                        <td>
                            <select id="ParagraphImageTarget" name="ParagraphImageTarget" runat="server" class="std">
                            </select>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
        </dw:Dialog>

        <dw:Dialog runat="server" ID="ChangeItemTypeDialog" Width="360" Title="Change item type" ShowOkButton="true" ShowCancelButton="true" CancelAction="Dynamicweb.Paragraph.ItemEdit.get_current().cancelChangeItemType();" OkAction="Dynamicweb.Paragraph.ItemEdit.get_current().changeItemType();">
            <dw:GroupBox ID="GroupBox3" runat="server" Title="Change item type">
                <table cellpadding="1" cellspacing="1">
                    <tr>
                        <td>
                            <dw:Richselect ID="ItemTypeSelect" runat="server" Height="60" Itemheight="60" Width="300" Itemwidth="300">
                            </dw:Richselect>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
        </dw:Dialog>

        <omc:MarketingConfiguration ID="marketConfig" runat="server" />
        <script type="text/javascript">
            ParagraphEdit.Marketing = <%=marketConfig.ClientInstanceName%>;
        </script>

        <dw:ContextMenu ID="languageSelectorContext" runat="server" MaxHeight="400">
        </dw:ContextMenu>

        <input type="hidden" id="ID" name="ID" runat="server" />
        <input type="hidden" id="MasterID" name="MasterID" runat="server" />
        <input type="hidden" id="ParagraphPageID" name="ParagraphPageID" runat="server" />
        <input type="hidden" id="cmd" name="cmd" value="save" />
        <input type="hidden" id="onSave" name="onSave" value="Close" />
        <input type="hidden" id="caller" name="caller" value="" runat="server" />

        <input type="hidden" id="ParagraphModuleSystemName" name="ParagraphModuleSystemName" value="" runat="server" />
        <input type="hidden" id="ParagraphModuleSettings" name="ParagraphModuleSettings" value="" runat="server" />

        <input type="hidden" id="ParagraphTemplateID" name="ParagraphTemplateID" value="" runat="server" />
        <input type="hidden" name="ParagraphImageHAlign" id="ParagraphImageHAlign" value="<%=Paragraph.ImageHAlign%>" />
        <input type="hidden" name="ParagraphImageHSpace" id="ParagraphImageHSpace" value="<%=Paragraph.ImageHSpace%>" />
        <input type="hidden" name="ParagraphImageVSpace" id="ParagraphImageVSpace" value="<%=Paragraph.ImageVSpace%>" />
        <input type="hidden" name="ParagraphImageVAlign" id="ParagraphImageVAlign" value="<%=Paragraph.ImageVAlign%>" />
        <input type="hidden" name="ParagraphSortDirection" id="ParagraphSortDirection" value="<%=Request.QueryString("ParagraphSortDirection")%>" />
        <input type="hidden" name="ParagraphSortID" id="ParagraphSortID" value="<%=Request.QueryString("ParagraphSortID")%>" />

        <dw:Overlay ID="PleaseWait" runat="server" />
    </form>
    <span id="_statusPageId" style="position: absolute; right: 18px; top: 5px; color: #c1c1c1;">ID: <%=Dynamicweb.Base.ChkInteger(Dynamicweb.Base.Request("ID"))%></span>
    <script type="text/javascript">
        function help(){
		<%=Dynamicweb.Gui.Help("", "page.paragraph.editNEW") %>
        }
        <%=If(Not String.IsNullOrEmpty(Base.Request("ParagraphViewMode")), "ParagraphView.switchMode(" + Base.Request("ParagraphViewMode") + ")", "")%>
    </script>

    <%Translate.GetEditOnlineScript()%>
</body>
</html>
