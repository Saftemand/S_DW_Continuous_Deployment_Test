<%@ Page CodeBehind="Form_Module_Option_Edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Form_Module_Option_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>


<%
Dim FormOptionsText As String
Dim FormFieldFormID As String
Dim FormOptionsID As String
Dim FormFieldID As String
Dim FormOptionsSort As Integer
Dim FormOptionsValue As String
Dim i As Integer
Dim recordCount as Integer

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title></title>
<dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
</head>
<script>
function DeleteOption(FormFieldID,FormOptionsID){
	if(confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JsTranslate("valgmulighed"))%>')){
		location = 'Form_Module_Option_Del.aspx?FormFieldID='+ FormFieldID + '&FormOptionsID=' + FormOptionsID + '&Redirect=Option'
	}
}

function ValidateForm(){
	FormOK = true;
	if(document.getElementById('FormOptionForm').FormOptionsValue.value.length <= 0){
		alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Værdi"))%>');
		document.getElementById('FormOptionForm').FormOptionsValue.focus();
		FormOK = false;
	}
	else if(document.getElementById('FormOptionForm').FormOptionsValue.value.length > 100){
		alert('<%=Translate.JSTranslate("Max %% tegn i: ","%%","100")%><%=Translate.JSTranslate("Værdi")%>');
		document.getElementById('FormOptionForm').FormOptionsValue.focus();
		FormOK = false;
	}
	else if(document.getElementById('FormOptionForm').FormOptionsText.value.length <= 0){
		alert('<%=Translate.JSTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Tekst"))%>');
		document.getElementById('FormOptionForm').FormOptionsValue.focus();
		FormOK = false;
	}
	else if(document.getElementById('FormOptionForm').FormOptionsText.value.length > 100){
		alert('<%=Translate.JSTranslate("Max %% tegn i: ","%%","100")%><%=Translate.JSTranslate("Tekst")%>');
		document.getElementById('FormOptionForm').FormOptionsValue.focus();
		FormOK = false;
	}

	if(FormOK){
		return true;
	}else{
		return false;
	}
}
 function helpLink()
         {
            <%= Gui.Help("news", "modules.form.general.field.option")%>;
         }
function CancelBtn()
{
location=<%="'"&"Form_Module_Field_Edit.aspx?FormFieldID=" & request.QueryString.Item("FormFieldID") & "&FormFieldFormID=" & request.QueryString.Item("FormFieldFormID") & "'"%>;
}
</script>
<body>
<%
FormFieldID = request.QueryString.Item("FormFieldID")
FormOptionsID = request.QueryString.Item("FormOptionsID")
FormFieldFormID = request.QueryString.Item("FormFieldFormID")
FormOptionsSort = 1

Dim cn		As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
Dim cmd		As IDbCommand		= cn.CreateCommand
Dim dr as IDataReader

If Not FormOptionsID = "" Then
	cmd.CommandText = "SELECT * FROM FormOptions WHERE FormOptionsID = " & FormOptionsID
	dr = cmd.ExecuteReader()
	If dr.Read() Then
		FormOptionsText = dr("FormOptionsText").ToString
		FormOptionsValue = dr("FormOptionsValue").ToString
		FormOptionsSort =  dr("FormOptionsSort").ToString
	End If
	dr.Close()
End If
%>
<BODY onLoad='document.getElementById('FormOptionForm').FormOptionsText.focus();'>
<%=Gui.MakeHeaders(Translate.Translate("%m%_-_Rediger_%c%", "%m%", Translate.Translate("Formular",9),"%c%", Translate.Translate("valgmulighed")), Translate.Translate("Valgmulighed"), "all")%>
<table border="0" cellpadding="0" cellspacing="0" Class="TabTable">
	<tr>
		<td valign="top">
			<form name="FormOptionForm" id="FormOptionForm" method="POST" action="Form_Module_Option_Save.aspx?FormFieldID=<%=FormFieldID%>&FormFieldFormID=<%=FormFieldFormID%>">
			<input type="Hidden" name="FormOptionsID" value="<%=FormOptionsID%>">
			<input type="Hidden" name="FormOptionsSort" value="<%=FormOptionsSort%>">
			    <dw:Toolbar ID="SurveyToolbar" runat="server" ShowStart="true"  ShowEnd="false">
                      <dw:ToolbarButton ID="tbApply" runat="server" OnClientClick="CancelBtn();" Image="SaveAndClose" Text="Save and close"><!---->
                       </dw:ToolbarButton>
                       <dw:ToolbarButton ID="tbHelp" runat="server" Image="Help" Text="Help" OnClientClick="helpLink();">
                       </dw:ToolbarButton>
                    </dw:Toolbar>
			<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
				<table border="0" cellpadding="0">
					<tr>
						<td width=170><%=Translate.Translate("Tekst")%></td>
						<td><input type="Text" name="FormOptionsText" value="<%=FormOptionsText%>" maxlength="255" class="std"></td>
					</tr>
					<tr>
						<td><%=Translate.Translate("Værdi")%> &nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td><input type="Text" name="FormOptionsValue" value="<%=FormOptionsValue%>" maxlength="255" class="std"></td>
					</tr>
					<tr>
						<td colspan="2" align="right"><%=Gui.Button(Translate.Translate("Gem"), "javascript:if(ValidateForm()){FormOptionForm.submit();};", 0)%></td>
					</tr>
				</table>
			</form>
			<%Response.Write(Gui.GroupBoxEnd)
			If Not FormFieldID = "" Then%>
			</td>
		</tr>
	<tr>
		<td>
			<%=Gui.GroupBoxStart(Translate.Translate("Valgmuligheder"))%>
				<table border="0" cellpadding="0" width="574">
					<tr>
						<td width="175"><strong><%=Translate.Translate("Tekst")%></strong></td>
						<td width="175"><strong><%=Translate.Translate("Værdi")%></strong></td>
						<td align="center"><strong><%=Translate.Translate("Sortering")%></strong>&nbsp;</td>
						<td align="center"><strong><%=Translate.Translate("Medtag")%></strong>&nbsp;</td>
						<td align="center"><strong><%=Translate.Translate("Default")%></strong>&nbsp;</td>
						<td align="center"><strong><%=Translate.Translate("Slet")%></strong></td>
					</tr>
					<tr>
						<td colspan="6" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
					</tr>
					<%	
					
	cmd.CommandText = "SELECT Count(*) As Amount FROM FormOptions WHERE FormOptionsFormFieldID =" & FormFieldID
	recordCount = cmd.ExecuteScalar()
	
	cmd.CommandText = "SELECT * FROM FormOptions WHERE FormOptionsFormFieldID =" & FormFieldID & " ORDER BY FormOptionsSort"
	dr = cmd.ExecuteReader()
	i = 0
	Do While dr.Read()
		i = i + 1
		FormOptionsSort = dr("FormOptionsSort")
		Response.Write("<tr>")
		Response.Write("<td width=""175""><a href=""Form_Module_Option_Edit.aspx?FormOptionsID=" & dr("FormOptionsID").ToString & "&FormFieldID=" & FormFieldID & """>" & dr("FormOptionsText").ToString & "</a></td>")
		Response.Write("<td width=""175"">" & dr("FormOptionsValue").ToString & "</td>")
		
		'Response.Write("<td align=""center""><a href=""Form_Module_Option_Sort.aspx?SortDirection=Up&Redirect=Option&FormOptionsID=" & dr("FormOptionsID") & "&FormFieldID=" & FormFieldID & """><img src=""../../images/PilOp.gif"" alt=""" & Translate.JsTranslate("Flyt op") & """ border=""0""></a>&nbsp;<a href=""Form_Module_Option_Sort.aspx?SortDirection=Down&FormOptionsID=" & dr("FormOptionsID").ToString & "&FormFieldID=" & FormFieldID & "&Redirect=Option""><img src=""../../images/PilNed.gif"" alt=""" & Translate.JsTranslate("Flyt ned") & """ border=""0""></a></td>")
		
		If i =1 Then
			if recordCount > 1 then
				Response.Write("<td align=""center""><img src=""../../images/nothing.gif"" width=""15"">&nbsp;<a href=""Form_Module_Option_Sort.aspx?SortDirection=Down&FormOptionsID=" & dr("FormOptionsID").ToString & "&FormFieldID=" & FormFieldID & "&Redirect=Option""><img src=""../../images/PilNed.gif"" alt=""" & Translate.JsTranslate("Flyt ned") & """ border=""0""></a></td>")
			else
				Response.Write("<td align=""center""><img src=""../../images/nothing.gif"" width=""15"">&nbsp;</td>")
			end if
		ElseIf i = recordCount Then 
			Response.Write("<td align=""center""><a href=""Form_Module_Option_Sort.aspx?SortDirection=Up&Redirect=Option&FormOptionsID=" & dr("FormOptionsID") & "&FormFieldID=" & FormFieldID & """><img src=""../../images/PilOp.gif"" alt=""" & Translate.JsTranslate("Flyt op") & """ border=""0""></a>&nbsp;<img src=""../../images/Nothing.gif"" width=""15""></td>")
		Else
			Response.Write("<td align=""center""><a href=""Form_Module_Option_Sort.aspx?SortDirection=Up&Redirect=Option&FormOptionsID=" & dr("FormOptionsID") & "&FormFieldID=" & FormFieldID & """><img src=""../../images/PilOp.gif"" alt=""" & Translate.JsTranslate("Flyt op") & """ border=""0""></a>&nbsp;<a href=""Form_Module_Option_Sort.aspx?SortDirection=Down&FormOptionsID=" & dr("FormOptionsID").ToString & "&FormFieldID=" & FormFieldID & "&Redirect=Option""><img src=""../../images/PilNed.gif"" alt=""" & Translate.JsTranslate("Flyt ned") & """ border=""0""></a></td>")
		End If
		
		If Base.ChkBoolean(dr("FormOptionsActive")) Then
			Response.Write("<td align=""center""><a href=""Form_Module_Option_SetActive.aspx?SetActive=False&Redirect=Option&FormOptionsID=" & dr("FormOptionsID").ToString & "&FormFieldID=" & FormFieldID & """><img src=""../../images/Check.gif"" border=""0""></a></td>")
		Else
			Response.Write("<td align=""center""><a href=""Form_Module_Option_SetActive.aspx?SetActive=True&Redirect=Option&FormOptionsID=" & dr("FormOptionsID").ToString & "&FormFieldID=" & FormFieldID & """><img src=""../../images/Minus.gif"" border=""0""></a></td>")
		End If
		If Base.ChkBoolean(dr("FormOptionsDefaultSelected")) Then
			Response.Write("<td align=""center""><a href=""Form_Module_Option_SetDefault.aspx?FormOptionsID=" & dr("FormOptionsID").ToString & "&FormFieldID=" & FormFieldID & "&Redirect=Option""><img src=""../../images/Check.gif"" border=""0""></a></td>")
		Else
			Response.Write("<td align=""center""><a href=""Form_Module_Option_SetDefault.aspx?FormOptionsID=" & dr("FormOptionsID").ToString & "&FormFieldID=" & FormFieldID & "&Redirect=Option""><img src=""../../images/Minus.gif"" border=""0""></a></td>")
		End If
		Response.Write("<td align=""center""><a href=""javascript:DeleteOption(" & FormFieldID & "," & dr("FormOptionsID").ToString & ");""><img src=""../../images/delete.gif"" border=""0"" alt=""" & Translate.Translate("Slet %%", "%%", Translate.Translate("valgmulighed")) & """></a></td>")
		Response.Write("</tr>")
		Response.Write("<tr>")
		Response.Write("<td colspan=""6"" bgcolor=""#C4C4C4""><img src=""../../images/nothing.gif"" width=1 height=1 alt="""" border=""0""></td>")
		Response.Write("</tr>")
	Loop 
%>
					<tr>
					    <td></td>
                    </tr>
				</table>
<%	Response.Write(Gui.GroupBoxEnd)
End If%>
			<input type="hidden" name="FormOptionsSort" value="<%=FormOptionsSort%>">
		</td>
	</tr>
	<tr>
		<td align="right" valign=bottom>
		</td>
	</tr>
</table>
<%If request.querystring("FormOptionsID") = "" Then%>
<script>
document.getElementById('FormOptionForm').FormOptionsSort.value = "<%=FormOptionsSort%>";
</script>
<%End If%>
<%
dr.Close()
dr.Dispose()
cmd.Dispose()
cn.Dispose()

Translate.GetEditOnlineScript()
%>