<%@ Page CodeBehind="Form_Edit.aspx.vb" Language="vb" ValidateRequest="false" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Form_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="mc" Namespace="Dynamicweb.Admin.ModulesCommon" Assembly="Dynamicweb.Admin" %>

<link href="/Admin/Module/Common/Stylesheet_ParSet.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">

	function ChangeGetFromEmail(obj)
	{
		if(obj.checked) {
			document.all["FormSender"].disabled = true;
		} else {
			document.all["FormSender"].disabled = false;
		}
    }

    function ajaxLoader(url, id) {
        new Ajax.Updater(id, url, {
            asynchronous: false,
            evalScripts: true,
            method: 'get',

            onSuccess: function (request) {
                $(id).update(request.responseText);
            }
        });
    }

    function onChangeFormID(val) {
        var url = "/Admin/Module/Form/Form_Edit.aspx?AJAXCMD=SUBSCRIBE_FIELDS&formId=" + val + "&fieldName="
        ajaxLoader(url + 'UserNameField' + '&formFieldType=TextInput', 'UserNameField');
        ajaxLoader(url + 'EmailField' + '&formFieldType=TextInput', 'EmailField');
        ajaxLoader(url + 'SubscribeCheckboxField' + '&formFieldType=CheckBox', 'SubscribeCheckboxField');
    }

</script>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<input type="Hidden" name="Form_settings" value="FormID, FormSubject, FormHTML, FormRecipient, FormCC, FormBCC, FormRedirect, FormAlignment, FormReceipt, FormReceiptShowForm, FormReceiptText, FormReceiptSubject, FormSaveData, FormSaveDataDate, FormTextRequired, FormReceiptSender, FormAction, FormMailEncoding, FormSender, FormSenderUseUserEmail, Form_underscore, FormSaveDataEncoding, FormUseSystemNames, FormMailLogging,UseNewsletterSubscription,NewsletterCategories,UserNameField,EmailField,SubscribeCheckboxField,MailFormat">

<tr>
	<td>
		<%=Gui.MakeModuleHeader("form", "Formularer")%>
	</td>
</tr>
<tr>
	<td colspan=2>
		<%=Gui.GroupBoxStart(Translate.Translate("Formular"))%>
		<table cellpadding=2 cellspacing=0>
			<tr>
				<td width=170><%=Translate.Translate("Formular")%></strong></td>
				<td>
					<select name="FormID" id="FormID" onchange='onChangeFormID(this.value);' class="std">
						<%
						'cmd.CommandText = "SELECT * FROM Form ORDER BY FormName"
						    Dim dr As IDataReader = Database.CreateDataReader("SELECT * FROM Form ORDER BY FormName")
						    Do While dr.Read()
						        Dim Selected As String
						        If propObj.Value("FormID") = dr("FormID").ToString() Then
						            Selected = " Selected "
						        Else
						            Selected = ""
						        End If
						        
						        If Base.HasAccess("FormCategories", dr("FormID").ToString) Or Selected <> "" Then
						            Response.Write(("<option value=""" & dr("FormID").ToString & """ " & Selected & ">" & dr("FormName").ToString & "</Option>"))
						        End If
						    Loop
						    
						    dr.Close()
						    dr.Dispose()
						
						%>			
					</select>
				</td>
			</tr>
			<tr>
				<td valign=top><%=Translate.Translate("Send som")%></td>
				<td><%'=Gui.CheckBox(propObj.Value("FormHTML"), "FormHTML")%>
					<%=Gui.RadioButton(propObj.Value("FormHTML"), "FormHTML", "1")%>&nbsp;<label for="FormHTML1"><%=Translate.Translate("HTML")%></label><br>
					<%=Gui.RadioButton(propObj.Value("FormHTML"), "FormHTML", "Text")%>&nbsp;<label for="FormHTMLText"><%=Translate.Translate("Tekst")%></label><br>
					<%=Gui.RadioButton(propObj.Value("FormHTML"), "FormHTML", "TextLabelAbove")%>&nbsp;<label for="FormHTMLTextLabelAbove"><%=Translate.Translate("Tekst med label over værdi")%></label><br>
					<%=Gui.RadioButton(propObj.Value("FormHTML"), "FormHTML", "TextNoLabel")%>&nbsp;<label for="FormHTMLTextNoLabel"><%=Translate.Translate("Tekst uden label")%></label><br>
				</td>
			</tr>
			<% If Base.HasVersion("18.10.1.0") Then%>
			<tr>
				<td><%=Translate.Translate("Brug systemnavn som label")%></td>
				<td><%=Gui.CheckBox(propObj.Value("FormUseSystemNames"), "FormUseSystemNames")%></td>
			</tr>
			<% End If %>
			<tr>
				<td><%=Translate.Translate("Emne")%></td>
				<td><input type="Text" name="FormSubject" value="<%=propObj.Value("FormSubject")%>" maxlength="255" class="std"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Afsender") %></td>
				<td>
					<input type="Text" name="FormSender" value="<%=propObj.Value("FormSender")%>" maxlength="255" class="std" <%=IIf((propObj.Value("FormSenderUseUserEmail") = "1"), " Disabled", "")%>><br />
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>
					<input type="CheckBox" onclick="Javascript:ChangeGetFromEmail(this);" name="FormSenderUseUserEmail" <%=IIf(propObj.Value("FormSenderUseUserEmail") = "1", " Checked", "")%> value="1"><label for="FormSenderUseUserEmail"><%=Translate.Translate("Hent fra %%","%%","<em>" & Translate.Translate("E-mail felt") & "</em>")%></label>
				</td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Modtager")%></td>
				<td><input type="Text" name="FormRecipient" value="<%=propObj.Value("FormRecipient")%>" maxlength="255" class="std"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Modtager CC")%></td>
				<td><input type="Text" name="FormCC" value="<%=propObj.Value("FormCC")%>" maxlength="255" class="std"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Modtager BCC")%></td>
				<td><input type="Text" name="FormBCC" value="<%=propObj.Value("FormBCC")%>" maxlength="255" class="std"></td>
			</tr>
			<tr>
				<td valign="top"><%=Translate.Translate("Side efter indsendelse")%>&nbsp;&nbsp;</td>
				<td><%=Gui.LinkManager(propObj.Value("FormRedirect"), "FormRedirect", "")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Justering")%></td>
				<td><select name="FormAlignment" class="std">
						<option value="Right" <%If propObj.Value("FormAlignment") = "Right" Then%>SELECTED<%End If%>><%=Translate.Translate("Højre")%></option>
						<option value="Left" <%If propObj.Value("FormAlignment") = "Left" Then%>SELECTED<%End If%>><%=Translate.Translate("Venstre")%></option>
					</select></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
	</td>
</tr>
<tr>
	<td colspan=2>
		<%=Gui.GroupBoxStart(Translate.Translate("Brugerdefinerede tekster"))%>
		<table cellpadding=2 cellspacing=0>
			<tr>
				<td width=170><%=Translate.Translate("Tekst ved krævet felt")%></td>
				<td><input type="Text" name="FormTextRequired" value="<%=propObj.Value("FormTextRequired")%>" maxlength="255" class="std"></td>
			</tr>
			
		</table>
		<%=Gui.GroupBoxEnd%>
	</td>
</tr>
<tr>
	<td colspan=2>
		<%=Gui.GroupBoxStart(Translate.Translate("Databehandling"))%>
		<table cellpadding=2 cellspacing=0>
			<tr>
				<td><%=Translate.Translate("Alternativ form action")%></td>
				<td><input type="Text" name="FormAction" value="<%=propObj.Value("FormAction")%>" maxlength="255" class="std"></td>
			</tr>
			<tr>
				<td width=170><%=Translate.Translate("Gem i fil")%></td>
				<td><%=Gui.CheckBox(propObj.Value("FormSaveData"), "FormSaveData")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("1 fil pr. dag")%></td>
				<td><%=Gui.CheckBox(propObj.Value("FormSaveDataDate"), "FormSaveDataDate")%></td>
			</tr>
			<%	If Base.HasVersion("18.10.1.0") Then%>
			<tr>
				<td><%=Translate.Translate("Encoding")%></td>
				<td><%=Gui.FileEncodingList(propObj.Value("FormSaveDataEncoding"), "FormSaveDataEncoding")%></td>
			</tr>
			<%	End If%>
		</table>
		<%=Gui.GroupBoxEnd%>
	</td>
</tr>
<tr>
	<td colspan=2>
		<%=Gui.GroupBoxStart(Translate.Translate("Kvittering"))%>
		<table cellpadding=2 cellspacing=0>
			<tr>
				<td width=170><%=Translate.Translate("Send kvittering til afsender")%></td>
				<td><%=Gui.CheckBox(propObj.Value("FormReceipt"), "FormReceipt")%></td>
			</tr>
			<tr>
				<td valign=top><%=Translate.Translate("Medtag indhold fra formular")%></td>
				<td><%=Gui.CheckBox(propObj.Value("FormReceiptShowForm"), "FormReceiptShowForm")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Afsender")%></td>
				<td><input type="Text" name="FormReceiptSender" value="<%=propObj.Value("FormReceiptSender")%>" maxlength="255" class="std"></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Emne")%></td>
				<td><input type="Text" name="FormReceiptSubject" value="<%=propObj.Value("FormReceiptSubject")%>" maxlength="255" class="std"></td>
			</tr>
			<tr>
				<td valign=top><%=Translate.Translate("Tekst")%></td>
				<td><textarea class=std name="FormReceiptText" rows="15" style="width:400px;"><%=Server.HtmlEncode(propObj.Value("FormReceiptText"))%></textarea></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
	</td>
</tr>
<tr>
	<td colspan=2>
		<%=Gui.GroupBoxStart(Translate.Translate("E-mail"))%>
		<table cellpadding=2 cellspacing=0>
			<tr>
				<td width=170><%=Translate.Translate("Encoding")%></td>
				<td><%=Gui.EncodingList(propObj.Value("FormMailEncoding"), "FormMailEncoding", True, "ms_access", true) %></td>
			</tr>
			<tr>
				<td width=170><%=Translate.Translate("Logging")%></td>
				<td><%=Gui.CheckBox(propObj.Value("FormMailLogging"), "FormMailLogging")%></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
	</td>
</tr>

<tr>
	<td>
        <dw:GroupBox ID="GroupBoxNewsletterSettings" runat="server" Title="Newsletter" DoTranslation="true">
    
            <input runat="server" type="checkbox" id="UseNewsletterSubscription" value="True" />
            <label for="UseNewsletterSubscription">
                <dw:TranslateLabel runat="server" Text="Use newsletter subscription"  />
            </label>
            <br />
            <br />

            <table>
                <tr>
                    <td class="leftColHigh">
                        <dw:TranslateLabel id="lbNewsletterCategories" runat="server" Text="Categories" />
                    </td>
                    <td>
                        <mc:ListSelector runat="server" name="NewsletterCategories" Columns="2" id="NewsletterCategoriesCtrl" DataTextField="Name" DataValueField="ID"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dw:TranslateLabel id="lbDefaultFormat" runat="server" Text="E-mail format" />
                    </td>
                    <td>
                        <%= Gui.RadioButton(propObj.Value("MailFormat"), "MailFormat", "1")%>&nbsp;
                        <label for="MailFormat1">
                            <dw:TranslateLabel id="lbFormatHTML" runat="server" Text="HTML" />
                        </label>&nbsp;&nbsp;
                                        
                        <%= Gui.RadioButton(propObj.Value("MailFormat"), "MailFormat", "2")%>&nbsp;
                        <label for="MailFormat2">
                            <dw:TranslateLabel id="lbFormatText" runat="server" Text="Text" />
                        </label>&nbsp;&nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="leftColHigh">
                        <div class="nobr">
                            <dw:TranslateLabel id="lbUserNameField" runat="server" Text="User name field" />
                        </div>
                    </td>
                    <td>
                        <select name="UserNameField" id="UserNameField" class="std">
                        <asp:Literal id="UserNameFieldItems" runat="server"></asp:Literal>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="leftColHigh">
                        <div class="nobr">
                            <dw:TranslateLabel id="lbEmailField" runat="server" Text="Email field" />
                        </div>
                    </td>
                    <td>
                        <select name="EmailField" id="EmailField" class="std">
                        <asp:Literal id="EmailFieldItems" runat="server"></asp:Literal>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td class="leftColHigh">
                        <div class="nobr">
                            <dw:TranslateLabel id="lbSubscribeCheckbox" runat="server" Text="Subscribe checkbox field" />
                        </div>
                    </td>
                    <td>
                        <select name="SubscribeCheckboxField" id="SubscribeCheckboxField" class="std">
                        <asp:Literal id="SubscribeCheckboxFieldItems" runat="server"></asp:Literal>
                        </select>
                    </td>
                </tr>
            </table>
        </dw:GroupBox>
	</td>
</tr>

<%
Translate.GetEditOnlineScript()
%>
