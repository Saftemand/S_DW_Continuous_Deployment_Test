<%@ Page CodeBehind="Form_Module_Edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Form_Module_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<%

Dim ShowTab As String
Dim FormEmailFieldID As String
Dim FormColumnShiftFormFieldID As String
Dim FormID As String
Dim FormLabelOverField As Boolean
Dim FormLabelRequired As String
Dim FormName As String
Dim FormLabelBold As String

	Dim recordCount As Integer = 0
Dim i As Integer

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title></title>
		<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
        <link rel="Stylesheet" type="text/css" href="Form.css" />
        <dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
	</head>
	<script>
     function helpLink()
         {
            <%= Gui.Help("news", "modules.news.general.list")%>;
         }
function ValidateForm(){
	FormOK = true;
	if(document.getElementById('FormForm').FormName.value.length <= 0){
		alert('<%=Translate.JSTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>');
		document.getElementById('FormForm').FormName.focus();
		FormOK = false;
	}
	if(document.getElementById('FormForm').FormName.value.length > 200){
		alert("<%=Translate.JSTranslate("Max %% tegn i: ","%%","200")%><%=Translate.JSTranslate("Navn")%>");
		document.getElementById('FormForm').FormName.focus();
		FormOK = false;
	}
	if(FormOK){
		return true;
	}else{
		return false;
	}
}

function ins_mover(pid){
	document.getElementById("i" + pid).src='../../images/nothing.gif'
}
function ins_mout(pid){
	document.getElementById("i" + pid).src='../../images/ins.gif'
}
function ins_clk(intSort){
	if(parseInt(intSort) != "NaN"){
		intSort = parseInt(intSort);
	}
	else{
		intSort = 1;
	}
	location = 'Form_Module_Field_Edit.aspx?FormFieldFormID=<%=request.QueryString.Item("FormID")%>&NewSort=' + intSort;
}

function DeleteFormField(lclFormFieldID,lclFormFieldName){
	if (confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JsTranslate("felt"))%>\n(' +  lclFormFieldName + ')')){
			location = "Form_Module_Field_Del.aspx?FormFieldID=" + lclFormFieldID + "&FormID=<%=request.QueryString.Item("FormID")%>";
	}
}
</script>


<%=Gui.MakeHeaders(Translate.Translate("%m% - Rediger %c%","%m%",Translate.Translate("Formularer",9),"%c%",Translate.Translate("formular")), Translate.Translate("Formular"), "all")%>
	
<%
If CInt(request.QueryString.Item("FormID")) < 1 Then
	FormID = "0"
Else
	FormID = request.QueryString.Item("FormID")
End If

If IsNothing(request.QueryString.GetValues("ShowTab")) Then
	ShowTab = "Tab1"
Else
	ShowTab = request.QueryString.Item("ShowTab")
End If

Dim cnForm		As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
Dim cmdForm		As IDbCommand		= cnForm.CreateCommand

If Not FormID = "0" Then
	cmdForm.CommandText = "SELECT * FROM Form WHERE FormID = " & FormID
	Dim drForm as IDataReader = cmdForm.ExecuteReader()
	If drForm.Read() Then
		
		FormName					= drForm("FormName").ToString
		FormEmailFieldID			= drForm("FormEmailFieldID").ToString
		FormColumnShiftFormFieldID	= drForm("FormColumnShiftFormFieldID").ToString
		FormLabelOverField			= Base.ChkBoolean(drForm("FormLabelOverField").ToString)
		FormLabelBold				= Base.ChkBoolean(drForm("FormLabelBold").ToString)
		FormLabelRequired			= Trim(drForm("FormLabelRequired").ToString)
	
	End If
	drForm.Close()
	drForm.Dispose()
Else
	FormName					= Base.ChkValue(Request("FormName"))
	FormEmailFieldID			= Base.ChkValue(Request("FormEmailFieldID"))
	FormColumnShiftFormFieldID	= Base.ChkValue(Request("FormColumnShiftFormFieldID"))
	FormLabelOverField			= Base.ChkBoolean(Request("FormLabelOverField"))
	FormLabelBold				= Base.ChkBoolean(Request("FormLabelBold"))
	FormLabelRequired			= Trim(Base.ChkValue(Request("FormLabelRequired")))
	
End If

cmdForm.CommandText = "SELECT Count(*) FROM FormField WHERE FormFieldFormID = " & FormID
recordCount = cmdForm.ExecuteScalar()

cmdForm.CommandText = "SELECT * FROM FormField WHERE FormFieldFormID = " & FormID & " ORDER BY FormFieldSort ASC"
Dim drFormField As IDataReader = cmdForm.ExecuteReader()

%>
	<table border="0" cellpadding="0" cellspacing="0" class="TabTable">
		<form action="Form_Module_Save.aspx" method="post" name="FormForm" id="FormForm">
			<input type="Hidden" name="FormID" value="<%=FormID%>">
			  <dw:Toolbar ID="SurveyToolbar" runat="server" ShowStart="true"  ShowEnd="false">
                      <dw:ToolbarButton ID="tSave" runat="server" OnClientClick="JavaScript:if(ValidateForm()){document.getElementById('FormForm').submit()};" Image="SaveAndClose" Text="Save">
                       </dw:ToolbarButton>
                       <dw:ToolbarButton ID="tbStart" runat="server" OnClientClick="window.location.href='Form_Module_List.aspx';" Image="Cancel" Text="Close" Divide="After">
                       </dw:ToolbarButton>
                       <dw:ToolbarButton ID="tbHelp" runat="server" Image="Help" Text="Help" OnClientClick="helpLink();">
                       </dw:ToolbarButton>
                    </dw:Toolbar>
            <tr class="WhiteBackground">
				<td valign="top"><br>
					<div id="Tab1" style="display:;">
						<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
						<table border="0" cellpadding="2" cellspacing="0">
							<tr>
								<td width="170">&nbsp;<%=Translate.Translate("Navn")%>&nbsp;</td>
								<td><input type="Text" name="FormName" value="<%=Server.HtmlEncode(FormName)%>" maxlength="255" class="std"><input type="Hidden" name="FormNameOld" value="<%=Server.HtmlEncode(FormName)%>" maxlength="255"></td>
							</tr>
							<tr>
								<td width="170">&nbsp;<%=Translate.Translate("E-mail felt")%>&nbsp;</td>
								<td><%=Gui.FieldList("FormEmailFieldID", FormEmailFieldID, drFormField, cmdForm)%></td>
							</tr>
							<tr>
								<td>&nbsp;<%=Translate.Translate("Kolonneskift efter")%>&nbsp;</td>
								<td><%=Gui.FieldList("FormColumnShiftFormFieldID", FormColumnShiftFormFieldID, drFormField, cmdForm)%></td>
							</tr>
							<tr>
								<td>&nbsp;<%=Translate.Translate("Felt under navn")%>&nbsp;</td>
								<td><%=Gui.CheckBox(FormLabelOverField, "FormLabelOverField")%></td>
							</tr>
							<tr>
								<td>&nbsp;<%=Translate.Translate("Feltnavn med fed")%>&nbsp;</td>
								<td><%=Gui.CheckBox(FormLabelBold, "FormLabelBold")%></td>
							</tr>
							<tr>
								<td>&nbsp;<%=Translate.Translate("Ikon ved krævet felt")%>&nbsp;</td>
								<td><%= Gui.FileManager(FormLabelRequired, Dynamicweb.Content.Management.Installation.ImagesFolderName, "FormLabelRequired")%></td>
							</tr>
							<tr>
								<td colspan="2">&nbsp;</td>
							</tr>
						</table>
						<%=Gui.GroupBoxEnd%>
					
						<%
						If IsNumeric(FormID) And CInt(FormID) > 0 Then%>
						<%=Gui.GroupBoxStart(Translate.Translate("Felter"))%>
						<table border="0" cellpadding="0" width="570">
							<tr>
								<td><strong><%=Translate.Translate("Felt tekst")%></strong></td>
								<td><strong><%=Translate.Translate("Systemnavn")%></strong></td>
								<td><strong><%=Translate.Translate("Type")%></strong></td>
								<td align="center"><strong><%=Translate.Translate("Sortering")%></strong></td>
								<td align="center"><strong><%=Translate.Translate("Aktiv")%></strong></td>
								<td align="center"><strong><nobr><%=Translate.Translate("Slet")%></nobr></strong></td>
							</tr>
							<%MakeDivider("0", "0", "569")%>
<%
	i = 0
	Do While drFormField.Read()
		i = i + 1
		Response.Write(("<tr>"))
		Response.Write(("<td><a href=""Form_Module_Field_Edit.aspx?FormFieldID=" & drFormField("FormFieldID").ToString & """> " & Server.HtmlEncode(drFormField("FormFieldName").ToString()) & "</a></td>"))
		Response.Write(("<td>" & drFormField("FormFieldSystemName").ToString & "</td>"))
		Response.Write(("<td>" & Gui.FieldType(drFormField("FormFieldType").ToString) & "</td>"))
		If recordCount = 1 Then
			Response.Write(("<td align=""center""><img src=""../../images/Nothing.gif"" width=""15"">&nbsp;<a href=""Form_Module_Field_Sort.aspx?SortDirection=Down&FormFieldID=" & drFormField("FormFieldID").ToString & "&FormID=" & FormID & """><img src=""../../images/Nothing.gif"" border=""0""></a></td>"))
		ElseIf i = 1 Then
			Response.Write(("<td align=""center""><img src=""../../images/Nothing.gif"" width=""15"">&nbsp;<a href=""Form_Module_Field_Sort.aspx?SortDirection=Down&FormFieldID=" & drFormField("FormFieldID").ToString & "&FormID=" & FormID & """><img src=""../../images/PilNed.gif"" alt=""" & Translate.JsTranslate("Flyt ned") & """ border=""0""></a></td>"))
		ElseIf i = recordCount Then 
			Response.Write(("<td align=""center""><a href=""Form_Module_Field_Sort.aspx?SortDirection=Up&FormFieldID=" & drFormField("FormFieldID").ToString & "&FormID=" & FormID & """><img src=""../../images/PilOp.gif"" alt=""" & Translate.JsTranslate("Flyt op") & """ border=""0""></a>&nbsp;<img src=""../../images/nothing.gif"" width=""15""></a></td>"))
		Else
			Response.Write(("<td align=""center""><a href=""Form_Module_Field_Sort.aspx?SortDirection=Up&FormFieldID=" & drFormField("FormFieldID").ToString & "&FormID=" & FormID & """><img src=""../../images/PilOp.gif"" alt=""" & Translate.JsTranslate("Flyt op") & """ border=""0""></a>&nbsp;<a href=""Form_Module_Field_Sort.aspx?SortDirection=Down&FormFieldID=" & drFormField("FormFieldID").ToString & "&FormID=" & FormID & """><img src=""../../images/PilNed.gif"" alt=""" & Translate.JsTranslate("Flyt ned") & """ border=""0""></a></td>"))
		End If
		If drFormField("FormFieldActive") Then
			Response.Write("<td align=""center""><a href=""Form_Module_Field_SetActive.aspx?SetActive=False&FormFieldID=" & drFormField("FormFieldID").ToString & "&FormID=" & FormID & """><img src=""../../images/Check.gif"" border=""0""></a></td>")
		Else
			Response.Write("<td align=""center""><a href=""Form_Module_Field_SetActive.aspx?SetActive=True&FormFieldID=" & drFormField("FormFieldID").ToString & "&FormID=" & FormID & """><img src=""../../images/Minus.gif"" border=""0""></a></td>")
		End If
		Response.Write(VbCrlf & VbCrlf & "<td align=""center""><a href=""javascript:DeleteFormField('" & drFormField("FormFieldID").ToString & "','" & Base.JSEncode(Server.HtmlEncode(drFormField("FormFieldName").ToString())) & "');""><img src=""../../images/Delete.gif"" border=0 alt=""" & Translate.JsTranslate("Slet %%", "%%", Translate.JsTranslate("felt")) & """></a></td>" & VbCrlf & VbCrlf)
		Response.Write("</tr>")
		MakeDivider(drFormField("FormFieldID").ToString, drFormField("FormFieldSort").ToString, 569)
	Loop
	%>
							<tr>
								<td colspan="6" align="right"><%=Gui.Button(Translate.Translate("Nyt felt"), "Javascript:location='Form_Module_Field_Edit.aspx?FormFieldFormID=" & FormID & "';", 0)%>
								</td>
							</tr>
						</table>
						<%Response.Write(Gui.GroupBoxEnd)
							End If%>
					</div>
				</td>
			</tr>
			<tr>
				<td align="right" valign="bottom">
				</td>
			</tr>
	</table>
<%
drFormField.Close()
drFormField.Dispose()
cmdForm.Dispose()
cnForm.Dispose()


%>

<%If request.QueryString.Item("alertFormExists") = "1" Then%>
<script>
alert('<%=Translate.JSTranslate("En %% med dette navn findes allerede!", "%%", Translate.JSTranslate("formular"))%>')
</script>
<%End If%>

<%
Translate.GetEditOnlineScript()
%>
