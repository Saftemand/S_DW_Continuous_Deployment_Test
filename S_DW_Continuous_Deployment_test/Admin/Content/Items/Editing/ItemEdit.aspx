<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ItemEdit.aspx.vb" Inherits="Dynamicweb.Admin.ItemEdit" EnableViewState="false" ValidateRequest="false" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title></title>
        <dw:ControlResources CombineOutput="false" IncludePrototype="true" IncludeScriptaculous="true" runat="server">
            <Items>
                <dw:GenericResource Url="/Admin/Content/Items/js/Default.js" />
                <dw:GenericResource Url="/Admin/Content/JsLib/dw/Utilities.js" />
                <dw:GenericResource Url="/Admin/Content/JsLib/dw/Validation.js" />
                <dw:GenericResource Url="/Admin/Content/Items/js/ItemEdit.js" />
                <dw:GenericResource Url="/Admin/Content/Items/css/Default.css" />
                <dw:GenericResource Url="/Admin/Content/Items/css/ItemEdit.css" />
            </Items>
        </dw:ControlResources>
        
        <% If OMCIsInstalled Then%>
        <script type="text/javascript" src="/Admin/Module/OMC/Experiments/Controls.js"></script>
        <script type="text/javascript">
            window.g_splitTestObj = createSplitTestObj(<%=TargetPage.ID%>, <%=NoContent.ToString().ToLower()%>)
        </script>
        <%End If%>

        <script type="text/javascript">
            var ElemCounter;

            function ShowCounters(field, counter, counterMax) {
                HideCounter();

                if (field == 'undefined') return;

                var elemCounter = document.getElementById(counter);
                if (elemCounter == 'undefined') return;

                var elemCounterMax = document.getElementById(counterMax);
                if (elemCounterMax == 'undefined') return;

                ShowCounter(elemCounter, elemCounterMax.value, field.value.length);
                ElemCounter = elemCounter;

            }

            function HideCounter() {
                if (ElemCounter) {
                    setTextContent(ElemCounter, '');
                }
            }

            function CheckAndHideCounter(field, counter, counterMax) {
                if (CheckCounter(field, counter, counterMax) == true) {
                    HideCounter();
                }
            }

            function CheckCounter(field, counter, counterMax) {
                if (field == 'undefined') return false;

                var elemCounter = document.getElementById(counter);
                if (elemCounter == 'undefined') return false;

                var elemCounterMax = document.getElementById(counterMax);
                if (elemCounterMax == 'undefined') return false;

                ShowCounter(elemCounter, elemCounterMax.value, field.value.length);
                return true;
            }

            function ShowCounter(elemCounter, maxSize, currentSize) {
                if (currentSize < maxSize) {
                    setTextContent(elemCounter, (maxSize - currentSize) + ' ' + '<%=Translate.JsTranslate("remaining before recommended maximum")%>');
                }
                else {
                    setTextContent(elemCounter, '<%=Translate.JsTranslate("recommended maximum exceeded")%>');
                }

                var sizeInPercentage = 100;
                if (maxSize > 0) {
                    sizeInPercentage = currentSize * 100 / maxSize;
                }

                if (sizeInPercentage < 80) {
                    elemCounter.style.color = '#7F7F7F';
                }
                else if (sizeInPercentage < 90) {
                    elemCounter.style.color = '#000000';
                }
                else {
                    elemCounter.style.color = '#FF0000';
                }
            }

            function setTextContent(element, text) {
                if (element) {
                    element.innerHTML = text || '&nbsp;';
                }
            }

            function reloadSMP(id)
            {
                <%=Me.pupCreateMessage.ClientInstanceName%>.set_contentUrl('/Admin/Module/OMC/SMP/EditMessage.aspx?popup=true&ID=' + id +'&pagePublish=true');
                <%=Me.pupCreateMessage.ClientInstanceName%>.reload();
            }

            function showSMP()
            {
                var name = encodeURIComponent('<%=TargetPage.MenuText%>');
                var desc = encodeURIComponent('<%=TargetPage.Description%>');
                var link = encodeURIComponent('<%=GetPageUrl()%>');
                <%=Me.pupCreateMessage.ClientInstanceName%>.set_contentUrl('/Admin/Module/OMC/SMP/EditMessage.aspx?popup=true&name=' + name + '&desc=' + desc + '&link=' + link +'&pagePublish=true');
                <%=Me.pupCreateMessage.ClientInstanceName%>.show();
            }

            function hideSMP()
            {
                <%=Me.pupCreateMessage.ClientInstanceName%>.hide();
            }

            $(document).observe('keydown', function (e) {
                if (e.keyCode == 13) {
                    var srcElement = e.srcElement ? e.srcElement : e.target;
                    if (srcElement.type != 'textarea') {
                        e.preventDefault();
                        Dynamicweb.Items.ItemEdit.get_current().save();
                    }
                }
            });

            
        </script>
    </head>
    <body>
        <form id="MainForm" enableviewstate="false" runat="server">
            <dw:Overlay ID="PleaseWait" runat="server" />

            <input type="hidden" id="hClose" name="Close" value="False" />

            <div id="menu" style="min-width: 1000px;">
                <dw:RibbonBar runat="server" ID="myribbon">
                    <dw:RibbonBarTab Name="Menupunkt" runat="server">
                        <dw:RibbonBarGroup Name="Funktioner" runat="server">
                            <dw:RibbonbarButton Text="Gem" Size="Small" Image="Save" KeyboardShortcut="ctrl+s" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().save();" runat="server" />
					        <dw:RibbonbarButton Text="Gem og luk" Size="Small" Image="SaveAndClose" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().saveAndClose();" runat="server" />
					        <dw:RibbonbarButton Text="Annuller" Size="Small" Image="Cancel" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().cancel();" runat="server" />
                        </dw:RibbonBarGroup>
                        <dw:RibbonbarGroup Name="Show" runat="server">
                            <dw:RibbonbarButton Text="Show page" Image="Preview" Size="Large" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().showItem();" runat="server" />
                        </dw:RibbonbarGroup>
				        <dw:RibbonbarGroup ID="groupView" Name="Content" runat="server">
				            <dw:RibbonbarRadioButton ID="cmdViewItem" Group="GroupView" Size="Large" ImagePath="/Admin/Images/Ribbon/Icons/document_ok.png" Text="Page"  Checked="true" runat="server" />
				            <dw:RibbonbarRadioButton ID="cmdViewParagraphs" Group="GroupView" Size="Large" Image="Document" Text="Paragraphs" runat="server" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().switchToParagraphs();" />
				            <dw:RibbonbarRadioButton ID="cmdEdit" runat="server" Size="Large" Text="Frontend editering" Image="EditDocument" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().openFrontendEditing();" />
				        </dw:RibbonbarGroup>
                        <dw:RibbonBarGroup ID="groupVersioning" runat="server" Name="Versioning">
                            <dw:RibbonBarCheckbox ID="cmdUseDraft" runat="server" Checked="false" Text="Use draft" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_notebook.png" OnClientClick="Dynamicweb.Items.VersionControl.get_current().useDraft();"></dw:RibbonBarCheckbox>
                            <dw:RibbonBarButton ID="cmdShowDraft" runat="server" Size="Small" Text="Vis kladde" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_zoom_in.png" OnClientClick="Dynamicweb.Items.VersionControl.get_current().previewPage();"></dw:RibbonBarButton>
                            <dw:RibbonBarButton ID="cmdCompare" runat="server" Size="Small" Text="Compare" ImagePath="/Admin/Images/Ribbon/Icons/Small/window_split_hor.png" OnClientClick="Dynamicweb.Items.VersionControl.get_current().previewComparePage();"></dw:RibbonBarButton>
                            <dw:RibbonBarButton ID="cmdPublish" runat="server" Size="Small" Text="Approve" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_ok.png" OnClientClick="Dynamicweb.Items.VersionControl.get_current().startWorkflow(true);"></dw:RibbonBarButton>
                            <dw:RibbonBarButton ID="cmdDiscardChanges" runat="server" Size="Small" Text="Discard changes" ImagePath="/Admin/Images/Ribbon/Icons/Small/door.png" OnClientClick="Dynamicweb.Items.VersionControl.get_current().discardChanges();"></dw:RibbonBarButton>
                            <dw:RibbonBarButton ID="cmdStartWorkflow" ModuleSystemName="Workflow" runat="server" Size="Small" Text="Start godkendelse" ImagePath="/Admin/Images/Ribbon/Icons/Small/users_into.png" OnClientClick="Dynamicweb.Items.VersionControl.get_current().startWorkflow(false);"></dw:RibbonBarButton>
                            <dw:RibbonBarButton ID="cmdShowPreviousVersions" ModuleSystemName="VersionControl" runat="server" Size="Small" Text="Tidligere versioner" ImagePath="/Admin/Images/Ribbon/Icons/Small/users_into.png" OnClientClick="Dynamicweb.Items.VersionControl.get_current().previewBydateShow(false);"></dw:RibbonBarButton>
                            <dw:RibbonBarButton ID="Versions" runat="server" ModuleSystemName="VersionControl" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/Documents.png" Text="Versions" Visible="true" OnClientClick="Dynamicweb.Items.VersionControl.get_current().ShowVersions();"></dw:RibbonBarButton>
                        </dw:RibbonBarGroup>
                        <dw:RibbonbarGroup Name="Side" runat="server">
					        <dw:RibbonbarButton ID="cmdNewSubPage" Size="Small" Text="Ny underside" Image="Paragraph" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().newSubPage();" runat="server" />
					        <dw:RibbonbarButton ID="cmdPageProperties" Size="Small" Text="Egenskaber" Image="DocumentProperties" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().pageProperties();" runat="server" />
					        <dw:RibbonbarButton ID="cmdDeletePage" Size="Small" Text="Slet side" Image="DeleteDocument" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().deletePage();" runat="server" />
					        <dw:RibbonBarRadioButton ID="cmdPublished" Checked="false" Group="Publishing" Text="Publiceret" Imagepath="/Admin/Images/Ribbon/Icons/Small/document_ok.png" Value="0" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().setPagePublished('published');" runat="server" />
					        <dw:RibbonBarRadioButton ID="cmdHideInNavigation" Checked="false" Group="Publishing" Text="Hide in menu" Imagepath="/Admin/Images/Ribbon/Icons/Small/document_plain_red.png" Value="2" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().setPagePublished('hideInMenu');" runat="server" />
					        <dw:RibbonBarRadioButton ID="cmdHidden" Checked="false" Group="Publishing" Text="Unpublished" Imagepath="/Admin/Images/Ribbon/Icons/Small/document_forbidden.png" Value="1" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().setPagePublished('unpublished');" runat="server" />
				        </dw:RibbonbarGroup>
                        <dw:RibbonbarGroup ID="PrimaryLanugageSelectorGrp" runat="server" Name="Sprog" Visible="false">
					        <dw:RibbonBarButton ID="languageSelector" runat="server" Active="false" ImagePath="/Admin/Images/Flags/flag_dk.png" Disabled="false" Size="Large" Text="Sprog" ContextMenuId="languageSelectorContext"></dw:RibbonBarButton>
				        </dw:RibbonbarGroup>
                        <dw:RibbonbarGroup Name="Help" runat="server">
					        <dw:RibbonbarButton Text="Help" Image="Help" Size="Large" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().help();" runat="server" />
				        </dw:RibbonbarGroup>
                    </dw:RibbonBarTab>
                    <dw:RibbonBarTab Name="Funktioner" runat="server">
                        <dw:RibbonbarGroup runat="server" Name="Optimering">
				            <dw:RibbonbarButton ID="cmdValidate" Image="CheckDocument" Text="Validate markup" Size="small" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().showValidationResults();" runat="server" />
					        <dw:RibbonbarButton runat="server" Size="small" Text="Metadata" ImagePath="/Admin/Images/Ribbon/Icons/Small/TextCode.png" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().pageMetadata();" />
                            <dw:RibbonbarButton ID="cmdSaveAsTemplate" runat="server" Size="small" Text="Save as template" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_new.png" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().saveAsTemplate();"></dw:RibbonbarButton>
				        </dw:RibbonbarGroup>

                        <dw:RibbonbarGroup Name="Rapporter" Visible="true" runat="server">
					        <dw:RibbonbarButton ID="cmdReportPageviews" Size="Small" Text="Sidevisninger" ImagePath="/Admin/Images/Ribbon/Icons/Small/line-chart.png" ContextmenuId="ReportPageviewOptions" runat="server" />
				            <dw:RibbonbarButton ID="cmdReportKeywords" ImagePath="/Admin/Images/Ribbon/Icons/Small/pie-chart.png" Text="Søgeord" Size="small" ContextMenuId="ReportSearchEnginePhrasesOptions" runat="server" />
				            <dw:RibbonbarButton ID="cmdReportSearchEngines" ImagePath="/Admin/Images/Ribbon/Icons/Small/chart.png" Text="Referers fra søgemaskiner" Size="small" ContextMenuId="ReportSearchEngineOptions" runat="server" />
					        <dw:RibbonbarButton Size="small" Text="Traffic" ImagePath="/Admin/Images/Ribbon/Icons/Small/dot-chart.png" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().report('Traffic');" runat="server" />
				            <dw:RibbonbarButton Size="small" Text="Page performance" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_new.png" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().report('PagePerformance');" runat="server" />
				            <dw:RibbonbarButton ID="cmdWebPageAnalysis" Size="small" Text="Webpage Analysis" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_info.png" runat="server" />
				        </dw:RibbonbarGroup>
                    </dw:RibbonBarTab>
                    <dw:RibbonBarTab ID="tabMarketing" Active="false" Name="Marketing" Visible="false" runat="server">
                        <dw:RibbonBarGroup ID="groupMarketingRestrictions" Name="Split test" runat="server">
                            <dw:RibbonBarButton ID="ExperimentSetupBtn" Text="Setup split test" Size="Large" ImagePath="/Admin/Images/Ribbon/Icons/branch_element_new.png" OnClientClick="g_splitTestObj.ExperimentSetup();" runat="server" />
                            <dw:RibbonBarButton ID="ExperientPreviewBtn" Text="Preview" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/branch_view.png" OnClientClick="g_splitTestObj.ExperimentPreview();" runat="server" Disabled="True" />
                            <dw:RibbonBarButton ID="ExperientSettingsBtn" Text="Settings" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/branch_edit.png" OnClientClick="g_splitTestObj.ExperimentSetup();" runat="server" Disabled="True" />
                            <dw:RibbonBarButton ID="ExperientViewReportBtn" Text="View report" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/line-chart.png" OnClientClick="g_splitTestObj.ExperimentReport();" runat="server" Disabled="True" />
                            <dw:RibbonBarButton ID="ExperimentStart" Text="Start" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/media_play_green.png" OnClientClick="g_splitTestObj.ExperimentStart();" runat="server" Disabled="True" />
                            <dw:RibbonBarButton ID="ExperimentPause" Text="Pause" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/media_pause.png" OnClientClick="g_splitTestObj.ExperimentPause();" runat="server" Disabled="True" />
                            <dw:RibbonBarButton ID="ExperientStopBtn" Text="Stop" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/media_stop_red.png" OnClientClick="g_splitTestObj.ExperimentDelete();" runat="server" Disabled="True" />
                        </dw:RibbonBarGroup>
                        <dw:RibbonBarGroup ID="rbgSMP" Name="Social publishing" runat="server">
                            <dw:RibbonBarButton ID="rbPublish" Text="Publish" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/users_family.png" OnClientClick="showSMP();" runat="server" />
                        </dw:RibbonBarGroup>
                    </dw:RibbonBarTab>
                </dw:RibbonBar>
            </div>
            <div id="breadcrumb" runat="server">
                <%=GetBreadcrumb(TargetPage.ID, True)%>
            </div>
            <div id="content">
                <div id="content-inner">
                    <asp:Literal ID="litFields" runat="server" />
                </div>
                <dw:Infobar runat="server" ID="unpublishedContentInfo" Type="Information" Message="This page has unpublished changes" Title="Publish" Visible="false" Action="Ribbon.checkBox('cmdUseDraft');Dynamicweb.Items.VersionControl.get_current().useDraft();//startWorkflow(false);">
                </dw:Infobar>
            </div>
            <div id="footer">
                <table border="0">
                    <tr>
                        <td rowspan="2"><img class="icon" src="/Admin/Images/Ribbon/Icons/Document_ok.png" alt="" title="" /></td>

                        <td class="label"><div><dw:TranslateLabel Text="Name" runat="server" />:</div></td>
                        <td class="value bold"><div><%=TargetPage.MenuText%></div></td>
                        <td class="label"><div><dw:TranslateLabel Text="Item type" runat="server" />:</div></td>
                        <td class="value"><div><%=TargetItemMeta.Name%></div></td>
                        <td class="label"><div><dw:TranslateLabel Text="Created" runat="server" />:</div></td>
                        <td class="value"><div><%=TargetPage.CreatedDate.ToString("ddd, dd MMM yyyy HH':'mm", Dynamicweb.Base.GetCulture())%></div></td>
                        <td class="label"><div><dw:TranslateLabel Text="Template" runat="server" />:</div></td>
                        <td class="value"><div class="large"><%=TatgetItemLayout%></div></td>
                    </tr>
                    <tr class="sub">
                        <td class="label"><div><dw:TranslateLabel Text="ID" runat="server" />:</div></td>
                        <td class="value"><div><%=String.Format("{0} ({1})", TargetPage.ID, If(IsNothing(TargetItem), "0", TargetItem.Id))%></div></td>
                        <td class="label"><div><dw:TranslateLabel Text="URL" runat="server" />:</div></td>
                        <td class="value"><div><%=GetPageUrl()%></div></td>
                        <td class="label"><div><dw:TranslateLabel Text="Edited" runat="server" />:</div></td>
                        <td class="value"><div><%=TargetPage.UpdatedDate.ToString("ddd, dd MMM yyyy HH':'mm", Dynamicweb.Base.GetCulture())%></div></td>
                        <td colspan="2"></td>
                    </tr>
                </table>
            </div>
        </form>

        <dw:PopUpWindow ID="webPageAnalysisDialog" UseTabularLayout="true" AutoReload="true" Width="600" Height="400"
            Title="Report" TranslateTitle="true" ContentUrl="" HidePadding="true" runat="server" AutoCenterProgress="true" ShowOkButton="false" ShowCancelButton="false" ShowClose="true" />

		<dw:Dialog ID="ReportsDialog" runat="server" Title="Rapport" HidePadding="true" Width="534">
		    <iframe id="ReportsFrame" style="width: 100%; height: 450px; border: solid 0px red;" src="about:blank" frameborder="0"></iframe>
		</dw:Dialog>

        <dw:PopUpWindow ID="dblPageValidation" UseTabularLayout="true" AutoReload="true" Width="550" Height="400" runat="server"
            Title="Validate markup" TranslateTitle="true" ContentUrl="" AutoCenterProgress="true" ShowOkButton="true" ShowCancelButton="false" ShowClose="true" />

        <dw:PopUpWindow ID="pupCreateMessage" SnapToScreen="True" UseTabularLayout="true" AutoReload="true" Width="720" Height="580" iframeHeight="530" 
            Title="Publish page to social media" TranslateTitle="true" ContentUrl="" HidePadding="true" runat="server" AutoCenterProgress="true" ShowOkButton="false" ShowCancelButton="false" ShowClose="true" />

        <dw:Dialog ID="MetaDialog" Width="518" runat="server" Title="Metadata" ShowOkButton="true" ShowCancelButton="true" ShowClose="false" CancelAction="Dynamicweb.Items.ItemEdit.get_current().pageMetadataClose();" OkAction="Dynamicweb.Items.ItemEdit.get_current().pageMetadataSave();">
		    <table border="0">
			    <tr>
				    <td width="170" valign="top">
					    <dw:TranslateLabel Text="Titel" runat="server" />
				    </td>
				    <td valign="top">
					    <input type="text" id="PageDublincoreTitle" name="PageDublincoreTitle" size="30" class="NewUIinput" runat="server" style="width: 300px; margin-bottom:1px;" 
                            onfocus="ShowCounters(this,'PageDublincoreTitleCounter','PageDublincoreTitleCounterMax');" 
					        onkeyup="CheckCounter(this,'PageDublincoreTitleCounter','PageDublincoreTitleCounterMax');"  
                            onblur="CheckAndHideCounter(this,'PageDublincoreTitleCounter','PageDublincoreTitleCounterMax');"
                        />
				    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
				        <strong id="PageDublincoreTitleCounter" class="char-counter">&nbsp;</strong>
				        <input type="hidden" id="PageDublincoreTitleCounterMax" name="PageDublincoreTitleCounterMax" runat="server"/>
                        <div>&nbsp;</div>
			        </td>
                </tr>
			    <tr>
				    <td valign="top">
					    <dw:TranslateLabel runat="server" Text="Beskrivelse" />
				    </td>
				    <td valign="top">
					    <textarea id="PageDescription" name="PageDescription" cols="30" rows="3" wrap="on" style="width: 300px; height: 60px;" runat="server"
					        onfocus="ShowCounters(this,'PageDescriptionCounter','PageDescriptionCounterMax');" 
					        onkeyup="CheckCounter(this,'PageDescriptionCounter','PageDescriptionCounterMax');"  
					        onblur="CheckAndHideCounter(this,'PageDescriptionCounter','PageDescriptionCounterMax');"
					    ></textarea>
				    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
				        <strong id="PageDescriptionCounter" class="char-counter">&nbsp;</strong>
				        <input type="hidden" id="PageDescriptionCounterMax" name="PageDescriptionCounterMax" runat="server"/>
                        <div>&nbsp;</div>
			        </td>
                </tr>
			    <tr>
				    <td valign="top">
					    <dw:TranslateLabel runat="server" Text="Nøgleord" />
				    </td>
				    <td valign="top">
					    <textarea id="PageKeywords" name="PageKeywords" cols="30" rows="3" wrap="on" style="width: 300px; height: 60px;margin-bottom:1px;" runat="server"
                            onfocus="ShowCounters(this,'PageKeywordsCounter','PageKeywordsCounterMax');" 
					        onkeyup="CheckCounter(this,'PageKeywordsCounter','PageKeywordsCounterMax');"  
					        onblur="CheckAndHideCounter(this,'PageKeywordsCounter','PageKeywordsCounterMax');"
                        ></textarea>
				    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
					    <strong id="PageKeywordsCounter" class="char-counter">&nbsp;</strong>
					    <input type="hidden" id="PageKeywordsCounterMax" name="PageKeywordsCounterMax" runat="server"/>
                        <div>&nbsp;</div>
				    </td>
                </tr>
		    </table>
	    </dw:Dialog>

	<dw:Dialog ID="SaveAsTemplateDialog" runat="server" Title="Save as template" ShowOkButton="true" ShowCancelButton="true" ShowClose="false" CancelAction="Dynamicweb.Items.ItemEdit.get_current().SaveAsTemplateCancel();" OkAction="Dynamicweb.Items.ItemEdit.get_current().SaveAsTemplateOk();">
		<table border="0" style="width:350px;">
			<tr>
				<td style="width:100px;"><dw:TranslateLabel ID="TranslateLabel10" runat="server" Text="Navn" /></td>
				<td><input type="text" runat="server" id="TemplateName" name="TemplateName" class="NewUIinput" maxlength="255" />
				</td>
			</tr>
			<tr><td style="height:3px;"></td></tr>
			<tr>
				<td><dw:TranslateLabel ID="TranslateLabel9" runat="server" Text="Beskrivelse" /></td>
				<td><input type="text" runat="server" id="TemplateDescription" name="TemplateDescription" class="NewUIinput" maxlength="255" />
				</td>
			</tr>
			<tr><td style="height:3px;"></td></tr>
			<tr id="isTemplateRow" runat="server" visible="false">
				<td></td>
				<td>
					<dw:CheckBox ID="isTemplate" runat="server" Value="1" SelectedFieldValue="1" />
					<label for="isTemplate">
						<dw:TranslateLabel ID="TranslateLabel11" runat="server" Text="Aktiv" />
					</label>
				</td>
			</tr>
		</table>
		<br />
		<br />
	</dw:Dialog>

        <dw:Dialog ID="QuitDraftDialog" runat="server" SnapToScreen="True" Title="Quit draft" ShowOkButton="true" ShowCancelButton="true" ShowClose="false" CancelAction="Dynamicweb.Items.VersionControl.get_current().quitDraftCancel();" OkAction="Dynamicweb.Items.VersionControl.get_current().quitDraftOk();">
            <img src="/Admin/Images/Ribbon/Icons/warning.png" alt="" style="vertical-align: middle;" />
            <dw:TranslateLabel ID="TranslateLabel8" runat="server" Text="This page has unpublished content. What do you want to do?" />
            <br />
            <br />
            <table border="0" style="width: 150px;">
                <tr>
                    <td>
                        <dw:RadioButton ID="QuitDraftPublish" runat="server" FieldName="QuitDraft" FieldValue="Publish" SelectedFieldValue="Publish" />
                    </td>
                    <td>
                        <img src="/Admin/Images/Ribbon/Icons/Small/document_ok.png" alt="" style="vertical-align: middle;" /></td>
                    <td>
                        <label for="QuitDraftPublish">
                            <dw:TranslateLabel ID="TranslateLabel7" runat="server" Text="Publish" />
                        </label>
                    </td>
                </tr>
                <tr>
                    <td style="height: 3px;"></td>
                </tr>
                <tr>
                    <td>
                        <dw:RadioButton ID="QuitDraftDiscard" runat="server" FieldName="QuitDraft" FieldValue="Discard" />
                    </td>
                    <td>
                        <img src="/Admin/Images/Ribbon/Icons/Small/door.png" alt="" style="vertical-align: middle;" /></td>
                    <td>
                        <label for="QuitDraftDiscard">
                            <dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="Discard changes" />
                        </label>
                    </td>
                </tr>
            </table>

            <br />

            <br />
        </dw:Dialog>

        <dw:Dialog ID="PreviewByDateDialog" runat="server" SnapToScreen="True" Title="Show previous version" ShowCancelButton="true" ShowOkButton="true" ShowClose="true" OkAction="Dynamicweb.Items.VersionControl.get_current().previewBydate();">
            <table border="0" style="width: 450px;">
                <tr>
                    <td>
                        <dw:TranslateLabel ID="TranslateLabel15" runat="server" Text="Dato" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <dw:DateSelector ID="DateSelector1" runat="server" AllowNeverExpire="false" AllowNotSet="false" />
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </dw:Dialog>

        <dw:Dialog ID="VersionsDialog" runat="server" SnapToScreen="True"  Title="Versioner" HidePadding="true" Width="600">
            <iframe id="VersionsFrame" src="/Admin/Content/ParagraphVersions.aspx?PageID=<%=Me.TargetPage.ID%>" style="width: 100%; height: 300px; border: solid 0px red;" src="about:blank" frameborder="0"></iframe>
        </dw:Dialog>
        <script type="text/javascript">
            var VersionUrl = '/Admin/Content/ParagraphVersions.aspx?PageID=<%=Me.TargetPage.ID%>';
        </script>

        <dw:ContextMenu ID="ReportPageviewOptions" runat="server">
		    <dw:ContextMenuButton Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/line-chart.png" Text="Dag" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().report('PageviewsDay');" runat="server" />
		    <dw:ContextMenuButton Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/line-chart.png" Text="Uge" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().report('PageviewsWeek');" runat="server" />
		    <dw:ContextMenuButton Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/line-chart.png" Text="Måned" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().report('PageviewsMonth');" runat="server" />
	    </dw:ContextMenu>

	    <dw:ContextMenu ID="ReportSearchEnginePhrasesOptions" runat="server">
		    <dw:ContextMenuButton Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/pie-chart.png" Text="Phrases" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().report('SearchEnginePhrases');" runat="server" />
		    <dw:ContextMenuButton Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/pie-chart.png" Text="Keywords" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().report('SearchEngineKeywords');" runat="server" />
		    <dw:ContextMenuButton Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/pie-chart.png" Text="Words per phrase" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().report('SearchEnginePhraseWordCount');" runat="server" />
	    </dw:ContextMenu>

	    <dw:ContextMenu ID="ReportSearchEngineOptions" runat="server">
		    <dw:ContextMenuButton Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/chart.png" Text="Top 5 referrers" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().report('SearchEngineReferrers');" runat="server" />
		    <dw:ContextMenuButton Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/chart.png" Text="All referrals" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().report('SearchEngineAllReferrals');" runat="server" />
		    <dw:ContextMenuButton Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/chart.png" Text="Top 5 crawlers" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().report('SearchEngineBotIndex');" runat="server" />
		    <dw:ContextMenuButton Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/chart.png" Text="Indexations over time" OnClientClick="Dynamicweb.Items.ItemEdit.get_current().report('SearchEngineIndexTime');" runat="server" />
	    </dw:ContextMenu>

	    <dw:ContextMenu ID="languageSelectorContext" runat="server" MaxHeight="400">
		
	    </dw:ContextMenu>

        <%Translate.GetEditOnlineScript()%>
        <dw:Dialog ID="OMCExperimentDialog" runat="server" SnapToScreen="True" Width="750" iframeHeight="535" ShowOkButton="false" ShowCancelButton="false" UseTabularLayout="true" Title="Setup split test" IsIFrame="true">
        </dw:Dialog>
    </body>
</html>
