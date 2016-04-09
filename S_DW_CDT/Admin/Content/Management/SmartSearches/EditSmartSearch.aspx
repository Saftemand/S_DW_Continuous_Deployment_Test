<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EditSmartSearch.aspx.vb" Inherits="Dynamicweb.Admin.EditSmartSearch" EnableEventValidation="false" ValidateRequest="false" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml"  lang="<%= Base.GetCulture() %>">
<head id="Head1" runat="server">
    <title></title>
<dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />	
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 
    <link rel="Stylesheet" type="text/css" href="/Admin/Module/eCom_Catalog/dw7/css/Main.css" />
    <link rel="Stylesheet" type="text/css" href="/Admin/Module/eCom_Catalog/dw7/css/OrderList.css" media="screen" />
    <link rel="Stylesheet" type="text/css" href="/Admin/Module/eCom_Catalog/dw7/css/OrderListPrint.css" media="print" />

	<link rel="Stylesheet" href="/Admin/Content/StyleSheetNewUI.css" />
	<link rel="Stylesheet" href="/Admin/Content/Management/SmartSearches/css/EditSmartSearch.css" />
    <script src="/Admin/Content/Management/SmartSearches/js/EditSmartSearch.js" type="text/javascript"></script>
    <script src="/Admin/Images/Ribbon/UI/WaterMark.js" type="text/javascript"></script>
	
    <dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true" />
    
    <script type="text/javascript">
        var id = <%= Base.ChkInteger(Base.Request("ID"))%>;
        var cmd = '<%= Base.ChkString(Base.Request("CMD"))%>';
        var isEdit = <%=IsEdit.ToString().ToLower() %>;
        
        function getContentFrame() {
            <%If IsFromEcom Then%>
                return $('cellContent') || parent.$('cellContent');
            <%Else%>
                return $('ContentFrame') || parent.$('ContentFrame');
            <%End If%>
            }

        Event.observe(document, 'dom:loaded', function () {
            WaterMark.create(document.getElementById('<%= tbTopRows.ClientID %>'), '<%= Base.JSEnable(Translate.JsTranslate("All"))%>');
        });

        function onKeyPress(evt) {
            var theEvent = evt || window.event;
            var key = theEvent.keyCode || theEvent.which;

            if (key != 35 && key != 36 && key != 37 && key != 38 && key != 39 && key != 40 && key != 46 && key != 8) {
                key = String.fromCharCode(key);
                var regex = /[0-9]|\./;
                if (!regex.test(key)) {
                    theEvent.returnValue = false;
                    if (theEvent.preventDefault) theEvent.preventDefault();
                }
            }
        };

        function setDisabledCacheTimeSelector(self) {
            var CachingIntervalSelector = document.getElementById('CachingIntervalSelector');
            self.checked ? CachingIntervalSelector.disabled = "" : CachingIntervalSelector.disabled = "disabled";
        };
        
    </script>
    
</head>
<body class="edit" style="border-bottom:1px solid #6593CF;" id="viewBody">
    <form id="viewForm" runat="server" style="height: 100%;" method="post">
        <dw:Ribbonbar ID="Ribbon" runat="server">
			<dw:RibbonbarTab ID="RibbonbarTab1" runat="server" Active="true" Name="Smart Search">
			
                <dw:RibbonbarGroup ID="RibbonbarGroup1" runat="server" Name="Funktioner">
					<dw:RibbonbarButton runat="server" Text="Gem" Size="Small" Image="Save" OnClientClick="onSave();" ID="cmdSave" />
					<dw:RibbonbarButton runat="server" Text="Gem og luk" Size="Small" Image="SaveAndClose" OnClientClick="onSaveAndClose();" ID="cmdSaveAndClose" />
					<dw:RibbonbarButton runat="server" Text="Annuller" Size="Small" Image="Cancel" OnClientClick="onCancel();" ID="cmdCancel" />
				</dw:RibbonbarGroup>
				
				<dw:RibbonbarGroup ID="RibbonbarGroup3" runat="server" Name="Rules">
	                <dw:RibbonbarRadioButton OnClientClick="onGroupSelected(2);" ID="cmdAll_must_apply" Text="All must apply" runat="server" Size="Small" Imagepath="/Admin/Module/OMC/img/rule_all_small.png" />
                    <dw:RibbonbarRadioButton OnClientClick="onGroupSelected(1);" ID="cmdAny_must_apply" Text="Any must apply" runat="server" Size="Small" Imagepath="/Admin/Module/OMC/img/rule_any_small.png" />
                    <dw:RibbonbarRadioButton OnClientClick="onUngroupSelected();" ID="cmdUngroup" Text="Ungroup" runat="server" Size="Small" Imagepath="/Admin/Module/OMC/img/rule_normal_small.png" />
                    <dw:RibbonbarRadioButton OnClientClick="onRemoveSelected();" ID="cmdRemove_selected" Text="Remove selected" runat="server" Size="Small" Imagepath="/Admin/Images/Ribbon/Icons/Small/DeleteDocument.png" />
				</dw:RibbonbarGroup>

				<dw:RibbonbarGroup ID="RibbonbarGroupPreview" runat="server" Name="Preview">
				    <dw:RibbonbarCheckbox ID="cmd_Preview" runat="server" Size="Large" Text="Preview" Image="Preview" OnClientClick="onPreview();" />
				</dw:RibbonbarGroup>

				<dw:RibbonbarGroup ID="RibbonbarGroupCaching" runat="server" Name="Caching" Visible="False">
					<dw:RibbonbarButton ID="cmd_CacheSettigns" runat="server" Text="Caching" Image="Refresh" Size="Large" OnClientClick="SmartSearch.EditSmartSearch.get_current().openCacheSettingsDialog();" />
				</dw:RibbonbarGroup>
				
				<dw:RibbonbarGroup ID="RibbonbarGroup2" runat="server" Name="Help">
					<dw:RibbonbarButton ID="cmd_help" runat="server" Text="Help" Image="Help" Size="Large" OnClientClick="onHelp();" />
				</dw:RibbonbarGroup>	
				
			</dw:RibbonbarTab>
        </dw:Ribbonbar>
        
    <div id="content" style="position: relative; overflow: auto;">
        <div id="divWiz" style="z-index: 0; float: left;">
            <dw:Infobar runat="server" ID="LastIndexUpdate" TranslateMessage="false" />
            <dw:GroupBox ID="GroupBox3" runat="server" DoTranslation="true" Title="Configure search">
                <div id="tablesDiv">
		                <table cellpadding="1" cellspacing="1" width="700">
			             <tr>
				            <td style="width: 130px; padding-left:7px;">
					            <dw:TranslateLabel ID="lbName" Text="Name" runat="server" />
				            </td>
			                <td style="width: 570px;">
                                <asp:TextBox ID="txtName" CssClass="std field-name" runat="server" />
                            </td>
			            </tr>
                        <tr>
				            <td style="height:28px; padding-left:7px;">
					            <dw:TranslateLabel ID="lbDataProvider" Text="Data provider" runat="server" />
				            </td>
			                <td>
                               <B><dw:TranslateLabel ID="lbDataProviderType" runat="server" /></B>
                            </td>
			            </tr>
			             <tr><td colspan="2" style="height:5px;"></td></tr>
			             <tr>
				            <td colspan="2">
                                <asp:PlaceHolder ID="SmartSearchRulesEditor" runat="server"></asp:PlaceHolder>
                            </td>
			            </tr>
			             <tr>
				            <td style="vertical-align:bottom; padding-left:7px;">
                                <dw:TranslateLabel ID="lbLimitText" Text="Rows to fetch" runat="server" />
				            </td>
				            <td style="height:30px; vertical-align:bottom;">
                                <asp:TextBox CssClass="std field-limit" ID="tbTopRows" MaxLength="15" Width="45" onkeypress="onKeyPress();" runat="server" />
				            </td>
			            </tr>	
			             <tr>
				            <td style="vertical-align:middle; padding-left:7px;">
					            <dw:TranslateLabel ID="lbPrimarySort" Text="Select by (primary)" runat="server" />
				            </td>
			                <td>
                                <asp:DropDownList ID="primarySortColumn" AutoPostBack="false" CssClass="NewUIinput" Width="180" runat="server" />
                                &nbsp;&nbsp;
                                <asp:DropDownList ID="primarySortType" CssClass="NewUIinput" Width="100" runat="server" />
                            </td>
			            </tr>
			             <tr>
				            <td style="vertical-align:middle; padding-left:7px;">
					            <dw:TranslateLabel ID="lbSecondarySort" Text="Select by (secondary)" runat="server" />
				            </td>
			                <td>
                                <asp:DropDownList ID="secondarySortColumn" CssClass="NewUIinput" Width="180" runat="server" />
                                &nbsp;&nbsp;
                                <asp:DropDownList ID="secondarySortType" CssClass="NewUIinput" Width="100" runat="server" />
                            </td>
			            </tr>
                        <tr><td colspan="2" style="height:20px;"></td></tr> 
                        </table>
                </div>			        
            </dw:GroupBox>
        </div>
    </div>

    <div id="PreviewLayer" style="z-index: 500; display:none; position: relative; overflow:hidden; height:1px; width:100%; background-color:White; border-top:2px solid #6593CF; border-bottom:1px solid #6593CF;">
        <div id="PreviewContent" style="height: 100%;">
            <iframe id="PreviewFrame" width="100%" height="100%"></iframe>
        </div>
    </div>
        
    <iframe src="about:blank" id="ContentSaveFrame" name="ContentSaveFrame" width="50%" frameborder="0" height="0" style="height: 0px;"></iframe>
    
    </form>

    <dw:Dialog ID="CacheSettingsDlg" runat="server" Title="Caching" ShowOkButton="true" ShowClose="true" OkAction="SmartSearch.EditSmartSearch.get_current().saveCacheSettings();">
        <fieldset class="cacheSettings">
            <legend class="gbTitle"><%=Translate.Translate("Caching")%></legend>
            <div>
                <div class="cacheSettings">
                    <label for="EnableCachinChkbox">
				        <dw:TranslateLabel ID="EnableCachingLbl" runat="server" Text="Enable Caching" />
			        </label>
                </div>
                <div class="cacheSettings">
                    <dw:CheckBox ID="EnableCachinChkbox" runat="server" AttributesParm="onclick='setDisabledCacheTimeSelector(this);'" />
                </div>
            </div>
            <div>
                <div class="cacheSettings">
                    <label for="CachingIntervalSelector">    
			            <dw:TranslateLabel ID="CachingTimeLbl" runat="server" Text="Calculate every" />	
			        </label>		
                </div>
                <div class="cacheSettings">
                    <select ID="CachingIntervalSelector" runat="server">
                        <option label="10 minutes" value="10" />
                        <option label="20 minutes" value="20" />
                        <option label="30 minutes" value="30" />
                        <option label="1 hour" value="60" />
                        <option label="2 hours" value="120" />
                        <option label="3 hours" value="180" />
                        <option label="4 hours" value="240" />
                        <option label="5 hours" value="300" />
                        <option label="10 hours" value="600" />
                        <option label="1 day" value="1440" />
                    </select>
                </div>
		    </div>
        </fieldset>
	</dw:Dialog>

    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</body>
</html>