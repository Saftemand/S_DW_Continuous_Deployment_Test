<%@ Page Language="vb" ValidateRequest="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<%
Dim NewsletterID As String

Dim ParagraphTemplateID As String
Dim TemplatePath As String
Dim TemplateOutput As String

Dim DWEditorTagsArray() As String
Dim IndexStart As Integer
Dim IndexEnd As Integer

Dim strSpan As String
Dim myStyle As String
Dim strSendText As String
Dim blnCategoryChecked As Integer
Dim strName As String
Dim varAttachmentList As String
Dim tempStr As String
Dim DWEditorTagsArrayString As String

Dim FileHome As String = "/Files/"
Dim StaticCounter As Byte
Dim sql As String

Dim varTab As String
Dim DWArray(50, 2) As String
Dim Counter As Integer
Dim AutoStart As String
Dim blnPagebased As boolean = false
Dim NewsletterPageBasedLink As String
Dim NewsletterLetterType As String
Dim strEditorHeight, strEditorWidth as String

Dim cnNewsletterExtended	As IDbConnection = Database.CreateConnection("NewsletterExtended.mdb")
Dim cmdNewsletterExtended	As IDbCommand	 = cnNewsletterExtended.CreateCommand

Dim drUserField				As IDataReader

response.Expires = -100

NewsletterID = Base.ChkNumber(Request.Item("ID"))
strEditorHeight = Request.QueryString("Width")
strEditorWidth = Request.QueryString("Height")

If strEditorHeight = "" Then
	strEditorHeight = "640"
End If

If strEditorWidth = "" Then
	strEditorWidth = "480"
End If

IndexStart = 1
IndexEnd = 2
Counter = 0

StaticCounter = Counter

Session("NewsletterArray") = DWArray.Clone()

myStyle = "<style> SPAN.dataslug { background-color: #ffff33; } </style>"

AutoStart = "1"

cmdNewsletterExtended.CommandText = "SELECT * FROM NewsletterExtendedUserField"
drUserField = cmdNewsletterExtended.ExecuteReader()

DWEditorTagsArrayString = " ,DWUserName,DWUserID,DWUserEmail,DWUserPassword"

Do While drUserField.Read()
	DWEditorTagsArrayString = DWEditorTagsArrayString & ",DW" & drUserField("NewsletterUserFieldSystemName").ToString
Loop 
drUserField.Close()
drUserField.Dispose()

DWEditorTagsArray = Split(DWEditorTagsArrayString, ",")

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<SCRIPT LANGUAGE="JavaScript">
<!--

// variable ensure the DWEditor does not load the content automatic and therefore won't overwrite the content you load.
function InsertIntoLetter()
{
	opener.DWEditor.DOM.body.innerHTML = window.DWEditor.FilterSourceCode(window.DWEditor.DOM.body.innerHTML);
	window.close();
}


function loadMail()
{

//	DWEditor.DocumentHTML = opener.document.getElementById("divNewsletterContent").value;
	//DWEditor.DOM.body.innerHTML = opener.DWEditor.DOM.body.innerHTML;
	DWEditor.DocumentHTML = opener.DWEditor.DocumentHTML
	DWEditor.ShowBorders = true;
	init = true;
		
}

//-->
</SCRIPT>
<title></title>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<body LEFTMARGIN="20" TOPMARGIN="16" onLoad="loadMail();">
		<div id="htmlmail" style="display:<%=Base.IIf(blnPagebased, "none", "")%>">
			<TABLE cellpadding=2 cellspacing=0>				
				<tr>
					<td colspan="2"><%=Gui.Editor("NewsletterMailBody", strEditorHeight, strEditorWidth, "", Autostart, DWEditorTagsArray)%></td>
				</tr>
				<tr>
					<td align=right colspan="2"><%=Gui.Button(Translate.Translate("Indsæt"), "InsertIntoLetter();", 0)%><br></td>
				</tr>
			</TABLE>
		</div>
<%
cmdNewsletterExtended.Dispose()
cnNewsletterExtended.Close()
cnNewsletterExtended.Dispose()
%>

</body>
</html>


<%
Translate.GetEditOnlineScript() 
%>
