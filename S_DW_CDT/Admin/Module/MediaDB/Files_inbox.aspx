<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Files_inbox.aspx.vb" Inherits="Dynamicweb.Admin.Files_inbox" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="System.drawing" %>
<%@ Import namespace="System.drawing.imaging" %>
<%@ Import namespace="System.drawing.drawing2d" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="WebSupergoo.ImageGlue6" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<script language="VB" runat="Server">
Dim ThumbPathNoExt As String
Dim Width As Integer
Dim intOrigWidth As Integer
Dim intThumbWidth As Integer
Dim Height As Integer
Dim intOrigHeight As Integer
Dim intThumbHeight As Integer
Dim NumberOfFiles As Integer
Dim FileHome As String
Dim Browse As Boolean
Dim StatusText As String
Dim tempPicHTML As String
Dim Path As String
Dim h As String
Dim c As String
Dim Root As String
Dim ThumbPath As String
Dim Extension As String
Dim ThumbHttpPath As String
Dim wi As Object
Dim wh As String
Dim CurrentPath As String
Dim iRow As Object
Dim Cbit() As String
Dim varInboxFolder As String
Dim omo As String
Dim FileInfo as System.IO.FileInfo  
Dim File As String
</script>

<%Server.ScriptTimeOut = 24*60 'minutes%>

<%
Base.MediaSettings(Path, extList)

varInboxFolder = Request.QueryString("InboxFolder")
If varInboxFolder = "" Then
    varInboxFolder = "/" & Dynamicweb.Content.Management.Installation.ImagesFolderName & "/MediaDB"
End If
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
	<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
    <script type="text/javascript">        var ImagesFolderName = '<%=Dynamicweb.Content.Management.Installation.ImagesFolderName%>';</script>
    <script type="text/javascript" src="../../Filemanager/Browser/EntryContent.js"></script>
	<script>
    var _popupWins = new Array();
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
	
	function mclick(ID){
		if(document.getElementById("R" + ID).style.backgroundColor != '#c3d6e6'){
			document.getElementById("R" + ID).style.backgroundColor = '#c3d6e6';
		}
		else{
			document.getElementById("R" + ID).style.backgroundColor = '';
		}
	}
	
	function SelectAll(){
		NumberOfRows = document.getElementById('countform').NumberOfRows.value;
		for(i=0;i<NumberOfRows;i++){
			if(document.getElementById("C" + i)){
				if(document.getElementById('selectallCheck').checked){
					document.getElementById("C" + i).checked = true;
					document.getElementById("R" + i).style.backgroundColor = '#c3d6e6';
				}
				else{
					document.getElementById("C" + i).checked = false;
					document.getElementById("R" + i).style.backgroundColor = '';
				}
			}
		}
	}
	
	function DeleteFile(filename){
		if(confirm("<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("fil"))%>\n(" +  filename + ")")){
			location = "Files_Delete.aspx?FileName=" + filename + "&Path="+ document.getElementById("FLDM_InboxFolder").value;
		}
	}
	
	function Send(){
		OneSelected = false;
		NumberOfRows = document.getElementById('countform').NumberOfRows.value;
		for(i=0;i<NumberOfRows;i++){
			if(document.getElementById("C" + i)){
				if(document.getElementById("C" + i).checked){
					OneSelected = true;
				}
			}
		}
		if(OneSelected){
			document.getElementById('selectform').submit();
		}
		else{
			alert("<%=Translate.JSTranslate("Vælg mindst en fil")%>")
		}
	}
    
	function Upload()
	{        
        _popupWins["filemanager"] = window.open("../../FileManager/Browser/Default.aspx?Folder=" + document.getElementById('FLDM_InboxFolder').value, "filemanager", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=800,height=600,screenX=50,screenY=50");
        url = '/Admin/Filemanager/Upload/Upload.aspx?Folder=' + document.getElementById('FLDM_InboxFolder').value +
            '&AllowChangeLocation=false&AllowOverwriteFiles=false&OnLoad=opener.MediaDB_RefreshFileManagerOnUpload';
        _popupWins["fmUploadWnd"] = window.open(url, 'fmUploadWnd', 'status=false,toolbar=false,location=false,menubar=false,directories=false,scrollbars=false,width=950,height=600');
	}

    function MediaDB_RefreshFileManagerOnUpload()
    {        
        var manager = _popupWins["fmUploadWnd"].UploadManager.getInstance();
        if (manager.get_canUpload()) {
            manager.add_afterUpload(function (sender, args) {
                _popupWins["filemanager"].document.location.href = "../../FileManager/Browser/Default.aspx?Folder=" + document.getElementById('FLDM_InboxFolder').value;
            });
        }
    }

	var LastID = 0
	var timer
	timer = setTimeout("hideMenu()",4000)

	function ShowPic(Path, menuobject, documentObj, Ey, Ex)
	{
		clearTimeout(timer);
		if(document.getElementById("PicMenu"))
			document.getElementById("PicMenu").style.display = "none";		
		var objJsdoc = new Object(); 
		var MenuHTML
		objJsdoc = "top.left.";

		if(!menuobject){
			menuobject = document.getElementById("PicMenu");
		}

		if(!documentObj){
			documentObj = document;
		}
		menuobject.setCapture();
		if(!Ey){ //Called from leftmenu
			Ey = event.clientY;
			Ex = event.clientX;
			menuobject.style.top=Ey + documentObj.body.scrollTop;
			menuobject.style.left=Ex + 10;
		}
		else{ //Called from paragraph_list.aspx
			menuobject.style.top=Ey + documentObj.body.scrollTop - 150;
			menuobject.style.left=Ex-50;
		}

		menuobject.releaseCapture();
		menuobject.style.display = "";
		document.getElementById("PicPrev").innerHTML = "<img src='" + Path + "'>"
		timer = setTimeout("hideMenu()",4000)
	}

	function hideMenu()
	{
	if(document.getElementById("PicMenu"))
		document.getElementById("PicMenu").style.display = "none";			
	}
	
	</script>
</head>
<%=Gui.MakeHeaders(Translate.Translate("Indbakke"), Translate.Translate("Filer"), "All")%>
<div id="load">
<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
	<tr>
		<td valign="top"></td>
	</tr>
	<tr>
		<td valign="middle" align="center">
			<%=Translate.Translate("Søger efter nye %%...", "%%", Translate.Translate("filer"))%><div id="status"></div><br><br>
			<img src="../../images/statusruler.gif" align="middle" />
		</td>
	</tr>
</table>
</div>
<%Response.Flush()%>
<table border="0" cellpadding="0" cellspacing="0" class="tabTable">
	<form name="selectform" id="selectform" method="post" action="Files_Import.aspx">
	<tr>
		<td valign="top">
			<div id="Tab1">
			<table cellpadding="0" cellspacing="0" border="0" class="clean" width="100%">
				<tr height="21">
					<td>
					</td>
					<td>
						<input id="selectallCheck" onclick="SelectAll()" type="checkbox"></td>
					<td>
						<strong>&nbsp;<%=Translate.Translate("Filnavn")%></strong></td>
					<td align="right" width="110">
						<strong>
							<%=Translate.Translate("Ændret")%>
						</strong>
					</td>
					<td align="right" width="90">
						<strong>
							<%=Translate.Translate("Dimensioner")%>
						</strong>
					</td>
					<td align="right" width="60">
						<strong>
							<%=Translate.Translate("Farver")%>
						</strong>
					</td>
					<td align="right" width="70">
						<strong>
							<%=Translate.Translate("Størrelse")%>
						</strong>
					</td>
					<%If Not Browse Then%>
					<td align="right" width="40">
						<strong>
							<%=Translate.Translate("Slet")%>
							&nbsp;</strong></td>
					<%End If%>
				</tr>

			<%
			    Dim gs As New Gestalt
			    Try
			        gs.License = "357-567-964-488-9635-441"
			    Catch ex As Exception
			    End Try
			    
			    iRow = 1
			    CurrentPath = Replace(Path, "\" & Dynamicweb.Content.Management.Installation.ImagesFolderName & "\MediaDB", "") & Replace(varInboxFolder, "/", "\")
			    Dim canvas As New Canvas()
			    Dim image As New Graphic()
			    Dim rect As New XRect()

			    If System.IO.Directory.Exists(CurrentPath) Then
			        NumberOfFiles = System.IO.Directory.GetFiles(CurrentPath).Length()
			        Response.Write("<script>document.getElementById('status').innerText = '(0/" & NumberOfFiles & ")';</script>")
			        Response.Flush()

			        Dim currentFiles() As String = System.IO.Directory.GetFiles(CurrentPath)

					'Rename - don't like comma...
					For Each File In currentFiles
						FileInfo = New System.IO.FileInfo(File)
						If FileInfo.Name.Contains(",") Then
							Dim path As String = FileInfo.FullName
							Dim path2 As String = FileInfo.DirectoryName & "\" & FileInfo.Name.Replace(",", "_")
							If System.IO.File.Exists(path2) Then
								path2 = FileInfo.DirectoryName & "\" & System.DateTime.Now.Ticks & FileInfo.Name.Replace(",", "_")
							End If
							System.IO.File.Move(path, path2)
						End If
					Next
					currentFiles = Nothing
					currentFiles = System.IO.Directory.GetFiles(CurrentPath)
			        For Each File In currentFiles
			            FileInfo = New System.IO.FileInfo(File)
			            Extension = getFileextension(FileInfo.Name)
			            ThumbHttpPath = ""
			            If IsImage(Extension) Then
			                Try
			                    image.SetFile(FileInfo.FullName)
			                    'ImageGlue.ReadImages = False
			                    If Not System.IO.Directory.Exists(Path & "\InboxThumbs\") Then
			                        System.IO.Directory.CreateDirectory(Path & "\InboxThumbs\")
			                    End If
			                    ThumbPath = Path & "\InboxThumbs\" & FileInfo.Name & ".jpg"
			                    ThumbHttpPath = "http://" & Request.ServerVariables("server_name") & "/Files/" & Dynamicweb.Content.Management.Installation.ImagesFolderName & "/MediaDB/InboxThumbs/" & FileInfo.Name & ".jpg"
			                    If Not System.IO.File.Exists(ThumbPath) Then
			                        rect.String = image(0).Rectangle
			                        canvas.Width = 80
			                        canvas.Height = (80 * rect.Height) / rect.Width
			                        canvas.DrawFile(FileInfo.FullName, "size=" & canvas.Width & "," & canvas.Height)
			                        canvas.SaveAs(ThumbPath, "Quality=50%")
			                        canvas.Clear()
			                    End If
			                    'tempPicHTML = tempPicHTML & "<div id='PicMenu" & iRow & "' class='picPreview' style='display:none;'><table cellpadding=0 cellspacing=1 border=0><tr><td><img src='" & ThumbHttpPath + "'></td></tr></table></div>"

			                    If Extension = "swf" Then
			                        'Set Canvas = Server.CreateObject("ImageGlue5.Canvas")
			                        'Canvas.DrawFile ImageGlue, ""
			                        'w Canvas.Width
			                        'w TypeName(ImageGlue)
			                        'w ImageGlue.Format
			                        'For each elm In ImageGlue
			                        '	w elm  & " : " & ImageGlue(elm)
			                        'next
			                        'w ImageGlue().Time
			                        'w ImageGlue(1).Time
			                        wh = image(0).Width & " x " & image(0).Height
			                        c = image(0).Depth
			                    Else
			                        wh = image(0).Width & " x " & image(0).Height
			                        c = image(0).Depth
			                    End If
			                Catch e As Exception
			                    'base.w(e.tostring)
			                End Try
			            Else
			                wh = ""
			                c = ""
			            End If

			            Response.Write("<tr><td colspan=""8"" bgcolor=""#C4C4C4""><img src=""../../images/nothing.gif"" width=1 height=1 border=0></td></tr>" & vbCrLf)
			            If ThumbHttpPath <> "" Then
			                omo = " onmouseover=""ShowPic('" & ThumbHttpPath & "');"""
			                Response.Write("<tr height=21 ID=""R" & iRow & """ onmouseover=""cc(this)"" onmouseout=""ccb(this)"" class=h>" & vbCrLf)
			            Else
			                Response.Write("<tr onmouseover=""hideMenu()"" height=21 ID=""R" & iRow & """ onmouseover=""cc(this)"" onmouseout=""ccb(this)"" class=h>" & vbCrLf)
			            End If
			            Response.Write("<td width=22><img src=../../images/ext/" & GetIcon(Extension) & ".gif" & omo & "></td>" & vbCrLf)
			            Response.Write("<td><input type=checkbox name=SelectedFiles value=""" & FileInfo.Name & """ onClick=""mclick(" & iRow & ")"" ID=""C" & iRow & """></td>" & vbCrLf)
			            Response.Write("<td style=""width:190px;height:15px;overflow:hidden;"">" & FileInfo.Name)
			            
			            Response.Write("</td>" & vbCrLf)
			            Response.Write("<td width=110 align=right>" & Dates.ShowDate(CDate(FileInfo.LastWriteTime), Dates.DateFormat.Short, True) & "</td>" & vbCrLf)
			            Response.Write("<td width=90 align=right>" & wh & "</td>" & vbCrLf)
			            Response.Write("<td width=60 align=right>" & c & "</td>" & vbCrLf)
    					
			            Response.Write("<td width=70 align=right>" & FormatNumber(FileInfo.Length / 1024, 0) & " KB" & "</td>" & vbCrLf)
			            Response.Write("<td width=40 align=right><img src=""../../images/Delete.gif"" border=0 onClick=""DeleteFile('" & FileInfo.Name & "');"">&nbsp;</td>" & vbCrLf)
			            Response.Write("</tr>" & vbCrLf)
			            Response.Write("<script>document.getElementById('status').innerText = '(" & iRow & "/" & NumberOfFiles & StatusText & ")'</script>")
			            Response.Flush()
			            iRow = iRow + 1
			        Next
			    End If

			    Response.Write("<tr><td colspan=""8"" bgcolor=""#C4C4C4""><img src=""../../images/nothing.gif"" width=1 height=1 border=0></td></tr>" & vbCrLf)
			%>
			</table>
			</div>
		</td>
	</tr>
	<tr>
		<td height=5></td>
	</tr>
	<tr>
		<td align="left" valign="bottom">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td width="5"></td>
					<td align="left"><%=Translate.translate("Vælg mappe")%></td>
					<td width="3"></td>
					<td align="left"><%= Gui.FolderManager(varInboxFolder, "InboxFolder")%></td>
					<td width="1">&nbsp;</td>
					<td align="right"><%=Gui.Button(Translate.Translate("Upload filer"), "Upload()", 0)%><%=Gui.Button(Translate.Translate("Importer",1), "Send('Media_import.aspx');", 0)%></td>
					<td width="4"></td>
				</tr>
				<tr>
					<td colspan="4" height="5"></td>
				</tr>			
			</table>
		</td>
	</tr>
	</form>
</table>
<div id='PicMenu' class='picPreview' style='display:none;'><table cellpadding=0 cellspacing=1 border=0><tr><td ID='PicPrev'><img SRC='../../images/nothing.gif'></td></tr></table></div>
<%
Response.Write(tempPicHTML)
Translate.GetEditOnlineScript()
%>
<form name="countform" id="countform">
<input type=hidden name=NumberOfRows ID=NumberOfRows value="<%=iRow%>">
</form>
<script>
document.getElementById('load').style.display = 'none';
</script>
