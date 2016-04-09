<%@ Page Language="vb" ValidateRequest="false" AutoEventWireup="false" CodeBehind="PageEdit.aspx.vb" Inherits="Dynamicweb.Admin.PageEdit" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls.OMC" TagPrefix="omc" %>
<%@ Register Assembly="Dynamicweb" Namespace="Dynamicweb.Extensibility" TagPrefix="de" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" IncludeScriptaculous="true" runat="server" CombineOutput="false">
        <Items>
            <dw:GenericResource Url="/Admin/Content/Items/js/Default.js" />
            <dw:GenericResource Url="/Admin/Content/Items/css/Default.css" />
            <dw:GenericResource Url="/Admin/Content/PageEdit.css" />
            <dw:GenericResource Url="/Admin/Content/PageEdit.js" />
            <dw:GenericResource Url="/Admin/Module/eCom_Catalog/images/ObjectSelector.css" />
            <dw:GenericResource Url="/Admin/Content/JsLib/dw/Utilities.js" />
            <dw:GenericResource Url="/Admin/Content/JsLib/dw/Validation.js" />            
        </Items>
    </dw:ControlResources>

    <% If Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Navigation/EnableNavigationGroupSorting")) Then  %>
    <style type="text/css">
        .ositem:hover{
            background-color: #EBF7FD;
        }        
    </style>
    <% End If%>

    <script type="text/javascript">
        var NotAllowedURLCharacters = "<%=NotAllowedURLCharacters %>";
    </script>

    <script src="PageEdit.js" type="text/javascript"></script>

    <script type="text/javascript">
        var pageNotSavedText = "<%=pageNotSavedText %>";
        var remainingText = '<%=Translate.JsTranslate("remaining before recommended maximum")%>';
        var recommendedText = '<%=Translate.JsTranslate("recommended maximum exceeded")%>';
        var sslConfirmation1 = '<%=Translate.JsTranslate("Are you sure you want to change SSL settings from ")%>';
        var sslConfirmation2 = '<%=Translate.JsTranslate(" to ")%>';
        var groupSorting = 'True' == '<%=Base.GetGs("/Globalsettings/Ecom/Navigation/EnableNavigationGroupSorting")%>';    

        
        ShowNamedList = function () {
            var url = '/Admin/Content/Items/Editing/NamedItemListEdit.aspx?PageID=' + <%=Dynamicweb.Base.ChkInteger(Dynamicweb.Base.Request("ID"))%>
            <%=Me.ItemListsPopup.ClientInstanceName%>.set_contentUrl(url);
            <%=Me.ItemListsPopup.ClientInstanceName%>.show();
        }

        function showAssortmentsInfo(list){                        
            if(list != null){
                if(list.selectedIndex > 0){                                        
                    showAssortments(false);
                }else{
                    showAssortments(true);
                }
            }
        }
        function showAssortments(show){
            var infoBar = document.getElementById("InfoBar_infoAssortments");
            if(infoBar != null){
                if(show){
                    infoBar.style.display = "";
                }else{
                    infoBar.style.display = "none";
                }                    
            }
        }

        $(document).observe('keydown', function (e) {
            if (e.keyCode == 13) {
                var srcElement = e.srcElement ? e.srcElement : e.target;
                if (srcElement.type != 'textarea') {
                    e.preventDefault();
                    PageEdit.Save();
                }
            }
        });
    </script>
    <style type="text/css">
        .infobar .information{
            background: #DDECFF; 
            border:1px solid #00529B; 
            /*width: 100%;*/
        }
        #InfoBar_infoAssortments{
            margin: 0px !important;
            width: 250px;
        }
    </style>

</head>
<body onload="PageEdit.init(<%=Dynamicweb.Base.ChkInteger(Dynamicweb.Base.Request("ID"))%>);">
    <form id="MainForm" name="MainForm" runat="server" action="PageEdit.aspx" method="post" enableviewstate="false">
        <input type="hidden" runat="server" id="previewUrl" />
     
        <dw:RibbonBar runat="server" ID="myribbon">
            <dw:RibbonBarTab Active="true" Name="Menupunkt" runat="server" ID="MenuBar">
                <dw:RibbonBarGroup ID="RibbonbarGroup1" runat="server" Name="Funktioner">
                    <dw:RibbonBarButton runat="server" Text="Gem" Size="Small" Image="Save" KeyboardShortcut="ctrl+s" OnClientClick="PageEdit.Save();" ID="Save" ShowWait="true">
                    </dw:RibbonBarButton>
                    <dw:RibbonBarButton runat="server" Text="Gem og luk" Size="Small" Image="SaveAndClose" OnClientClick="PageEdit.SaveAndClose();" ID="SaveAndClose" ShowWait="true">
                    </dw:RibbonBarButton>
                    <dw:RibbonBarButton runat="server" Text="Annuller" Size="Small" Image="Cancel" OnClientClick="PageEdit.Cancel();" ID="Cancel" ShowWait="true" WaitTimeout="500">
                    </dw:RibbonBarButton>
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonbarGroup2" runat="server" Name="Side">
                    <dw:RibbonBarButton ID="cmdPreview" runat="server" Size="Large" Text="Vis" Image="Preview" OnClientClick="PageEdit.showPage();">
                    </dw:RibbonBarButton>
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonbarGroup3" runat="server" Name="Tilgængelighed">
                    <dw:RibbonBarCheckbox runat="server" Size="Small" Text="Medtag i menu" Image="CheckDocument" Hide="true" RenderAs="FormControl" ID="PageActive">
                    </dw:RibbonBarCheckbox>
                    <dw:RibbonBarCheckbox runat="server" Size="Small" Text="Klikbar" Image="FolderClosed" RenderAs="FormControl" ID="PageAllowclick">
                    </dw:RibbonBarCheckbox>
                    <dw:RibbonBarCheckbox runat="server" Size="Small" Text="Vis i brødkrummesti" Image="Address_book" RenderAs="FormControl" ID="PageShowInLegend">
                    </dw:RibbonBarCheckbox>
                    <dw:RibbonBarCheckbox runat="server" Size="Small" Text="Vis sidst opdateret" Image="Clock" RenderAs="FormControl" ID="PageShowUpdateDate">
                    </dw:RibbonBarCheckbox>
                    <dw:RibbonBarCheckbox runat="server" Size="Small" Text="Medtag i søgning" Image="Preview" RenderAs="FormControl" ID="PageAllowsearch">
                    </dw:RibbonBarCheckbox>
                    <dw:RibbonBarCheckbox runat="server" Size="Small" Text="Medtag i sitemap" Image="Tree" RenderAs="FormControl" ID="PageShowInSitemap">
                    </dw:RibbonBarCheckbox>
                    <dw:RibbonBarCheckbox runat="server" Size="Small" Text="Hide for phones" Image="Tree" RenderAs="FormControl" ID="PageHideForPhones">
                    </dw:RibbonBarCheckbox>
                    <dw:RibbonBarCheckbox runat="server" Size="Small" Text="Hide for tablets" Image="Tree" RenderAs="FormControl" ID="PageHideForTablets">
                    </dw:RibbonBarCheckbox>
                    <dw:RibbonBarCheckbox runat="server" Size="Small" Text="Hide for desktops" Image="Tree" RenderAs="FormControl" ID="PageHideForDesktops">
                    </dw:RibbonBarCheckbox>
                    <dw:RibbonBarRadioButton ID="cmdPublished" runat="server" Checked="false" Group="Publishing" Text="Publiceret" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_ok.png" Value="0" OnClientClick="PageEdit.SetPublish();">
                    </dw:RibbonBarRadioButton>
                    <dw:RibbonBarRadioButton ID="cmdPageActive" runat="server" Checked="false" Group="Publishing" Text="Hide in menu" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_plain_red.png" Value="2" OnClientClick="PageEdit.SetPublishHide()">
                    </dw:RibbonBarRadioButton>
                    <dw:RibbonBarRadioButton ID="cmdHidden" runat="server" Checked="false" Group="Publishing" Text="Unpublished" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_forbidden.png" Value="1" OnClientClick="PageEdit.SetUnPublish();">
                    </dw:RibbonBarRadioButton>
                    <dw:RibbonBarButton ID="cmdRestrictionRules" Visible="false" runat="server" Size="Small" Text="Limit children" Image="key" OnClientClick="PageEdit.showRestrictionRules();">
                    </dw:RibbonBarButton>
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="PrimaryLanugageSelectorGrp" runat="server" Name="Sprog" Visible="false">
                    <dw:RibbonBarButton ID="languageSelector" runat="server" Active="false" ImagePath="/Admin/Images/Flags/flag_dk.png" Disabled="false" Size="Large" Text="Sprog" ContextMenuId="languageSelectorContext">
                    </dw:RibbonBarButton>
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonbarGroup4" runat="server" Name="Help">
                    <dw:RibbonBarButton ID="RibbonbarButton1" runat="server" Text="Help" Image="Help" Size="Large" OnClientClick="help();">
                    </dw:RibbonBarButton>
                </dw:RibbonBarGroup>
            </dw:RibbonBarTab>
            <dw:RibbonBarTab ID="RibbonbarTab1" Active="false" Name="Options" runat="server">
                <dw:RibbonBarGroup ID="RibbonbarGroup5" runat="server" Name="Funktioner">
                    <dw:RibbonBarButton runat="server" Text="Gem" Size="Small" Image="Save" OnClientClick="PageEdit.Save();" ID="Save2" ShowWait="true">
                    </dw:RibbonBarButton>
                    <dw:RibbonBarButton runat="server" Text="Gem og luk" Size="Small" Image="SaveAndClose" OnClientClick="PageEdit.SaveAndClose();" ID="SaveAndClose2" ShowWait="true">
                    </dw:RibbonBarButton>
                    <dw:RibbonBarButton runat="server" Text="Annuller" Size="Small" Image="Cancel" OnClientClick="PageEdit.Cancel();" ID="Cancel2" ShowWait="true">
                    </dw:RibbonBarButton>
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonbarGroup6" runat="server" Name="Composition">
                    <dw:RibbonBarButton ID="RibbonbarButton2" runat="server" Text="Navigation" Size="Small" Image="Tree" OnClientClick="dialog.show('NavigationDialog');">
                    </dw:RibbonBarButton>
                    <dw:RibbonBarButton ID="RibbonbarButton3" runat="server" Text="Composition" Size="Small" Image="DocumentProperties" OnClientClick="dialog.show('LayoutDialog');">
                    </dw:RibbonBarButton>
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonbarGroup7" runat="server" Name="Publicering">
                    <dw:RibbonBarPanel ID="RibbonbarPanel1" ExcludeMarginImage="true" runat="server">
                        <table style="height: 45px; margin: 0px 0px 0px 0px;">
                            <tr valign="top">
                                <td>
                                    <dw:DateSelector runat="server" EnableViewState="false" ID="PageActiveFrom" />
                                </td>
                                <td>
                                    <%=Translate.Translate("Activation date")%>
                                </td>
                            </tr>
                            <tr valign="top">
                                <td>
                                    <dw:DateSelector runat="server" EnableViewState="false" ID="PageActiveTo" />
                                </td>
                                <td>
                                    <%=Translate.Translate("Deactivation date")%>
                                </td>
                            </tr>
                        </table>
                    </dw:RibbonBarPanel>
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonbarGroup8" runat="server" Name="Help">
                    <dw:RibbonBarButton ID="RibbonbarButton4" runat="server" Text="Help" Image="Help" Size="Large" OnClientClick="help();">
                    </dw:RibbonBarButton>
                </dw:RibbonBarGroup>
            </dw:RibbonBarTab>
            <dw:RibbonBarTab Active="false" Name="Advanced" runat="server" ID="ContentBar">
                <dw:RibbonBarGroup ID="RibbonbarGroup9" runat="server" Name="Funktioner">
                    <dw:RibbonBarButton runat="server" Text="Gem" Size="Small" Image="Save" OnClientClick="PageEdit.Save();" ID="Save3" ShowWait="true">
                    </dw:RibbonBarButton>
                    <dw:RibbonBarButton runat="server" Text="Gem og luk" Size="Small" Image="SaveAndClose" OnClientClick="PageEdit.SaveAndClose();" ID="SaveAndClose3" ShowWait="true">
                    </dw:RibbonBarButton>
                    <dw:RibbonBarButton runat="server" Text="Annuller" Size="Small" Image="Cancel" OnClientClick="PageEdit.Cancel();" ID="Cancel3" ShowWait="true">
                    </dw:RibbonBarButton>
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonbarGroup10" runat="server" Name="Indstillinger">
                    <dw:RibbonBarButton ID="RibbonbarButton5" runat="server" Text="Cache" Image="memory" Size="Small" OnClientClick="dialog.show('CacheDialog');">
                    </dw:RibbonBarButton>
                    <dw:RibbonBarButton ID="RibbonbarButton6" runat="server" Text="Genvej" ImagePath="/Admin/images/Icons/Page_int.gif" Size="Small" OnClientClick="dialog.show('ShortcutDialog');">
                    </dw:RibbonBarButton>
                    <dw:RibbonBarButton ID="RibbonbarButton7" runat="server" Text="Rotation" Image="Convert" Size="Small" OnClientClick="dialog.show('RotationDialog');">
                    </dw:RibbonBarButton>
                    <dw:RibbonBarButton runat="server" Text="Sikkerhed" Image="Key" Size="Small" ID="extranetBtn" OnClientClick="dialog.showAt('SecurityDialog', 28, 0);"></dw:RibbonBarButton>
                    <dw:RibbonBarButton runat="server" Text="Permissions" ImagePath="/Admin/Images/Icons/user1_lock.png" ID="PermissionsButton" Size="Small" OnClientClick="openEditPermission();" />
                    <dw:RibbonBarButton runat="server" Text="Ansvarlig" ImagePath="/Admin/Images/Ribbon/Icons/Small/users_preferences.png" ID="btnResponsible" Size="Small" OnClientClick="dialog.show('dlgResponsible');" Visible="false" />
                    <dw:RibbonBarButton runat="server" Text="Password" Image="Key" ID="PasswordButton" Size="Small" OnClientClick="dialog.show('PasswordDialog');" />
                    <dw:RibbonBarButton runat="server" Text="Sti" ImagePath="/Admin/Images/Ribbon/Icons/Small/link.png" ID="RibbonbarButton8" Size="Small" OnClientClick="dialog.show('UrlStatusDialog');" />
                    <dw:RibbonBarButton ID="RibbonBarButton9" Text="Comments" ImagePath="/Admin/Images/Ribbon/Icons/Small/star_yellow.png" Size="Small" runat="server" OnClientClick="comments();" />
	                <dw:RibbonBarButton runat="server" Text="Item type" Image="ItemType" ID="ItemTypeButton" Size="Small" OnClientClick="Dynamicweb.Page.ItemEdit.get_current().openItemType();" />
                    <dw:RibbonbarButton runat="server" Text="Item lists" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_cube_small.png" ID="cmdViewNamedList"  Size="Small"   OnClientClick="ShowNamedList();" />
				</dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="SSLRibbonbarGroup" runat="server" Name="Https">
                    <dw:RibbonBarRadioButton ID="cmdSSLStandard" Group="SSLMode" runat="server" Checked="false" Value="0" Text="Standard" ImagePath="/Admin/Images/Ribbon/Icons/Small/lock_ok.png" Size="Small" OnClientClick="changeSSLMode('cmdSSLStandard');">
                    </dw:RibbonBarRadioButton>
                    <dw:RibbonBarRadioButton ID="cmdSSLForce" Group="SSLMode" runat="server" Checked="false" Value="1" Text="Force SSL" ImagePath="/Admin/Images/Ribbon/Icons/Small/lock_add.png" Size="Small" OnClientClick="changeSSLMode('cmdSSLForce');">
                    </dw:RibbonBarRadioButton>
                    <dw:RibbonBarRadioButton ID="cmdSSLUnforce" Group="SSLMode" runat="server" Checked="false" Value="2" Text="Un-force SSL" ImagePath="/Admin/Images/Ribbon/Icons/Small/lock_delete.png" Size="Small" OnClientClick="changeSSLMode('cmdSSLUnforce');">
                    </dw:RibbonBarRadioButton>
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup runat="server" Name="Workflow" ID="workflowGroup">
                    <dw:RibbonBarPanel runat="server" ID="versionBtn">
                        <span style="height: 45px; margin-top: 5px;">
                            <%=Dynamicweb.Gui.ApprovalTypeBox(p.ApprovalType, p.ApprovalState, False, True, "PageApprovalType", "")%>
                        </span>
                    </dw:RibbonBarPanel>
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup runat="server" ID="ribbonGrpMaster" Name="Language management" Visible="false" Version="19.1.0.0">
                    <dw:RibbonBarCheckbox runat="server" Size="Small" Text="Lock language versions" RenderAs="FormControl" ID="PageMasterType">
                    </dw:RibbonBarCheckbox>
                    <dw:RibbonBarButton ID="languagemgmtInherit" runat="server" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/earth_lock.png" Text="Languages" Visible="false" OnClientClick="ShowLanguages();">
                    </dw:RibbonBarButton>
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonBarGroup15" Name="Personalization" runat="server">
                    <dw:RibbonBarButton ID="RibbonbarButton15" Text="Personalize" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/star_yellow.png" OnClientClick="PageEdit.openContentRestrictionDialog();" runat="server" />
                    <dw:RibbonBarButton ID="RibbonbarButton16" Text="Add profile points" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/line-chart.png" OnClientClick="PageEdit.openProfileDynamicsDialog();" runat="server" />
                    <dw:RibbonBarButton ID="cmdPreviewProfileVisit" Text="Preview" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/user1_view.png" OnClientClick="PageEdit.profileVisitPreview();" runat="server" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonbarGroup12" runat="server" Name="Help">
                    <dw:RibbonBarButton ID="RibbonbarButton10" runat="server" Text="Help" Image="Help" Size="Large" OnClientClick="help();">
                    </dw:RibbonBarButton>
                </dw:RibbonBarGroup>
            </dw:RibbonBarTab>
            <dw:RibbonBarTab ID="grpLayout" Active="False" Name="Layout" runat="server" Visible="false">
                <dw:RibbonBarGroup ID="RibbonbarGroup13" runat="server" Name="Funktioner">
                    <dw:RibbonBarButton runat="server" Text="Gem" Size="Small" Image="Save" OnClientClick="PageEdit.Save();" ID="RibbonbarButton11">
                    </dw:RibbonBarButton>
                    <dw:RibbonBarButton runat="server" Text="Gem og luk" Size="Small" Image="SaveAndClose" OnClientClick="PageEdit.SaveAndClose();" ID="RibbonbarButton12">
                    </dw:RibbonBarButton>
                    <dw:RibbonBarButton runat="server" Text="Annuller" Size="Small" Image="Cancel" OnClientClick="PageEdit.Cancel();" ID="RibbonbarButton13">
                    </dw:RibbonBarButton>
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonbarGroup14" runat="server" Name="Layout">
                    <dw:RibbonBarPanel ID="RibbonbarPanel2" runat="server">
                        <dw:Richselect ID="PageLayout" runat="server" Height="60" Itemheight="60" Width="300" Itemwidth="300">
                        </dw:Richselect>
                        <span style="color: #7E96BC;" runat="server" id="IneritedTemplate"></span>
                    </dw:RibbonBarPanel>
                    <dw:RibbonBarCheckbox runat="server" Size="Small" Text="Inherit to subpages" Image="FolderClosed" RenderAs="FormControl" ID="PageLayoutApplyToSubPages">
                    </dw:RibbonBarCheckbox>
                    <dw:RibbonBarButton runat="server" ID="RibbonBarButton14" Size="Small" Image="AddDocument" Text="Device layouts" OnClientClick="devicelayouts();" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonbarGroup11" runat="server" Name="Content type" Version="8.4.0.0">
                    <dw:RibbonBarPanel runat="server">
                        <div class="page-content-type">
                            <select id="PageContentType" class="std page-content-type" runat="server"></select>
                            <a title="Add" onclick="PageEdit.openContentTypeDialog();" class="page-content-type">&nbsp;</a>
                        </div>
                    </dw:RibbonBarPanel>
                </dw:RibbonBarGroup>
            </dw:RibbonBarTab>
        </dw:RibbonBar>
        <div id="_contentWrapper">
            <div id="breadcrumb" runat="server">
            </div>
            <div id="content" style="position: fixed; top: 135px; bottom: 0px; overflow: auto; width: 100%;">
                <dw:GroupBox ID="GB_Page" runat="server" Title="Title" DoTranslation="true">
                    <table cellpadding="1" cellspacing="1">
                        <tr>
                            <td width="170">
                                <div class="nobr">
                                    <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Sidenavn" />
                                </div>
                            </td>
                            <td>
                                <input type="text" name="PageMenuText" id="PageMenuText" runat="server" maxlength="255" class="NewUIinput" onkeyup="PageEdit.updateBreadCrumb();" />
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
                <dw:GroupBox ID="GB_Meta" runat="server" Title="Meta" DoTranslation="true">
                    <table cellpadding="1" cellspacing="1">
                        <tr>
                            <td width="170" valign="top">
                                <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Titel" />
                            </td>
                            <td>
                                <input type="text" id="PageDublincoreTitle" name="PageDublincoreTitle" size="30" class="NewUIinput" runat="server" style="margin-bottom: 1px;" onfocus="ShowCounters(this,'PageDublincoreTitleCounter','PageDublincoreTitleCounterMax');" onkeyup="CheckCounter(this,'PageDublincoreTitleCounter','PageDublincoreTitleCounterMax');" onblur="CheckAndHideCounter(this,'PageDublincoreTitleCounter','PageDublincoreTitleCounterMax');" />
                            </td>
                            <td align="left" valign="top">
                                <strong id="PageDublincoreTitleCounter" class="char-counter"></strong>
                                <input type="hidden" id="PageDublincoreTitleCounterMax" name="PageDublincoreTitleCounterMax" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <table cellpadding="1" cellspacing="1">
                        <tr>
                            <td width="170" valign="top">
                            </td>
                            <td>
                                <div id="SuggestTitleLinkDiv">
                                    <a id="InfobarSuggestTitle" style="border: none; padding: 4px;" href="#" onclick="PageEdit.Suggest('title');" class="std"><%=Translate.Translate("Suggest title")%></a>
                                </div>
                            </td>
                        </tr>   
                        <tr>
                            <td width="170" valign="top">
                            </td>
                            <td>
                                <div id="SuggestedTitleDiv" style="display: none;">
                                    <dw:Infobar Message="Suggested title" runat="server" Type="Information" Title="Click to use suggested title" Action="document.getElementById('PageDublincoreTitle').value=document.getElementById('SuggestedTitleB').innerHTML; document.getElementById('SuggestedTitleDiv').setAttribute('style', 'display: none');" ID="SuggestedTitleInforbar" Visible="True">
                                        : <b id="SuggestedTitleB" runat="server"></b>
                                    </dw:Infobar>
                                </div>
                            </td>
                            <td align="left" valign="top">
                            </td>
                        </tr>
                    </table>
                    <table cellpadding="1" cellspacing="1">
                        <tr>
                            <td width="170" valign="top">
                                <dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Beskrivelse" />
                            </td>
                            <td>
                                <textarea id="PageDescription" name="PageDescription" cols="30" rows="3" wrap="on" style="width: 250px; height: 60px;" runat="server" onfocus="ShowCounters(this,'PageDescriptionCounter','PageDescriptionCounterMax');" onkeyup="CheckCounter(this,'PageDescriptionCounter','PageDescriptionCounterMax');" onblur="CheckAndHideCounter(this,'PageDescriptionCounter','PageDescriptionCounterMax');"></textarea>
                            </td>
                            <td align="left" valign="top">
                                <strong id="PageDescriptionCounter" class="char-counter"></strong>
                                <input type="hidden" id="PageDescriptionCounterMax" name="PageDescriptionCounterMax" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Nøgleord" />
                            </td>
                            <td>
                                <textarea id="PageKeywords" name="PageKeywords" cols="30" rows="3" wrap="on" style="width: 250px; height: 60px; margin-bottom: 1px;" runat="server" onfocus="ShowCounters(this,'PageKeywordsCounter','PageKeywordsCounterMax');" onkeyup="CheckCounter(this,'PageKeywordsCounter','PageKeywordsCounterMax');" onblur="CheckAndHideCounter(this,'PageKeywordsCounter','PageKeywordsCounterMax');"></textarea>
                            </td>
                            <td align="left" valign="top">
                                <strong id="PageKeywordsCounter" class="char-counter"></strong>
                                <input type="hidden" id="PageKeywordsCounterMax" name="PageKeywordsCounterMax" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <table cellpadding="1" cellspacing="1">
                        <tr>
                            <td width="170" valign="top">
                            </td>
                            <td>
                                <div id="SuggestKeywordsLinkDiv">
                                    <a id="InfobarSuggestKeywords" style="border:none;padding:4px;" href="#" onclick="PageEdit.Suggest('keywords');" class="std"><%=Translate.Translate("Suggest keywords")%></a>
                                </div>
                            </td>
                        </tr>   
                        <tr>
                            <td width="170" valign="top">
                            </td>
                            <td>
                                <div id="SuggestedKeywordsDiv" style="display: none;">
                                    <dw:Infobar Message="Suggested keywords" runat="server" Type="Information" Title="Click to use suggested keywords" Action="document.getElementById('PageKeywords').value=document.getElementById('SuggestedKeywordsB').innerHTML; document.getElementById('SuggestedKeywordsDiv').setAttribute('style', 'display: none');" ID="SuggestedKeywordsInforbar">
                                        : <b id="SuggestedKeywordsB" runat="server"></b>
                                    </dw:Infobar>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td width="170" valign="top">
                            </td>
                            <td>
                                <input type="checkbox" id="DisableAutoMeta" value="True" runat="server" />
                                <label for="DisableAutoMeta">
                                    <dw:TranslateLabel ID="TranslateLabel151" runat="server" Text="Do not suggest meta information" />
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                            </td>
                            <td colspan="2">
                                <asp:CheckBox runat="server" ID="Noindex" />
                                <label for="Noindex">
                                    <dw:TranslateLabel ID="TranslateLabel23" runat="server" Text="Noindex" />
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                            </td>
                            <td colspan="2">
                                <asp:CheckBox runat="server" ID="Nofollow" />
                                <label for="Nofollow">
                                    <dw:TranslateLabel ID="TranslateLabel24" runat="server" Text="Nofollow" />
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                            </td>
                            <td colspan="2">
                                <asp:CheckBox runat="server" ID="Robots404" />
                                <label for="Robots404">
                                    <dw:TranslateLabel ID="TranslateLabel161" runat="server" Text="404 for detected robots" />
                                </label>
                            </td>
                        </tr>
                    </table>
                    <%If Base.HasVersion("8.3.0.0") Then%>
                    <table cellpadding="1" cellspacing="1">
                        <tr>
                            <td width="170" valign="top">
                                <dw:TranslateLabel ID="TranslateLabel21" runat="server" Text="Canonical page" />
                            </td>
                            <td>
                                <input type="text" name="PageCanonical" id="PageCanonical" runat="server" maxlength="255" class="NewUIinput" />
                            </td>
                            <td align="left" valign="top">
                            </td>
                        </tr>
                    </table>
                    <%End If%>
                    <input type="hidden" name="PageDublincore" value="PageDublincoreTitle, PageDublincoreSubject, PageDublincoreCopyright, PageDublincorePublisher, PageDublincoreRights, PageDublincoreCreator, PageDublincoreAuthor">
                </dw:GroupBox>
                <% If Base.ChkBoolean(Base.GetGs("/Globalsettings/Settings/Performance/ActivateDublinCore")) Then%>
                <dw:GroupBox ID="GB_DublinCore" runat="server" Title="Dublin core">
                    <table cellpadding="1" cellspacing="1">
                        <tr>
                            <td width="170">
                                <dw:TranslateLabel ID="TranslateLabel51" runat="server" Text="Emne" />
                            </td>
                            <td>
                                <input type="text" runat="server" id="PageDublincoreSubject" name="PageDublincoreSubject" size="30" maxlength="255" value="" class="NewUIinput" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel61" runat="server" Text="Forfatter" />
                            </td>
                            <td>
                                <input type="text" runat="server" id="PageDublincoreAuthor" name="PageDublincoreAuthor" size="30" maxlength="255" value="" class="NewUIinput" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel71" runat="server" Text="Oprettet af" />
                            </td>
                            <td>
                                <input type="text" runat="server" id="PageDublincoreCreator" name="PageDublincoreCreator" size="30" maxlength="255" value="" class="NewUIinput" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel81" runat="server" Text="Rettigheder" />
                            </td>
                            <td>
                                <input type="text" runat="server" id="PageDublincoreRights" name="PageDublincoreRights" size="30" maxlength="255" value="" class="NewUIinput" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel91" runat="server" Text="Udgiver" />
                            </td>
                            <td>
                                <input type="text" runat="server" id="PageDublincorePublisher" name="PageDublincorePublisher" size="30" maxlength="255" value="" class="NewUIinput" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel101" runat="server" Text="Copyright" />
                            </td>
                            <td>
                                <input type="text" runat="server" id="PageDublincoreCopyright" name="PageDublincoreCopyright" size="30" maxlength="255" value="" class="NewUIinput" />
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
                <% End If%>
                <dw:GroupBox ID="GB_Url" runat="server" Title="Url" DoTranslation="true">
                    <table cellpadding="1" cellspacing="1">
                        <tr id="FriendlyUrlRow" runat="server">
                            <td width="170">
                                <div class="nobr">
                                    <dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Url" />
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
                                    <dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="Use in url" />
                                </div>
                            </td>
                            <td>
                                <input type="text" id="PageUrlName" name="PageUrlName" size="30" maxlength="50" class="NewUIinput" runat="server" />
                            </td>
                        </tr>
                        <tr id="PageUrlIgnoreForChildrenRow" runat="server">
                            <td width="170">
                                <div class="nobr">
                                </div>
                            </td>
                            <td>
                                <asp:CheckBox runat="server" ID="PageUrlIgnoreForChildren" /><label for="PageUrlIgnoreForChildren"><dw:TranslateLabel ID="TranslateLabel11" runat="server" Text="Do not include in subpage URLs" />
                                </label>
                            </td>
                        </tr>
						<tr id="exacturl" runat="server" visible="true">
							<td colspan="2">
								<table cellpadding="0" cellspacing="0">
									<tr>
										<td colspan="2"><hr /></td>
									</tr>
									<tr>
										<td width="170">
											<div class="nobr">
												<dw:TranslateLabel ID="TranslateLabel22" runat="server" Text="Exact URL for this page" />
											</div>
										</td>
										<td>
											<input type="text" id="PageExactUrl" name="PageExactUrl" size="30" maxlength="255" class="NewUIinput" runat="server" />
										</td>
									</tr>
									<tr>
										<td></td>
										<td><small>I.e. pagename.xml or mypath/somepage.php</small></td>
									</tr>
								</table>
							</td>
                        </tr>
                        
                    </table>
                </dw:GroupBox>
                <div id="content-item">
		            <asp:Literal ID="litFields" runat="server" />
                </div>
            </div>
        </div>
        <dw:Dialog runat="server" ID="DeviceLayoutDialog" Width="525" Title="Device layouts" ShowOkButton="true" OkOnEnter="true">
            <dw:GroupBox ID="GroupBox2" runat="server" Title="Templates">
                <table cellpadding="1" cellspacing="1">
                    <tr>
                        <td width="170">
                            <dw:TranslateLabel ID="TranslateLabel19" runat="server" Text="Phone" />
                        </td>
                        <td>
                            <asp:ListBox runat="server" Rows="1" ID="PageLayoutPhone" CssClass="NewUIinput" Width="250" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="TranslateLabel20" runat="server" Text="Tablet" />
                        </td>
                        <td>
                            <asp:ListBox runat="server" Rows="1" ID="PageLayoutTablet" CssClass="NewUIinput" Width="250" />
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
        </dw:Dialog>
        <dw:Dialog ID="dlgResponsible" runat="server" Width="525" Title="Ansvarlig" ShowOkButton="true" Visible="false">
            <dw:GroupBox ID="GroupBox1" runat="server" Title="Ansvarlig" DoTranslation="true">
                <table cellpadding="2" cellspacing="2">
                    <tr>
                        <td width="170">
                            <dw:TranslateLabel ID="TranslateLabel131" runat="server" Text="Ansvarlig" />
                        </td>
                        <td>
                            <%=Gui.UserList("PageManager", p.Manager)%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="TranslateLabel141" runat="server" Text="Opdater" />
                        </td>
                        <td>
                            <select class="std" name="PageManageFrequence">
                                <option value="0">
                                    <%=Translate.Translate("Intet valgt")%>
                                </option>
                                <option value="1" <%=Base.IIf(p.ManageFrequence = "1", "selected", "")%>>
                                    <%=Translate.Translate("Hver dag")%>
                                </option>
                                <option value="2" <%=Base.IIf(p.ManageFrequence = "2", "selected", "")%>>
                                    <%=Translate.Translate("Hver 2. dag")%>
                                </option>
                                <option value="14" <%=Base.IIf(p.ManageFrequence = "14", "selected", "")%>>
                                    <%=Translate.Translate("Hver 14. dag")%>
                                </option>
                                <option value="30" <%=Base.IIf(p.ManageFrequence = "30", "selected", "")%>>
                                    <%=Translate.Translate("Hver måned")%>
                                </option>
                                <option value="60" <%=Base.IIf(p.ManageFrequence = "60", "selected", "")%>>
                                    <%=Translate.Translate("Hver 2. måned")%>
                                </option>
                                <option value="90" <%=Base.IIf(p.ManageFrequence = "90", "selected", "")%>>
                                    <%=Translate.Translate("Hver 3. måned")%>
                                </option>
                                <option value="180" <%=Base.IIf(p.ManageFrequence = "180", "selected", "")%>>
                                    <%=Translate.Translate("Hver 6. måned")%>
                                </option>
                                <option value="360" <%=Base.IIf(p.ManageFrequence = "360", "selected", "")%>>
                                    <%=Translate.Translate("Hvert år")%>
                                </option>
                            </select>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
        </dw:Dialog>
        <dw:Dialog ID="UrlStatusDialog" runat="server" Width="525" Title="Sti" ShowOkButton="true" OkOnEnter="true">
            <dw:GroupBox ID="GB_UrlStatus" runat="server" Title="Sti" DoTranslation="true">
                <table cellpadding="1" cellspacing="1">
                    <tr>
                        <td width="170">
                            <div class="nobr">
                                <dw:TranslateLabel ID="TranslateLabel7" runat="server" Text="Direct path" />
                            </div>
                        </td>
                        <td>
                            <input type="hidden" runat="server" id="UrlPathID" name="UrlPathID" />
                            <input type="text" runat="server" id="UrlPath" name="UrlPath" maxlength="255" class="NewUIinput" />
                            <a href="" id="UrlPathTestLink" runat="server" target="_blank" visible="false">
                                <img src="/Admin/Images/Ribbon/Icons/Small/link.png" border="0" align="absmiddle" alt="<%=Dynamicweb.Backend.Translate.translate("Test") %>" /></a>
                        </td>
                    </tr>
                    <tr>
                        <td width="170" valign="top">
                            <div class="nobr">
                                <dw:TranslateLabel ID="TranslateLabel8" runat="server" Text="Status" />
                            </div>
                        </td>
                        <td>
                            <dw:RadioButton runat="server" ID="UrlPathStatus200" FieldName="UrlPathStatus" FieldValue="200" />
                            <label for="UrlPathStatus200">
                                <dw:TranslateLabel ID="TranslateLabel9" Text="Behold sti (200 OK)" runat="server" />
                            </label>
                            <br />
                            <dw:RadioButton runat="server" ID="UrlPathStatus301" FieldName="UrlPathStatus" FieldValue="301" SelectedFieldValue="301" />
                            <label for="UrlPathStatus301">
                                <dw:TranslateLabel ID="TranslateLabel10" Text="Vidersend til link (301 Moved Permanently)" runat="server" />
                            </label>
                            <br />
                            <dw:RadioButton runat="server" ID="UrlPathStatus302" FieldName="UrlPathStatus" FieldValue="302" />
                            <label for="UrlPathStatus302">
                                <dw:TranslateLabel ID="TranslateLabel113" Text="Vidersend til link (302 Moved Temporarily)" runat="server" />
                            </label>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
        </dw:Dialog>
        <%   If Me.p.IsMaster Then%>
        <dw:Dialog ID="LanguageDialog" runat="server" Title="Language management" HidePadding="true" Width="525">
            <iframe id="LanguageFrame" style="width: 100%; height: 300px; border: solid 0px red;" src="about:blank" frameborder="0"></iframe>
        </dw:Dialog>

        <script type="text/javascript">
            LanguageUrl = '/Admin/Content/Page/Languages.aspx?PageID=<%=Me.p.ID %>';
        </script>

        <% End If%>
        <dw:Dialog ID="NavigationDialog" runat="server" Width="525" Title="Grafisk navigation" ShowOkButton="true" OkOnEnter="true">
            <dw:GroupBox ID="GB_Navigation" runat="server" DoTranslation="True" Title="Grafisk navigation">
                <table cellpadding="1" cellspacing="1">
                    <tr>
                        <td width="170">
                            <dw:TranslateLabel ID="TranslateLabel12" runat="server" Text="Grafik" />
                        </td>
                        <td>
                            <dw:FileManager ID="PageImageMouseOut" runat="server" Folder="/Navigation" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="TranslateLabel13" runat="server" Text="MouseOver grafik" />
                        </td>
                        <td>
                            <dw:FileManager ID="PageImageMouseOver" runat="server" Folder="/Navigation" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="TranslateLabel14" runat="server" Text="Valgt grafik" />
                        </td>
                        <td>
                            <dw:FileManager ID="PageImageActivePage" runat="server" Folder="/Navigation" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <dw:CheckBox runat="server" Value="True" ID="PageTextAndImage" FieldName="PageTextAndImage" />
                            <label for="PageTextAndImage">
                                <dw:TranslateLabel ID="TranslateLabel15" runat="server" Text="Medtag tekst" />
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="nobr">
                                <dw:TranslateLabel ID="TranslateLabel16" runat="server" Text="Statuslinje tekst" />
                                :&nbsp;</div>
                        </td>
                        <td>
                            <input type="text" name="PageMouseOver" id="PageMouseOver" runat="server" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div class="nobr">
                                <dw:TranslateLabel ID="TranslateLabel18" runat="server" Text="Navigation tag" />
                                :&nbsp;</div>
                        </td>
                        <td>
                            <input type="text" name="PageNavigationTag" id="PageNavigationTag" runat="server" maxlength="255" class="NewUIinput" />
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
            <asp:Panel ID="eComNavContainer" runat="server">
                <dw:GroupBox ID="gbContent" DoTranslation="true" Title="Content" runat="server">
                    <table cellpadding="1" cellspacing="1" border="0">
                        <tr>
                            <td>
                                <span style="color: Gray">
                                    <dw:TranslateLabel ID="lbSelectContent" Text="Select the content you want to be displayed under this page in the standard XML menu" runat="server" />
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div>
                                    <input type="checkbox" id="chkNavProductGroups" value="True" runat="server" />
                                    <asp:Label ID="lbGroups" AssociatedControlID="chkNavProductGroups" runat="server" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
                <div id="divProductGroups" runat="server">
                    <dw:GroupBox ID="gbProductGroups" DoTranslation="false" runat="server">
                        <table cellpadding="1" cellspacing="1" border="0">                            
                            <tr>
                                <td>
                                    <!-- Parent selector -->
                                    <table cellpadding="2" cellspacing="0">
                                        <tr id="NavigationProviderListRow" runat="server">
                                            <td width="170">
                                                <label class="group-header"><dw:TranslateLabel ID="TranslateLabel25" Text="Navigation provider" runat="server" /></label>
                                            </td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="NavigationProviderList" CssClass="std" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="170">
                                                <label class="group-header"><dw:TranslateLabel ID="lbGroupParent" Text="Group parent" runat="server" /></label>
                                            </td>
                                            <td>                                                
                                                <dw:Infobar ID="infoAssortments" ClientIDMode="Static" Type="Information" Message="Assortments are enabled" UseInlineStyles="false" runat="server" />                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <input type="radio" name="NavigationProductGroupParent" id="rbGroups" value="Groups" runat="server" />
                                                <asp:Label ID="lbSelectGroups" AssociatedControlID="rbGroups" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <input type="radio" name="NavigationProductGroupParent" id="rbShop" value="Shop" runat="server" />
                                                <asp:Label ID="lbSelectShop" AssociatedControlID="rbShop" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                    <!-- Group selector -->
                                    <div id="divGroupsSelector" runat="server">
                                        <br />
                                        <table cellpadding="2" cellspacing="0">
                                            <tr>
                                                <td valign="top">
                                                    <label  class="group-header"><dw:TranslateLabel ID="lbGroupsSelector" Text="Groups" runat="server" /></label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="selectorContainer">
                                                    <de:ProductsAndGroupsSelector runat="server" OnlyGroups="true" ID="NavigationGroupSelector" CallerForm="MainForm" Width="404px" Height="100px" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <!-- Shop selector -->
                                    <div id="divShopSelector" runat="server">
                                        <br />
                                        <table cellpadding="2" cellspacing="0">
                                            <tr>
                                                <td style="width: 170px" valign="top">
                                                    <dw:TranslateLabel ID="lbShopSelector" Text="Shop" runat="server" />
                                                </td>
                                                <td>
                                                    <de:ShopDropDown ID="NavigationShopSelector" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <br />
                                    <!-- Max level selector, Productpage selector -->
                                    <table cellpadding="2" cellspacing="0">
                                        <tr>
                                            <td style="width: 170px" valign="top">
                                                
                                            </td>
                                            <td>
                                                <input type="checkbox" id="chkIncludeProducts" value="True" runat="server" />
                                                <asp:Label ID="lbIncludeProducts" AssociatedControlID="chkIncludeProducts" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 170px" valign="top">
                                                <dw:TranslateLabel ID="lbMaxLevelsSelector" Text="Max levels" runat="server" />
                                            </td>
                                            <td>
                                                <select id="ddMaxLevels" runat="server" class="std" style="width:140px;">
                                                    <option label="1" value="1" />
                                                    <option label="2" value="2" />
                                                    <option label="3" value="3" />
                                                    <option label="4" value="4" />
                                                    <option label="5" value="5" />
                                                    <option label="6" value="6" />
                                                    <option label="7" value="7" />
                                                    <option label="8" value="8" />
                                                    <option label="9" value="9" />
                                                    <option label="10" value="10" />
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 170px" valign="top">
                                                <dw:TranslateLabel ID="lbProductpageSelector" Text="Product page" runat="server" />
                                            </td>
                                            <td>
                                                <asp:Literal ID="litProductPage" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </dw:GroupBox>
                </div>
            </asp:Panel>
        </dw:Dialog>
        <dw:Dialog ID="LayoutDialog" runat="server" Width="525" Title="Composition" ShowOkButton="true" OkOnEnter="true">
            <dw:GroupBox ID="GB_Layout" runat="server" DoTranslation="True" Title="Composition">
                <table cellpadding="1" cellspacing="1">
                    <tr>
                        <td width="170">
                            <dw:TranslateLabel ID="TranslateLabel17" runat="server" Text="Logo" />
                        </td>
                        <td>
                            <dw:FileManager ID="PageTopLogoImage" runat="server" Folder="/System" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel runat="server" Text="Logo" />
                            (alt)
                        </td>
                        <td>
                            <input class="NewUIinput" maxlength="255" id="PageTopLogoImageAlt" name="PageTopLogoImageAlt" size="30" type="text" value="" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel runat="server" Text="Topgrafik" />
                        </td>
                        <td>
                            <dw:FileManager ID="PageTopImage" runat="server" Folder="/System" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <dw:CheckBox runat="server" Value="True" ID="PageShowTopImage" FieldName="PageShowTopImage" />
                            <label for="PageShowTopImage">
                                <dw:TranslateLabel runat="server" Text="Vis topgrafik" />
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel runat="server" Text="Menulogo" />
                        </td>
                        <td>
                            <dw:FileManager ID="PageMenuLogoImage" runat="server" Folder="/System" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel runat="server" Text="Baggrund" />
                        </td>
                        <td>
                            <dw:FileManager ID="PageBackgroundImage" runat="server" Folder="/System" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel runat="server" Text="Sidefod" />
                        </td>
                        <td>
                            <dw:FileManager ID="PageFooterImage" runat="server" Folder="/System" />
                        </td>
                    </tr>
                    <%  If Not Base.GetGs("/Globalsettings/Settings/Designs/UseOnlyDesignsAndLayouts") = "True" Then%>
                    <tr>
                        <td>
                            <dw:TranslateLabel runat="server" Text="Stylesheet" />
                        </td>
                        <td>
                            <%=Gui.StylesheetList(p.Stylesheet, "PageStylesheet")%>
                        </td>
                    </tr>
                    <%  End If%>
                </table>
            </dw:GroupBox>
        </dw:Dialog>
        <dw:Dialog ID="CacheDialog" runat="server" Title="Cache" Width="525" ShowOkButton="true" OkOnEnter="true">
            <dw:GroupBox ID="GB_Cache" runat="server" DoTranslation="True" Title="Cache">
                <table cellpadding="1" cellspacing="1">
                    <tr>
                        <td width="170" valign="top">
                            <dw:TranslateLabel runat="server" Text="Type" />
                        </td>
                        <td>
                            <dw:RadioButton runat="server" ID="PageCacheMode1" FieldName="PageCacheMode" FieldValue="1" />
                            <label for="PageCacheMode1">
                                <dw:TranslateLabel runat="server" Text="Ingen" />
                            </label>
                            <br />
                            <dw:RadioButton runat="server" ID="PageCacheMode2" FieldName="PageCacheMode" FieldValue="2" />
                            <label for="PageCacheMode2">
                                <dw:TranslateLabel runat="server" Text="Standard" />
                            </label>
                            <br />
                            <dw:RadioButton runat="server" ID="PageCacheMode3" FieldName="PageCacheMode" FieldValue="3" />
                            <label for="PageCacheMode3">
                                <dw:TranslateLabel runat="server" Text="Hele siden" />
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel runat="server" Text="Gyldig" />
                        </td>
                        <td>
                            <%=CacheFrequence(p.CacheFrequence, "PageCacheFrequence")%>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
        </dw:Dialog>
        <!-- Start Password Dialog -->
        <dw:Dialog ID="PasswordDialog" runat="server" Title="Password" Width="450" ShowOkButton="true">
            <table cellpadding="1" cellspacing="1">
                <tr style="height: 25px;">
                    <td width="170">
                    </td>
                    <td>
                        <dw:CheckBox runat="server" Value="1" ID="PageProtect" AttributesParm="onclick='showOrHide(this);'" />
                        <label for="PageProtect">
                            <dw:TranslateLabel ID="TranslateLabel112" runat="server" Text="Kodeordsbeskyttelse" />
                        </label>
                    </td>
                </tr>
                <tr style="height: 25px;" id="pwd" runat="server">
                    <td width="170">
                        <dw:TranslateLabel ID="TranslateLabel122" runat="server" Text="Kodeord" />
                    </td>
                    <td>
                        <input type="text" runat="server" id="PagePassword" name="PagePassword" size="30" maxlength="255" value="" style="width: 120px;" class="NewUIinput" />
                    </td>
                </tr>
            </table>
        </dw:Dialog>
        <!-- End Password Dialog -->
        <dw:Dialog ID="SecurityDialog" runat="server" Title="Sikkerhed" Width="525" ShowOkButton="true">
            <div runat="server" id="extranetDiv">
                <dw:GroupBox ID="GB_Rights" runat="server" Title="Rettigheder">
                    <div runat="server" id="GB_rights_container">
                    </div>
                </dw:GroupBox>
                <dw:GroupBox ID="GB_Login" runat="server" Title="Login">
                    <table cellpadding="1" cellspacing="1">
                        <tr>
                            <td width="170">
                                <dw:TranslateLabel runat="server" Text="Vis i menu" />
                            </td>
                            <td>
                                <dw:RadioButton runat="server" ID="PagePermissionType2" FieldName="PagePermissionType" FieldValue="2" />
                                <label for="PagePermissionType2">
                                    <dw:TranslateLabel runat="server" Text="Kun for brugere med adgang" />
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <dw:RadioButton runat="server" ID="PagePermissionType1" FieldName="PagePermissionType" FieldValue="1" />
                                <label for="PagePermissionType1">
                                    <dw:TranslateLabel runat="server" Text="For alle brugere" />
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel runat="server" Text="Template" />
                            </td>
                            <td>
                                <dw:FileManager ID="PagePermissionTemplate" runat="server" Folder="Templates/Extranet" />
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
            </div>
        </dw:Dialog>
        <dw:Dialog ID="ShortcutDialog" runat="server" Title="Genvej" Width="525" ShowOkButton="true" OkOnEnter="true">
            <dw:GroupBox ID="GB_Shortcut" runat="server" DoTranslation="True" Title="Genvej">
                <table cellpadding="1" cellspacing="1">
                    <tr>
                        <td width="170" valign="top">
                            <dw:TranslateLabel runat="server" Text="Genvej" />
                        </td>
                        <td>
                            <dw:LinkManager ID="PageShortCut" runat="server" DisableFileArchive="False" DisableParagraphSelector="True" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <dw:CheckBox runat="server" Value="1" ID="PageShortCutRedirect" FieldName="PageShortCutRedirect" />
                            <label for="PageShortCutRedirect">
                                <dw:TranslateLabel runat="server" Text="Videresend" />
                            </label>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
        </dw:Dialog>
        <dw:Dialog ID="RotationDialog" runat="server" Title="Rotationssider" Width="525" ShowOkButton="true" OkOnEnter="true">
            <dw:GroupBox ID="GB_Rotation" runat="server" DoTranslation="True" Title="Rotationssider">
                <table cellpadding="1" cellspacing="1" width="100%">
                    <asp:Repeater runat="server" ID="RotationItems">
                        <HeaderTemplate>
                            <tr>
                                <td width="270">
                                    <strong>
                                        <dw:TranslateLabel runat="server" Text="Sidenavn" />
                                    </strong>
                                </td>
                                <td width="35" align="center">
                                    <strong>
                                        <dw:TranslateLabel runat="server" Text="Slet" />
                                    </strong>
                                </td>
                            </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td colspan="2" bgcolor="#C4C4C4">
                                    <img src="/Admin/images/nothing.gif" width="1" height="1" border="0" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="/Default.aspx?ID=<%#Container.DataItem%>" target="_blank">
                                        <%#Base.GetInternal(Container.DataItem)%>
                                    </a>
                                </td>
                                <td width="35" align="center">
                                    <a href="/Admin/Page_Rotation_Delete.aspx?ID=<%#p.ID %>&RotateID=<%#Container.DataItem%>">
                                        <img src="/Admin/Images/Delete.gif" border="0" alt="[x]" />
                                    </a>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:Panel runat="server" ID="RotationItemsAlt">
                        <tr>
                            <td colspan="2">
                                <strong>
                                    <dw:TranslateLabel runat="server" Text="Der er ikke tilknyttet rotationssider" />
                                </strong>
                            </td>
                        </tr>
                    </asp:Panel>
                    <tr>
                        <td width="170">
                        </td>
                        <td align="right">
                            <table cellpadding="1" cellspacing="1">
                                <tr>
                                    <td>
                                        <dw:Button runat="server" Name="Tilføj side" OnClick="PageEdit.AddPage('');" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
            <dw:GroupBox ID="GB_RotationType" runat="server" Title="Type">
                <table cellpadding="1" cellspacing="1" width="100%">
                    <tr>
                        <td width="170">
                        </td>
                        <td>
                            <dw:RadioButton runat="server" ID="PageRotationType0" FieldName="PageRotationType" FieldValue="0" />
                            <label for="PageRotationType0">
                                <dw:TranslateLabel runat="server" Text="Afsnit" />
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <dw:RadioButton runat="server" ID="PageRotationType1" FieldName="PageRotationType" FieldValue="1" />
                            <label for="PageRotationType1">
                                <dw:TranslateLabel runat="server" Text="Hele siden" />
                            </label>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
        </dw:Dialog>
        <omc:MarketingConfiguration ID="marketConfig" runat="server" />

        <script type="text/javascript">
            PageEdit.Marketing = <%=marketConfig.ClientInstanceName%>;
        </script>

        <dw:Dialog runat="server" ID="PagePermissionDialog" Width="522" Title="Page permissions" HidePadding="true">
            <iframe id="PagePermissionDialogIFrame" src="" height="485px" width="505px"></iframe>
        </dw:Dialog>
        <dw:Dialog ID="CommentsDialog" runat="server" Title="Comments" HidePadding="true" Width="625">
            <iframe id="CommentsFrame" style="width: 100%; height: 300px; border: solid 0px red;" src="about:blank" frameborder="0"></iframe>
        </dw:Dialog>
        
        <div class="page-content-type">
            <dw:Dialog ID="ContentTypeDialog" Width="265" OkOnEnter="True" ShowOkButton="True" ShowCancelButton="True" ShowClose="True" Title="Input new content type" OkAction="PageEdit.addContentType();" runat="server">
                <input type="text" class="std page-content-type"/>         
            </dw:Dialog>            
        </div>

        <dw:Dialog ID="dlgEditRestrictionRules" Title="Edit restrictions" UseTabularLayout="true" Width="450" OkAction="PageEdit.hideRestrictionRules();" ShowOkButton="true" ShowCancelButton="false" ShowClose="true" ShowHelpButton="false" runat="server">
                <div class="restrictions-container">
                    <dw:GroupBox ID="gbRestrictionRules" Title="Children restrictions" runat="server"></dw:GroupBox>
                </div>
                <div class="separator-10">&nbsp;</div>
        </dw:Dialog>

	    <dw:Dialog runat="server" ID="ChangeItemTypeDialog" Width="360" Title="Change item type" ShowOkButton="true" ShowCancelButton="true" CancelAction="Dynamicweb.Page.ItemEdit.get_current().cancelChangeItemType();" OkAction="Dynamicweb.Page.ItemEdit.get_current().changeItemType();">
	    <dw:GroupBox ID="GroupBox3" runat="server" Title="Change item type">
	    <table cellpadding="1" cellspacing="1">
	        <tr>
                <td>
				    <dw:Richselect ID="ItemTypeSelect" runat="server" Height="60" Itemheight="60" Width ="300" Itemwidth="300">
				    </dw:Richselect>
			    </td>
            </tr>
	    </table>
	    </dw:GroupBox>
	    </dw:Dialog>

        <dw:PopUpWindow ID="ItemListsPopup" SnapToScreen="True" UseTabularLayout="true" AutoReload="true" Width="1024" Height="600" iframeHeight="500"
                Title="Item lists" TranslateTitle="true" ContentUrl="" HidePadding="true" runat="server" AutoCenterProgress="true" ShowOkButton="false" ShowCancelButton="false" ShowClose="true" />

        <dw:ContextMenu ID="languageSelectorContext" runat="server" MaxHeight="400">
        </dw:ContextMenu>
        <iframe id="SaveFrame" name="SaveFrame" style="display: none;"></iframe>
        <input type="hidden" id="ID" name="ID" runat="server" />
        <input type="hidden" id="AreaID" name="AreaID" runat="server" />
        <input type="hidden" id="ParentPageID" name="ParentPageID" runat="server" />
        <input type="hidden" id="cmd" name="cmd" value="save" />
        <input type="hidden" id="onSave" name="onSave" value="Close" />
    </form>
    <span id="NoNameText" style="display: none">
        <%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%></span>

    <script type="text/javascript">        
	<% if (Base.Request("ShowRotation") <> "") Then %>
	    dialog.show('RotationDialog');
	<% End If %>
	
	function help(){
		<%=Dynamicweb.Gui.Help("", "page.editNEW") %>
	}
    	var useSSLOption = '<%=p.SSLMode%>';
    </script>

    <%Translate.GetEditOnlineScript()%>
	
</body>
</html>
