<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Media_Edit.aspx.vb" Inherits="Dynamicweb.Admin.Media_Edit" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<%
Dim MediaDBMediaGroups As Object
Dim MediaDBMediaResolution As Object
Dim MediaDBMediaRelated As Object
Dim MediaDBMediaType As Object
Dim MediaDBMediaDescription As String
Dim MediaDBMediaColorSpace As Object
Dim MediaDBMediaKeywords As String
Dim MediaDBMediaNumber As Object
Dim MediaDBMediaPrice3 As String
Dim MediaDBMediaHeigth As Object
Dim MediaDBMediaName As String
Dim extension As String
Dim MediaDBMediaFileName As String
Dim MediaDBMediaID As Integer
Dim extList As String
Dim MediaDBMediaPrice1 As String
Dim MediaDBMediaBlackWhite As Boolean
Dim MediaDBMediaActiveFrom As Object
Dim MediaDBGroupName As String
Dim Tabs As String
Dim SQL As String
Dim MediaDBMediaGroupID As Object
Dim MediaDBMediaCopyright As Object
Dim ProductEditFieldList As String
Dim Root As String
Dim ThumbSettings As Object
Dim MediaDBMediaActive As Object
Dim MediaDBGroupList As Object
Dim MediaDBMediaWidth As Object
Dim i As Integer
Dim MediaDBMediaPrice2 As String
Dim MediaDBMediaColors As Object
Dim Path As String
Dim MediaDBMediaActiveTo As Object
Dim DWMediaOriginalPath As String
Dim Fileinfo As System.IO.FileInfo  
Dim FileName As String
Dim blnHasRows As Boolean

Base.MediaSettings(Path, extList)

'**************************************************************************************************
'	Current version:	1.0
'	Created:			01-08-2002
'	Last modfied:		01-08-2002
'
'	Purpose: List medias in group
'
'	Revision history:
'		1.0 - 01-08-2002 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************

Dim connMedia As IDbConnection = Database.CreateConnection("DWMedia.mdb")
Dim cmdMedia As IDbCommand = connMedia.CreateCommand

If Not IsNothing(Request.QueryString("ID")) Then
	
	SQL = "SELECT * FROM MediaDBMedia WHERE MediaDBMediaID = " & Base.ChkNumber(CInt(Request.QueryString("ID")))

    cmdMedia.CommandText = SQL

    Dim drDBMediaReader As IDataReader = cmdMedia.ExecuteReader

	If drDBMediaReader.Read Then
		MediaDBMediaGroupID = drDBMediaReader("MediaDBMediaGroupID").ToString
		MediaDBMediaNumber = drDBMediaReader("MediaDBMediaNumber").ToString
		MediaDBMediaName = drDBMediaReader("MediaDBMediaName").ToString
		MediaDBMediaKeywords = drDBMediaReader("MediaDBMediaKeywords").ToString
		MediaDBMediaCopyright = drDBMediaReader("MediaDBMediaCopyright").ToString
		MediaDBMediaWidth = drDBMediaReader("MediaDBMediaWidth").ToString
		MediaDBMediaHeigth = drDBMediaReader("MediaDBMediaHeigth").ToString
		MediaDBMediaColors = drDBMediaReader("MediaDBMediaColors").ToString
		MediaDBMediaResolution = drDBMediaReader("MediaDBMediaResolution").ToString
		MediaDBMediaColorSpace = drDBMediaReader("MediaDBMediaColorSpace").ToString
		MediaDBMediaType = drDBMediaReader("MediaDBMediaType").ToString
		MediaDBMediaDescription = drDBMediaReader("MediaDBMediaDescription").ToString
		MediaDBMediaActive = drDBMediaReader("MediaDBMediaActive").ToString
		MediaDBMediaActiveFrom = drDBMediaReader("MediaDBMediaActiveFrom").ToString
		MediaDBMediaActiveTo = drDBMediaReader("MediaDBMediaActiveTo").ToString
		MediaDBMediaFileName = drDBMediaReader("MediaDBMediaFileName").ToString
		MediaDBMediaPrice1 = Base.ChkString(drDBMediaReader("MediaDBMediaPrice1").ToString)
		MediaDBMediaPrice2 = Base.ChkString(drDBMediaReader("MediaDBMediaPrice2").ToString)
		MediaDBMediaPrice3 = Base.ChkString(drDBMediaReader("MediaDBMediaPrice3").ToString)
		MediaDBMediaGroups = drDBMediaReader("MediaDBMediaGroups").ToString
		MediaDBMediaRelated = drDBMediaReader("MediaDBMediaRelated").ToString
		MediaDBMediaBlackWhite = drDBMediaReader("MediaDBMediaBlackWhite").ToString

		If MediaDBMediaActiveTo = "" Or IsDbNull(MediaDBMediaActiveTo) Then
			MediaDBMediaActiveTo = "2999-12-31 23:59"
		End If
	Else
		Response.Write("<strong>" & translate.translate("%% blev ikke fundet!", "%%", Translate.Translate("Produkt")) & "</strong>")
		Response.End()
	End If
	If IsNothing(Request.QueryString.GetValues("ID")) Then
		MediaDBMediaID = Base.ChkNumber(CInt(Request.QueryString("MediaDBMediaID")))
	Else
		MediaDBMediaID = Base.ChkNumber(CInt(Request.QueryString("ID")))
	End If
	
	drDBMediaReader.Dispose
	
Else
	MediaDBMediaActiveFrom = Dates.DWnow()
	MediaDBMediaActiveTo = "2999-12-31 23:59"
	MediaDBMediaActive = True
	MediaDBMediaGroupID = Base.ChkNumber(CInt(Request.QueryString("GroupID"))) 'MediaDBMediaGroupID
	MediaDBMediaID = 0
	MediaDBMediaBlackWhite = False
End If
extension = Base.getFileextension(MediaDBMediaFileName)

MediaDBGroupName = "&nbsp;"
SQL = "SELECT * FROM MediaDBGroup WHERE MediaDBGroupID = " & MediaDBMediaGroupID

cmdMedia.CommandText = SQL

Dim drDBGroupReader As IDataReader = cmdMedia.ExecuteReader

If drDBGroupReader.Read Then
	MediaDBGroupName = drDBGroupReader("MediaDBGroupName").ToString
End If

drDBGroupReader.Dispose
%>


<%' start <!-- #INCLUDE FILE="Media_Edit_Field_List.aspx" -->%>

<%
SQL = "SELECT MediaDBField.*, MediaDBFieldType.MediaDBFieldTypeDW FROM MediaDBFieldType RIGHT JOIN MediaDBField ON MediaDBFieldType.MediaDBFieldTypeID = MediaDBField.MediaDBFieldTypeID"

cmdMedia.CommandText = SQL
Dim drFields As IDataReader = cmdMedia.ExecuteReader()

blnHasRows = False

Do While drFields.Read
	If Not blnHasRows Then  ' First iteration
		ProductEditFieldList = "<table cellpadding=2 cellspacing=0 border=0>" & vbCrLf
	End If
	ProductEditFieldList = ProductEditFieldList & "<tr>" & vbCrLf
	ProductEditFieldList = ProductEditFieldList & "	<td width=170 valign=top>" & drFields("MediaDBFieldName").ToString & "</td>" & vbCrLf
	ProductEditFieldList = ProductEditFieldList & "	<td>" & ReturnInputField(drFields("MediaDBFieldTypeDW").ToString, drFields("MediaDBFieldSystemName").ToString) & "</td>" & vbCrLf
	ProductEditFieldList = ProductEditFieldList & "</tr>" & vbCrLf
	blnHasRows = True
Loop

If blnHasRows Then
	ProductEditFieldList = ProductEditFieldList & "</table>" & vbCrLf
End If

drFields.Dispose
%>

<%'slut%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title></title>
	<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<script language="JavaScript">
function Send(FileToHandle){
	if (document.getElementById('ProductEdit').MediaDBMediaName.value.length < 1){
		TablClick(document.getElementById('Tab1_head'));
		document.getElementById('ProductEdit').MediaDBMediaName.focus();
		alert('<%=Translate.JSTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>');
	}
	else {
		document.getElementById('ProductEdit').action = FileToHandle;
		document.getElementById('ProductEdit').submit();
	}
}

function setFocus(){
	if(document.getElementById('Tab1').style.display!="none"){
		setTimeout("document.getElementById('ProductEdit').MediaDBMediaName.focus()", 250);
	}
}
</script>
<%
Tabs = Translate.Translate("Fil") & IIf(Base.IsImage(extension), "," & Translate.Translate("Thumbnails"), "") & "," & Translate.Translate("Grupper")
If ProductEditFieldList <> "" Then
	Tabs = Tabs & "," & Translate.Translate("Oplysninger")
End If
%>
<%=Gui.MakeHeaders("&nbsp;" & MediaDBMediaName, Tabs, "JavaScript")%>
<body onLoad="setFocus();document.getElementById('BodyContent').style.display=''; InitFckEditor();">
<div ID=BodyContent style="display:none"><br>
<form action="Media_save.aspx" method="post" name="ProductEdit" id="ProductEdit">
<input type="Hidden" value="<%=MediaDBMediaGroupID%>" name="MediaDBMediaGroupID">
<input type="Hidden" value="<%=MediaDBMediaID%>" name="MediaDBMediaID">
<%=Gui.MakeHeaders(MediaDBMediaName & " (" & MediaDBGroupName & ")<br><br>", Tabs, "HTML")%>
<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
	<tr>
		<td valign="top">
			<DIV ID="Tab1" STYLE="display:;">
			<br>
			<table cellspacing="0" border="0" cellpadding="2" width="100%">
				<tr>
					<td>
					<%=Gui.GroupBoxStart(Translate.Translate("Fil"))%>
						<table cellpadding=2 cellspacing=0 border=0>
								<tr>
									<td width=170><%=Translate.Translate("Navn")%></td>
									<td><INPUT TYPE="TEXT" NAME="MediaDBMediaName" VALUE="<%=MediaDBMediaName%>" maxlength="255" class="std"></td>
								</tr>
								<tr>
									<td valign=top><%=Translate.Translate("SÃ¸geord")%></td>
									<td><textarea class=std name="MediaDBMediaKeywords"><%=MediaDBMediaKeywords%></textarea></td>
								</tr>
								<tr>
									<td width=170><%=Translate.Translate("Copyright")%></td>
									<td><INPUT TYPE="TEXT" NAME="MediaDBMediaCopyright" VALUE="<%=MediaDBMediaCopyright%>" maxlength="255" class="std"></td>
								</tr>
								<tr>
									<td><%=Translate.Translate("Sort/hvid")%></td>
							      	<td><%=Gui.CheckBox(MediaDBMediaBlackWhite, "MediaDBMediaBlackWhite")%></td>
							    </tr>
								<tr>
									<td><%=Translate.Translate("Aktiv")%></td>
							      	<td><%=Gui.CheckBox(MediaDBMediaActive, "MediaDBMediaActive")%></td>
							    </tr>
							</table>
					<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
				<tr>
					<td>
					<%=Gui.GroupBoxStart(Translate.Translate("Oplysninger"))%>
						<table cellpadding=2 cellspacing=0 border=0>
								<tr>
									<td><%=Translate.Translate("Filnavn")%></td>
									<td><%=MediaDBMediaFileName%></td>
								</tr>
								<%
								DWMediaOriginalPath = Path & "\Originals\" & MediaDBMediaFileName
								If System.IO.File.Exists(DWMediaOriginalPath) Then
									%>
									<tr>
										<td width=170><%=Translate.Translate("StÃ¸rrelse")%></td>
										<td>
										<%	
										Fileinfo = New System.IO.FileInfo(DWMediaOriginalPath)
										Response.Write(Base.getFileSize(Fileinfo.Length))
										%>
										</td>
									</tr>
									<%	
								End If
								%>
								<%If Base.IsImage(MediaDBMediaType) Then%>
								<tr>
									<td width=170><%=Translate.Translate("Bredde")%></td>
									<td><%=IIf(MediaDBMediaWidth <> "", MediaDBMediaWidth, "N/A")%></td>
								</tr>
								<tr>
									<td><%=Translate.Translate("HÃ¸jde")%></td>
									<td><%=IIf(MediaDBMediaHeigth <> "", MediaDBMediaHeigth, "N/A")%></td>
								</tr>
								<tr>
									<td><%=Translate.Translate("Farver")%></td>
									<td><%=IIf(MediaDBMediaColors <> "", MediaDBMediaColors, "N/A")%></td>
								</tr>
								<tr>
									<td><%=Translate.Translate("OplÃ¸sning")%></td>
									<td><%=IIf(MediaDBMediaResolution <> "", MediaDBMediaResolution, "N/A")%></td>
								</tr>
								<tr>
									<td><%=Translate.Translate("Farve type")%></td>
									<td><%=IIf(MediaDBMediaColorSpace.ToString <> "", MediaDBMediaColorSpace, "N/A")%></td>
								</tr>
								<tr>
									<td><%=Translate.Translate("Orientering")%></td>
									<td><%=Base.getOrientation(MediaDBMediaWidth, MediaDBMediaHeigth, False)%></td>
								</tr>
								<tr>
									<td><%=Translate.Translate("Ratio")%></td>
									<td><%=Base.getRatio(MediaDBMediaWidth, MediaDBMediaHeigth)%></td>
								</tr>
								<%End If%>
							</table>
					<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
				<tr<%=Base.HasAccessHIDE("Publish", "")%>>
					<td>
					<%=Gui.GroupBoxStart(Translate.Translate("Publicering"))%>
						<table cellpadding=2 cellspacing=0 border=0>
							<tr>
								<td width=170><%=Translate.Translate("Gyldig fra")%></td>
								<td><%Response.Write(Dates.DateSelect(MediaDBMediaActiveFrom, True, False, False, "MediaDBMediaActiveFrom"))%></td>
							</tr>
							<tr>
								<td width=170><%=Translate.Translate("Gyldig til")%></td>
								<td><%Response.Write(Dates.DateSelect(MediaDBMediaActiveTo, True, False, True, "MediaDBMediaActiveTo"))%></td>
							</tr>
						</table>
					<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
			</table>
			<table cellspacing="0" border="0" cellpadding="2" width="100%">
				<tr>
					<td>
					<%=Gui.GroupBoxStart(Translate.Translate("Tekst"))%>
						<table cellpadding=2 cellspacing=0 border=0 width="100%">
							<tr>
								<td><%= Gui.Editor("MediaDBMediaDescription", 560, 0, MediaDBMediaDescription, "", Nothing, "", "DwCustomConfig", Gui.EditorEdition.SystemDefault, True, False, True)%></td>
							</tr>
						</table>
					<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
			</table>
			</div>
			
			<%If Base.IsImage(extension) Then%>
			<DIV ID="Tab2" STYLE="display:none;">
			<br>
			
			<table cellspacing="0" border="0" cellpadding="2" width="100%">
				<tr>
					<td>
					<%=Gui.GroupBoxStart(Translate.Translate("Thumbnails"))%>
						<table cellpadding=2 cellspacing=0 border=0>
							<tr>
								<td>
								<%	
								'************** Get settings for thumbnails *************
								SQL = "SELECT MediaDBThumbnailsID, MediaDBThumbnailsMaxwidth, MediaDBThumbnailsMaxheight, MediaDBThumbnailsResizePatern, MediaDBThumbnailsQuality "
								SQL = SQL & "FROM MediaDBThumbnails "
								SQL = SQL & "ORDER BY (MediaDBThumbnails.MediaDBThumbnailsMaxwidth*MediaDBThumbnails.MediaDBThumbnailsMaxheight) DESC"

								cmdMedia.CommandText = SQL
								Dim drThumbnails As IDataReader = cmdMedia.ExecuteReader()
								Dim alThumbnails As ArrayList = New ArrayList

								Do While drThumbnails.Read
									Dim objValues(drThumbnails.FieldCount) As Object
									drThumbnails.GetValues(objValues)
									alThumbnails.Add(objValues)
								Loop

								FileName = Replace(MediaDBMediaFileName & "", ".", "_")

								For Each Row As Object() In alThumbnails
									Response.Write("<img src=""../../../Files/" & Dynamicweb.Content.Management.Installation.ImagesFolderName & "/MediaDB/Thumbs/" & _
										Row(0) & "/" & FileName & _ 
										".jpg"" style=""border:1px solid black;""><br>(" & Row(1) & _
										" x " & Row(2) & " px, " & Translate.translate("Kvalitet") & ": " & Row(4) & ")<br><br>")
								Next 
								
								drThumbnails.Dispose
								'************** End get settings ***************
								%>
								</td>
							</tr>
						</table>
					<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
			</table>
			
			</div>
			<%End If%>
			<%If Base.IsImage(extension) Then%>
			<DIV ID="Tab3" STYLE="display:none;">
			<%Else%>
			<DIV ID="Tab2" STYLE="display:none;">
			<%End If%>
			<br>
			<table cellspacing="0" border="0" cellpadding="2" width="100%">
				<tr>
					<td>
					<%=Gui.GroupBoxStart(Translate.Translate("Grupper"))%>
					<%=Gui.MediaDBGroupList("MediaDBMediaRelated", Base.ChkString(MediaDBMediaRelated), True, 15)%>
					<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
			</table>
			</div>
			<%If Base.IsImage(extension) Then%>
			<DIV ID="Tab4" STYLE="display:none;">
			<%Else%>
			<DIV ID="Tab3" STYLE="display:none;">
			<%End If%>	
			<br>
			<table cellspacing="0" border="0" cellpadding="2" width="100%">
				<tr>
					<td>
					<%=Gui.GroupBoxStart(Translate.Translate("Oplysninger"))%>
					<%=ProductEditFieldList%>
					<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
			</table>
			</div>			
		</td>
	</tr>
	<tr>
		<td align="right" valign="bottom">
			<table cellpadding="0" cellspacing="0">
				<tr>
					<td align="right"><%=Gui.Button(Translate.Translate("OK"), "if(html()){Send('Media_save.aspx');}", 0)%></td>
					<td width="5"></td>
					<td align="right"><%=Gui.Button(Translate.Translate("Annuller"), "location='Media_list.aspx?ID=" & MediaDBMediaGroupID & "'", 0)%></td>
					<td width="20"></td>
				</tr>
				<tr>
					<td colspan="4" height="5"></td>
				</tr>			
			</table>
		</td>
	</tr>
	
</table>
<%=Gui.SelectTab()%>
</form>
</div>
</body>
</html>
<%
	Translate.GetEditOnlineScript()
%>