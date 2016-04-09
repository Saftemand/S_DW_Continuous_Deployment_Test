<%@ Page Language="vb" AutoEventWireup="false" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb.Content.Files" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<%
Dim tmpHTML As String
Dim h As Object
Dim File As String = ""
Dim FileHome As String
Dim c As String = ""
Dim Folder As String = ""
Dim wi As Object
Dim wh As String = ""
    Dim size As String = ""
Dim d As String = ""
    Dim FilePath As String
    Dim FilePathEncode As String
Dim ext As String
Dim height As String = ""
Dim width As String = ""
    Dim documentTitle As String = ""
    Dim blnFileNotFound As Boolean = False
    Dim hasAccessToEdit As Boolean = False

If Not IsNothing(Request.QueryString("File")) Then
	Session.CodePage = 1252
	File = Request.QueryString("File")
	Folder = Request.QueryString("Folder")
	ext = lcase(Dynamicweb.Image.GetFileextension(File))
    
        If File.StartsWith("/") Then
            File = File.TrimStart({"/"c})
        End If
        FilePath = "/Files/" & Folder & "/" & File
        FilePathEncode = "/Files/" & Folder & "/" & HttpUtility.UrlEncode(File).Replace("+", " ")
        FilePath = Replace(FilePath, "//", "/")
        FilePathEncode = Replace(FilePathEncode, "//", "/")
        
        Folder = FilePath.Substring(0, FilePath.LastIndexOf("/"c))
        hasAccessToEdit = Permission.HasAccess(Folder.Substring("/Files".Length))
        
        If ext = "gif" Or ext = "jpg" Or ext = "jpeg" Or ext = "png" Or ext = "bmp" Then
            tmpHTML = "<img id=""Image"" class=""imageResizable"" src=""" & FilePathEncode & "?" & Date.Now().Millisecond & """>"
            documentTitle = "Billedpreview"
        ElseIf ext = "swf" Then
            tmpHTML = String.Format("<div id=""Image"">{0}<div>", Dynamicweb.Image.WriteFlash(FilePath))
            documentTitle = "Billedpreview"
            cmdEditImage.Visible = False
        ElseIf ext = "htm" Or ext = "html" Then
            tmpHTML = Base.ReadTextFile(Server.MapPath(FilePath))
            documentTitle = "Document preview"
        ElseIf ext = "pdf" Then
            tmpHTML = String.Format("<embed id=""Image"" height=""100%"" width=""100%"" pluginspage=""http://www.adobe.com/products/acrobat/readstep2.html"" src=""{0}"" type=""application/pdf"">", FilePathEncode)
            documentTitle = "Document preview"
            cmdEditImage.Visible = False
        End If
        
        If ext = "gif" Or ext = "jpg" Or ext = "jpeg" Or ext = "png" Or ext = "bmp" Then
            If IO.File.Exists(Server.MapPath(FilePath)) Then
                Dim imgfullSizeImg As System.Drawing.Image
                Try
                    imgfullSizeImg = System.Drawing.Image.FromFile(Server.MapPath(FilePath))
                Catch ex As OutOfMemoryException
                    Response.Write("This file is not an image")
                    Response.End()
                End Try

                height = imgfullSizeImg.Height
                width = imgfullSizeImg.Width
                'c = imgfullSizeImg.GetPixelFormatSize(imgfullSizeImg.PixelFormat)
                'If c <> "" Then
                '    c = Translate.Translate("%% Bit", "%%", c)
                'End If
                wh = Translate.Translate("%w% x %h%", "%w%", width, "%h%", height)
                imgfullSizeImg.Dispose()
                
                Dim image As System.IO.FileInfo = New System.IO.FileInfo(Server.MapPath(FilePath))
                size = Math.Round(image.Length / 1024).ToString()
                d = image.LastWriteTime().ToShortDateString()
            Else
                blnFileNotFound = True
            End If
        ElseIf ext = "swf" Then
            Dim swfObj As Dynamicweb.Image = New Dynamicweb.Image
            swfObj.SwfDump(Server.MapPath(FilePath))
            width = swfObj.Width.ToString
            height = swfObj.Heigt.ToString
            
            If swfObj.Compressed Then
                wh = Translate.Translate("Komprimeret")
            Else
                wh = Translate.Translate("%w% x %h%", "%w%", width, "%h%", height)
            End If
            c = Translate.Translate("Ver. %%", "%%", swfObj.Version.ToString)
        ElseIf ext = "pdf" Then
            width = "800"
            height = "600"
            wh = ""
        Else
            width = "0"
            height = "0"
            wh = ""
        End If
        
        If Not hasAccessToEdit Then
            cmdEditImage.Visible = False
            cmdDelete.Visible = False
        End If
        
        Session.CodePage = 65001
    End If%>
<%if blnFileNotFound then%>
<SCRIPT language='JavaScript'>
	alert('<%=Translate.JSTranslate("Filen er ikke fundet")%>');
	window.close();
</SCRIPT>
<%End if%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<link href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" rel="stylesheet" type="text/css" />
<link href="FileManager_Preview.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/Admin/Content/JsLib/prototype-1.6.0.2.js"></script>
<title><%=Translate.JSTranslate("FileManager")%></title>
<link rel="STYLESHEET" type="text/css" href="../Stylesheet.css" />
<script type="text/javascript">
var winOpener = opener;
var picWidth = <%=width%>;
var picHeight = <%=height%>;

function ResizeWin() {
	var resWidth = 700;
	var resHeight = 700;
    
	try {
		if (picWidth > resWidth) {
			resWidth = picWidth + 32;
		}
		if (picHeight > resHeight) {
			//resHeight = picHeight;
			resHeight = picHeight + 100;
		}	
	} catch(e) {
		//Nothing
	}	
	
	window.resizeTo(resWidth,resHeight)
}
window.onload= ResizeWin

Event.observe(document.onresize ? document : window, "resize", function(event) {
    if(($('Image').getHeight() < picHeight || $('Image').getWidth() < picWidth) ||
        ($('wrapperImage').getDimensions().height < picHeight || $('wrapperImage').getDimensions().width < picWidth))
        $('cmdFullSize').className = 'toolbar-button';
    else 
        $('cmdFullSize').className = 'toolbar-button-disabled';
    Event.stop(event);
});

editImage = function () {
    var width = window.screen.width - 300;
    var height = window.screen.height - 300;
    var filePathEncode = "<%=FilePathEncode %>";

    DW_imageeditor_window = window.open("/Admin/Filemanager/ImageEditor/Edit.aspx?File=" + filePathEncode, "DW_imageeditor_window", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=yes,minimize=no,width=" + width + ",height=" + height + ",left=150,top=150");
    DW_imageeditor_window.focus();
}

deleteFile = function () {
    var file = "<%=File %>";
    var folder = "<%=Folder %>";
    var filePathEncode = "<%=FilePathEncode %>";
    
    //delete one file
    if (confirm('<%=Translate.JsTranslate("Delete this file")%>: ' + file + '?')) {
        url = "/Admin/Filemanager/Browser/FileSystem.aspx?action=delete&file=" + filePathEncode + '&timestamp=' + (new Date()).getTime();
        new Ajax.Request(url, {
            method: 'get',
            onSuccess: function (transport) {
                if (transport.responseText.truncate().length > 0)
                    alert(transport.responseText);
                else {
                    if (winOpener && winOpener.parent && winOpener.parent.reloadWindow){
                        winOpener.parent.reloadWindow(folder);
                    }
                    self.close();
                }
            }
        });
    }
}

download = function () {
    var filePathEncode = "<%=FilePathEncode %>";

    document.location.href = "/Admin/Public/download.aspx?Filarchive=true&File=" + filePathEncode, "FileManagerAction", "";
    return false;
}

viewFullSize = function () {
    if($('cmdFullSize').className == 'toolbar-button') {
        if($('Image').hasClassName('imageResizable')) {
            $('Image').className = 'imageFullSize';
        }
        else {
            $('Image').className = 'imageResizable';
        }
    }
}
</script>
</head>
<body style="margin:0px;">
        <%If ext = "gif" Or ext = "jpg" Or ext = "png" Or ext = "bmp" Or ext = "pdf" Or ext = "swf" Then%>
            <div id="divToolbar">
                <dw:Toolbar ID="Buttons" runat="server" ShowEnd="false">
                    <dw:ToolbarButton ID="cmdClose" runat="server" Divide="None" ImagePath="../images/Close_off.gif" Text="Close"
                        OnClientClick="self.close();">
                    </dw:ToolbarButton>
                    <dw:ToolbarButton ID="cmdEditImage" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/EditDocument.png" Text="Edit"
                        OnClientClick="editImage()">
                    </dw:ToolbarButton>
                    <dw:ToolbarButton ID="cmdFullSize" runat="server" Divide="None" Image="FolderUpload" Text="View full size"
                        OnClientClick="viewFullSize();">
                    </dw:ToolbarButton>
                    <dw:ToolbarButton ID="cmdDelete" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/DeleteDocument.png" Text="Delete"
                        OnClientClick="deleteFile();">
                    </dw:ToolbarButton>
                    <dw:ToolbarButton ID="cmdDownload" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/Download.png" Text="Download"
                        OnClientClick="download();">
                    </dw:ToolbarButton>
                </dw:Toolbar>
            </div>
            <div id="wrapperImage">
		            <div id="imagearea">
			            <%=tmpHTML%>
		            </div>
            </div>
	        <div id="statusBarImage">
		        <span class="statusBarItem"><span><%= FilePath%> - <%= wh%> - <%= size%> kb - <%=d%></span></span>		
	        </div>
       <%Else %>
            <div id="wrapperFile">
		        <div id="filearea">
			        <%=tmpHTML%>
		        </div>
            </div>
	        <div id="statusBar">
		        <span class="statusBarItem"><span><%= FilePath%></span></span>		
	        </div>
      <%End If%>
</body>
</html>
<%
Translate.GetEditOnlineScript()
%>