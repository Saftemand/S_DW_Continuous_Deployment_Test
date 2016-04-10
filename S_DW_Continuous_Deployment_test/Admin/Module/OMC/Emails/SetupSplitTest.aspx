<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SetupSplitTest.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Emails.SetupSplitTest" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <dw:ControlResources ID="ControlResources1" runat="server" IncludeUIStylesheet="true" IncludePrototype="false"/>
    <link rel="StyleSheet" href="/Admin/Module/OMC/Experiments/Setup.css" type="text/css" />
    <title>Setup split test</title>
    <script type="text/javascript">

        function submitSplitTest() {
             $('splitTestSetupForm').request({
                method: 'post',
                parameters: { ValidateEndTime: true},
                onSuccess: function (transport) {
                    if (transport.responseText.length > 0 ) {
                        alert(transport.responseText);
                    } else {
                        if (confirm('<%= Dynamicweb.Backend.Translate.Translate("This will start the split test. Do you wish to continue?")%>')) {
                            document.getElementById("cmdSave").value = "saveSplitTest";
                            document.getElementById("splitTestSetupForm").submit();
                        } else {
                            return false;
                        }
                    }
                }
            });
        }

        function cancelSplitTest() {
            parent.OMC.MasterPage.get_current().hideDialog();
        }

        function validateInputs(elementID) {
            var inputValue = document.getElementById(elementID).value;
            var num = parseInt(inputValue) || 0;
            if (inputValue.length > 0 && num != 0 ) {
                document.getElementById("SaveExperimentBtn").disabled = false;
                document.getElementById(elementID).value = num;
            }else {
                if (inputValue.length > 0 && num == 0) {
                    document.getElementById(elementID).value = num;
                }
                document.getElementById(elementID).focus();
                document.getElementById("SaveExperimentBtn").disabled = true;
            }

            if (elementID == "txtRecipients") {
                validateRecipientsNumber(elementID, 'lstRecipients');
            } else if (elementID == "txtAmountOfOpened") {
                validateRecipientsNumber(elementID, 'lstStopRecipients');
            } 
        }

        function validateRecipientsNumber(elementID, dropDownListID) {
            var inputValue = $(elementID).value;
            var num = parseInt(inputValue) || 0;

            if (document.getElementById(dropDownListID).value == '1' && num != 0 && num > 100) {
                $(elementID).value = 100;
            } else if (document.getElementById(dropDownListID).value == '2' && num != 0) {
                //var numberOfRecipients = <%=RecipientsCount%>;
                //if (num != 0 && num > numberOfRecipients) {
                    //$(elementID).value = numberOfRecipients;
                //}
                if (num < 0)
                    $(elementID).value = 0;
            }
            return true;
        }

        function showScheduleDate(box) {
            if (!document.getElementById("StartDate2").checked) {
                document.getElementById("ScheduleDateSelectorDiv").style.display = "none";
            } else {
                document.getElementById("ScheduleDateSelectorDiv").style.display = "";
            }
        }

        function showAfterPickingWinner(box) {
            if (!document.getElementById("EndTestType4").checked) {
                document.getElementById("AfterPickingWinnerDiv").style.display = "";
            } else {
                document.getElementById("AfterPickingWinnerDiv").style.display = "none";
            }
        }

        function disableControls() {
            $('StartDate1').disable();
            $('StartDate2').disable();

            $('EndTestType1').disable();
            $('EndTestType2').disable();
            $('EndTestType3').disable();
            $('EndTestType4').disable();

            $('SendBest').disable();
            $('NotifyEmails').disable();
        }
    </script>
</head>
<body>
    <form id="splitTestSetupForm" runat="server" method="post" action="SetupSplitTest.aspx">
    <input type="hidden" runat="server" id="cmdSave" name="cmdSave" value=""/>
    <input type="hidden" runat="server" id="spltNewsletterId" name="spltNewsletterId" value=""/> 
    <input type="hidden" runat="server" id="spltNewsletterName" name="spltNewsletterName" value=""/> 
    <input type="hidden" runat="server" id="spltParentClientInstance" name="spltParenClientInstance" value=""/> 
    <input type="hidden" runat="server" id="settingsMode" name="settingsMode" value=""/> 
    <div>
        <div class="header">
            <h1 id="headerTitle" runat="server"></h1>
        </div>
        <div class="mainArea">
        <dw:GroupBox ID="GroupBoxRecipients" runat="server" DoTranslation="True" Title="Test recipients">
            <input type="text" class="NewUIinput" name="ExperimentName" id="txtRecipients" runat="server" style="width:50px;" onblur="validateInputs('txtRecipients');" />
            <asp:DropDownList ID="lstRecipients" runat="server" class="NewUIinput" style="width:80px" onchange="validateRecipientsNumber('txtRecipients', 'lstRecipients');">
                <asp:ListItem Selected="True" Text="%" Value="1"></asp:ListItem>
                <asp:ListItem Selected="False" Value="2"></asp:ListItem>
            </asp:DropDownList>
        </dw:GroupBox>

        <dw:GroupBox ID="GroupBoxGoal" runat="server" DoTranslation="True" Title="Conversion Goal">
            <table>
                <tr>
                    <td>
                        <dw:RadioButton ID="rbBestEngagement" runat="server" FieldName="ConversionGoal" FieldValue="bestengagement"/>
                        <dw:TranslateLabel id="TranslateLabel4" Text="Best Engagement" runat="server" /><br />
                    </td>
                </tr>
                <tr>
                    <td>
                        <dw:RadioButton ID="rbMostOpened" runat="server" FieldName="ConversionGoal" FieldValue="mostopened"/>
                        <dw:TranslateLabel id="TranslateLabel5" Text="Most Opened" runat="server" /><br />
                    </td>
                </tr>
                <tr>
                    <td>
                        <dw:RadioButton ID="rbMostClicked" runat="server" FieldName="ConversionGoal" FieldValue="mostclicked"/>
                        <dw:TranslateLabel id="TranslateLabel6" Text="Most Clicked" runat="server" /><br />
                    </td>
                </tr>
            </table>
        </dw:GroupBox>

        <dw:GroupBox ID="GroupBoxStart" runat="server" DoTranslation="True" Title="Start Test">
            <table>
                <tr>
                    <td>
                        <dw:RadioButton ID="rbStartNow" runat="server" FieldName="StartDate" FieldValue="1" OnClientClick="showScheduleDate(this);" />
                        <dw:TranslateLabel id="TranslateLabel9" Text="Start test now" runat="server" /><br />
                    </td>
                </tr>
                <tr>
                    <td>
                        <dw:RadioButton ID="rbScheduleTest" runat="server" FieldName="StartDate" FieldValue="2" OnClientClick="showScheduleDate(this);"/>
                        <dw:TranslateLabel id="TranslateLabel10" Text="Schedule test" runat="server" /><br />
                    </td>
                </tr>
                <tr id="ScheduleDateSelectorDiv" style="display: none;">
                    <td>
                        <dw:DateSelector ID="dsStartDate" runat="server" IncludeTime="True" ShowAsLabel="False" />
                        <asp:DropDownList runat="server" ID="ScheduledSendTimeZone" DataTextField="Text" DataValueField="Value" Style="width: 350px;" CssClass="std" />
                    </td>
                </tr>
            </table>
        </dw:GroupBox>

        <dw:GroupBox ID="GroupBoxEnd" runat="server" DoTranslation="True" Title="Pick the winner">
            <table>
                <tr>
                    <td style="width: 170px;">
                        <dw:RadioButton ID="endAfterXHours" runat="server" FieldName="EndTestType" FieldValue="1"  OnClientClick="showAfterPickingWinner(this);"/>
                        <dw:TranslateLabel id="lbEndAfterXHours" Text="After X Hours" runat="server" /><br />
                    </td>
                    <td>
                        <omc:NumberSelector ID="EndHoursAmount" AllowNegativeValues="false" MinValue="1" MaxValue="24" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 170px;">
                        <dw:RadioButton ID="endAtGivenTime" runat="server" FieldName="EndTestType" FieldValue="2"  OnClientClick="showAfterPickingWinner(this);"/>
                        <dw:TranslateLabel id="TranslateLabel1" Text="At Given Time" runat="server" /><br />
                    </td>
                    <td>
                        <dw:DateSelector ID="sdEndDate" runat="server" IncludeTime="True" ShowAsLabel="False" />
                        <asp:DropDownList runat="server" ID="ScheduledWinnerTimeZone" DataTextField="Text" DataValueField="Value" Style="width: 350px;" CssClass="std" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 170px;">
                        <dw:RadioButton ID="endWhenXHasOpened" runat="server" FieldName="EndTestType" FieldValue="3"  OnClientClick="showAfterPickingWinner(this);"/>
                        <dw:TranslateLabel id="TranslateLabel3" Text="When X Has Opened" runat="server" /><br />
                    </td>
                    <td>
                        <input type="text" class="NewUIinput" name="ExperimentName" id="txtAmountOfOpened" runat="server" style="width:50px" onblur="validateInputs('txtAmountOfOpened');" />
                        <asp:DropDownList ID="lstStopRecipients" runat="server" class="NewUIinput" style="width:80px" onchange="validateRecipientsNumber('txtAmountOfOpened', 'lstStopRecipients');">
                            <asp:ListItem Selected="True" Text="%" Value="1"></asp:ListItem>
                            <asp:ListItem Selected="False" Value="2"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="width: 170px;">
                        <dw:RadioButton ID="endManually" runat="server" FieldName="EndTestType" FieldValue="4" OnClientClick="showAfterPickingWinner(this);"/>
                        <dw:TranslateLabel id="TranslateLabel2" Text="Manually" runat="server" /><br />
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
        </dw:GroupBox>
        <div id="AfterPickingWinnerDiv">
            <dw:GroupBox ID="GroupBoxAfter" runat="server" DoTranslation="True" Title="After picking the winner">
                <table>
                    <tr>
                        <td valign="top">
                            <dw:CheckBox ID="chkNotifyEmails" FieldName="NotifyEmails" runat="server"/>
                            <dw:TranslateLabel ID="TranslateLabel7" runat="server" Text="Notify following people:"/>
                        </td>
                        <td>
                            <omc:EditableListBox id="editNotify" runat="server"/>
                        </td>
                    </tr>
                </table>
            </dw:GroupBox>
        </div>
        </div>

        <div class="footer">
            <input type="button" value="" id="SaveExperimentBtn" runat="server" onclick="submitSplitTest();" />
            <input type="button" value="" id="CancelBtn" runat="server" onclick="cancelSplitTest();" />
        </div>
    </div>
    </form>
    <%Translate.GetEditOnlineScript()%>
</body>
</html>
