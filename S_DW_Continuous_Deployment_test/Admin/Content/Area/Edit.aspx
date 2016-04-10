<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Edit.aspx.vb" Inherits="Dynamicweb.Admin.Edit2" EnableEventValidation="false" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="area" TagName="RegionalSelect" Src="/Admin/Content/Area/RegionalSelect.ascx" %>
<%@ Import Namespace="Dynamicweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <dw:ControlResources ID="ctrlResources" runat="server" IncludeUIStylesheet="true" CombineOutput="false" IncludePrototype="true" IncludeScriptaculous="true" runat="server">
        <Items>
            <dw:GenericResource Url="/Admin/Content/Items/js/Default.js" />
            <dw:GenericResource Url="/Admin/Content/Items/css/Default.css" />
            <dw:GenericResource Url="/Admin/Content/JsLib/dw/Utilities.js" />
            <dw:GenericResource Url="/Admin/Content/JsLib/dw/Validation.js" />
            <dw:GenericResource Url="/Admin/Content/Area/Edit.js" />
            <dw:GenericResource Url="/Admin/Content/Area/Edit.css" />
        </Items>
    </dw:ControlResources>

    <title>Area edit</title>
    <script type="text/javascript" language="javascript">
        function cancel() {
        	<% If LCase(Base.Request("FrontPage")) = "true" Then%>
            location = '/Admin/Content/Management/Start.aspx';
            <% Else%>
            location = 'List.aspx';
            <% End If%>
            return false;
        }

        function validate() {
            if ($('AreaPermission')) {
                if ($('AreaPermission').options) {
                    for (i = 0; i < $('AreaPermission').options.length; i++) {
                        $('AreaPermission').options[i].selected = true;
                    }
                }
            }

            <%  If Base.GetGs("/Globalsettings/Settings/Designs/UseOnlyDesignsAndLayouts") = "True" Then%>
            var areaLayout = $('AreaLayout');
            if (areaLayout.value.length < 1) {
                alert("<%=Translate.JSTranslate("Der skal angives en værdi i: %%", "%%", Translate.Translate("Layout"))%>");
                    areaLayout.activate();
                    return false;
                }
            <% End If%>

            var name = $('AreaName');
            var domain = $('AreaDomain');
            if (name.value.length < 1) {
                alert("<%=Translate.JSTranslate("Der skal angives en værdi i: %%", "%%", Translate.Translate("Navn"))%>");
			    name.activate();
			} else if (name.value.length > 255) {
			    alert("<%=Translate.JSTranslate("Max %% tegn i: ´%f%´","%%","255", "%f%", Translate.JSTranslate("Navn"))%>");
				    name.activate();
				} else {
				    return true;
				}
            return false;
        }

        function save(action) {
            if (validate()) {
                var itemEdit = Dynamicweb.Area.ItemEdit.get_current();
                itemEdit.validate(function (result) {
                    if (result.isValid) {
                        itemEdit.showWait();
                        // Fire event to handle saving
                        window.document.fire("General:DocumentOnSave");
                        $("action").value = (action) ? action : "save";
                        if (action != "saveAndClose") {
                            $("MainForm").target = "SaveFrame";
                            $('SaveFrame').onload = function () {
                                itemEdit.hideWait();
                            };
                        } else {
                            $("MainForm").target = "";
                        }
                        $('cmdSubmit').click();
                    }
                });
            }
            return false;
        }

        function saveAndClose() {
            save("saveAndClose");
            return false;
        }

        function openEditPermission() {
            $('AreaPermissionDialogIFrame').src = '/Admin/Content/PagePermission.aspx?AreaID=<%=Base.Request("AreaID")%>&DialogID=AreaPermissionDialog';
            dialog.show('AreaPermissionDialog');
        }

        function openEcomSettings() {
            dialog.show("EcomSettingsDialog");
        }

        function openItemType() {
            dialog.show("AreaItemTypeDialog");
        }

        function openCookieSettings() {
            dialog.show("CookieSettingsDialog");
        }

        function showHideCookieWarningTemplateSelector() {
            if (document.getElementById("rbCustomUserNotifications").checked) {
                document.getElementById("templateContainer").style.display = "none";
            } else {
                document.getElementById("templateContainer").style.display = "";
            }
        }

        function cookieSettingsDialogSave() {
            document.getElementById("CookieDialogOkAction").value = "true";
            dialog.hide("CookieSettingsDialog");
        }

        function devicelayouts() {
            dialog.show("DeviceLayoutDialog");
        }

        function itemTypePageLayouts() {
            dialog.show("ItemTypePageLayoutDialog");
        }

        function itemTypeParagraphLayouts() {
            dialog.show("ItemTypeParagraphLayoutDialog");
        }

        function help() {
		    <%=Dynamicweb.Gui.Help("", "modules.area.edit") %>
	    }

        function addPrimDom() {
            var pd = "";
            pd = prompt("<%=Translate.JSTranslate("Primær domæne")%>", "");
            if (pd != null && pd != '') {
                var sl = document.getElementById("AreaDomainLock");

                var elOptNew = document.createElement('option');
                elOptNew.text = pd;
                elOptNew.value = pd;
                elOptNew.setAttribute("selected", "selected")

                try {
                    sl.add(elOptNew, null);
                }
                catch (ex) {
                    sl.add(elOptNew);
                }
            }
        }

        function exportArea() {
            dialog.hide('ExportAreaDialog');

            var areaID = $('AreaID').value;
            var name = $('AreaName').value;
            var mode = $('chkFullExport').checked ? 'full' : 'translation';

            location = 'Edit.aspx?Export=True&Compress=false&Name=' + name + '&AreaID=' + areaID + '&Mode=' + mode;
        }

        function ReloadLanguages() {
            var shopEl = $('AreaEcomShopID');
            var langEl = $('AreaEcomLanguageID');

            new Dynamicweb.Ajax.doPostBack({
                eventTarget: 'this',
                eventArgument: 'UpdateLanguages:' + shopEl.value,
                onComplete: function (transport) {
                    if (transport.responseText) {
                        var len = langEl.length;

                        for (i = 0; i < len; i++)
                            langEl.remove(0);

                        var data = transport.responseText.split(',');

                        for (i = 0; i < data.length / 2; i++)
                            langEl.options[i] = new Option(data[i * 2 + 1], data[i * 2]);
                    }
                }
            });
        }

        var useSSLOption = '<%=area.SSLMode%>';
        var sslConfirmation1 = '<%=Translate.JsTranslate("Are you sure you want to change SSL settings from ")%>';
        var sslConfirmation2 = '<%=Translate.JsTranslate(" to ")%>';
        function changeSSLMode(sslMode) {
            var previousSSLMode = "";

            if (useSSLOption == "0") {
                previousSSLMode = "cmdSSLStandard";
            } else if (useSSLOption == "1") {
                previousSSLMode = "cmdSSLForce";
            } else if (useSSLOption == "2") {
                previousSSLMode = "cmdSSLUnforce";
            }

            if (sslMode != previousSSLMode) {
                var sslOptionConfirmed = confirm(sslConfirmation1 + "'" + document.getElementById(previousSSLMode).title + "'" + sslConfirmation2 + "'" + document.getElementById(sslMode).title + "' ?");
                document.getElementById("cmdSSLStandard").className = "";
                document.getElementById("cmdSSLForce").className = "";
                document.getElementById("cmdSSLUnforce").className = "";
                if (sslOptionConfirmed != true) {

                    document.getElementById(previousSSLMode).className = "active";
                    document.getElementById("radio_SSLMode_selected").value = previousSSLMode;
                    if (document.getElementById("SSLMode") != null) {
                        document.getElementById("SSLMode").value = useSSLOption;
                    } else {
                        document.getElementById("radio_SSLMode").value = useSSLOption;
                    }
                } else {
                    document.getElementById(sslMode).className = "active";
                }
            }
        }

        function CdnActiveChanged(val) {
            var cdnHostEl = document.getElementById("CdnHost");
            var cdnImageHostEl = document.getElementById("CdnImageHost");
            cdnHostEl.disabled = !val;
            cdnImageHostEl.disabled = !val;
        }
    </script>
</head>
<body>
    <form id="MainForm" runat="server" action="Edit.aspx" method="post">
        <input type="hidden" name="action" id="action" value="" />
        <input type="hidden" name="FrontPage" id="FrontPage" value="<%=Base.Request("FrontPage")%>" />
        <input type="hidden" name="AreaID" id="AreaID" value="<%=Base.Request("AreaID")%>" />
        <input type="submit" id="cmdSubmit" value="Submit" style="display: none" />
        <dw:RibbonBar runat="server" ID="myribbon">
            <dw:RibbonBarTab ID="RibbonBarTab1" runat="server" Name="Website">
                <dw:RibbonBarGroup ID="RibbonBarGroup1" runat="server" Name="Tools">
                    <dw:RibbonBarButton runat="server" ID="Save" Size="Small" Image="Save" Text="Save" OnClientClick="save();" />
                    <dw:RibbonBarButton runat="server" ID="SaveAndClose" Size="Small" Image="SaveAndClose" Text="Save and close" OnClientClick="saveAndClose();" />
                    <dw:RibbonBarButton runat="server" ID="Cancel" Size="Small" Image="Cancel" Text="Cancel" OnClientClick="cancel();" ShowWait="true" WaitTimeout="500" />
                </dw:RibbonBarGroup>

                <dw:RibbonBarGroup ID="RibbonBarGroup2" runat="server" Name="Website">
                    <dw:RibbonBarButton runat="server" ID="Layout" Size="Small" Image="DocumentProperties" Text="HTML" OnClientClick="dialog.show('LayoutDialog');" />
                    <dw:RibbonBarButton runat="server" ID="RobotsTxt" Size="Small" Image="EditDocument" Text="Robots.txt" OnClientClick="dialog.show('RobotsTxtDialog')" />
                    <dw:RibbonBarButton runat="server" ID="Export" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/export1.png" Text="Eksporter" OnClientClick="dialog.show('ExportAreaDialog')" />
                    <dw:RibbonBarPanel runat="server" ID="DateFormatRb" ExcludeMarginImage="true">
                        <span style="height: 45px; margin-top: 5px;">
                            <dw:TranslateLabel ID="TranslateLabel12" runat="server" Text="Datoformat" />
                            <br />
                            <asp:ListBox Rows="1" runat="server" ID="AreaDateformat" CssClass="NewUIinput" Width="250" /><br />
                        </span>
                        <span style="height: 45px; margin-top: 5px;">
                            <dw:TranslateLabel ID="TranslateLabel13" runat="server" Text="Workflow" />
                            <br />
                            <%= Gui.ApprovalTypeBox(AreaApprovalType, True) %>
                        </span>
                    </dw:RibbonBarPanel>
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup runat="server" Name="Advanced" ID="grpAdvanced">
                    <dw:RibbonBarButton runat="server" Text="Permissions" ImagePath="/Admin/Images/Icons/user1_lock.png" ID="PermissionsButton" Size="Small" OnClientClick="openEditPermission();" />
                    <dw:RibbonBarButton runat="server" Text="Sikkerhed" Image="Key" Size="Small" ID="ExtranetButton" OnClientClick="dialog.showAt('SecurityDialog', 28, 0);"></dw:RibbonBarButton>
                    <dw:RibbonBarButton runat="server" Text="eCommerce" ImagePath="/Admin/Images/Icons/Module_eCom_Standard_small.gif" ID="EcomButton" Size="Small" OnClientClick="openEcomSettings();" />
                    <dw:RibbonBarButton runat="server" Text="Item type" Image="ItemType" ID="ItemTypeButton" Size="Small" OnClientClick="openItemType();" />
                    <dw:RibbonBarButton runat="server" Text="Cookies" ImagePath="/Admin/Images/Icons/cookies.png" ID="CookieButton" Size="Small" OnClientClick="openCookieSettings();" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="SSLRibbonbarGroup" runat="server" Name="Https">
                    <dw:RibbonBarRadioButton ID="cmdSSLStandard" Group="SSLMode" runat="server" Checked="false" Value="0" Text="Standard" ImagePath="/Admin/Images/Ribbon/Icons/Small/lock_ok.png" Size="Small" OnClientClick="changeSSLMode('cmdSSLStandard');"></dw:RibbonBarRadioButton>
                    <dw:RibbonBarRadioButton ID="cmdSSLForce" Group="SSLMode" runat="server" Checked="false" Value="1" Text="Force SSL" ImagePath="/Admin/Images/Ribbon/Icons/Small/lock_add.png" Size="Small" OnClientClick="changeSSLMode('cmdSSLForce');"></dw:RibbonBarRadioButton>
                    <dw:RibbonBarRadioButton ID="cmdSSLUnforce" Group="SSLMode" runat="server" Checked="false" Value="2" Text="Un-force SSL" ImagePath="/Admin/Images/Ribbon/Icons/Small/lock_delete.png" Size="Small" OnClientClick="changeSSLMode('cmdSSLUnforce');"></dw:RibbonBarRadioButton>
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonbarGroup4" runat="server" Name="Help">
                    <dw:RibbonBarButton ID="RibbonbarButton4" runat="server" Text="Help" Size="Large" Image="Help" OnClientClick="help();"></dw:RibbonBarButton>
                </dw:RibbonBarGroup>
            </dw:RibbonBarTab>
            <dw:RibbonBarTab ID="grpLayout" Active="False" Name="Layout" runat="server" Visible="true">
                <dw:RibbonBarGroup ID="RibbonBarGroup3" runat="server" Name="Tools">
                    <dw:RibbonBarButton runat="server" ID="RibbonBarButton1" Size="Small" Image="Save" Text="Save" OnClientClick="save();" />
                    <dw:RibbonBarButton runat="server" ID="RibbonBarButton2" Size="Small" Image="SaveAndClose" Text="Save and close" OnClientClick="saveAndClose();" />
                    <dw:RibbonBarButton runat="server" ID="RibbonBarButton3" Size="Small" Image="Cancel" Text="Cancel" OnClientClick="cancel();" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonbarGroup9" runat="server" Name="Layout">
                    <dw:RibbonBarPanel ID="RibbonbarPanel1" runat="server">
                        <dw:Richselect ID="AreaLayout" runat="server" Height="60" Width="300" Itemheight="60" Itemwidth="300">
                        </dw:Richselect>
                    </dw:RibbonBarPanel>
                    <dw:RibbonBarButton runat="server" ID="RibbonBarButton7" Size="Small" Image="AddDocument" Text="Device layouts" OnClientClick="devicelayouts();" />
                    <dw:RibbonBarButton runat="server" ID="ItemTypePageLayoutsButton" Size="Small" ImagePath="/Admin/images/icons/cube_blue.png" Text="Item page layouts" OnClientClick="itemTypePageLayouts();" />
                    <dw:RibbonBarButton runat="server" ID="ItemTypeParagraphLayoutsButton" Size="Small" ImagePath="/Admin/images/icons/cube_blue.png" Text="Item paragraph layouts" OnClientClick="itemTypeParagraphLayouts();" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonbarGroup6" runat="server" Name="HTML type">
                    <dw:RibbonBarPanel ID="AreaHtmlTypePanel" runat="server">
                        <asp:ListBox runat="server" Rows="1" ID="AreaHtmlType" CssClass="NewUIinput" Width="100" />
                    </dw:RibbonBarPanel>
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonbarGroup5" runat="server" Name="Help">
                    <dw:RibbonBarButton ID="RibbonbarButton5" runat="server" Size="Large" Text="Help" Image="Help" OnClientClick="help();"></dw:RibbonBarButton>
                </dw:RibbonBarGroup>
            </dw:RibbonBarTab>
        </dw:RibbonBar>


        <div id="_contentWrapper">
            <dw:Infobar ID="infoNoPermissions" Visible="false" Type="Error" Message="You do not have access to this functionality" runat="server" />

            <asp:Panel ID="pContent" runat="server">
                <dw:GroupBox ID="GbSettings" runat="server" Title="Settings">
                    <table cellpadding="1" cellspacing="1">
                        <tr>
                            <td valign="top" width="170" class="nobr">
                                <dw:TranslateLabel ID="tl1" runat="server" Text="Name" />
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="AreaName" MaxLength="255" CssClass="NewUIinput" Width="250" />
                                <div runat="server" id="AreaRenameLanguagesDiv">
                                    <asp:CheckBox runat="server" ID="AreaRenameLanguages" />
                                    <label for="AreaRenameLanguages">
                                        <dw:TranslateLabel runat="server" Text="Rename languages" />
                                    </label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" class="nobr">
                                <dw:TranslateLabel ID="tl2" runat="server" Text="Regionale indstillinger" />
                            </td>
                            <td>
                                <%= Gui.CultureList(AreaCulture, "AreaCulture")%><br />
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
                <dw:GroupBox ID="GbMe" runat="server" Title="Meta">
                    <table cellpadding="1" cellspacing="1">
                        <tr>
                            <td valign="top" width="170" class="nobr">
                                <dw:TranslateLabel ID="tl3" runat="server" Text="Title" />
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="AreaTitle" MaxLengh="255" CssClass="NewUIinput" />
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" class="nobr">
                                <dw:TranslateLabel ID="tl6" runat="server" Text="Description" />
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="AreaDescription" CssClass="NewUIinput" TextMode="MultiLine" Rows="3" Columns="30" Wrap="true" Width="250" Height="60" />
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" class="nobr">
                                <dw:TranslateLabel ID="tl7" runat="server" Text="Keywords" />
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="AreaKeywords" CssClass="NewUIinput" TextMode="MultiLine" Rows="3" Columns="30" Wrap="true" Width="250" Height="60" />
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
                <dw:GroupBox ID="GbDetails" runat="server" Title="Details">
                    <table cellpadding="1" cellspacing="1">
                        <tr>
                            <td valign="top" width="170" class="nobr">
                                <dw:TranslateLabel ID="tl4" runat="server" Text="Domæne" />
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="AreaDomain" CssClass="NewUIinput" TextMode="MultiLine" Rows="10" Wrap="true" Width="250" />
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" class="nobr">
                                <dw:TranslateLabel ID="tl5" runat="server" Text="Primær domæne" />
                            </td>
                            <td>
                                <asp:ListBox runat="server" ID="AreaDomainLock" CssClass="NewUIinput" Rows="1" Width="250" />
                                <img src="/Admin/Images/Ribbon/Icons/Small/add2.png" alt="<%=Translate.JSTranslate("Add")%>" style="cursor: pointer; margin-top: 1px;" onclick="addPrimDom();" />
                            </td>
                        </tr>
                        <tr>
                            <td valign="top"></td>
                            <td>
                                <asp:CheckBox ID="AreaLockPagesToDomain" runat="server" />
                                <asp:Label ID="lbLockPagesToDomain" AssociatedControlID="AreaLockPagesToDomain" runat="server">
                                    <dw:TranslateLabel ID="TranslateLabel6" Text="Lock pages to given domains" runat="server" />
                                </asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <tr id="AreaNotFoundTr" runat="server" visible="false">
                            <td valign="top" class="nobr">
                                <dw:TranslateLabel ID="TranslateLabel7" runat="server" Text="HTTP 404" />
                            </td>
                            <td>
                                <dw:LinkManager ID="AreaNotFound" runat="server" DisableFileArchive="False" DisableParagraphSelector="True" />
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
                <dw:GroupBox ID="GB_Url" runat="server" Title="Url" DoTranslation="true">
                    <table cellpadding="1" cellspacing="1">
                        <tr id="FriendlyUrlRow" runat="server">
                            <td width="170">
                                <div class="nobr">
                                    <dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Url" />
                                </div>
                            </td>
                            <td>
                                <div runat="server" id="FriendlyUrl">
                                </div>
                            </td>
                        </tr>
                        <tr id="Tr1" runat="server">
                            <td width="170">
                                <div class="nobr">
                                    <dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Use in url" />
                                </div>
                            </td>
                            <td>
                                <input type="text" id="AreaUrlName" name="AreaUrlName" size="30" maxlength="50" class="NewUIinput" runat="server" />
                            </td>
                        </tr>
                        <tr id="AreaUrlIgnoreForChildrenRow" runat="server">
                            <td width="170">
                                <div class="nobr">
                                </div>
                            </td>
                            <td>
                                <asp:CheckBox runat="server" ID="AreaUrlIgnoreForChildren" /><label for="AreaUrlIgnoreForChildren"><dw:TranslateLabel
                                    ID="TranslateLabel20" runat="server" Text="Do not include in subpage URLs" />
                                </label>
                            </td>
                        </tr>
                        <tr id="Tr2" runat="server">
                            <td width="170"></td>
                            <td>
                                <asp:CheckBox runat="server" ID="AreaRedirectFirstPage" />
                                <label for="AreaRedirectFirstPage">
                                    <dw:TranslateLabel ID="TranslateLabel14" runat="server" Text="Redirect first page to '/'" />
                                </label>
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>

                <dw:GroupBox ID="gbCDN" Title="Content Delivery Network" runat="server">
                    <table cellpadding="1" cellspacing="1">
                        <tr>
                            <td valign="top" width="170" class="nobr">
                                <dw:TranslateLabel ID="TranslateLabel27" Text="Content Delivery Network" runat="server" />
                            </td>
                            <td>
                                <asp:RadioButtonList ID="EnableCdn" runat="server" RepeatDirection="Vertical" CellPadding="0" CellSpacing="0">  
                                    <asp:ListItem Value="True" onClick="CdnActiveChanged(true);" Text="Activate">                                        
                                    </asp:ListItem>  
                                    <asp:ListItem Value="False" onClick="CdnActiveChanged(false);" Text="Deactivate">                                        
                                    </asp:ListItem>  
                                    <asp:ListItem Value="" onClick="CdnActiveChanged(null);" Text="Inherits global settings">                                        
                                    </asp:ListItem>  
                                </asp:RadioButtonList> 
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">&nbsp;</td>
                        </tr>
			            <tr>
                            <td style="width: 170px" valign="top">
                                <dw:TranslateLabel ID="tlCdnHost" Text="Host" runat="server" />
                            </td>
                            <td>
                                <input type="text" id="CdnHost" name="CdnHost"  maxlength="255" class="NewUIinput" runat="server" />
                                <br />
					            <small>http(s)://cdn.domain.com</small>
                            </td>
                        </tr>
			            <tr>
                            <td style="width: 170px" valign="top">
                                <dw:TranslateLabel ID="tlCdnImgHost" Text="Host" runat="server" /> <small>(GetImage.ashx)</small>
                            </td>
                            <td>
                                <input type="text" id="CdnImageHost" name="CdnImageHost" maxlength="255" class="NewUIinput" runat="server" />
                                <br />
					            <small>http(s)://cdn.domain.com</small>
                            </td>
                        </tr>
            
                    </table>
                </dw:GroupBox>

                <div id="content-item">
                    <asp:Literal ID="litFields" runat="server" />
                </div>
            </asp:Panel>
        </div>


        <dw:Dialog ID="ExportAreaDialog" Width="200" runat="server" Title="Select export mode" ShowOkButton="true" ShowCancelButton="true" ShowClose="false" CancelAction="dialog.hide('ExportAreaDialog');" OkAction="exportArea();">
            <table cellpadding="1" cellspacing="1">
                <tr>
                    <td>
                        <input type="radio" id="chkFullExport" name="RenamedFile" disabled="disabled" />
                        <label for="chkFullExport" style="color: #999999"><%= Translate.Translate("Full export")%></label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="radio" id="chkTranslationExport" name="RenamedFile" checked="checked" />
                        <label for="chkTranslationExport"><%= Translate.Translate("Translation export")%></label>
                    </td>
                </tr>
            </table>
        </dw:Dialog>

        <dw:Dialog runat="server" ID="DeviceLayoutDialog" Width="420" Title="Device layouts" ShowOkButton="true">
            <dw:GroupBox ID="GroupBox1" runat="server" Title="Templates">
                <table cellpadding="1" cellspacing="1">
                    <tr>
                        <td width="70" height="67" valign="middle">
                            <dw:TranslateLabel ID="TranslateLabel15" runat="server" Text="Phone" />
                        </td>
                        <td valign="middle">
                            <dw:Richselect ID="AreaLayoutPhone" runat="server" Height="60" Width="300" Itemheight="60" Itemwidth="300"></dw:Richselect>
                        </td>
                    </tr>
                    <tr>
                        <td height="67" valign="middle">
                            <dw:TranslateLabel ID="TranslateLabel16" runat="server" Text="Tablet" />
                        </td>
                        <td valign="middle">
                            <dw:Richselect ID="AreaLayoutTablet" runat="server" Height="60" Width="300" Itemheight="60" Itemwidth="300"></dw:Richselect>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
        </dw:Dialog>

        <dw:Dialog runat="server" ID="AreaItemTypeDialog" Width="480" Title="Item type" ShowOkButton="true" ShowCancelButton="true" CancelAction="Dynamicweb.Area.ItemEdit.get_current().cancelChangeItemType();" OkAction="Dynamicweb.Area.ItemEdit.get_current().changeItemType();">
            <dw:GroupBox ID="GroupBox3" runat="server" Title="Item type">
                <table cellpadding="1" cellspacing="1">
                    <tr>
                        <td width="170">
                            <dw:TranslateLabel ID="TranslateLabel21" runat="server" Text="Website properties" />
                        </td>
                        <td>
                            <dw:Richselect ID="ItemTypeSelect" runat="server" Height="60" Itemheight="60" Width="300" Itemwidth="300">
                            </dw:Richselect>
                        </td>
                    </tr>
                    <tr>
                        <td width="170">
                            <dw:TranslateLabel ID="TranslateLabel22" runat="server" Text="Page properties" />
                        </td>
                        <td>
                            <dw:Richselect ID="ItemTypePageSelect" runat="server" Height="60" Itemheight="60" Width="300" Itemwidth="300">
                            </dw:Richselect>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
        </dw:Dialog>

        <dw:Dialog runat="server" ID="ItemTypePageLayoutDialog" Width="480" Title="Item page layouts" ShowOkButton="true">
            <dw:GroupBox ID="GroupBox2" runat="server" Title="Item types">
                <div class="items-container">
                    <asp:Repeater ID="ItemTypePageLayoutRepeater" runat="server" EnableViewState="false">
                        <HeaderTemplate>
                            <table cellpadding="1" cellspacing="1">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td width="170">
                                    <%#Eval("Name")%>
                                </td>
                                <td runat="server" id="ItemTypeSelectorContainer">
                                    <input type="hidden" id="ItemTypeSystemName" value="<%#Eval("SystemName")%>" />
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </dw:GroupBox>
        </dw:Dialog>

        <dw:Dialog runat="server" ID="ItemTypeParagraphLayoutDialog" Width="480" Title="Item paragraph layouts" ShowOkButton="true">
            <dw:GroupBox ID="GroupBox4" runat="server" Title="Item types">
                <div class="items-container">
                    <asp:Repeater ID="ItemTypeParagraphLayoutRepeater" runat="server" EnableViewState="false">
                        <HeaderTemplate>
                            <table cellpadding="1" cellspacing="1">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td width="170">
                                    <%#Eval("Name")%>
                                </td>
                                <td runat="server" id="ItemTypeSelectorContainer">
                                    <input type="hidden" id="ItemTypeSystemName" value="<%#Eval("SystemName")%>" />
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </dw:GroupBox>
        </dw:Dialog>

        <dw:Dialog runat="server" ID="LayoutDialog" Width="525" Title="HTML" ShowOkButton="true">
            <dw:GroupBox ID="gbLayoutDialog" runat="server" Title="HTML">
                <table cellpadding="1" cellspacing="1">
                    <%  If Not Base.GetGs("/Globalsettings/Settings/Designs/UseOnlyDesignsAndLayouts") = "True" Then%>
                    <tr>
                        <td width="170">
                            <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Stylesheet" />
                        </td>
                        <td>
                            <%= Gui.StylesheetList(AreaStyleID, "AreaStyleID")%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Template" />
                        </td>
                        <td>
                            <dw:FileManager ID="AreaMasterTemplate" runat="server" />
                        </td>
                    </tr>
                    <%End If%>
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Statisk forside" />
                        </td>
                        <td>
                            <dw:FileManager ID="AreaFrontpage" runat="server" />
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
        </dw:Dialog>

        <dw:Dialog runat="server" ID="RobotsTxtDialog" Width="525" Title="Robots.txt" ShowOkButton="true">
            <dw:GroupBox ID="gbRobotsTxtDialog" runat="server" Title="Robots.txt">
                <table cellpadding="1" cellspacing="1">
                    <tr>
                        <td valign="top" width="170">
                            <dw:TranslateLabel ID="TranslateLabel8" runat="server" Text="Link to Google Sitemap" />
                        </td>
                        <td>
                            <dw:CheckBox runat="server" ID="AreaRobotsTxtIncludeSitemap" />
                        </td>
                    </tr>
                    <%If Base.HasVersion("8.3.0.0") Then%>
                    <tr>
                        <td valign="top" width="170">
                            <dw:TranslateLabel ID="TranslateLabel25" runat="server" Text="Include products inside sitemap.xml" />
                        </td>
                        <td>
                            <dw:CheckBox runat="server" ID="AreaIncludeProductsInSitemap" />
                        </td>
                    </tr>
                    <%End If%>
                    <tr>
                        <td valign="top" width="170" class="nobr">
                            <dw:TranslateLabel ID="TranslateLabel9" runat="server" Text="Robots.txt" />
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="AreaRobotsTxt" CssClass="NewIUinput" TextMode="MultiLine" Rows="5" Columns="50" /></td>
                    </tr>
                </table>
            </dw:GroupBox>
        </dw:Dialog>

        <dw:Dialog runat="server" ID="AreaPermissionDialog" Width="555" Title="Area permissions">
            <iframe id="AreaPermissionDialogIFrame" src="" height="445px" width="520px"></iframe>
        </dw:Dialog>

        <% If Dynamicweb.eCommerce.Common.Functions.IsEcom Then%>
        <dw:Dialog runat="server" ID="EcomSettingsDialog" Width="450" Title="eCommerce settings" ShowOkButton="true">
            <dw:GroupBox ID="gbEcomSettingsDialog" runat="server" Title="Language and currency">
                <table cellpadding="1" cellspacing="1">
                    <tr>
                        <td valign="top" class="nobr">
                            <dw:TranslateLabel ID="TranslateLabel19" runat="server" Text="Shop" />
                        </td>
                        <td>
                            <select onchange="ReloadLanguages();" id="AreaEcomShopID" name="AreaEcomShopID" runat="server" size="1" class="NewUIinput"></select>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" width="170" class="nobr">
                            <dw:TranslateLabel ID="TranslateLabel10" runat="server" Text="Language" />
                        </td>
                        <td>
                            <select id="AreaEcomLanguageID" name="AreaEcomLanguageID" runat="server" size="1" class="NewUIinput"></select>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" class="nobr">
                            <dw:TranslateLabel ID="TranslateLabel11" runat="server" Text="Currency" />
                        </td>
                        <td>
                            <select id="AreaEcomCurrencyID" name="AreaEcomCurrencyID" runat="server" size="1" class="NewUIinput"></select>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" class="nobr">
                            <dw:TranslateLabel ID="TranslateLabel17" runat="server" Text="Country" />
                        </td>
                        <td>
                            <select id="AreaEcomCountryCode" name="AreaEcomCountryCode" runat="server" size="1" class="NewUIinput"></select>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" class="nobr">
                            <dw:TranslateLabel ID="TranslateLabel26" runat="server" Text="Prices with VAT" />
                        </td>
                        <td>
                            <select id="AreaEcomPricesWithVAT" name="AreaEcomPricesWithVat" runat="server" size="1" class="NewUIinput"></select>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
        </dw:Dialog>
        <% End If%>

        <dw:Dialog ID="SecurityDialog" runat="server" Title="Sikkerhed" Width="525" ShowOkButton="true">
            <div runat="server" id="extranetDiv">
                <dw:GroupBox ID="GB_Rights" runat="server" Title="Rettigheder">
                    <div runat="server" id="GB_rights_container"></div>
                </dw:GroupBox>
                <dw:GroupBox ID="GB_Login" runat="server" Title="Login">
                    <table cellpadding="1" cellspacing="1">
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel18" runat="server" Text="Template" />
                            </td>
                            <td>
                                <dw:FileManager ID="AreaPermissionTemplate" runat="server" Folder="Templates/Extranet" />
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
            </div>
        </dw:Dialog>

        <dw:Dialog runat="server" ID="CookieSettingsDialog" Width="450" Title="Cookie settings" ShowOkButton="true" OkAction="cookieSettingsDialogSave();">
            <input type="hidden" name="CookieDialogShown" id="CookieDialogOkAction" value="" runat="server" />
            <dw:GroupBoxStart ID="GroupBoxStart2" runat="server" Title="User notification" />
            <div style="padding: 20px;">
                <input type="radio" runat="server" id="rbWarnings" name="UserNotificationGroup" />
                <label for="rbWarningTemplate">
                    <dw:TranslateLabel ID="TranslateLabel23" Text="Template based warnings" runat="server" />
                </label>
                <div id="templateContainer" runat="server" style="margin: 10px 0px 0px 20px;">
                    <dw:FileManager ID="templateSelector" runat="server" FixFieldName="true" ShowPreview="false" Folder="Templates/CookieWarning" ShowNothingSelectedOption="False" />
                </div>
                <br />
                <input type="radio" runat="server" id="rbCustomUserNotifications" name="UserNotificationGroup" />
                <label for="rbCustomSet">
                    <dw:TranslateLabel ID="TranslateLabel24" Text="Custom (set with Javascript or .Net)" runat="server" />
                </label>
                <br />
            </div>
            <dw:GroupBoxEnd ID="GroupBoxEnd2" runat="server" />
        </dw:Dialog>

        <dw:Overlay ID="PleaseWait" runat="server" />
    </form>
    <iframe id="SaveFrame" name="SaveFrame" style="display: none;"></iframe>
    <iframe name="EcomUpdator" id="EcomUpdator" width="0" height="0" tabindex="-1" align="right" marginwidth="0" marginheight="0" frameborder="0" src="/Admin/Module/eCom_Catalog/dw7/Edit/EcomUpdator.aspx" border="0"></iframe>
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</body>
</html>
