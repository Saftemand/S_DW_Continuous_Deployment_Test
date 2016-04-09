<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BasicForms_Edit.aspx.vb" Inherits="Dynamicweb.Admin.BasicForms_Edit" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<dw:ModuleHeader ID="ModuleHeader1" runat="server" ModuleSystemName="BasicForms" />
<dw:ModuleSettings ID="ModuleSettings1" runat="server" ModuleSystemName="BasicForms" Value="FormID, UseTemplate, Template, FormSubmitButtonText, MailSubject, MailSender, MailSenderUseUserEmail, MailRecipient, MailCC, MailBCC, UseMailTemplate, MailTemplate, MailText, ReceiptSubject, ReceiptSender, ReceiptRecipient, ReceiptCC, ReceiptBCC, UseReceiptTemplate, ReceiptTemplate, ReceiptText, formSubmitAction, formSubmitPageAfterSave, formSubmitConfirmationTemplate, FormMaxSubmitAction, FormMaxSubmitsReachedPage, FormMaxSubmitsReachedTemplate, FormMaxSubmits, FormUploadPath" />

<script>
    function download() {
		if (document.getElementById("FormID").selectedIndex > 0) {
		    var formid = document.getElementById("FormID").options[document.getElementById("FormID").selectedIndex].value
		    var pageID = 0;
		    if (document.getElementById("FormMaxSubmits").value.length > 0) {
                pageid = <%=Request.QueryString("PageId") %>;
		    }
		    location = "/Admin/Module/BasicForms/ListSubmits.aspx?action=ExportCsv&headers=true&formid=" + formid + "&PageId=" + pageid;
		}
	}
	function toggleSubmitAction() {
		if (document.getElementById("formSubmitActionPageRadio").checked) {
			document.getElementById("SaveActionTemplateContainer").style.display = "none";
			document.getElementById("SaveActionPageRedirectContainer").style.display = "";
		} else {
			document.getElementById("SaveActionTemplateContainer").style.display = "";
			document.getElementById("SaveActionPageRedirectContainer").style.display = "none";
		}
		
	}
	function ChangeGetFromEmail(elm) {
		if (elm.checked) {
		    document.getElementById("MailSender").style.display = 'none';
		    document.getElementById("MailSender").disabled = true;
		    document.getElementById("MailSender").value = '';
		} else {
		    document.getElementById("MailSender").style.display = '';
		    document.getElementById("MailSender").disabled = false;
		}
	}

	function InitGetFromEmail() {
	    var e = document.getElementById("MailSenderUseUserEmail");
	    ChangeGetFromEmail(e);
	}

	

	function enableTemplate(elm, id) {
	    if (elm.checked && elm.value == '1') {
			document.getElementById(id).style.display = '';
		} else {
			document.getElementById(id).style.display = 'none';
		}
	}
	function toggleMaxSubmitAction() {
	    if (document.getElementById("FormMaxSubmitsReachedPageRadio").checked) {
	        document.getElementById("SaveActionMaxSubmitsTemplateContainer").style.display = "none";
	        document.getElementById("SaveActionMaxSubmitsPageRedirectContainer").style.display = "";
	    } else {
	        document.getElementById("SaveActionMaxSubmitsTemplateContainer").style.display = "";
	        document.getElementById("SaveActionMaxSubmitsPageRedirectContainer").style.display = "none";
	    }
	}
</script>
<dw:GroupBox ID="GroupBox1" runat="server" Title="Formular" DoTranslation="true">
	<table>
		<tr>
			<td style="width: 170px;">
				<dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Formular" />
			</td>
			<td>
				<select runat="server" id="FormID" class="std" name="FormID"></select></td>
		</tr>
		<tr>
			<td valign="top">
				<dw:TranslateLabel ID="TranslateLabel24" runat="server" Text="Template" />
			</td>
			<td>
                <input type="radio" name="UseTemplate" id="UseAutomatic" onclick="enableTemplate(this, 'templateRow');" value="0" runat="server">Automatic<br>
                <input type="radio" name="UseTemplate" id="UseTemplate" onclick="enableTemplate(this, 'templateRow');" value="1" runat="server">Template
			</td>
		</tr>
		<tr id="templateRow">
			<td>
				<dw:TranslateLabel ID="TranslateLabel21" runat="server" Text="Template" />
			</td>
			<td>
				<dw:FileManager ID="Template" Name="Template" runat="server" Folder="/Templates/Forms/Form" />
			</td>
		</tr>
		<tr>
			<td style="width: 170px;">
				<dw:TranslateLabel ID="TranslateLabel32" runat="server" Text="Tekst_på_submit" />
			</td>
			<td>
				<input type="Text" name="FormSubmitButtonText" id="FormSubmitButtonText" runat="server" value="" maxlength="255" class="std"></td>
		</tr>
		<tr runat="server" id="submitCountRow" visible="true">
			<td>
				<dw:TranslateLabel ID="TranslateLabel10" runat="server" Text="Submit" />
			</td>
			<td>
				<span runat="server" id="submitCount">
                    <span ID="SubmitCountLabel" runat="server" /> <dw:TranslateLabel ID="SubmitCountOfLabel" runat="server" Text="of" /> 
                    <span ID="MaxSubmitCountLabel" runat="server" /> 
				</span> <dw:TranslateLabel ID="TranslateLabel16" runat="server" Text="submits" />
				<button onclick="download();return false;"><dw:TranslateLabel ID="TranslateLabel22" runat="server" Text="Export csv" /></button>
			</td>
		</tr>
	</table>
</dw:GroupBox>

<dw:GroupBox ID="GroupBox4" runat="server" Title="When submitting form" DoTranslation="true">
	<table>
		<tr>
            <td style="width: 170px;vertical-align:top;">
                <dw:TranslateLabel runat="server" Text="When submitting form" />
            </td>
            <td>
                <input type="radio" name="formSubmitAction" value="page" id="formSubmitActionPageRadio" onclick="toggleSubmitAction();" runat="server" /><label for="formSubmitActionPageRadio"><dw:TranslateLabel runat="server" Text="Redirect to page" /></label><br />
                <input type="radio" name="formSubmitAction" value="template" id="formSubmitActionTemplateRadio" onclick="toggleSubmitAction();" runat="server" /><label for="formSubmitActionTemplateRadio"><dw:TranslateLabel runat="server" Text="Use confirmation template" /></label>
            </td>
        </tr>
		<tr id="SaveActionPageRedirectContainer">
            <td>
                 <dw:TranslateLabel ID="TranslateLabel14" runat="server" Text="Page after submission" />
            </td>
            <td>
                <dw:LinkManager ID="formSubmitPageAfterSave" name="formSubmitPageAfterSave" DisableTyping="False" DisableParagraphSelector="True" runat="server" DisableFileArchive="true" />
            </td>
        </tr>
		<tr id="SaveActionTemplateContainer">
			<td>
				<dw:TranslateLabel ID="TranslateLabel15" runat="server" Text="Confirmation template" />
			</td>
			<td>
				<dw:FileManager ID="formSubmitConfirmationTemplate" Name="formSubmitConfirmationTemplate" runat="server" Folder="/Templates/Forms/Confirmation" />
			</td>
		</tr>
	</table>
</dw:GroupBox>

<dw:GroupBox ID="GroupBox2" runat="server" Title="Mail" DoTranslation="true">
	<table>
		<tr>
			<td style="width: 170px;">
				<dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Emne" />
			</td>
			<td>
				<input type="Text" name="MailSubject" id="MailSubject" runat="server" value="" maxlength="255" class="std"></td>
		</tr>
		<tr>
			<td valign="top">
				<dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Afsender" />
			</td>
			<td>
				<div id="MailSenderCell" runat="server"><input type="Text" name="MailSender" id="MailSender" runat="server" value="" maxlength="255" class="std" title="user@domain.com"></div>
				<input type="checkBox" name="MailSenderUseUserEmail" id="MailSenderUseUserEmail" onclick="ChangeGetFromEmail(this);" runat="server"><label for="MailSenderUseUserEmail"><%=Translate.Translate("Hent fra %%","%%","<em>" & Translate.Translate("E-mail felt") & "</em>")%></label>
			</td>
		</tr>
		<tr>
			<td style="height:5px;"></td>
		</tr>
		<tr>
			<td valign="top">
				<dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Modtager" />
			</td>
			<td>
				<input type="Text" name="MailRecipient" id="MailRecipient" runat="server" value="" maxlength="255" class="std" title="user@domain.com, user2@domain.com">
			</td>
		</tr>
		<tr>
			<td valign="top">
				<dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Modtager CC" />
			</td>
			<td>
				<input type="Text" name="MailCC" id="MailCC" runat="server" value="" maxlength="255" class="std" title="user@domain.com, user2@domain.com">
			</td>
		</tr>
		<tr>
			<td valign="top">
				<dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="Modtager BCC" />
			</td>
			<td>
				<input type="Text" name="MailBCC" id="MailBCC" runat="server" value="" maxlength="255" class="std" title="user@domain.com, user2@domain.com">
			</td>
		</tr>
		<tr>
			<td valign="top">
				<dw:TranslateLabel ID="TranslateLabel26" runat="server" Text="Template" />
			</td>
			<td>
                <input type="radio" name="UseMailTemplate" id="UseMailAutomatic" onclick="enableTemplate(this, 'MailTemplateRow');" value="0" runat="server">Automatic<br>
                <input type="radio" name="UseMailTemplate" id="UseMailTemplate" onclick="enableTemplate(this, 'MailTemplateRow');" value="1" runat="server">Template
			</td>
		</tr>
		<tr id="MailTemplateRow">
			<td>
				<dw:TranslateLabel ID="TranslateLabel7" runat="server" Text="Template" />
			</td>
			<td>
				<dw:FileManager ID="MailTemplate" Name="MailTemplate" runat="server" Folder="/Templates/Forms/Mail" />
			</td>
		</tr>
		<tr>
			<td valign="top">
				<dw:TranslateLabel ID="TranslateLabel17" runat="server" Text="Tekst" />
			</td>
			<td>
				<div id="MailTextPreview" runat="server" class="std" style="width:350px;min-height:100px;" onclick="showDialog('MailTextDialog');">
				</div>
				<button onclick="showDialog('MailTextDialog');return false;"><dw:TranslateLabel ID="TranslateLabel19" runat="server" Text="Edit or add text" /></button>
			</td>
		</tr>
	</table>
</dw:GroupBox>

<dw:dialog ID="MailTextDialog" runat="server" Width="600" OkAction="updateMailText();" ShowOkButton="true" ShowClose="false" IsModal="true" SnapToScreen="true">
	<dw:editor id="MailText" runat="server" Width="600" Height="100" ForceNew="true" InitFunction="true" WindowsOnLoad="false" GetClientHeight="true" />
</dw:dialog>

<dw:GroupBox ID="GroupBox3" runat="server" Title="Kvittering" DoTranslation="true">
	<table>
		<tr>
			<td style="width: 170px;">
				<dw:TranslateLabel ID="TranslateLabel8" runat="server" Text="Emne" />
			</td>
			<td>
				<input type="Text" name="ReceiptSubject" id="ReceiptSubject" runat="server" value="" maxlength="255" class="std"></td>
		</tr>
		<tr id="Tr1" runat="server">
			<td style="width: 170px;">
				<dw:TranslateLabel ID="TranslateLabel9" runat="server" Text="Afsender" />
			</td>
			<td>
				<input type="Text" name="ReceiptSender" id="ReceiptSender" runat="server" value="" maxlength="255" class="std" title="user@domain.com"></td>
		</tr>
		
		<tr>
			<td>
				<dw:TranslateLabel ID="TranslateLabel11" runat="server" Text="Modtager CC" />
			</td>
			<td>
				<input type="Text" name="ReceiptCC" id="ReceiptCC" runat="server" value="" maxlength="255" class="std" title="user@domain.com, user2@domain.com"></td>
		</tr>
		<tr>
			<td style="width: 170px;">
				<dw:TranslateLabel ID="TranslateLabel12" runat="server" Text="Modtager BCC" />
			</td>
			<td>
				<input type="Text" name="ReceiptBCC" id="ReceiptBCC" runat="server" value="" maxlength="255" class="std" title="user@domain.com, user2@domain.com"></td>
		</tr>
		<tr>
			<td valign="top">
				<dw:TranslateLabel ID="TranslateLabel30" runat="server" Text="Template" />
			</td>
			<td>
                <input type="radio" name="UseReceiptTemplate" id="UseReceiptAutomatic" onclick="enableTemplate(this, 'ReceiptTemplateRow');" value="0" runat="server">Automatic<br>
                <input type="radio" name="UseReceiptTemplate" id="UseReceiptTemplate" onclick="enableTemplate(this, 'ReceiptTemplateRow');" value="1" runat="server">Template
			</td>
		</tr>
		<tr id="ReceiptTemplateRow">
			<td>
				<dw:TranslateLabel ID="TranslateLabel13" runat="server" Text="Template" />
			</td>
			<td>
				<dw:FileManager ID="ReceiptTemplate" Name="ReceiptTemplate" runat="server" Folder="/Templates/Forms/Mail" />
			</td>
		</tr>
		<tr>
			<td valign="top">
				<dw:TranslateLabel ID="TranslateLabel18" runat="server" Text="Tekst" />
			</td>
			<td>
				<div id="ReceiptTextPreview" runat="server" class="std" style="width:350px;min-height:100px;" onclick="showDialog('ReceiptTextDialog');">
				</div>
				<button onclick="showDialog('ReceiptTextDialog');return false;"><dw:TranslateLabel ID="TranslateLabel20" runat="server" Text="Edit or add text" /></button>
			</td>
		</tr>
	</table>
</dw:GroupBox>

<dw:dialog ID="ReceiptTextDialog" runat="server" Width="600" OkAction="updateReceiptText();" ShowOkButton="true" ShowClose="false" IsModal="true" SnapToScreen="true">
	<dw:editor id="ReceiptText" runat="server" Width="600" Height="100" ForceNew="true" InitFunction="true" WindowsOnLoad="false" GetClientHeight="true" />
</dw:dialog>



<script>
	function showDialog(name) {
		dialog.show(name);
		document.getElementById(name).scrollIntoView();
	}
	function updateReceiptText() {
		//alert(CKEDITOR.instances['ReceiptText'].getData());
		document.getElementById('ReceiptTextPreview').innerHTML = CKEDITOR.instances['ReceiptText'].getData();
		dialog.hide('ReceiptTextDialog');
		document.getElementById('ReceiptTextPreview').scrollIntoView();
	}
	function updateMailText() {
		//alert(CKEDITOR.instances['ReceiptText'].getData());
		document.getElementById('MailTextPreview').innerHTML = CKEDITOR.instances['MailText'].getData();
		dialog.hide('MailTextDialog');
		document.getElementById('MailTextPreview').scrollIntoView();
	}
	//function updateMaxSubmitsReachedText() {
		//alert(CKEDITOR.instances['ReceiptText'].getData());
		//document.getElementById('MaxSubmitsReachedTextPreview').innerHTML = CKEDITOR.instances['MaxSubmitsReachedText'].getData();
		//dialog.hide('MaxSubmitsReachedTextDialog');
		//document.getElementById('MaxSubmitsReachedTextPreview').scrollIntoView();
	//}
	toggleSubmitAction();
	enableTemplate(document.getElementById("UseTemplate"), 'templateRow');
	enableTemplate(document.getElementById("UseMailTemplate"), 'MailTemplateRow');
	enableTemplate(document.getElementById("UseReceiptTemplate"), 'ReceiptTemplateRow');

</script>

<dw:GroupBox ID="MaxSubmitsReachedTextGroup" runat="server" Title="Max submits" DoTranslation="true">
	<table>
        <tr id="MaxSubmitsAllowedContainer">
            <td>
                 <dw:TranslateLabel ID="TranslateLabel23" runat="server" Text="Max submits on this page" /> (<span ID="MaxSubmitsOnForm" runat="server" />)
            </td>
            <td>
                <input type="text" name="FormMaxSubmits" id="FormMaxSubmits" runat="server" enableviewstate="false" maxlength="255" class="NewUIinput" />
            </td>
        </tr>
		<tr>
            <td style="width: 170px;vertical-align:top;">
                <dw:TranslateLabel runat="server" Text="When max submits is reached" />
            </td>
            <td>
                <input type="radio" name="FormMaxSubmitAction" value="page" id="FormMaxSubmitsReachedPageRadio" onclick="toggleMaxSubmitAction();" runat="server" /><label for="FormMaxSubmitsReachedPageRadio"><dw:TranslateLabel runat="server" Text="Redirect to page" /></label><br />
                <input type="radio" name="FormMaxSubmitAction" value="template" id="FormMaxSubmitsReachedTemplateRadio" onclick="toggleMaxSubmitAction();" runat="server" /><label for="FormMaxSubmitsReachedTemplateRadio"><dw:TranslateLabel runat="server" Text="template" /></label>
            </td>
        </tr>
		<tr id="SaveActionMaxSubmitsPageRedirectContainer">
            <td>
                 <dw:TranslateLabel ID="FormMaxSubmitsReachedPageLabel" runat="server" Text="Page" />
            </td>
            <td>
                <dw:LinkManager ID="FormMaxSubmitsReachedPage" name="FormMaxSubmitsReachedPage" DisableTyping="False" DisableParagraphSelector="True" runat="server" DisableFileArchive="true" />
            </td>
        </tr>
		<tr id="SaveActionMaxSubmitsTemplateContainer">
			<td>
				<dw:TranslateLabel ID="FormMaxSubmitsReachedTemplateLabel" runat="server" Text="Template" />
			</td>
			<td>
				<dw:FileManager ID="FormMaxSubmitsReachedTemplate" Name="FormMaxSubmitsReachedTemplate" runat="server" Folder="/Templates/Forms/Confirmation" />
			</td>
		</tr>
	</table>
</dw:GroupBox>

<dw:GroupBox ID="GroupBox5" runat="server" Title="Upload settings" DoTranslation="true">
	<table>
        <tr id="FormUploadPathContainer">
            <td style="width: 170px;vertical-align:top;">
                 <dw:TranslateLabel ID="TranslateLabel28" runat="server" Text="Upload path" />
            </td>
            <td>
                <dw:FolderManager ID="FormUploadPath" name="FormUploadPath" DisableTyping="False" DisableParagraphSelector="True" runat="server" DisableFileArchive="False" />
            </td>
        </tr>
	</table>
</dw:GroupBox>

<script>
    toggleMaxSubmitAction();
    InitGetFromEmail();
</script>