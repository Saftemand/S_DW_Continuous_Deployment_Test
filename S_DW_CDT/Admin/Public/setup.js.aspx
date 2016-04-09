<%@ Page Language="vb" %>

<%@ Import Namespace="Dynamicweb" %>

FCKConfig.SkinPath = "/admin/editor/editor/skins/office2003/";
FCKConfig.ImageBrowserURL = "/Admin/FileManager/Browser/Default.aspx?Mode=browse&Caller=txtUrl&Folder=/&strChosenFile=";
FCKConfig.LinkBrowserURL = "/Admin/Editor/EditorLinker.aspx?Timestamp=<%=DateTime.Now.Ticks()%>";
//FCKConfig.LinkBrowserURL = "/Admin/Menu.aspx?ID=0&Action=InternalNewEditor&Caller=txtUrl&AreaID=1&strShowParagraphsOption=on";
FCKConfig.TemplatesXmlPath = '/files/templates/editor/mytemplates.xml' ;
FCKConfig.LinkBrowserWindowWidth = 350;
FCKConfig.LinkBrowserWindowHeight = 70;
FCKConfig.ImageBrowserWindowWidth  = 1024;
FCKConfig.ImageBrowserWindowHeight = 700;
FCKConfig.ImageUpload = false ;
FCKConfig.LinkUpload = false ;
FCKConfig.FlashUpload = false ;
FCKConfig.AutoDetectLanguage = false;
<%If CType(HttpContext.Current.Session("DW_Language_Code"), String) <> "" Then%>
	FCKConfig.DefaultLanguage = "<%=CType(HttpContext.Current.Session("DW_Language_Code"), String) %>"
<%Else%>
	FCKConfig.DefaultLanguage = "en"
<%End If%>

<%If Base.ChkBoolean( Base.GetGs("/Globalsettings/Settings/Paragraph/RequireAltAndTitle")) Then%>
FCKConfig.RequireImageAltAndTitle = true;
<%Else%>
FCKConfig.RequireImageAltAndTitle = false;
<%  End If%>