<%@ Page Language="vb" AutoEventWireup="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>


<%
Dim Count As Integer
Dim intMediaCount as Integer
Dim tmpThumb As String
Dim style As String
Dim ThumbID As Object
Dim SqlWhere As String
Dim MediaDBGroupListGetGroups As Object
Dim ColWidth As Integer
Dim FileName As String
Dim Number As Integer
Dim Action As String
Dim ID As Integer
Dim ThumbFolder As Object
Dim Link As String
Dim borderStyle As String
Dim ModuleIcon As String
Dim File As Object
Dim i As Double
Dim Root As String
Dim Title As String
Dim extList As String
Dim NextPosition As Integer
Dim PrevPosition As Integer
Dim alOrientation As ArrayList = New ArrayList
Dim Cols As Integer
Dim Position As String
Dim Amount As String
Dim span As String
Dim sql As String
Dim MediaDBGroupName As String
Dim ThumbSrc As String
Dim Path As String
Dim no As Integer
Dim extension As String
Dim MediaDBThumbnailsMaxwidth As Object
Dim NLRowNumbers As Object
Dim blnHasRows As Boolean

Base.MediaSettings(Path, extList)

Dim connMedia As IDbConnection = Database.CreateConnection("DWMedia.mdb")
Dim cmdMedia As System.Data.IDbCommand = connMedia.CreateCommand

If Request.QueryString("ID") <> "" Then
	ID = CInt(Request.QueryString("ID"))
Else
	ID = 0
End If

If ID > 0 Then
	sql = "SELECT MediaDBGroup.MediaDBGroupName, MediaDBGroup.MediaDBGroupID, Count(MediaDBMedia.MediaDBMediaID) AS CountOfMediaDBMediaID "
	sql = sql & "FROM MediaDBGroup RIGHT JOIN MediaDBMedia ON MediaDBGroup.MediaDBGroupID = MediaDBMedia.MediaDBMediaGroupID "
	sql = sql & "WHERE (((MediaDBGroup.MediaDBGroupID)=" & ID & ")) OR (MediaDBMedia.MediaDBMediaRelated LIKE '%@" & ID & "@%') "
	sql = sql & "GROUP BY MediaDBGroup.MediaDBGroupName, MediaDBGroup.MediaDBGroupID"

    cmdMedia.CommandText = SQL

    Dim drMediaGroupReader As IDataReader = cmdMedia.ExecuteReader

	Number = 0
	MediaDBGroupName = ""

	Do While drMediaGroupReader.Read
		Number = Number + drMediaGroupReader("CountOfMediaDBMediaID")
		If ID = drMediaGroupReader("MediaDBGroupID") Then
			MediaDBGroupName = drMediaGroupReader("MediaDBGroupName")
		End If
		blnHasRows = True
	Loop

	If Not blnHasRows Then
		Title = "<br>" & "&nbsp;"
	Else
		Title = "<br>" & MediaDBGroupName & " (" & Translate.Translate("%% filer", "%%", Number.ToString) & ")"
	End If

    drMediaGroupReader.Dispose

Else
	Title = "<br>" & "&nbsp;"
End If

%>
<html>
<head>
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
<TITLE></TITLE>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<script type="text/javascript">
mac = false;
if(navigator.appVersion.toLowerCase().indexOf("mac") > 0){
	mac = true;
}

function MediaDelete(ID, MediaDBMediaGroupID, strName){
	if (confirm('<%=Translate.Translate("Slet %%?", "%%", Translate.JSTranslate("fil"))%>\n(' + strName + ')')){
		location = "Media_Delete.aspx?ID=" + ID + "&MediaDBMediaGroupID=" + MediaDBMediaGroupID
	}
}

function movepage(ID, AreaID){
	movepageWindow = window.open("Menu.aspx?MoveID=" + ID + "&Action=Move&AreaID=" + AreaID, "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=200,height=350,top=155,left=202");
	hideNow();
}

hide = true;
function doNotHide(){
	hide = false;
}

function hideMenu(){
	hide = true;
	setTimeout("doTheHide()", 2500);
}

function doTheHide(){
	if(hide){
		document.getElementById('Rmenu').style.display = 'none';
		hide = false;
	}
}

function hideNow(){
	document.getElementById('Rmenu').style.display = 'none';
}

function FieldSize(){
	var height = document.body.clientHeight;
	height = height-140
	if(height > 425){
		height = 425;
	}
	if(document.getElementById('MediaID')){
		obj = document.getElementById('MediaID')
		if(obj.value.length >= 1){
			tmpString = obj.value.split(", ")
			for(var i=0;i < tmpString.length;i++){
				CP(tmpString[i])
			}
		}
	}
}

function cc(objRow){ //Change color of row when mouse is over... (ChangeColor)
	if(objRow.style.backgroundColor != "#c3d6e6"){
		objRow.style.backgroundColor='#ece9d8';
	}
}

function ccb(objRow){ //Remove color of row when mouse is out... (ChangeColorBack)
	if(objRow.style.backgroundColor != "#c3d6e6"){
		objRow.style.backgroundColor='';
	}
}

function CP(ID){
	//alert(document.getElementById(ID));
	if(document.getElementById("T" + ID).style.backgroundColor == "#c3d6e6"){
		del(ID)
		//document.getElementById(ID).style.border = "1px solid #000000";
		document.getElementById("T" + ID).style.backgroundColor = "";
	}
	else{
		add(ID)
		//document.getElementById(ID).style.border = "1px solid #990000";
		document.getElementById("T" + ID).style.backgroundColor = "#c3d6e6";
	}
}



function del(ID){
	obj = document.getElementById('MediaID')
	tmpString = obj.value.split(", ")
	newString = ""
	tmpDel = ""
	for(var i=0;i < tmpString.length;i++){
		if(tmpString[i].toString() != ID.toString()){
			newString += tmpDel + tmpString[i]
			tmpDel = ", "
		}
	}
	obj.value = newString;
}

function add(ID){
	obj = document.getElementById('MediaID')
	tmpString = obj.value.split(", ")
	newString = ""
	tmpDel = ""
	found = false;
	for(var i=0;i < tmpString.length;i++){
		if(tmpString[i].toString() == ID.toString()){
			found = true;
		}
	}
	if(!found){
		if(obj.value.length < 1){
			obj.value = ID
		}
		else{
			obj.value = obj.value + ", " + ID
		}
	}
}

var selectedFiles;
function setSelectedFiles(){
	selectedFiles = "";
	for(i = 0; i < document.getElementById('FileHolder').elements.length; i++){
		if(document.getElementById('FileHolder').elements[i].checked){
			if(selectedFiles.length == 0){
				selectedFiles += document.getElementById('FileHolder').elements[i].value;
			}else{
				selectedFiles += ',' + document.getElementById('FileHolder').elements[i].value;
			}
		}
	}
}

function movecopy(action){
	setSelectedFiles();
alert(selectedFiles);
//	MediaIDs = "";
//	if(document.getElementById('MediaID2')){
//	
//		obj = document.getElementById('MediaID2')
//		MediaIDs = "0";
//		alert(document.getElementById('MediaID2').);
//		if(document.getElementById('MediaID2').length){
//			for(var i=0;i < obj.length;i++){
//				if(obj[i].checked){
//					MediaIDs += ", " + obj[i].value;
//				}
//			}
//		}
//		else{
//			MediaIDs += ", " + obj.value;
//		}
//		if(MediaIDs.length < 2){
//			alert("<%=Translate.JSTranslate("Ingen medier er valgt!")%>");
//			return;
//		}
//	}
//	else {
//		if(document.getElementById('MediaID')){
//		alert('2');
//			obj = document.getElementById('MediaID')
//			if(obj.value.length < 1){
//				alert("<%=Translate.JSTranslate("Ingen medier er valgt!")%>");
//				return;
//			}else{
//				MediaIDs = document.getElementById('MediaID').value;
//			}
//		}
//	}
	location = "Media_Media_MoveCopy.aspx?Action=" + action + '&MediaID=' + selectedFiles;
}

<%If Request.QueryString("Mode") = "Browse" Then%>
function Choose(ProductID, ProdcutName, ProductNumber, doClose){
	obj = top.opener.document.getElementById('<%=Request.QueryString("Caller")%>')
	objList = top.opener.document.getElementById('<%=Request.QueryString("Caller")%>List')

	if(!top.opener.document.getElementById("R" + ProductID)){
		if(obj.value.length > 0){
			obj.value += ", " + ProductID;
		}
		else{
			obj.value = ProductID;
		}
		objList.innerHTML += "<table ID=R" + ProductID + "><tr><td width=150>" + ProductNumber + "</td><td width=150>" + ProdcutName + "</td><td width=30><a href='javascript:del(" + ProductID + ");'><img src=\"/Admin/images/Delete.gif\" border=0></a></td></tr></table>"
	}
	else{
		alert("<%=Translate.JSTranslate("Den valgte fil er tilføjet")%>");
	}
	if(doClose){
		self.close();
	}
}
<%End If%>
</script>

</head>
<body onload="FieldSize();">
<%
'************** Get settings for thumbnails *************

sql = "SELECT MediaDBThumbnailsID, MediaDBThumbnailsName, MediaDBThumbnailsMaxwidth "
sql = sql & "FROM MediaDBThumbnails "
sql = sql & "ORDER BY (MediaDBThumbnails.MediaDBThumbnailsMaxwidth * MediaDBThumbnails.MediaDBThumbnailsMaxheight)"

cmdMedia.CommandText = SQL

Dim drThumbnailsReader As IDataReader = cmdMedia.ExecuteReader

ThumbFolder = ""
If Not IsNothing(Request.QueryString("ThumbID")) Then
	If Request.QueryString("ThumbID") <> "0" Then
		ThumbID = Request.QueryString("ThumbID")
	Else
		ThumbID = ""
	End If
	Session("ThumbID") = ThumbID
Else
	ThumbID = Session("ThumbID")
End If

blnHasRows = False

Do While drThumbnailsReader.Read

	If Not blnHasRows Then
		tmpThumb = Translate.Translate("Liste visning") & ": <select ID=ThumbID class=std style=""width:150px;"" onChange=""location='Media_list.aspx?ID=" & ID & "&ThumbID=' + document.getElementById('ThumbID').value;"">" & vbCrLf
		tmpThumb = tmpThumb & "<option value=""0"">" & Translate.Translate("Detaljer") & vbCrLf
	End If

	If drThumbnailsReader("MediaDBThumbnailsID") & "" = ThumbID Then
		MediaDBThumbnailsMaxwidth = drThumbnailsReader("MediaDBThumbnailsMaxwidth")
	End If
	ThumbFolder = drThumbnailsReader("MediaDBThumbnailsID")
	tmpThumb = tmpThumb & "<option value=""" & drThumbnailsReader("MediaDBThumbnailsID") & """" & IIf(drThumbnailsReader("MediaDBThumbnailsID") & "" = ThumbID & "", " SELECTED", "") & ">Thumbnails: " & drThumbnailsReader("MediaDBThumbnailsName") & vbCrLf
	blnHasRows = True

Loop 

If blnHasRows Then
	tmpThumb = tmpThumb & "</select>" & vbCrLf
End If


drThumbnailsReader.Dispose


'************** End get settings ***************
%>
<div id="bodyheight" style="vertical-align:top;">
<form name="FileHolder" id="FileHolder">
<%=Gui.MakeHeaders(Title, Translate.Translate("Filer"), "all")%>
<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
<tr><td valign="top">

    <table border="0" cellpadding="0" width="598">
<%
Action = Request.QueryString("Action")
If Action = "Search" Then
	%>
	<tr>
		<td colspan=6>
			<%=Gui.GroupBoxStart(Translate.Translate("Søg"))%>
			<table cellpadding="2" cellspacing="0">
				<form name="Search" id="Search" action="Media_List.aspx" method="get">
				<input type="hidden" name="Action" value="Search">
				<input type="hidden" name="Search" value="True">
				<tr>
					<td width="170"><%=Translate.Translate("Søgetekst")%></td>
					<td><input type=text name="MediaDBSearchString" value="<%=Request.QueryString("MediaDBSearchString")%>" class=std></td>
				</tr>
				<tr>
					<td><%=Translate.Translate("Kategori")%></td>
					<td>
					<select name="MediaDBMediaGroupID" class="std">
					<option value=""></option>
					<%=Gui.MediaDBGroupListGetGroups(Request.QueryString("MediaDBMediaGroupID"), 0, 0)%>
					</select>
				</tr>
				<tr>
					<td colspan="2" align="right"><%= Gui.Button(Translate.Translate("Søg"), "document.getElementById('Search').submit();", 0)%></td>
				</tr>
				</form>
			</table>
			<%=Gui.GroupBoxEnd%>
		</td>
    </tr>
	<%	
	If Request.QueryString("Search") = "True" Then
		SqlWhere = "WHERE (MediaDBMediaName LIKE '%" & Request.QueryString("MediaDBSearchString") & "%' "
		SqlWhere = SqlWhere & "OR MediaDBMediaKeywords LIKE '%" & Request.QueryString("MediaDBSearchString") & "%' "
		SqlWhere = SqlWhere & "OR MediaDBMediaDescription LIKE '%" & Request.QueryString("MediaDBSearchString") & "%' "
		SqlWhere = SqlWhere & "OR MediaDBMediaFileName LIKE '%" & Request.QueryString("MediaDBSearchString") & "%') "
		If Request.QueryString("MediaDBMediaGroupID") <> "" Then
			SqlWhere = SqlWhere & "AND MediaDBMediaGroupID = " & Replace(Request.QueryString("MediaDBMediaGroupID"), "@", "")
		End If
		SqlWhere = SqlWhere & " ORDER BY MediaDBMediaName"
	Else
		SqlWhere = "WHERE 1=2"
	End If
Else
	SqlWhere = "WHERE MediaDBMedia.MediaDBMediaGroupID=" & ID & " OR (MediaDBMedia.MediaDBMediaRelated LIKE '%@" & ID & "@%')  ORDER BY MediaDBMediaRelated, MediaDBMediaSort, MediaDBMediaName"
End If

sql = "SELECT Count(*) FROM MediaDBMedia "

If Action = "Search" Then
	sql += "WHERE (MediaDBMediaName LIKE '%" & Request.QueryString("MediaDBSearchString") & "%' "
		sql += "OR MediaDBMediaKeywords LIKE '%" & Request.QueryString("MediaDBSearchString") & "%' "
		sql += "OR MediaDBMediaDescription LIKE '%" & Request.QueryString("MediaDBSearchString") & "%' "
		sql += "OR MediaDBMediaFileName LIKE '%" & Request.QueryString("MediaDBSearchString") & "%') "
		If Request.QueryString("MediaDBMediaGroupID") <> "" Then
			sql += "AND MediaDBMediaGroupID = " & Replace(Request.QueryString("MediaDBMediaGroupID"), "@", "")
		End If
Else
	sql += "WHERE MediaDBMedia.MediaDBMediaGroupID=" & ID & " OR (MediaDBMedia.MediaDBMediaRelated LIKE '%@" & ID & "@%')"
End If 

cmdMedia.CommandText = SQL
intMediaCount = cmdMedia.ExecuteScalar()


sql = "SELECT * FROM MediaDBMedia " & SqlWhere
cmdMedia.CommandText = SQL

Dim drDBMediaReader As IDataReader = cmdMedia.ExecuteReader

Number = 0
MediaDBGroupName = ""

blnHasRows = False

Do While drDBMediaReader.Read
	If Not blnHasRows Then  ' is it first loop
		If Not ThumbID <> "" Then
			%>
		<tr>
			<td colspan=7 align=right>
				<a href="#" onClick="movecopy('copy');"><img src="../../Images/Icons/Page_Copy.gif" width="15" height="17" border="0" title=<%=Translate.Translate("Copy")%> /></a> 
				<a href="#" onClick="movecopy('move');"><img src="../../Images/Icons/Page_Move.gif" width="15" height="17" border="0" title=<%=Translate.Translate("Move")%> /></a>
			</td>
		</tr>
		<tr>
			<td width="272"><img src="../../../images/Nothing.gif" width="15" height="1" alt="" border="0"> <strong><%=Translate.Translate("Fil")%></strong></td>
			<td width=40><strong><%=Translate.Translate("Original")%></strong></td>
			<td width=40><strong><%=Translate.Translate("Medtag")%></strong></td>
			<td width=68><strong><%=Translate.Translate("Oprettet")%></strong></td>
			<td width=68><strong><%=Translate.Translate("Redigeret")%></strong></td>
			<td width=30 align="right"><strong><%=Translate.Translate("Slet")%></strong></td>
		</tr>
		<tr>
			<td colspan="6" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width="1" height="1" alt="" border="0" /></td>
		</tr>
	<%		
		Else%>
			<tr>
				<td align="right">
				
				<input type="hidden" name="MediaID" id="MediaID" size="50">
				<a href="#" onclick="movecopy('copy');"><img src="../../Images/Icons/Page_Copy.gif" width="15" height="17" border="0" title=<%=Translate.Translate("Copy")%> alt="" /></a> 
				<a href="#" onclick="movecopy('move');"><img src="../../Images/Icons/Page_Move.gif" width="15" height="17" border="0" title=<%=Translate.Translate("Move")%> /></a>
				<table cellpadding=5 width="100%"><tr>
			<%		
			If MediaDBThumbnailsMaxwidth > 290 Then
				Cols = 1
				ColWidth = 100
			ElseIf MediaDBThumbnailsMaxwidth > 190 Then 
				Cols = 2
				ColWidth = 50
			ElseIf MediaDBThumbnailsMaxwidth > 140 Then 
				Cols = 3
				ColWidth = 33
			ElseIf MediaDBThumbnailsMaxwidth > 110 Then 
				Cols = 4
				ColWidth = 25
			Else
				Cols = 5
				ColWidth = 20
			End If
		End If
		
		Position = Request("Position")
		Amount = Request("Amount")
		If Position = "" Then
			Position = 0
		End If
		If Not IsNothing(Request.QueryString.GetValues("NLRowNumbers")) Then
			NLRowNumbers = Request.QueryString("NLRowNumbers")
			Session("NLRowNumbers") = NLRowNumbers
		End If
		If CStr(Session("NLRowNumbers")) <> "" Then
			NLRowNumbers = Session("NLRowNumbers")
		End If
		If NLRowNumbers = 0 Or NLRowNumbers = "" Then
			NLRowNumbers = 20
		End If
		NextPosition = CShort(Position) + NLRowNumbers
		If CStr(NextPosition) = "" Then
			NextPosition = NLRowNumbers
		End If
		
		PrevPosition = CShort(Position) '- NLRowNumbers
		Count = 0
	End If


	extension = Base.getFileextension((drDBMediaReader("MediaDBMediaFileName")))
	If CShort(Count) >= CShort(PrevPosition) And CShort(Count) < CShort(NextPosition) Then
		
		If drDBMediaReader("MediaDBMediaFileName") <> "" Then
			FileName = Replace(drDBMediaReader("MediaDBMediaFileName"), ".", "_") & ".jpg"
		Else
			FileName = drDBMediaReader("MediaDBMediaFileName") & ".jpg"
		End If
		i = i + 1
		If ThumbID <> "" Then
			Response.Write("<td width=""" & ColWidth & "%"" align=center ID=""T" & drDBMediaReader("MediaDBMediaID") & """ onmouseover=""cc(this)"" onmouseout=""ccb(this)"" style=""border:1px solid #cccccc;cursor:pointer;"" onDblClick=""location='Media_edit.aspx?ID=" & drDBMediaReader("MediaDBMediaID") & "&PageID=" & drDBMediaReader("MediaDBMediaGroupID") & "';"" onClick=""CP(" & drDBMediaReader("MediaDBMediaID") & ")"">")
			If Base.IsImage(extension) Then
			        ThumbSrc = "../../../Files/" & Dynamicweb.Content.Management.Installation.ImagesFolderName & "/MediaDB/Thumbs/" & ThumbID & "/" & FileName & ""
				borderStyle = "border:1px solid black"
			Else
				ThumbSrc = "../../images/ext/" & Base.GetIcon(extension, extList) & ".gif"
				borderStyle = ""
			End If
			Response.Write("<img src=""" & ThumbSrc & """ border=0 style=""" & borderStyle & """ ID=""" & drDBMediaReader("MediaDBMediaID") & """><br>" & drDBMediaReader("MediaDBMediaName"))
			Response.Write("</td>")

'TODO: ikke vildt vigtig - problemet er vi ikke kan checke for EOF.... og det her er ikke som normalt
			If (i Mod Cols) = 0 Then
				If intMediaCount = i Then
					Response.Write("</tr>" & vbCrLf)
				Else
			            Response.Write("</tr><tr><td></td></tr><tr>" & vbCrLf)
				End If
			End If
		Else
			%>
		<TR>
		<%				
			span = "<span>"
			style = ""
			If Not drDBMediaReader("MediaDBMediaActive") Then
				span = "<span style=""color:#C1C1C1;"">"
				style = " STYLE=""filter:progid:DXImageTransform.Microsoft.Alpha(opacity=30)progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);"""
			End If
			
			ModuleIcon = "../../images/ext/" & Base.GetIcon(extension, extList) & ".gif"
			%>
				<td><input type="checkbox" name="MediaID2" ID=MediaID2 value="<%=drDBMediaReader("MediaDBMediaID")%>"><a href="Media_edit.aspx?ID=<%=drDBMediaReader("MediaDBMediaID")%>&PageID=<%=drDBMediaReader("MediaDBMediaGroupID")%>"><img src="<%=ModuleIcon%>" border="0" align=absmiddle<%=style%>>&nbsp;
				<%				
			If Len(drDBMediaReader("MediaDBMediaName")) > 25 Then
				Response.Write(span & Left(drDBMediaReader("MediaDBMediaName"), 32) & "...")
			Else
				Response.Write(span & drDBMediaReader("MediaDBMediaName"))
			End If
			If Not System.IO.File.Exists(Path & "\Thumbs\" & ThumbFolder & "\" & FileName) And Base.IsImage(extension) Then
				Response.Write(" <img src='../../Images/infoicon.gif' align=absmiddle border=0 alt='" & Translate.Translate("Fil findes muligvis ikke!") & "'>")
			End If
			If drDBMediaReader("MediaDBMediaOriginalID").ToString <> "" Then
				Response.Write(" <img src=""../../Images/Shortcut.gif"" align=absmiddle border=0>")
			End If
			If drDBMediaReader("MediaDBMediaGroupID") <> ID Then
				Response.Write("&nbsp;<img src=""../../Images/Shortcut.gif"" align=absmiddle border=0>")
			End If
			%></span></a>
			</td>
			<!--td>
			<%				
			If len(drDBMediaReader("MediaDBMediaNumber").ToString) > 12 Then
				Response.Write(span & Left(drDBMediaReader("MediaDBMediaNumber"), 10) & "...")
			Else
				Response.Write(span & drDBMediaReader("MediaDBMediaNumber"))
			End If
			%></span>
			</td-->
			<%If (i = 1 And i = 1) Then  'rs.recordcount) Or drDBMediaReader("MediaDBMediaSort") = "0" Then%>
				<!--td align="center"></td-->
			<%ElseIf i = 1 Then %>
				<!--td align="center"><img src="../../images/nothing.gif" width="15" border="0"><a href="Media_Sort.aspx?ID=<%=ID%>&MediaDBMediaID=<%=drDBMediaReader("MediaDBMediaID")%>&MediaDBMediaGroupID=<%=drDBMediaReader("MediaDBMediaGroupID")%>&MoveDirection=down"><img src="../../images/pilned.gif" alt="<%=Translate.JsTranslate("Flyt ned")%>" border="0"<%=style%>></a></td-->
			<%ElseIf i = 1 Then  'rs.recordcount Then %>
				<!--td align="center"><a href="Media_Sort.aspx?ID=<%=ID%>&MediaDBMediaID=<%=drDBMediaReader("MediaDBMediaID")%>&MediaDBMediaGroupID=<%=drDBMediaReader("MediaDBMediaGroupID")%>&MoveDirection=up"><img src="../../images/pilop.gif" alt="<%=Translate.JsTranslate("Flyt op")%>" border="0"<%=style%>></a><img src="../../images/nothing.gif" width="15" border="0"<%=style%>></td-->
			<%Else%>
				<!--td align="center"><a href="Media_Sort.aspx?ID=<%=ID%>&MediaDBMediaID=<%=drDBMediaReader("MediaDBMediaID")%>&MediaDBMediaGroupID=<%=drDBMediaReader("MediaDBMediaGroupID")%>&MoveDirection=up"><img src="../../images/pilop.gif" alt="<%=Translate.JsTranslate("Flyt op")%>" border="0"<%=style%>></a><a href="Media_Sort.aspx?ID=<%=ID%>&MediaDBMediaID=<%=drDBMediaReader("MediaDBMediaID")%>&MediaDBMediaGroupID=<%=drDBMediaReader("MediaDBMediaGroupID")%>&MediaDBMediaSort=<%=drDBMediaReader("MediaDBMediaSort")%>&MoveDirection=down"><img src="../../images/pilned.gif" alt="<%=Translate.JsTranslate("Flyt ned")%>" border="0"<%=style%>></a></td-->
			<%End If%>
			<td align="center">
			<%				
			If System.IO.File.Exists(Path & "\Originals\" & drDBMediaReader("MediaDBMediaFileName")) Then
				Response.Write("<img src=""../../images/Check.gif"" border=0>")
			Else
				Response.Write("<img src=""../../images/Minus.gif"" border=0>")
			End If
			%>
			</td>
			<td align="center">
			<%				
			If drDBMediaReader("MediaDBMediaActive") Then 'Is the media active or not? Show the right icon (and make the right link)
				Response.Write("<a href=""Media_Toggle_Active.aspx?ID=" & drDBMediaReader("MediaDBMediaID") & "&active=0""><img src=""../../images/Check.gif"" border=0></a>")
			Else
				Response.Write("<a href=""Media_Toggle_Active.aspx?ID=" & drDBMediaReader("MediaDBMediaID") & "&active=1""><img src=""../../images/Minus.gif"" border=0></a>")
			End If%>
			</td>
			<td><%if not drDBMediaReader("MediaDBMediaCreatedDate").ToString = "" then response.write(span & Dates.ShowDate(CDate(drDBMediaReader("MediaDBMediaCreatedDate")), Dates.Dateformat.Short, false))%></span></td>
			<td><%if not drDBMediaReader("MediaDBMediaUpdatedDate").ToString = "" then response.write(span & Dates.ShowDate(CDate(drDBMediaReader("MediaDBMediaUpdatedDate")), Dates.Dateformat.Short, false))%></span></td>
			<td align="center"><a href="JavaScript:MediaDelete(<%=drDBMediaReader("MediaDBMediaID")%>, <%=drDBMediaReader("MediaDBMediaGroupID")%>, '<%=Base.JSEnable(drDBMediaReader("MediaDBMediaName")).replace("\""", "")%>')"><img src="../../images/Delete.gif" border="0"<%=style%>></a></td>
		</TR>
		<tr>
			<td colspan="6" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
		</tr>
		<%				
		End If

	End If
	Count = Count + 1
	Position = Position + 1
	blnHasRows = True
Loop

If blnHasRows Then

	no = Count
	
	Response.Write(("<tr><td colspan=6><table>"))
	If CShort(no) > CShort(NextPosition) And CShort(NextPosition) > CShort(NLRowNumbers) Then
		Response.Write(("<tr><td width='100%'>" & Translate.Translate("Fra") & " " & PrevPosition & " " & Translate.Translate("Til") & " "))
		If NextPosition > no Then
			Response.Write((no))
		Else
			Response.Write((NextPosition))
		End If
		Response.Write(("</td><td width='100%'><img src=""../../images/nothing.gif"" width=1 height=1 alt="" border=""0""></td><td><img onclick='location=""Media_List.aspx?ID=" & ID & "&Position=" & CShort(PrevPosition) - NLRowNumbers & "&Action=" & request("Action") & "&Search=" & request("Search") & "&MediaDBSearchString=" & request("MediaDBSearchString") & """' src='../../images/Page_Previous.gif' class='H'></td><td><img onclick='location=""Media_List.aspx?ID=" & ID & "&Position=" & NextPosition & "&Action=" & request("Action") & "&Search=" & request("Search") & "&MediaDBSearchString=" & request("MediaDBSearchString") & """'src='../../images/Page_Next.gif' class='H'></td></tr>"))
	ElseIf CShort(no) > CShort(NextPosition) Then 
		Response.Write(("<tr><td width='100%'>" & Translate.Translate("Fra") & " " & PrevPosition & " " & Translate.Translate("Til") & " "))
		If NextPosition > no Then
			Response.Write((no))
		Else
			Response.Write((NextPosition))
		End If
		Response.Write(("</td><td width='100%'><img src=""../../images/nothing.gif"" width=1 height=1 alt="" border=""0""></td><td><img src='../../images/Nothing.gif' width='20'></td><td><img onclick='location=""Media_List.aspx?ID=" & ID & "&Position=" & NextPosition & "&Action=" & request("Action") & "&Search=" & request("Search") & "&MediaDBSearchString=" & request("MediaDBSearchString") & """' src='../../images/Page_Next.gif' class='H'></td></tr>"))
	ElseIf CShort(PrevPosition) > 0 Then 
		Response.Write(("<tr><td width='100%'>" & Translate.Translate("Fra") & " " & PrevPosition & " " & Translate.Translate("Til") & " "))
		If NextPosition > no Then
			Response.Write((no))
		Else
			Response.Write((NextPosition))
		End If
		Response.Write(("</td><td width='100%'><img src=""../../images/nothing.gif"" width=1 height=1 alt="" border=""0""></td><td><img onclick='location=""Media_List.aspx?ID=" & ID & "&Position=" & CShort(PrevPosition) - NLRowNumbers & "&Action=" & request("Action") & "&Search=" & request("Search") & "&MediaDBSearchString=" & request("MediaDBSearchString") & """' src='../../images/Page_Previous.gif' class='H'></td><td><img src='../../images/Nothing.gif' width='20'></td></tr>"))
	End If
    Response.Write(("</table></td></tr>"))
	'	ElseIF Cint(No) > Cint(NextPosition)
	If ThumbID <> "" Then
		Response.Write("</tr></table></td></tr>")
	End If
	i = 0

else%>
	<tr>
		<td colspan="6" align="center" valig="center" height="200"><b><%=Translate.Translate("Ingen medier i denne kategori")%></b></td>
    </tr>
<%	
End If

drDBMediaReader.Dispose

%>
</table>
</div>
</td></tr>
<tr>
	<td align=right valign=bottom>
		<table>
			<tr>
				<td>
				<script>
				function jump(NLRowNumbers){
					<%
					If Not IsNothing(Request.QueryString("NLRowNumbers")) Then
						Link = Replace(Request.QueryString.ToString, "=" & Request.QueryString("NLRowNumbers"), "=")
					Else
						Link = Request.QueryString.ToString & "&NLRowNumbers="
					End If
					%>
					location = "Media_List.aspx?<%=Link%>" + NLRowNumbers;
				}
				</script>
				<%=Translate.Translate("Medier pr. side")%>: 
				<%=Gui.SpacListExt(NLRowNumbers, "NLRowNumbers"" onChange=""jump(this.value);", 10, 200, 10, "")%>&nbsp;
				<%
				If no > 0 Then
					Response.Write(tmpThumb)
				End If
				%>
				</td>
				<td width=5></td>
				<td>
				<%
				If Action <> "Search" Then
					'Response.Write DWButton(Translate.Translate("Ny fil"), "location='Media_edit.aspx?MediaDBMediaGroupID=" & ID & "';", 0)
				End If
				%></td>
			</tr>
		</table>
	</td>
</tr>
</table>
</form>
</div>
<div id="Rmenu" class="altMenu" style="display:none;"></div>
</body>
</html>
<%
connMedia.Dispose

Translate.GetEditOnlineScript()
%>
