<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Setup.aspx.vb" Inherits="Dynamicweb.Admin.Setup" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <dw:ControlResources ID="ControlResources1" runat="server" IncludeUIStylesheet="true"
        IncludePrototype="false" />
    <link rel="StyleSheet" href="Setup.css" type="text/css" />
    <script type="text/javascript" src="Setup.js">
    </script>
    <title></title>
</head>
<body onload="start();">
    <div runat="server" id="closeJs" visible="false">
        <script type="text/javascript">
            close();
        </script>
    </div>
    <form id="experimentSetupForm" method="post" action="Setup.aspx">
    <input type="hidden" runat="server" id="ExperimentType" name="ExperimentType" />
    <input type="hidden" runat="server" id="ExperimentID" name="ExperimentID" />
    <input type="hidden" runat="server" id="StepName" name="StepName" value=""/>
    <input type="hidden" runat="server" id="id" name="id" />
    <div id="step1ChooseType" style="display: none;">
        <div class="header">
            <h1 id="title">
                <%= Dynamicweb.Backend.Translate.Translate("Create new split test.")%></h1>
        </div>
        <div class="mainArea">
            <div runat="server" id="ContentBasedTestOption" class="option" onclick="setType(2);">
                <img src="/Admin/Images/Ribbon/Icons/elements_selection.png" />
                <b><%= Dynamicweb.Backend.Translate.Translate("Content based split test")%></b>
                <ul>
                    <li><%= Dynamicweb.Backend.Translate.Translate("Test different versions of paragraphs against each other.")%></li>
                    <li><%= Dynamicweb.Backend.Translate.Translate("Use this split test if you want to test different design elements such as buttons.")%></li>
                    <li><%= Dynamicweb.Backend.Translate.Translate("Use this split test if you want to test different texts and images.")%></li>
                    <li><%= Dynamicweb.Backend.Translate.Translate("Copies paragraphs in different version that can be differentiated.")%></li>
                </ul>
            </div>
            <div class="option" onclick="setType(1);">
                <img src="/Admin/Images/Ribbon/Icons/Copy.png" />
                <b><%= Dynamicweb.Backend.Translate.Translate("Page based split test")%></b>
                <ul>
                    <li><%= Dynamicweb.Backend.Translate.Translate("Test two different pages against each other.")%></li>
                    <li><%= Dynamicweb.Backend.Translate.Translate("Use this split test if you want to test different layouts.")%></li>
                    <li><%= Dynamicweb.Backend.Translate.Translate("Select another page to test against this one.")%></li>
                </ul>
            </div>
        </div>
        <div class="footer">
        </div>
    </div>
    <div id="step2ChooseAlternatePage" style="display: none;">
        <div class="header">
            <h1 id="H1">
                <%= Dynamicweb.Backend.Translate.Translate("Choose page to test against this page.")%></h1>
        </div>
        <div class="mainArea">
            <div class="option2" onclick="observerAlternateLink();">
                <img src="/Admin/Images/Ribbon/Icons/document_exchange.png" />
                <b><%= Dynamicweb.Backend.Translate.Translate("Alternate page")%></b>
                <ul>
                    <li><%= Dynamicweb.Backend.Translate.Translate("Choose a page that will be shown as alternative.")%><br />
                        <br />
                        <dw:LinkManager ID="ExperimentAlternatePage" runat="server" DisableFileArchive="true"
                            DisableParagraphSelector="true" DisableTyping="true" />
                    </li>
                </ul>
            </div>
        </div>
        <div class="footer">
            <input type="button" value="<%=Dynamicweb.Backend.Translate.Translate("Previous")%>" onclick="showStep('step1ChooseType');" />
            <input type="button" value="<%=Dynamicweb.Backend.Translate.Translate("Next")%>" id="step2ChooseAlternatePageforwardButton" disabled="disabled"
                onclick="showStep('step3ChooseGoal');" />
        </div>
    </div>
    <div id="step3ChooseGoal" style="display: none;">
        <div class="header">
            <h1 id="H2">
                <%= Dynamicweb.Backend.Translate.Translate("Identify conversion goal.")%></h1>
        </div>
        <div class="mainArea">
            <div class="option2" style="cursor: auto;">
                <img src="/Admin/Images/Ribbon/Icons/target2.png" />
                <b><%= Dynamicweb.Backend.Translate.Translate("Conversion goal")%></b>
                <ul>
                    <li>
                        <dw:RadioButton FieldName="ExperimentGoalType" ID="ExperimentGoalTypePage" FieldValue="Page"
                            runat="server" OnClientClick="showInput('inputAlternativePage');" />
                        <label for="ExperimentGoalTypePage">
                            <%= Dynamicweb.Backend.Translate.Translate("Choose another page as conversion page")%></label><br />
                        <div style="margin-left: 22px; margin-top: 5px;display:none;" id="inputAlternativePage">
                            <dw:LinkManager ID="ExperimentGoalTypePageValue" runat="server" DisableFileArchive="true"
                                DisableParagraphSelector="true" DisableTyping="true" />
                        </div>
                    </li>
                    <li>
                        <dw:RadioButton FieldName="ExperimentGoalType" ID="ExperimentGoalTypeItem" FieldValue="Item"
                            runat="server" OnClientClick="showInput('inputItemType');" />
                        <label for="ExperimentGoalTypeItem">
                            <%= Dynamicweb.Backend.Translate.Translate("Create an item")%></label><br />
                        <div style="margin-left: 22px; margin-top: 5px; display:none;" id="inputItemType">
				            <dw:Richselect ID="ItemTypeSelect" runat="server" Height="60" Itemheight="60" Width ="300" Itemwidth="300">
				            </dw:Richselect>
                        </div>
                    </li>
                    <li>
                        <dw:RadioButton FieldName="ExperimentGoalType" ID="ExperimentGoalTypeForm" FieldValue="Form"
                            runat="server" OnClientClick="showInput('inputForm');" />
                        <label for="ExperimentGoalTypeForm">
                            <%= Dynamicweb.Backend.Translate.Translate("Submitting af form from the forms module")%></label><br />
                        <div style="margin-left: 22px; margin-top: 5px; display:none;" id="inputForm">
                            <select name="ExperimentGoalTypeFormValue" id="ExperimentGoalTypeFormValue">
                                <asp:Literal ID="FormList" runat="server"></asp:Literal>
                            </select>
                        </div>
                    </li>
                    <li>
                        <dw:RadioButton FieldName="ExperimentGoalType" ID="ExperimentGoalTypeCart" FieldValue="Cart"
                            runat="server" OnClientClick="showInput();" />
                        <label for="ExperimentGoalTypeCart">
                            <%= Dynamicweb.Backend.Translate.Translate("Adding products to cart")%></label><br />
                    </li>
                    <li>
                        <dw:RadioButton FieldName="ExperimentGoalType" ID="ExperimentGoalTypeOrder" FieldValue="Order"
                            runat="server" OnClientClick="showInput();" />
                        <label for="ExperimentGoalTypeOrder">
                            <%= Dynamicweb.Backend.Translate.Translate("Placing an order")%></label><br />
                    </li>
                    <li>
                        <dw:RadioButton FieldName="ExperimentGoalType" ID="ExperimentGoalTypeFile" FieldValue="File"
                            runat="server" OnClientClick="showInput('inputDownloadFile');" />
                        <label for="ExperimentGoalTypeFile">
                            <%= Dynamicweb.Backend.Translate.Translate("Downloading a file")%></label><br />
                        <div id="inputDownloadFile" style="margin-left: 22px; margin-top: 5px;display:none;">
                            <dw:FileManager ID="ExperimentGoalTypeFileValue" runat="server" Folder="Files" />
                            <small><%= Dynamicweb.Backend.Translate.Translate("(Must be in /Files/")%><%=Dynamicweb.Content.Management.Installation.FilesFolderName%>
                                <%= Dynamicweb.Backend.Translate.Translate("folder)")%></small></div>
                    </li>
                    <li>
                        <dw:RadioButton FieldName="ExperimentGoalType" ID="ExperimentGoalTypeNewsletter"
                            FieldValue="Newsletter" runat="server" OnClientClick="showInput();" />
                        <label for="ExperimentGoalTypeNewsletter">
                            <%= Dynamicweb.Backend.Translate.Translate("Signing up for newsletter")%></label><br />
                    </li>
                    <li id="customProviderContentItem" runat="server" style="display:none;">
                        <div id="customProviderContent" runat="server" visible="false">
                        <dw:RadioButton FieldName="ExperimentGoalType" ID="CustomGoalProvider"
                            FieldValue="CustomGoalProviderType" runat="server" OnClientClick="showInput('inputCustomGoalProvider');" />
                        <label for="ExperimentGoalTypeCustomGoalProviderType"><%= Dynamicweb.Backend.Translate.Translate("Custom providers")%></label><br />
                        <div id="inputCustomGoalProvider" style="margin-left: 22px; margin-top: 5px;display:none;">
                            <asp:Literal ID="sourceSelectorScripts" runat="server"></asp:Literal>
                            <de:AddInSelector ID="sourceSelector" runat="server" ShowOnlySelectedGroup="true"
                                AddInGroupName="ConversionGoalProvider" UseLabelAsName="True" AddInShowNothingSelected="true"
                                AddInTypeName="Dynamicweb.Analytics.Goals.ConversionGoalProvider" AddInShowFieldset="false" useNewUI="True" />
                            <asp:Literal ID="sourceSelectorLoadScript" runat="server"></asp:Literal>
                        </div>
                        </div>
                    </li>
                    <li>
                        <dw:RadioButton FieldName="ExperimentGoalType" ID="ExperimentGoalTypeTimespent" FieldValue="Timespent"
                            runat="server" OnClientClick="showInput();" />
                        <label for="ExperimentGoalTypeTimespent">
                            <%= Dynamicweb.Backend.Translate.Translate("Maximize time spent on site")%></label><br />
                    </li>
                    <li>
                        <dw:RadioButton FieldName="ExperimentGoalType" ID="ExperimentGoalTypeHighestAverageValueOrder" FieldValue="HighestAverageValueOrder"
                            runat="server" OnClientClick="showInput();" />
                        <label for="ExperimentGoalTypeHighestAverageValueOrder">
                            <%= Dynamicweb.Backend.Translate.Translate("Highest average order value")%></label><br />
                    </li>
                    <li>
                        <dw:RadioButton FieldName="ExperimentGoalType" ID="ExperimentGoalTypeHighestAverageMarkupOrder" FieldValue="HighestAverageMarkupOrder"
                            runat="server" OnClientClick="showInput();" />
                        <label for="ExperimentGoalTypeHighestAverageMarkupOrder">
                            <%= Dynamicweb.Backend.Translate.Translate("Highest average markup order")%></label><br />
                    </li>
                    <li>
                        <dw:RadioButton FieldName="ExperimentGoalType" ID="ExperimentGoalTypeBounce" FieldValue="Bounce"
                            runat="server" OnClientClick="showInput();" />
                        <label for="ExperimentGoalTypeBounce">
                            <%= Dynamicweb.Backend.Translate.Translate("Minimize bounce rate")%></label><br />
                    </li>
                    <li>
                        <dw:RadioButton FieldName="ExperimentGoalType" ID="ExperimentGoalTypePageviews" FieldValue="Pageviews"
                            runat="server" OnClientClick="showInput();" />
                        <label for="ExperimentGoalTypePageviews">
                            <%= Dynamicweb.Backend.Translate.Translate("Maximize page views")%></label><br />
                    </li>
                </ul>
            </div>
        </div>
        <div class="footer">
            <input type="button" value="<%= Dynamicweb.Backend.Translate.Translate("Previous")%>" onclick="showStep('step1ChooseType');" />
            <input type="submit" value="" id="step3ChooseGoalNext" disabled="disabled" onclick="return verifyGoal();" runat="server" />
        </div>
    </div>
    <div id="step4Settings" style="display: none;">
        <div class="header">
            <h1 id="H4">
                <%= Dynamicweb.Backend.Translate.Translate("Settings for this split test.")%></h1>
        </div>
        <div class="mainArea">
            <div class="option2" style="cursor: auto;" onclick="observerAlternateLink();">
                <img src="/Admin/Images/Ribbon/Icons/Check.png" />
                <b><%= Dynamicweb.Backend.Translate.Translate("Settings")%></b>
                <ul>
                    <li><b><%= Dynamicweb.Backend.Translate.Translate("Split test name")%></b></li>
                    <li>
                        <input type="text" class="NewUIinput" name="ExperimentName" id="ExperimentName" runat="server"
                            onkeyup="validateName();" />
                    </li>
                </ul>
                <ul>
                    <input type="hidden" runat="server" id="ExperimentGoalTypeFormValueHidden" name="ExperimentGoalTypeFormValueHidden" />
                    <li><b><%= Dynamicweb.Backend.Translate.Translate("Split test type: ")%></b><label ID="TranslatelabelType" runat="server"></label></li>
                </ul>
                <ul>
                    <li><b><%= Dynamicweb.Backend.Translate.Translate("Conversion goal: ")%></b><label ID="TranslatelabelGoal" runat="server"></label></li>
                </ul>
                <ul>
                    <li><b><%= Dynamicweb.Backend.Translate.Translate("Active")%></b></li>
                    <li>
                        <dw:CheckBox FieldName="ExperimentActive" Value="True" runat="server" ID="ExperimentActive" />
                        <label for="ExperimentActive">
                            <%= Dynamicweb.Backend.Translate.Translate("This split test is active")%></label></li>
                </ul>
                <ul id="ExperimentMeasureSettings" runat="server">
                    <li><b><%= Dynamicweb.Backend.Translate.Translate("Conversion metrics")%></b></li>
                    <li>
                        <dw:RadioButton ID="ExperimentConversionMetric1200" FieldName="ExperimentConversionMetric"
                            FieldValue="1200" runat="server" />
                        <label for="ExperimentConversionMetric1200">
                           <%= Dynamicweb.Backend.Translate.Translate("Register conversion through entire visit.")%> </label><br />
                    </li>
                    <li>
                        <dw:RadioButton ID="ExperimentConversionMetric0" FieldName="ExperimentConversionMetric"
                            FieldValue="0" runat="server" />
                        <label for="ExperimentConversionMetric0">
                            <%= Dynamicweb.Backend.Translate.Translate("Register conversion in next step only.")%></label><br />
                    </li>
                </ul>
                <ul>
                    <li><b><%= Dynamicweb.Backend.Translate.Translate("Traffic sent through this split test")%></b></li>
                    <li><%= Dynamicweb.Backend.Translate.Translate("Visitors to include")%>
                        <dw:RadioButton ID="ExperimentIncludes100" FieldName="ExperimentIncludes" FieldValue="100"
                            SelectedFieldValue="0" runat="server" />
                        <label for="ExperimentIncludes100">
                            100%</label>
                        <dw:RadioButton ID="ExperimentIncludes75" FieldName="ExperimentIncludes" FieldValue="75"
                            SelectedFieldValue="0" runat="server" />
                        <label for="ExperimentIncludes75">
                            75%</label>
                        <dw:RadioButton ID="ExperimentIncludes50" FieldName="ExperimentIncludes" FieldValue="50"
                            SelectedFieldValue="0" runat="server" />
                        <label for="ExperimentIncludes50">
                            50%</label>
                        <dw:RadioButton ID="ExperimentIncludes25" FieldName="ExperimentIncludes" FieldValue="25"
                            SelectedFieldValue="0" runat="server" />
                        <label for="ExperimentIncludes25">
                            25%</label>
                        <dw:RadioButton ID="ExperimentIncludes10" FieldName="ExperimentIncludes" FieldValue="10"
                            SelectedFieldValue="0" runat="server" />
                        <label for="ExperimentIncludes10">
                            10%</label>
                    </li>
                </ul>
                <ul style="display: none;">
                    <!--Not implemented yet - does it make sense?-->
                    <li><b><%= Dynamicweb.Backend.Translate.Translate("Subsequent visiting behavior")%></b></li>
                    <li>
                        <dw:RadioButton ID="ExperimentPatternSticky" FieldName="ExperimentPattern" FieldValue="1"
                            runat="server" />
                        <label for="ExperimentPattern1">
                            <%= Dynamicweb.Backend.Translate.Translate("Sticky")%></label><br />
                        <dw:RadioButton ID="ExperimentPatternRandom" FieldName="ExperimentPattern" FieldValue="2"
                            runat="server" />
                        <label for="ExperimentPattern2">
                            <%= Dynamicweb.Backend.Translate.Translate("Random")%></label>
                    </li>
                </ul>
                <ul id="ShowToSearchEngineBotsSettings" runat="server">
                    <li><b><%= Dynamicweb.Backend.Translate.Translate("Show to search engine bots")%></b></li>
                     <li>
                        <dw:RadioButton ID="ExperimentShowToBots1" FieldName="ExperimentShowToBots" FieldValue="0"
                            runat="server" />
                        <label for="ExperimentShowToBots1">
                            <%= Dynamicweb.Backend.Translate.Translate("Show original to search engines.")%></label><br />
                    </li>
                    <li>
                        <dw:RadioButton ID="ExperimentShowToBots0" FieldName="ExperimentShowToBots" FieldValue="1"
                            runat="server" />
                        <label for="ExperimentShowToBots0">
                            <%= Dynamicweb.Backend.Translate.Translate("Show all versions to search engines.")%></label><br />
                    </li>
                </ul>
            </div>
        </div>
        <div class="footer">
            <input type="button" value="" id="SettingsPreviousBtn" runat="server" onclick="showStep('step3ChooseGoal');"/>
            <input type="button" value="" id="SettingNextBtn" disabled="disabled" runat="server" onclick="showStep('step5ExperimentEnding');"/>
        </div>
    </div>

    <div id="step5ExperimentEnding" style="display: none;">
        <div class="header">
            <h1 id="H3">
                <%= Dynamicweb.Backend.Translate.Translate("Settings for ending the split test")%></h1>
        </div>
        <div class="mainArea">
            <div class="option2" style="cursor: auto;">
                <img src="/Admin/Images/Ribbon/Icons/target2.png" />
                <b><%= Dynamicweb.Backend.Translate.Translate("End split test")%></b>
                <ul>
                    <li>
                        <dw:RadioButton FieldName="ExperimentEndingType" ID="ExperimentEndingTypeManually" FieldValue="1" 
                             runat="server" OnClientClick="showEndingTypeParams('divActionAndNotification');" />
                        <label for="ExperimentEndingTypeManually">
                            <%= Dynamicweb.Backend.Translate.Translate("Manually")%></label><br />
                    </li>
                    <%If Base.HasVersion("8.4.0.0") Then%>
                    <li>
                        <dw:RadioButton FieldName="ExperimentEndingType" ID="ExperimentEndingTypeAtGivenTime" FieldValue="2"
                            runat="server" OnClientClick="showEndingTypeParams('divAtGivenTime');" />
                        <label for="ExperimentEndingTypeAtGivenTime">
                            <%= Dynamicweb.Backend.Translate.Translate("At given time")%></label><br />
                        <div id="divAtGivenTime" style="margin-left: 22px; margin-top: 5px; display: none;">
                            <dw:DateSelector ID="sdEndDate" runat="server" IncludeTime="True" ShowAsLabel="False" /><br />
                            <select name="ExperimentEndingTypeTimeZone" id="SelectExperimentEndingTypeTimeZone" style="width: 350px;">
                                <asp:Literal ID="LiteralTimeZone" runat="server"></asp:Literal>
                            </select>
                        </div>
                    </li>
                    <li>
                        <dw:RadioButton FieldName="ExperimentEndingType" ID="ExperimentEndingTypeAfterXViews" FieldValue="3"
                            runat="server" OnClientClick="showEndingTypeParams('divAfterXViews');" />
                        <label for="ExperimentEndingTypeAfterXViews">
                            <%= Dynamicweb.Backend.Translate.Translate("After x views")%></label><br />
                        <div id="divAfterXViews" style="margin-left: 22px; margin-top: 5px; display: none;">
                            <omc:NumberSelector ID="endViewsAmount" AllowNegativeValues="false" MinValue="1" MaxValue="1000000" runat="server" />
                        </div>
                    </li>
                    <%End If%>
                    <% If IsProbabilityAvailable() Then%>
                    <li>
                        <dw:RadioButton FieldName="ExperimentEndingType" ID="ExperimentEndingTypeIsSignificant" FieldValue="4"
                             runat="server" OnClientClick="showEndingTypeParams();"/>
                        <label for="ExperimentEndingTypeIsSignificant">
                            <%= Dynamicweb.Backend.Translate.Translate("When result is significant")%></label><br />
                    </li>
                    <%End If%>
                </ul>
                <div id="divActionAndNotification" style="display: none;">
                    <ul>
                        <li><b><%= Dynamicweb.Backend.Translate.Translate("Action after split test ends")%></b></li>
                        <li>
                            <dw:CheckBox FieldName="DeleteExperiment" Value="True" runat="server" ID="cbDeleteExperiment" />
                            <label for="cbDeleteExperiment">
                                <%= Dynamicweb.Backend.Translate.Translate("Stop experiment (all data on visitors and conversions will be deleted)")%>
                            </label>
                        </li>
                    </ul>
                        <div id="divKeepVersions">
                             <ul>
                                <li>
                                    <dw:RadioButton FieldName="ExperimentEndingActionType" ID="ExperimentEndingActionTypeKeepAll" FieldValue="1" runat="server"/>
                                    <label for="ExperimentEndingActionTypeKeepAll">
                                        <%= Dynamicweb.Backend.Translate.Translate("Keep all versions with the best performing published")%></label><br />
                                </li>
                                <li>
                                    <dw:RadioButton FieldName="ExperimentEndingActionType" ID="ExperimentEndingActionTypeKeepBestPerforming" FieldValue="2" runat="server"/>
                                    <label for="ExperimentEndingActionTypeKeepBestPerforming">
                                        <%= Dynamicweb.Backend.Translate.Translate("Keep the best performing version and delete the other")%></label><br />
                                </li>
                             </ul>
                        </div>
                    <ul>
                        <li><b><%= Dynamicweb.Backend.Translate.Translate("Notification e-mail template:")%></b></li>
                        <li>
                            <dw:FileManager ID="fmTemplate" runat="server" Folder="Templates/OMC/Notifications" File="EmailExperimentAutoStop.html" />
                        </li>
                        <li><b><%= Dynamicweb.Backend.Translate.Translate("Notify following people:")%></b></li>
                        <li>
                            <omc:EditableListBox id="editNotify" runat="server"/>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="footer">
            <input type="button" value="<%= Dynamicweb.Backend.Translate.Translate("Previous")%>" onclick="showStep('step4Settings');" />
            <input type="button" value="" id="SaveExperimentBtn" runat="server"  onclick="saveExperiment();"/>
        </div>
    </div>
    </form>
    <script type="text/javascript">
        <%= _ErrorMsgJS%>
        var PageBasedSplitTestTranslated = '<%= Dynamicweb.Backend.Translate.Translate("Page based split test.")%>';
        var ContentBasedSplitTestTranslated = '<%= Dynamicweb.Backend.Translate.Translate("Content based split test.")%>';
        var OpenAnotherPageAsConversionPage = '<%= Dynamicweb.Backend.Translate.Translate("Open another page as conversion page")%>';
        var AnyItemType = '<%= Dynamicweb.Backend.Translate.Translate("Any item type")%>';
        var SubmittingAnItemFromTheItemCreatorModule = '<%= Dynamicweb.Backend.Translate.Translate("Create an item")%>';
        var SubmittingAFormFromTheFormsModule = '<%= Dynamicweb.Backend.Translate.Translate("Submitting af form from the forms module")%>';
        var AddingProductsToCart = '<%= Dynamicweb.Backend.Translate.Translate("Adding products to cart")%>';
        var PlacingAnOrder = '<%= Dynamicweb.Backend.Translate.Translate("Placing an order")%>';
        var DownloadingFile = '<%= Dynamicweb.Backend.Translate.Translate("Downloading file")%>';
        var SigningUpForNewsletter = '<%= Dynamicweb.Backend.Translate.Translate("Signing up for newsletter")%>';
        var MaximizeTimeSpentOnSite = '<%= Dynamicweb.Backend.Translate.Translate("Maximize time spent on site")%>';
        var MinimizeBounceRate = '<%= Dynamicweb.Backend.Translate.Translate("Minimize bounce rate")%>';
        var MaximizePageViews = '<%= Dynamicweb.Backend.Translate.Translate("Maximize page views")%>';
        var HighestAverageOrderValueGoalProvider = '<%= Dynamicweb.Backend.Translate.Translate("Highest average order value")%>';
        var HighestAverageMarkupGoalProvider = '<%= Dynamicweb.Backend.Translate.Translate("Highest average markup order")%>';

        validateName();
        if ($('ExperimentEndingType2') && $('ExperimentEndingType2').checked) {
            showEndingTypeParams('divAtGivenTime');
        } else if ($('ExperimentEndingType3') && $('ExperimentEndingType3').checked) {
            showEndingTypeParams('divAfterXViews');
        } else if ($('ExperimentEndingType4') && $('ExperimentEndingType4').checked) {
            showEndingTypeParams();
        }
    </script>
</body>
<%Translate.GetEditOnlineScript()%>
</html>
