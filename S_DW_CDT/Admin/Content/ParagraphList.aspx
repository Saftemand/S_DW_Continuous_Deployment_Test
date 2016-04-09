<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ParagraphList.aspx.vb" Inherits="Dynamicweb.Admin.ParagraphList1" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls.OMC" TagPrefix="omc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>

    <dw:ControlResources runat="server" IncludePrototype="true" IncludeUtilities="true" IncludeScriptaculous="true">
    </dw:ControlResources>

    <link rel="Stylesheet" href="/Admin/Images/Ribbon/UI/List/List.css" />
    <link rel="Stylesheet" href="ParagraphList.css" />

    <style id="styleNonBrowsing" type="text/css" runat="server">
        .browseHide
        {
            display: none;
        }

        body
        {
            overflow: hidden;
        }

        #_contentWrapper
        {
            position: fixed;
            top: 68px;
            left: 0px;
            bottom: 0px;
            right: 1px;
            overflow: auto;
        }
    </style>
    <style id="RibbonToolbarStyles" runat="server" type="text/css">
        #_contentWrapper
        {
            position: fixed;
            top: 155px;
            left: 0px;
            bottom: 53px;
            right: 1px;
            overflow: auto;
            border-top: 1px solid #BDCCE0;
        }
    </style>
    <style id="SimpleToolbarStyles" runat="server" type="text/css" visible="false">
        #_contentWrapper
        {
            position: fixed;
            top: 68px;
            left: 0px;
            bottom: 53px;
            right: 1px;
            overflow: auto;
            border-top: 1px solid #BDCCE0;
        }
    </style>
    <style id="WorkflowCss" runat="server" type="text/css" visible="false">
        #ShowWorkflow1, #ShowWorkflow2, #ShowWorkflow3
        {
            display: none;
            visibility: hidden;
        }
    </style>
    <style id="CH4" type="text/css" runat="server" visible="false">
        .CH4
        {
            display: none !important;
            visibility: hidden;
        }
    </style>
    <style id="CH5" type="text/css" runat="server" visible="false">
        .CH5
        {
            display: none !important;
            visibility: hidden;
        }
    </style>
    <style id="CH6" type="text/css" runat="server" visible="true">
        .CH6
        {
            display: none !important;
            visibility: hidden;
        }
    </style>
    <style id="CH7" type="text/css" runat="server" visible="true">
        .CH7
        {
            display: none !important;
            visibility: hidden;
        }
    </style>
    
    <% If OMCIsInstalled Then%>
    <script type="text/javascript" src="/Admin/Module/OMC/Experiments/Controls.js"></script>
    <script type="text/javascript">
        window.g_splitTestObj = createSplitTestObj(<%=PageID%>, <%=NoContent.ToString().ToLower()%>)
    </script>
    <%End If%>

    <script src="ParagraphList.js" type="text/javascript"></script>
    <script type="text/javascript">
        var experimentParagraphs = new Array();
        var InternalAllID = '<%=Dynamicweb.Base.Request("caller")%>';
        var deleteMsg = '<%=GetDeleteParagraphMessage()%>';
        pageID = <%=Dynamicweb.Base.ChkInteger(Dynamicweb.Base.Request("PageID"))%>;
            
        ShowParagraphSortingConfirmation = <%= IIf(ShowParagraphSortingConfirmation(), "true", "false") %>;
        ParagraphSortingWarningMsg = '<%=Translate.JsTranslate("Sorting paragraphs on master page will sort on the language versions too. Continue?")%>';

        Dynamicweb.ParagraphList.Translations['ContainerRestriction'] = '<%=Translate.JsTranslate("Containers restriction does not allow to contain specified item.")%>';
        Dynamicweb.ParagraphList.ItemEdit.get_current().set_item({id: '<%=_Page.ItemId%>', type: '<%=_Page.ItemType%>'}); 

        function help() {
            eval($('jsHelp').innerHTML);
        }
		
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

            if (maxSize > 0)
            {
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
            while (element.firstChild !== null) { 
                element.removeChild(element.firstChild); // remove all existing content 
            }
            element.appendChild(document.createTextNode(text)); 
        }
        function openContentRestrictionDialog (params) {
            var p = pageID;

            if (params && params.pageID) {
                p = params.pageID;
            }

            Marketing.openSettings('ContentRestriction', { data: { ItemType: 'Page', ItemID: p} });
        }

        function openProfileDynamicsDialog () {
            Marketing.openSettings('ProfileDynamics', { data: { ItemType: 'Page', ItemID: pageID} });
        }

        function profileVisitPreview() {
            window.open("/Admin/Module/Omc/Profiles/PreviewProfile.aspx?PageID=" + pageID + "&original=" + encodeURIComponent(document.getElementById("previewUrl").value), "_blank", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no");
        }

        function pagePreviewCombined() {
            window.open("/Admin/Content/PreviewCombined.aspx?PageID=" + pageID + "&original=" + encodeURIComponent(document.getElementById("showUrl").value), "_blank", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no");
        }

        function reloadSMP(id)
        {
            <%=Me.pupCreateMessage.ClientInstanceName%>.set_contentUrl('/Admin/Module/OMC/SMP/EditMessage.aspx?popup=true&ID=' + id +'&pagePublish=true');
            <%=Me.pupCreateMessage.ClientInstanceName%>.reload();
        }

        function showSMP()
        {
            var name = encodeURIComponent($('_pagename').innerText);
            var desc = encodeURIComponent($('PageDescription').innerText);
            var link = encodeURIComponent('Default.aspx?ID=' + pageID);
            <%=Me.pupCreateMessage.ClientInstanceName%>.set_contentUrl('/Admin/Module/OMC/SMP/EditMessage.aspx?popup=true&name=' + name + '&desc=' + desc + '&link=' + link +'&pagePublish=true');
            <%=Me.pupCreateMessage.ClientInstanceName%>.show();
        }

        function hideSMP()
        {                 
            <%=Me.pupCreateMessage.ClientInstanceName%>.hide();
        }
    </script>

</head>
<body onload="init(<%=PageID%>);">
    <form id="form1" runat="server">
       <omc:MarketingConfiguration ID="marketConfig" runat="server" />

        <script type="text/javascript">
            var Marketing = <%=marketConfig.ClientInstanceName%>;
        </script>

        <input type="hidden" runat="server" id="previewUrl" />
        <input type="hidden" runat="server" id="showUrl" />
        <input type="hidden" runat="server" id="hasUnpublishedContent" />
        <input type="hidden" runat="server" id="PageParentID" />
        <input type="hidden" runat="server" id="PageApprovalType" />
        <input type="hidden" runat="server" id="AllowParagraphOperations" value="true" />
        <input type="hidden" runat="server" id="NewParagraphsIDs" value="" />
        <input type="hidden" runat="server" id="NewPageID" value="" />
        <input type="hidden" runat="server" id="OldPageState" value="" />
        <input type="hidden" runat="server" id="isOmcExp" value="" />

        <dw:Toolbar runat="server" ID="mytoolbar" ShowStart="true" ShowEnd="false" Visible="false">
            <dw:ToolbarButton runat="server" ID="btn1" Text="Nyt afsnit" Image="AddDocument" OnClientClick="newParagraph();"></dw:ToolbarButton>
            <dw:ToolbarButton runat="server" ID="btn2" Text="Global element" Image="InsertGlobalElement" OnClientClick="insertGlobalElement();"></dw:ToolbarButton>
            <dw:ToolbarButton runat="server" ID="btn3" Text="Vis" Image="Preview" OnClientClick="showPage();" Divide="Before"></dw:ToolbarButton>
            <dw:ToolbarButton runat="server" ID="btn4" Image="CheckDocument" Text="Validate" OnClientClick="showValidationResults();" Divide="Before"></dw:ToolbarButton>
            <dw:ToolbarButton runat="server" ID="btn5" Text="Help" Image="Help" OnClientClick="help();" Divide="Before"></dw:ToolbarButton>
        </dw:Toolbar>

        <h1 id="browseHeading" runat="server" visible="false" class="title">
            <dw:TranslateLabel Text="Vælg" runat="server" />
        </h1>
        <h2 id="browseSubheading" runat="server" visible="false" class="subtitle">
            <dw:TranslateLabel Text="Afsnit" runat="server" />
        </h2>

        <div style="min-width: 1000px; overflow: hidden">
            <dw:RibbonBar runat="server" ID="myribbon">
                <dw:RibbonBarTab Active="true" Name="Indhold" runat="server" ID="tabContent">
                    <dw:RibbonBarGroup runat="server" Name="Indsæt">
                        <dw:RibbonBarButton ID="NewParagraph" runat="server" Size="Small" Text="Nyt afsnit" Image="AddDocument" OnClientClick="newParagraph();" ShowWait="true"></dw:RibbonBarButton>
                        <dw:RibbonBarButton ID="InsertGlobalElement" runat="server" Size="Small" Text="Global element" Image="InsertGlobalElement" OnClientClick="insertGlobalElement();"></dw:RibbonBarButton>
                        <dw:RibbonBarButton ID="cmdSort" Visible="false" runat="server" ImagePath="/Admin/Images/Ribbon/Icons/Small/sort_ascending.png" Active="false" Disabled="false" Size="Small" Text="Sorter" OnClientClick="location = '/Admin/Paragraph/Paragraph_SortAll.aspx?PageID=' + pageID;"></dw:RibbonBarButton>
                        <%--<dw:RibbonbarButton ID="cmdInsertModule" runat="server" Size="Small" Text="Module" Image="Module" OnClientClick="insertModule();">
					</dw:RibbonbarButton>--%>
                    </dw:RibbonBarGroup>

                    <dw:RibbonBarGroup Name="Show" runat="server">
                        <dw:RibbonBarButton ID="cmdShowpage" runat="server" Size="Large" Text="Vis side" Image="Preview" OnClientClick="showPage();" />
                    </dw:RibbonBarGroup>

                    <dw:RibbonBarGroup ID="RibbonbarGroup4" runat="server" Name="Indhold">
                        <dw:RibbonBarRadioButton ID="cmdViewItem" Visible="false" Group="GroupView" Size="Large" ImagePath="/Admin/Images/Ribbon/Icons/document_ok.png" Text="Page" OnClientClick="switchToItem();" runat="server" />
                        <dw:RibbonBarRadioButton ID="cmdViewParagraphs" Visible="false" Group="GroupView" Size="Large" Image="Document" Text="Paragraphs" Checked="true" runat="server" />
                        <dw:RibbonBarCheckbox ID="cmdUseDraft" runat="server" Checked="false" Text="Use draft" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_notebook.png" OnClientClick="useDraft();"></dw:RibbonBarCheckbox>
                        <dw:RibbonBarButton ID="cmdShowDraft" runat="server" Size="Small" Text="Vis kladde" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_zoom_in.png" OnClientClick="previewPage();"></dw:RibbonBarButton>
                        <dw:RibbonBarButton ID="cmdCompare" runat="server" Size="Small" Text="Compare" ImagePath="/Admin/Images/Ribbon/Icons/Small/window_split_hor.png" OnClientClick="previewComparePage();"></dw:RibbonBarButton>
                        <dw:RibbonBarButton ID="cmdPublish" runat="server" Size="Small" Text="Approve" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_ok.png" OnClientClick="startWorkflow(true);"></dw:RibbonBarButton>
                        <dw:RibbonBarButton ID="cmdDiscardChanges" runat="server" Size="Small" Text="Discard changes" ImagePath="/Admin/Images/Ribbon/Icons/Small/door.png" OnClientClick="discardChanges();"></dw:RibbonBarButton>
                        <dw:RibbonBarButton ID="cmdStartWorkflow" ModuleSystemName="Workflow" runat="server" Size="Small" Text="Start godkendelse" ImagePath="/Admin/Images/Ribbon/Icons/Small/users_into.png" OnClientClick="startWorkflow(false);"></dw:RibbonBarButton>
                        <dw:RibbonBarButton ID="cmdShowPreviouesVersions" Version="19.1.0.0" ModuleSystemName="VersionControl" runat="server" Size="Small" Text="Tidligere versioner" ImagePath="/Admin/Images/Ribbon/Icons/Small/users_into.png" OnClientClick="previewBydateShow(false);"></dw:RibbonBarButton>
                        <dw:RibbonBarButton ID="Versions" runat="server" Version="19.1.0.0" ModuleSystemName="VersionControl" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/Documents.png" Text="Versions" Visible="true" OnClientClick="ShowVersions();"></dw:RibbonBarButton>
                        <dw:RibbonBarButton ID="cmdEdit" runat="server" Size="Small" Text="Frontend editering" Image="EditDocument" OnClientClick="openFrontendEditing();">
                        </dw:RibbonBarButton>
                    </dw:RibbonBarGroup>

                    <dw:RibbonBarGroup runat="server" Name="Side">
                        <dw:RibbonBarButton runat="server" ID="cmdNewSubPage" Size="Small" Text="Ny underside" Image="Paragraph" OnClientClick="newSubpage();" ShowWait="true"></dw:RibbonBarButton>
                        <dw:RibbonBarButton runat="server" Size="Small" Text="Egenskaber" Image="DocumentProperties" OnClientClick="pageProperties2();" ShowWait="true"></dw:RibbonBarButton>
                        <dw:RibbonBarButton ID="RibbonBarDeletePage" runat="server" Size="Small" Text="Slet side" Image="DeleteDocument" OnClientClick="deletePage();"></dw:RibbonBarButton>
                        <dw:RibbonBarRadioButton ID="cmdPublished" runat="server" Checked="false" Group="Publishing" Text="Publiceret" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_ok.png" Value="0" OnClientClick="publish()"></dw:RibbonBarRadioButton>
                        <dw:RibbonBarRadioButton ID="cmdHideInNavigation" runat="server" Checked="false" Group="Publishing" Text="Hide in menu" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_plain_red.png" Value="2" OnClientClick="unPublishHide()"></dw:RibbonBarRadioButton>
                        <dw:RibbonBarRadioButton ID="cmdHidden" runat="server" Checked="false" Group="Publishing" Text="Unpublished" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_forbidden.png" Value="1" OnClientClick="unPublish()"></dw:RibbonBarRadioButton>
                    </dw:RibbonBarGroup>

                    <dw:RibbonBarGroup ID="PrimaryLanugageSelectorGrp" runat="server" Name="Sprog" Visible="false">
                        <dw:RibbonBarButton ID="languageSelector" runat="server" Active="false" ImagePath="/Admin/Images/Flags/flag_dk.png" Disabled="false" Size="Large" Text="Sprog" ContextMenuId="languageSelectorContext"></dw:RibbonBarButton>
                    </dw:RibbonBarGroup>

                    <dw:RibbonBarGroup runat="server" Name="Help">
                        <dw:RibbonBarButton runat="server" Text="Help" Image="Help" OnClientClick="help();"></dw:RibbonBarButton>
                    </dw:RibbonBarGroup>

                </dw:RibbonBarTab>

                <dw:RibbonBarTab ID="RibbonbarTab2" Active="false" Name="Funktioner" runat="server">
                    <dw:RibbonBarGroup ID="RibbonbarGroup1" runat="server" Name="Afsnit">
                        <dw:RibbonBarButton runat="server" Text="Kopier" ID="CopyParagraphs" Size="Small" Image="Copy" Disabled="true" OnClientClick="copyParagraphs();"></dw:RibbonBarButton>
                        <dw:RibbonBarButton runat="server" Text="Kopier hertil" ID="CopyParagraphsHere" Size="Small" Image="Copy" Disabled="true" OnClientClick="copyParagraphsHere();"></dw:RibbonBarButton>
                        <dw:RibbonBarButton runat="server" Text="Flyt" ID="MoveParagraphs" Size="Small" Image="MoveDocument" Disabled="true" OnClientClick="moveParagraphs();"></dw:RibbonBarButton>
                        <dw:RibbonBarButton runat="server" Text="Slet" ID="DeleteParagraphs" Size="Small" Image="DeleteDocument" Disabled="true" OnClientClick="deleteParagraphs();"></dw:RibbonBarButton>
                        <dw:RibbonBarButton runat="server" Text="Medtag" ID="IncludeParagraphs" Size="Small" Image="Check" Disabled="true" OnClientClick="toggleActiveAll();"></dw:RibbonBarButton>
                    </dw:RibbonBarGroup>

                    <dw:RibbonBarGroup ID="grpPreview" runat="server" Name="Preview">
                        <dw:RibbonBarButton runat="server" ID="PreviewPage" Text="Preview" Image="Preview" OnClientClick="pagePreviewCombined();"></dw:RibbonBarButton>
                    </dw:RibbonBarGroup>

                    <dw:RibbonBarGroup ID="RibbonbarGroup5" runat="server" Name="Optimering">
                        <dw:RibbonBarButton ID="btnSeo" ModuleSystemName="Seo" runat="server" Size="small" Text="Optimize" Image="Seo" OnClientClick="optimize();"></dw:RibbonBarButton>
                        <dw:RibbonBarButton ID="cmdValidate" Image="CheckDocument" Text="Validate markup" Size="small" OnClientClick="showValidationResults();" runat="server"></dw:RibbonBarButton>
                        <dw:RibbonBarButton ID="cmdSaveAsTemplate" runat="server" Size="small" Text="Save as template" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_new.png" OnClientClick="saveAsTemplate();"></dw:RibbonBarButton>
                        <dw:RibbonBarButton ID="cmdEditTemplateSettings" runat="server" Size="small" Text="Template settings" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_new.png" OnClientClick="saveAsTemplate();"></dw:RibbonBarButton>
                        <dw:RibbonBarButton ID="RibbonbarButton5" runat="server" Size="small" Text="Metadata" ImagePath="/Admin/Images/Ribbon/Icons/Small/TextCode.png" OnClientClick="dialog.show('MetaDialog');"></dw:RibbonBarButton>
                        <dw:RibbonBarButton ID="btnSeoExpress" ModuleSystemName="SeoExpress" runat="server" Size="small" Text="Optimize Express" ImagePath="/Admin/Images/Ribbon/Icons/Small/earth_view.png" OnClientClick="optimizeExpress();"></dw:RibbonBarButton>
                    </dw:RibbonBarGroup>

                    <dw:RibbonBarGroup ID="rbgReports" runat="server" Name="Rapporter" Visible="true" Version="19.1.0.0">
                        <dw:RibbonBarButton ID="cmdReportPageviews" runat="server" Size="Small" Text="Sidevisninger" ImagePath="/Admin/Images/Ribbon/Icons/Small/line-chart.png" ContextMenuId="ReportPageviewOptions" />
                        <dw:RibbonBarButton ID="RibbonbarButton6" ImagePath="/Admin/Images/Ribbon/Icons/Small/pie-chart.png" Text="Søgeord" Size="small" ContextMenuId="ReportSearchEnginePhrasesOptions" runat="server" />
                        <dw:RibbonBarButton ID="RibbonbarButton4" ImagePath="/Admin/Images/Ribbon/Icons/Small/chart.png" Text="Referers fra søgemaskiner" Size="small" ContextMenuId="ReportSearchEngineOptions" runat="server" />
                        <dw:RibbonBarButton ID="RibbonbarButton8" runat="server" Size="small" Text="Traffic" ImagePath="/Admin/Images/Ribbon/Icons/Small/dot-chart.png" OnClientClick="report('Traffic');" />
                        <dw:RibbonBarButton ID="RibbonbarButton7" runat="server" Size="small" Text="Page performance" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_new.png" OnClientClick="report('PagePerformance');" />
                        <dw:RibbonBarButton ID="cmdWebPageAnalysis" runat="server" Size="small" Text="Webpage Analysis" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_info.png" />
                    </dw:RibbonBarGroup>

                    <dw:RibbonBarGroup ID="RibbonbarGroup6" runat="server" Name="Help">
                        <dw:RibbonBarButton ID="RibbonbarButton3" runat="server" Text="Help" Image="Help" OnClientClick="help();" />
                    </dw:RibbonBarGroup>
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
                    <dw:RibbonBarGroup ID="groupMarketingContent" Name="Indhold" runat="server" Visible="false">
                        <dw:RibbonBarButton ID="ExperimentTestBtn" Text="Create variant" Size="Large" ImagePath="/Admin/Images/Ribbon/Icons/element_copy.png" OnClientClick="experimentTestParagraph();" runat="server" Disabled="true" />
                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup ID="rbgSMP" Name="Social publishing" runat="server">
                        <dw:RibbonBarButton ID="rbPublish" Text="Publish" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/users_family.png" OnClientClick="showSMP();" runat="server" />
                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup ID="groupPersonalization" Name="Personalization" runat="server">
                        <dw:RibbonBarButton ID="PersonalizationShow" Text="Email Personalization" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/star_yellow.png" OnClientClick="PersonalizationShow();" runat="server" />
                        <dw:RibbonBarButton ID="EmailPreview" Text="Email Preview" Size="Small" Image="Preview" OnClientClick="EmailPreviewShow();" runat="server" />
                    </dw:RibbonBarGroup>
                    <dw:RibbonBarGroup ID="groupMarketingHelp" Name="Help" runat="server">
                        <dw:RibbonBarButton ID="cmdMarketingHelp" Text="Help" Image="Help" Size="Large" OnClientClick="help();" runat="server">
                        </dw:RibbonBarButton>
                    </dw:RibbonBarGroup>
                </dw:RibbonBarTab>
            </dw:RibbonBar>

        </div>

        <div id="breadcrumb" runat="server"></div>

        <div class="list">
            <asp:Repeater ID="ContainerRepeater" runat="server" EnableViewState="false">
                <HeaderTemplate>
                    <ul>
                        <li class="header">
                            <span class="C1" style="padding-top: 0px; padding-left: 24px; width: 30px">
                                <input id="chkAll" name="chkAll" type="checkbox" onclick="toggleAllSelected();" />
                            </span>
                            <span class="pipe"></span><span class="C2"><%=Translate.Translate("Afsnitsnavn")%></span>
                            <span class="pipe"></span><span class="C3"><%=Translate.Translate("Medtag")%></span>
                            <span class="pipe" id="ShowWorkflow1"></span><span class="C4" id="ShowWorkflow2"><%=Translate.Translate("Publiceret")%></span>
                            <span class="pipe CH4"></span><span class="C4 CH4"><%=Translate.Translate("Redigeret")%></span>
                            <span class="pipe CH5"></span><span class="C5 CH5"><%=Translate.Translate("Bruger")%></span>
                            <span class="pipe CH6"></span><span class="C6 CH6"><%=Translate.Translate("Aktiv fra")%></span>
                            <span class="pipe CH7"></span><span class="C7 CH7"><%=Translate.Translate("Aktiv til")%></span>
                            <span class="pipe"></span>
                        </li>
                    </ul>
                    <div id="_contentWrapper">
                        <ul id="items">
                </HeaderTemplate>
                <ItemTemplate>
                    <li class="ContainerDummy" oncontextmenu="<%# Dynamicweb.Controls.ContextMenu.GetContextMenuAction("AddParagraph", DataBinder.Eval(Container.DataItem, "Name")) %>">                        
                        <div class="ContainerDiv" <%# ShowContainer(Container.DataItem) %>>
                            <span class="handle"></span>
                            <img src="/Admin/Images/Ribbon/Icons/Small/folder_blue.png" align="absmiddle" />
                            <input type="hidden" class="container-name" value="<%# DataBinder.Eval(Container.DataItem, "Name")%>" />
                            <%# DataBinder.Eval(Container.DataItem, "Title")%>
                        </div>
                        <ul style="position:relative;min-height:5px" class="paragraph-container" id="Container_<%# DataBinder.Eval(Container.DataItem, "Name")%>" data-items-allowed="<%#DataBinder.Eval(Container.DataItem, "Settings").Get("items-allowed") %>">
                            <asp:Repeater ID="containerParagraphsRepeater" runat="server">
                                <ItemTemplate>
                                    <li class="paragraph" id="Paragraph_<%# Eval("ID") %>" data-item-type="<%#DataBinder.Eval(Container.DataItem, "ItemType") %>" oncontextmenu="<%#Contextmenu(CType(Container.DataItem, Dynamicweb.Content.Paragraph), Container) %>">
                                        <span class="C1" style="padding-top: 2px; padding-left: 5px; overflow: hidden;">
                                            <span id="PI_<%# Eval("ID") %>" class="Show<%#DoShowParagraph(CType(Container.DataItem, Dynamicweb.Content.Paragraph))%>"><%#Icon(CType(Container.DataItem, Dynamicweb.Content.Paragraph))%>&nbsp;</span>
                                            <input id="P<%# Eval("ID") %>" type="checkbox" name="P<%# Eval("ID") %>" value="<%# Eval("ID") %>" onclick="handleCheckboxes();" class="browseHide" <%#CheckCheckboxIsAllowed(CType(Container.DataItem, Dynamicweb.Content.Paragraph)) %> />
                                        </span>
                                        <%If Dynamicweb.Base.ChkString(Dynamicweb.Base.Request("mode")).ToLower() = "browse" Then%>
                                        <span class="C2" onclick="<%#ClickAction(CType(Container.DataItem, Dynamicweb.Content.Paragraph)) %>">
                                            <%Else%>
                                            <span class="C2" style="cursor: pointer">
                                                <%End If%>

                                                <span class="Show<%#DoShowParagraph(CType(Container.DataItem, Dynamicweb.Content.Paragraph))%>">
                                                    <%#WorkflowState(CType(Container.DataItem, Dynamicweb.Content.Paragraph).ApprovalState)%>
                                                    <%If Dynamicweb.Base.ChkString(Dynamicweb.Base.Request("mode")).ToLower() = "browse" Then%>
                                                    <a href="#" style="<%#LinkStyle(CType(Container.DataItem, Dynamicweb.Content.Paragraph)) %>">
                                                        <%Else%>
                                                        <a href="<%#ClickAction(CType(Container.DataItem, Dynamicweb.Content.Paragraph)) %>"
                                                            style="width: 200px; display: block; <%#LinkStyle(CType(Container.DataItem, Dynamicweb.Content.Paragraph)) %>">
                                                            <%End If%>
                                                            <%#Eval("Header")%>&nbsp;
								                <%#MasterUpdatedIcon(CType(Container.DataItem, Dynamicweb.Content.Paragraph))%>
                                                            <%#LockIcon(CType(Container.DataItem, Dynamicweb.Content.Paragraph)) %>
                                                            <%#ActiveFromToIcon(CType(Container.DataItem, Dynamicweb.Content.Paragraph))%>
                                                            <%#Experiment(CType(Container.DataItem, Dynamicweb.Content.Paragraph))%>
                                                            <%# ProfiledParagraph(CType(Container.DataItem, Dynamicweb.Content.Paragraph))%>
                                                        </a></span>
                                            </span>
                                            <span class="C3"><a href="<%#ToggleActiveLink(CType(Container.DataItem, Dynamicweb.Content.Paragraph)) %>" style="<%#LinkStyle(CType(Container.DataItem, Dynamicweb.Content.Paragraph)) %>" class="browseHide"><%#ActiveGif(CType(Container.DataItem, Dynamicweb.Content.Paragraph).ShowParagraph)%></a></span>
                                            <div class="handle">
                                                <span class="C4" id="ShowWorkflow3">
                                                    <span class="Show<%#DoShowParagraph(CType(Container.DataItem, Dynamicweb.Content.Paragraph))%>"><%#Eval("VersionTimeStamp", "{0:ddd, dd MMM yyyy HH':'mm}")%></span>
                                                </span>
                                                <span class="C4 CH4" title="<%=Translate.Translate("Oprettet") %>: <%#Eval("CreatedDate", "{0:ddd, dd MMM yyyy HH':'mm}")%>">
                                                    <span class="Show<%#DoShowParagraph(CType(Container.DataItem, Dynamicweb.Content.Paragraph))%>"><%#Eval("UpdatedDate", "{0:ddd, dd MMM yyyy HH':'mm}")%></span>
                                                </span>
                                                <span class="C5 CH5" title="<%=Translate.Translate("Oprettet af")%>: <%#CType(Container.DataItem, Dynamicweb.Content.Paragraph).UserCreate.Name%>">
                                                    <span class="Show<%#DoShowParagraph(CType(Container.DataItem, Dynamicweb.Content.Paragraph))%>"><%#CType(Container.DataItem, Dynamicweb.Content.Paragraph).UserEdit.Name%></span>
                                                </span>
                                                <span class="C6 CH6" id="Span1">
                                                    <span class="Show<%#DoShowParagraph(CType(Container.DataItem, Dynamicweb.Content.Paragraph))%>"><%#ActiveFrom(CType(Container.DataItem, Dynamicweb.Content.Paragraph))%></span>
                                                </span>
                                                <span class="C7 CH7" id="Span2">
                                                    <span class="Show<%#DoShowParagraph(CType(Container.DataItem, Dynamicweb.Content.Paragraph))%>"><%#ActiveTo(CType(Container.DataItem, Dynamicweb.Content.Paragraph))%></span>
                                                </span>
                                            </div>
                                            <script type="text/javascript">
                                                experimentParagraphs.push('P'+<%# if(CType(Container.DataItem, Dynamicweb.Content.Paragraph).Variation>1 , Eval("ID"),0) %>);
                                            </script>
                                        </li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </li>
                </ItemTemplate>
                <FooterTemplate>
				        </ul>                    
                </FooterTemplate>            
            </asp:Repeater> 

            <dw:Infobar runat="server" ID="unpublishedContentInfo" Type="Information" Message="This page has unpublished changes" Title="Publish" Visible="false" Action="Ribbon.checkBox('cmdUseDraft');useDraft();//startWorkflow(false);">
            </dw:Infobar>

            <dw:Infobar runat="server" ID="noParagraphsInfo" Type="Information" Message="Ingen afsnit på denne side" Title="Nyt afsnit" Action="newParagraph();">
            </dw:Infobar>

            <dw:Infobar runat="server" ID="isTemplateInfo" Type="Information" Message="This page is a template for new pages." Title="Skabelon" Visible="false" Action="saveAsTemplate();">
            </dw:Infobar>
            <dw:Infobar runat="server" ID="designMissing" Type="Warning" Message="No design is selected. This is causing problems" Title="Skabelon" Visible="false" Action="saveAsTemplate();">
            </dw:Infobar>

            <dw:Infobar runat="server" ID="shortcutInfo" Type="Information">
                <%=LinkInfo()%>
            </dw:Infobar>

            <dw:Infobar Visible="false" Message="Suggested title" runat="server" Type="Information" Title="Click to use suggested title" Action="suggest();" ID="SuggestedTitleInfobar">: <b id="SuggestedTitleB" runat="server"></b>
            </dw:Infobar>

            <dw:Infobar Visible="false" Message="Suggested keywords" runat="server" Type="Information" Title="Click to use suggested keywords" Action="suggest();" ID="SuggestedKeywordsInfobar">: <b id="SuggestedKeywordsB" runat="server"></b>
            </dw:Infobar>

            <dw:Infobar Visible="false" Message="Meta data was updated" runat="server" Type="Information" Title="" Action="" ID="MetaWasUpdatedInfobar">
            </dw:Infobar>

            <dw:Infobar Visible="false" Message="Layout missing" runat="server" Type="Information" Title="" Action="" ID="layoutMissing">
            </dw:Infobar>

            <div id="markupWarning" style="display: none"></div>

        </div>

        </div>
	
        <input type="hidden" id="GlobalIDs" runat="server" />
        <input type="hidden" id="GlobalElementsIDs" runat="server" />

        <span id="jsHelp" style="display: none">
            <%=Dynamicweb.Gui.Help("", "page.paragraph.listNEW")%>
        </span>

        <span id="confirmDiscard" style="display: none">
            <%=Dynamicweb.Backend.Translate.JsTranslate("Discard changes")%>?
        </span>
    </form>

    <dw:Dialog ID="PreviewByDateDialog" runat="server" SnapToScreen="True" Title="Show previous version" ShowCancelButton="true" ShowOkButton="true" ShowClose="true" OkAction="previewBydate();">
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

    <%    If Me.Page1.ID > 0 Then%>
    <dw:Dialog ID="VersionsDialog" runat="server" SnapToScreen="True"  Title="Versioner" HidePadding="true" Width="600">
        <iframe id="VersionsFrame" style="width: 100%; height: 300px; border: solid 0px red;" src="about:blank" frameborder="0"></iframe>
    </dw:Dialog>
    <script type="text/javascript">
        VersionUrl = 'ParagraphVersions.aspx?PageID=<%=Me.Page1.ID %>';
    </script>
    <% End If%>

    <dw:Dialog ID="QuitDraftDialog" runat="server" SnapToScreen="True" Title="Quit draft" ShowOkButton="true" ShowCancelButton="true" ShowClose="false" CancelAction="QuitDraftCancel();" OkAction="QuitDraftOk();">
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

    <dw:Dialog ID="MetaDialog" Width="600" runat="server" SnapToScreen="True" Title="Metadata" ShowOkButton="true" ShowCancelButton="true" ShowClose="False" CancelAction="HideCounter();dialog.hide('MetaDialog');" OkAction="suggestSave();">
        <table cellpadding="1" cellspacing="1">
            <tr>
                <td width="60" valign="top">
                    <dw:TranslateLabel ID="TranslateLabel12" runat="server" Text="Titel" />
                </td>
                <td>
                    <input type="text" id="PageDublincoreTitle" name="PageDublincoreTitle" size="30" class="NewUIinput" runat="server" style="width: 220px; margin-bottom: 1px;"
                        onfocus="ShowCounters(this,'PageDublincoreTitleCounter','PageDublincoreTitleCounterMax');"
                        onkeyup="CheckCounter(this,'PageDublincoreTitleCounter','PageDublincoreTitleCounterMax');"
                        onblur="CheckAndHideCounter(this,'PageDublincoreTitleCounter','PageDublincoreTitleCounterMax');" />
                </td>
                <td align="left" valign="top" width="300">
                    <strong id="PageDublincoreTitleCounter" class="char-counter"></strong>
                    <input type="hidden" id="PageDublincoreTitleCounterMax" name="PageDublincoreTitleCounterMax" runat="server" />
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <dw:TranslateLabel ID="TranslateLabel13" runat="server" Text="Beskrivelse" />
                </td>
                <td>
                    <textarea id="PageDescription" name="PageDescription" cols="30" rows="3" wrap="on" style="width: 220px; height: 60px;" runat="server"
                        onfocus="ShowCounters(this,'PageDescriptionCounter','PageDescriptionCounterMax');"
                        onkeyup="CheckCounter(this,'PageDescriptionCounter','PageDescriptionCounterMax');"
                        onblur="CheckAndHideCounter(this,'PageDescriptionCounter','PageDescriptionCounterMax');"></textarea>
                </td>
                <td align="left" valign="top">
                    <strong id="PageDescriptionCounter" class="char-counter"></strong>
                    <input type="hidden" id="PageDescriptionCounterMax" name="PageDescriptionCounterMax" runat="server" />
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <dw:TranslateLabel ID="TranslateLabel14" runat="server" Text="Nøgleord" />
                </td>
                <td>
                    <textarea id="PageKeywords" name="PageKeywords" cols="30" rows="3" wrap="on" style="width: 220px; height: 60px; margin-bottom: 1px;" runat="server"
                        onfocus="ShowCounters(this,'PageKeywordsCounter','PageKeywordsCounterMax');"
                        onkeyup="CheckCounter(this,'PageKeywordsCounter','PageKeywordsCounterMax');"
                        onblur="CheckAndHideCounter(this,'PageKeywordsCounter','PageKeywordsCounterMax');"></textarea>
                </td>
                <td align="left" valign="top">
                    <strong id="PageKeywordsCounter" class="char-counter"></strong>
                    <input type="hidden" id="PageKeywordsCounterMax" name="PageKeywordsCounterMax" runat="server" />
                </td>
            </tr>
        </table>
    </dw:Dialog>

    <dw:Dialog ID="SaveAsTemplateDialog" runat="server" SnapToScreen="True" Title="Save as template" ShowOkButton="true" ShowCancelButton="true" ShowClose="false" CancelAction="SaveAsTemplateCancel();" OkAction="SaveAsTemplateOk();">
        <table border="0" style="width: 350px;">
            <tr>
                <td style="width: 100px;">
                    <dw:TranslateLabel ID="TranslateLabel10" runat="server" Text="Navn" />
                </td>
                <td>
                    <input type="text" runat="server" id="TemplateName" name="TemplateName" class="NewUIinput" maxlength="255" />
                </td>
            </tr>
            <tr>
                <td style="height: 3px;"></td>
            </tr>
            <tr>
                <td>
                    <dw:TranslateLabel ID="TranslateLabel9" runat="server" Text="Beskrivelse" />
                </td>
                <td>
                    <input type="text" runat="server" id="TemplateDescription" name="TemplateDescription" class="NewUIinput" maxlength="255" />
                </td>
            </tr>
            <tr>
                <td style="height: 3px;"></td>
            </tr>
            <tr id="isTemplateRow" runat="server" visible="false">
                <td></td>
                <td>
                    <dw:CheckBox ID="isTemplate" runat="server" Value="1" SelectedFieldValue="1" />
                    <label for="isTemplate">
                        <dw:TranslateLabel ID="TranslateLabel11" runat="server" Text="Aktiv" />
                        <%--<dw:TranslateLabel ID="TranslateLabel12" runat="server" Text="Create and move to template folder" />--%>
                    </label>
                </td>
            </tr>
        </table>
        <br />
        <br />
    </dw:Dialog>
    
    <div id="BottomInformationBg" runat="server">
        <table border="0">
            <tr>
                <td rowspan="2">
                    <img src="/Admin/Images/Ribbon/Icons/Paragraph.png" alt="" onclick="pageProperties2();" class="icon" id="itemIcon" runat="server" />
                    <img class="icon" src="/Admin/Images/Ribbon/Icons/Paragraph.png" alt="" title="" id="pageIcon" visible="false" runat="server" />
                </td>
                <td class="label"><div><dw:TranslateLabel Text="Name" runat="server" />:</div></td>
                <td class="value">
                    <div>
                        <b id="_pagename" runat="server"></b>
                        <img src="/Admin/Images/Ribbon/Icons/Small/Seo.png" alt="" style="margin-left: 5px; vertical-align: middle; cursor: pointer;" runat="server" id="optimezedIcon" visible="false" title="Optimized" onclick="optimize();" />&nbsp;&nbsp;
                    </div>
                </td>
                <td class="label">
                    <div>
                        <dw:TranslateLabel ID="TitleLbl" runat="server" Text="Titel" /><dw:TranslateLabel ID="ItemTypeLbl" runat="server" Text="Item type" Visible="False" />:
                    </div>
                </td>
                <td class="value"><div><span id="_title" runat="server"></span></div></td>
                <td class="label"><div><dw:TranslateLabel Text="Created" runat="server" />:</div></td>
                <td class="value"><div><span id="_created" runat="server"></span></div></td>
                <td class="label"><div><dw:TranslateLabel Text="Template" runat="server" />:</div></td>
                <td class="value"><div class="large"><span id="_template" runat="server"></span></div></td>
            </tr>
            <tr class="sub">
                <td class="label"><div><dw:TranslateLabel Text="ID" runat="server" />:</div></td>
                <td class="value"><div><span id="_pageid" runat="server">0</span></div></td>
                <td class="label"><div><dw:TranslateLabel Text="URL" runat="server" />:</div></td>
                <td class="value"><div><span id="_url" runat="server"></span></div></td>
                <td class="label"><div><dw:TranslateLabel Text="Edited" runat="server" />:</div></td>
                <td class="value"><div><span id="_edited" runat="server"></span></div></td>                        
                <td colspan="2">
                <%If Not String.IsNullOrEmpty(_profile.InnerText) Then%>
                    <div>
                        <span class="label"><b><dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Dispaly of the page is dependant on OMC profile" />:</b></span>
                        <span class="value" id="_profile" runat="server"></span>
                    </div>
                <%End If%>
                </td>
            </tr>
        </table>
    </div>

    <dw:Dialog ID="DialogOptimize" runat="server" SnapToScreen="True" Title="Optimering" HidePadding="true" Width="600">
        <iframe id="OptimizeFrame" style="width: 100%; height: 370px; border: solid 0px red;" src="about:blank" frameborder="0"></iframe>
    </dw:Dialog>

    <dw:Dialog ID="GlobalsDialog" runat="server" SnapToScreen="True" Title="Global element" HidePadding="true" Width="600">
        <iframe id="GlobalsFrame" style="width: 100%; height: 400px; border: solid 0px red;" src="about:blank" frameborder="0"></iframe>
    </dw:Dialog>
    <script type="text/javascript">
        GlobalUrl = 'InsertGlobalElement.aspx?AreaID=<%=Me.Page1.AreaID %>';
    </script>

    <dw:PopUpWindow ID="webPageAnalysisDialog" SnapToScreen="True" UseTabularLayout="true" AutoReload="true" Width="600" Height="400"
        Title="Report" TranslateTitle="true" ContentUrl="" HidePadding="true" runat="server" AutoCenterProgress="true" ShowOkButton="false" ShowCancelButton="false" ShowClose="true" />

    <dw:PopUpWindow ID="pupCreateMessage" SnapToScreen="True" UseTabularLayout="true" AutoReload="true" Width="720" Height="580" iframeHeight="530" 
        Title="Publish page to social media" TranslateTitle="true" ContentUrl="" HidePadding="true" runat="server" AutoCenterProgress="true" ShowOkButton="false" ShowCancelButton="false" ShowClose="true" />
   
    <dw:Dialog ID="ReportsDialog" runat="server" SnapToScreen="True" Title="Rapport" HidePadding="true" Width="534">
        <iframe id="ReportsFrame" style="width: 100%; height: 450px; border: solid 0px red;" src="about:blank" frameborder="0"></iframe>
    </dw:Dialog>

    <dw:Dialog ID="editParagraphDialog" runat="server" SnapToScreen="True" Title="Edit paragraph" HidePadding="true" Width="800">
        <iframe id="editParagraphIframe" style="width: 100%; height: 450px; border: solid 0px red;" src="about:blank" frameborder="0"></iframe>
    </dw:Dialog>
    
    <dw:Dialog ID="ParagraphOptionsDialog" Width="250" runat="server" SnapToScreen="True" Title="Paragraph options" ShowOkButton="true" OkOnEnter="true" ShowCancelButton="false" ShowClose="false" CancelAction="dialog.hide('ParagraphOptionsDialog');" OkAction="updateParagraphOptions();">
        <img src="/Admin/Images/Ribbon/Icons/warning.png" alt="" style="vertical-align: middle;" />
        <dw:TranslateLabel ID="TranslateLabel17" runat="server" Text="Would you like the paragraphs to be:" />
        <br />
        <br />
        <table border="0" style="width: 150px;">
            <tr>
                <td>
                    <dw:RadioButton ID="AsTheyAreButton" runat="server" FieldName="ParagraphOptions" FieldValue="AsTheyAre" SelectedFieldValue="AsTheyAre" />
                </td>
                <td>
                    <label for="AsTheyAreButton">
                        <dw:TranslateLabel ID="TranslateLabel18" runat="server" Text="Leave as they are" />
                    </label>
                </td>
            </tr>
            <tr>
                <td style="height: 3px;"></td>
            </tr>
            <tr>
                <td>
                    <dw:RadioButton ID="ActiveButton" runat="server" FieldName="ParagraphOptions" FieldValue="Active" />
                </td>
                <td>
                    <label for="ActiveButton">
                        <dw:TranslateLabel ID="TranslateLabel19" runat="server" Text="Active" />
                    </label>
                </td>
            </tr>
            <tr>
                <td style="height: 3px;"></td>
            </tr>
            <tr>
                <td>
                    <dw:RadioButton ID="NotActiveButton" runat="server" FieldName="ParagraphOptions" FieldValue="NotActive" />
                </td>
                <td>
                    <label for="NotActiveButton">
                        <dw:TranslateLabel ID="TranslateLabel20" runat="server" Text="Not active" />
                    </label>
                </td>
            </tr>
        </table>
	</dw:Dialog>
    
    <dw:Dialog ID="PageOptionsDialog" runat="server" Width="550" SnapToScreen="True" Title="Page options" ShowOkButton="true" OkOnEnter="true" ShowCancelButton="false" ShowClose="False" OkAction="updatePageOptions();" CancelAction="dialog.hide('PageOptionsDialog');">
            <img src="/Admin/Images/Ribbon/Icons/warning.png" alt="" style="vertical-align: middle;" />
            <dw:TranslateLabel ID="lblCopyWarning" runat="server" Text="Copying page will not copy page on the language websites due to perfomance problems." Visible="false" />            
            <dw:TranslateLabel ID="TranslateLabel21" runat="server" Text="Would you like the page to be:" />
            <br />
            <br />
            <table border="0">
                <% If Base.Request("cmd") = "copypage" %>
                <tr>
                    <td>
                        <label for="NewPageName">
                            <dw:TranslateLabel ID="TranslateLabel26" runat="server" Text="New page name" />
                        </label>
                    </td>                
                    <td style="height: 6px;">
                        <input type="text" runat="server" id="NewPageName" name="NewPageName" class="NewUIinput" maxlength="255" value=""/>
                    </td>
                </tr>    
                <tr>
                    <td style="height: 6px;">
                        <label><dw:TranslateLabel ID="TranslateLabel28" runat="server" Text="Page status" /></label>
                    </td>
                <% Else%>                            
                    <tr><td style="height: 6px;"></td>
                <% End If %>                                 
                    <td>
                        <dw:RadioButton ID="RadioButton1" runat="server" FieldName="PageOptions" FieldValue="AsTheyAre" SelectedFieldValue="AsTheyAre" />
                        <label for="AsTheyAreButton"><dw:TranslateLabel ID="TranslateLabel22" runat="server" Text="Leave as they are" /></label>
                        <br />
                        <dw:RadioButton ID="Published" runat="server" FieldName="PageOptions" FieldValue="Published" />
                        <label for="Published"><dw:TranslateLabel ID="TranslateLabel23" runat="server" Text="Published" /></label>
                        <br />
                        <dw:RadioButton ID="Unpublished" runat="server" FieldName="PageOptions" FieldValue="Unpublished" />
                        <label for="Unpublished"><dw:TranslateLabel ID="TranslateLabel24" runat="server" Text="Unpublished" /></label>
                        <br />
                        <dw:RadioButton ID="HideInMenu" runat="server" FieldName="PageOptions" FieldValue="HideInMenu" />
                        <label for="HideInMenu"><dw:TranslateLabel ID="TranslateLabel25" runat="server" Text="Hide in menu" /></label>
                    </td>
                </tr>
            </table>
    </dw:Dialog>

    <script type="text/javascript">
        ListHasTemplateModule = <%=ListHasTemplateModule.tostring.toLower %>;
    </script>
    <!--
To be used to insert modules from the paragraph list
-->
    <dw:Dialog ID="insertModuleDialog" runat="server" SnapToScreen="True" Width="250" ShowOkButton="false" ShowCancelButton="false" Title="Indsæt modul">
        <ul id="modules" style="display: none;">
            <li id="Some_1">News</li>
            <li id="Some_1">MediaDB</li>
        </ul>
    </dw:Dialog>
    <dw:ContextMenu ID="AddParagraph" runat="server">
        <dw:ContextMenuButton ID="addparagraphbtn" runat="server" Text="Nyt afsnit" Image="AddDocument" OnClientClick="newParagraphToContainer();">
        </dw:ContextMenuButton>
    </dw:ContextMenu>
    <dw:ContextMenu ID="ParagraphInclude" OnShow="initializeContextMenu(ContextMenu.callingID, this);" runat="server">
        <dw:ContextMenuButton ID="cmdEditParagraphInclude" runat="server" Divide="After" Image="EditDocument" Text="Rediger">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton runat="server" Divide="None" Image="Check" Text="Medtag" OnClientClick="toggleActiveR();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdDetachGlobalInclude" runat="server" Divide="None" Text="Detach global element" Image="DocumentUp" OnClientClick="detachGlobalElement(ContextMenu.callingID);">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdCopyInclude" runat="server" Divide="None" Image="Copy" Text="Kopier" OnClientClick="copyParagraph();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdCopyHereInclude" runat="server" Divide="None" Image="Copy" Text="Kopier hertil" OnClientClick="copyParagraphHere();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdMoveInclude" runat="server" Divide="None" Image="MoveDocument" Text="Flyt" OnClientClick="moveParagraph();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdInsertBeforeInclude" runat="server" Divide="Before" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_up.png" Text="Insert before" OnClientClick="insertParagraphBefore();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdInsertAfterInclude" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_down.png" Text="Insert after" OnClientClick="insertParagraphAfter();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdDeleteInclude" runat="server" Divide="before" Image="DeleteDocument" Text="Slet" OnClientClick="deleteParagraph();">
        </dw:ContextMenuButton>
    </dw:ContextMenu>

    <dw:ContextMenu ID="ParagraphIncludeModule" OnShow="initializeContextMenu(ContextMenu.callingID, this);" runat="server">
        <dw:ContextMenuButton ID="cmdEditParagraphIncludeModule" runat="server" Divide="None" Image="EditDocument" Text="Rediger">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton runat="server" Divide="After" Image="EditGear" Text="Modulopsætning" OnClientClick="openModuleSettings();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton runat="server" Divide="None" Image="Check" Text="Medtag" OnClientClick="toggleActiveR();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdDetachGlobalIncludeModule" runat="server" Divide="None" Text="Detach global element" Image="DocumentUp" OnClientClick="detachGlobalElement(ContextMenu.callingID);">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdCopyIncludeModule" runat="server" Divide="None" Image="Copy" Text="Kopier" OnClientClick="copyParagraph();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdCopyHereIncludeModule" runat="server" Divide="None" Image="Copy" Text="Kopier hertil" OnClientClick="copyParagraphHere();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdMoveIncludeModule" runat="server" Divide="None" Image="MoveDocument" Text="Flyt" OnClientClick="moveParagraph();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdInsertBeforeIncludeModule" runat="server" Divide="Before" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_up.png" Text="Insert before" OnClientClick="insertParagraphBefore();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdInsertAfterIncludeModule" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_down.png" Text="Insert after" OnClientClick="insertParagraphAfter();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdDeleteIncludeModule" runat="server" Divide="before" Image="DeleteDocument" Text="Slet" OnClientClick="deleteParagraph();">
        </dw:ContextMenuButton>
    </dw:ContextMenu>

    <dw:ContextMenu ID="ParagraphExclude" OnShow="initializeContextMenu(ContextMenu.callingID, this);" runat="server">
        <dw:ContextMenuButton ID="cmdEditParagraphExclude" runat="server" Divide="After" Image="EditDocument" Text="Rediger">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton runat="server" Divide="None" Image="Delete" Text="Exclude" OnClientClick="toggleActiveR();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdDetachGlobalExclude" runat="server" Divide="None" Text="Detach global element" Image="DocumentUp" OnClientClick="detachGlobalElement(ContextMenu.callingID);">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdCopyExclude" runat="server" Divide="None" Image="Copy" Text="Kopier" OnClientClick="copyParagraph();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdCopyHereExclude" runat="server" Divide="None" Image="Copy" Text="Kopier hertil" OnClientClick="copyParagraphHere();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdMoveExclude" runat="server" Divide="None" Image="MoveDocument" Text="Flyt" OnClientClick="moveParagraph();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdInsertBeforeExclude" runat="server" Divide="Before" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_up.png" Text="Insert before" OnClientClick="insertParagraphBefore();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdInsertAfterExclude" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_down.png" Text="Insert after" OnClientClick="insertParagraphAfter();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdDeleteExclude" runat="server" Divide="before" Image="DeleteDocument" Text="Slet" OnClientClick="deleteParagraph();">
        </dw:ContextMenuButton>
    </dw:ContextMenu>

    <dw:ContextMenu ID="ParagraphExcludeModule" OnShow="initializeContextMenu(ContextMenu.callingID, this);" runat="server">
        <dw:ContextMenuButton ID="cmdEditParagraphExcludeModule" runat="server" Divide="None" Image="EditDocument" Text="Rediger">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton runat="server" Divide="After" Image="EditGear" Text="Modulopsætning" OnClientClick="openModuleSettings();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton runat="server" Divide="None" Image="Delete" Text="Exclude" OnClientClick="toggleActiveR();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdDetachGlobalExcludeModule" runat="server" Divide="None" Text="Detach global element" Image="DocumentUp" OnClientClick="detachGlobalElement(ContextMenu.callingID);">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdCopyExcludeModule" runat="server" Divide="None" Image="Copy" Text="Kopier" OnClientClick="copyParagraph();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdCopyHereExcludeModule" runat="server" Divide="None" Image="Copy" Text="Kopier hertil" OnClientClick="copyParagraphHere();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdMoveExcludeModule" runat="server" Divide="None" Image="MoveDocument" Text="Flyt" OnClientClick="moveParagraph();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdInsertBeforeExcludeModule" runat="server" Divide="Before" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_up.png" Text="Insert before" OnClientClick="insertParagraphBefore();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdInsertAfterExcludeModule" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_down.png" Text="Insert after" OnClientClick="insertParagraphAfter();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="cmdDeleteExcludeModule" runat="server" Divide="before" Image="DeleteDocument" Text="Slet" OnClientClick="deleteParagraph();">
        </dw:ContextMenuButton>
    </dw:ContextMenu>

    <dw:ContextMenu ID="languageSelectorContext" runat="server" MaxHeight="400">
    </dw:ContextMenu>

    <dw:ContextMenu ID="ReportPageviewOptions" runat="server">
        <dw:ContextMenuButton ID="ContextmenuButton9" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/line-chart.png" Text="Dag" OnClientClick="report('PageviewsDay');">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="ContextmenuButton7" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/line-chart.png" Text="Uge" OnClientClick="report('PageviewsWeek');">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="ContextmenuButton8" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/line-chart.png" Text="Måned" OnClientClick="report('PageviewsMonth');">
        </dw:ContextMenuButton>
    </dw:ContextMenu>
    <dw:ContextMenu ID="ReportSearchEnginePhrasesOptions" runat="server">
        <dw:ContextMenuButton ID="ContextmenuButton10" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/pie-chart.png" Text="Phrases" OnClientClick="report('SearchEnginePhrases');">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="ContextmenuButton11" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/pie-chart.png" Text="Keywords" OnClientClick="report('SearchEngineKeywords');">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="ContextmenuButton12" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/pie-chart.png" Text="Words per phrase" OnClientClick="report('SearchEnginePhraseWordCount');">
        </dw:ContextMenuButton>
    </dw:ContextMenu>
    <dw:ContextMenu ID="ReportSearchEngineOptions" runat="server">
        <dw:ContextMenuButton ID="ContextmenuButton13" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/chart.png" Text="Top 5 referrers" OnClientClick="report('SearchEngineReferrers');">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="ContextmenuButton16" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/chart.png" Text="All referrals" OnClientClick="report('SearchEngineAllReferrals');">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="ContextmenuButton14" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/chart.png" Text="Top 5 crawlers" OnClientClick="report('SearchEngineBotIndex');">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton ID="ContextmenuButton15" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/chart.png" Text="Indexations over time" OnClientClick="report('SearchEngineIndexTime');">
        </dw:ContextMenuButton>
    </dw:ContextMenu>
    <!-- Moved up, before the dialog declaration - not executed in other case 
	(it seems that the dialog's iframe causes browser not to evaluate this script -->
    <%Translate.GetEditOnlineScript()%>
    <dw:Dialog ID="OMCExperimentDialog" runat="server" SnapToScreen="True" Width="750" iframeHeight="535" ShowOkButton="false" ShowCancelButton="false" UseTabularLayout="true" Title="Setup split test" IsIFrame="true">
    </dw:Dialog>

    <dw:PopUpWindow ID="OMCPersonalizationDialog" Title="Email Personalization" UseTabularLayout="true" ShowOkButton="false" ShowCancelButton="false" AllowDrag="true" ShowClose="true" 
         HidePadding="true" AllowContentTransparency="true" TranslateTitle="true" AutoReload="true" runat="server" Width="700" Height="432" />

    <dw:Dialog ID="PageValidateDialog" runat="server" SnapToScreen="True" Width="550" ShowOkButton="True" ShowCancelButton="false" Title="Validate markup">
        <div>
            <div id="imgProcessing" style="display: block">
                <img src="/Admin/Module/Seo/Dynamicweb_wait.gif" border="0" alt="" />
            </div>
            <div id="validateContent" style="border: 1px solid #dcdcdc; display: none">
                <iframe id="frmResults" src="" width="100%" height="400" scrolling="auto" frameborder="0"></iframe>
            </div>
        </div>
    </dw:Dialog>

</body>
</html>
