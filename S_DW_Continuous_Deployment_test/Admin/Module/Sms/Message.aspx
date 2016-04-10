<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Message.aspx.vb" Inherits="Dynamicweb.Admin.SmsMessage" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
	<dw:ControlResources ID="ctrlResources" IncludePrototype="false" CombineOutput="true" runat="server"></dw:ControlResources>
	<script>
		function send() {
			if (document.getElementById("MessageName").value.length < 1) {
				alert(document.getElementById("specifyName").innerHTML);
				document.getElementById("MessageName").focus();
				return;
			}
			if (document.getElementById("MessageText").value.length < 1) {
				alert(document.getElementById("specifyMessage").innerHTML);
				document.getElementById("MessageText").focus();
				return;
			}
			if (document.getElementById("MessageGrouphidden").value.length < 1) {
				alert(document.getElementById("specifyRecipients").innerHTML);
				return;
			}
			if (confirm(document.getElementById("confirmSend").innerHTML)) {
			    document.getElementById("messageForm").SendButton.click();
				__o = new overlay('__ribbonOverlay'); __o.message('Sending...'); __o.show();
			} else {
				__o = new overlay('__ribbonOverlay'); __o.message(''); __o.hide();
			}
		}
		function calculate(field) {
			var msgCount = 0
			if (field.value.length > 0) {
				msgCount = Math.ceil(field.value.length / 160);
			}
			
			if (field.value.length > 120) {
				var header = 0;
				if (msgCount > 1) {
					header = 14; //If a text message is more than one message long, it uses a header to chain them
				}
				if (msgCount > 2) {
					header = 21; //If a text message is more than one message long, it uses a header to chain them
				}
				if (msgCount > 3) {
					header = 28; //If a text message is more than one message long, it uses a header to chain them
				}
				document.getElementById("charCount").innerHTML = field.value.length + "/" + ((msgCount*160)-header);
			} else {
				document.getElementById("charCount").innerHTML = "";
			}
			
			if (field.value.length>160){
				document.getElementById("msgCount").innerHTML = msgCount + " " + document.getElementById("txtmessages").innerHTML + ", ";
			} else {
				document.getElementById("msgCount").innerHTML = "";
			}
		}

		function deleteMessage() {
		    if (!Toolbar.buttonIsDisabled('cmdDelete') && confirm("<%= Translate.JsTranslate("Are you sure you want to delete this message?")%>")) {
		            document.getElementById('messageForm').DeleteButton.click();
		        };
		}
	</script>
</head>
<body onload="calculate(document.getElementById('MessageText'));">
	<form id="messageForm" runat="server">
		<dw:Toolbar ID="ToolbarButtons" runat="server" ShowEnd="false">
			<dw:ToolbarButton ID="cmdSaveAndSend" runat="server" Disabled="false" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/small/message_ok.png" OnClientClick="if(!Toolbar.buttonIsDisabled('cmdSaveAndSend')) {{ send(); }}" Text="Save and send" ShowWait="false" />
			<dw:ToolbarButton ID="cmdCancel" runat="server" Disabled="false" Divide="None" Image="Cancel" OnClientClick="location='SmsList.aspx'" Text="Cancel" />
			<dw:ToolbarButton ID="cmdHelp" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="help();" />
            <dw:ToolbarButton ID="cmdDelete" runat="server" Divide="Before" Image="Delete" Text="Delete" OnClientClick="deleteMessage();" Disabled="True"/>  
		</dw:Toolbar>
		<h2 class="subtitle">
			<dw:TranslateLabel ID="lbSetup" Text="New text message" runat="server" />
		</h2>

		<dw:GroupBox Title="Message" runat="server">
			<table cellpadding="1" cellspacing="1">
				<tr>
					<td style="width: 170px;">
						<div class="nobr">
							<dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Name" />
						</div>
					</td>
					<td>
						<input type="text" name="MessageName" id="MessageName" class="std" runat="server" />
					</td>
				</tr>
				<tr>
					<td valign="Top">
						<div class="nobr">
							<dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Message" />
						</div>
					</td>
					<td>
						<textarea class="std" rows="5" cols="100" name="MessageText" id="MessageText" onkeyup="calculate(this)" runat="server"></textarea><br />
						<small class=""><dw:TranslateLabel ID="TranslateLabel7" runat="server" Text="Available tags" />: @Name, @FirstName, @LastName</small><br />
						<span id="msgCount"></span><span id="charCount"></span><br />
						<br />
					</td>
				</tr>
				<tr>
					<td valign="Top">
						<div class="nobr">
							<dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Send to groups" />
						</div>
					</td>
					<td>
						<dw:UserSelector runat="server" ID="MessageGroup" Show="Groups, SmartSearches"></dw:UserSelector>
					</td>
				</tr>
			</table>
		</dw:GroupBox>
        
        <asp:Button ID="DeleteButton" Style="display: none" runat="server" />
        <asp:Button ID="SendButton" Style="display: none" runat="server" />
	</form>
	<span id="confirmSend" style="display: none"><dw:TranslateLabel ID="lbDelete" Text="Send" runat="server" />?</span>
	<span id="specifyName" style="display: none"><dw:TranslateLabel ID="TranslateLabel4" Text="Please specify name" runat="server" /></span>
	<span id="specifyMessage" style="display: none"><dw:TranslateLabel ID="TranslateLabel5" Text="Please specify message" runat="server" /></span>
	<span id="specifyRecipients" style="display: none"><dw:TranslateLabel ID="TranslateLabel6" Text="Please specify recipients" runat="server" /></span>
	<span id="txtmessages" style="display: none"><dw:TranslateLabel ID="TranslateLabel8" Text="messages" runat="server" /></span>
</body>
</html>
