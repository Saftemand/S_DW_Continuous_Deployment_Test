<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TerminologyTestPage.aspx.vb"%>
<%@ Import namespace="Dynamicweb"%>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>


<script language="javascript">
	if (1==1)
		{
			// alert('<%=Translate.JsTranslate("Ugyldige tegn:")%>\n(hfdjshfkj)');
		}
</script>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
  <head>
    <title>Test page for terminology translation</title>
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
    <meta name=vs_defaultClientScript content="JavaScript">
    <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
  </head>
  <body>
<%
Dim strModuleSystemName as string = "SearchFriendlyUrls"
Dim strModuleName as string = ""
dim strArray as string() = {"test1","test2"}
Dim strModuleSettingsPage as string = ""
		Dim dr As IDataReader = Database.CreateDataReader("SELECT ModuleName, ModuleScript FROM [Module] WHERE ModuleSystemName = '" & strModuleSystemName & "'")
		If dr.Read() Then
			strModuleName = dr("ModuleName").ToString
			strModuleSettingsPage = dr("ModuleScript").ToString
		End If
		strModuleName = Translate.JSTranslate(strModuleName,9)
		dr.Close()
		dr.Dispose()
%>
<!--
		<table cellpadding='2' cellspacing='0' border='0' width='590'><tr><td> 
		<%=Gui.GroupBoxStart(Translate.Translate("Modul"))%>
		<table cellpadding='2' cellspacing='0' border='0' width='100%'>
		    <tr valign=middle>
		        <td align=left nowrap>
		            <span title='<%=Translate.JSTranslate("Modulopsætning")%>' onclick='window.open("/admin/module/Calender/Calender_Category_List.aspx", "window_name", "toolbar=no, directories=no, location=no, status=yes, menubar=no, resizable=no, scrollbars=no, width=630, height=400");' style='font-size: 14; font-family: Verdana, Arial, Helvetica; font-weight: Bold;'><img src='/Admin/Images/Icons/Module_Calendar.gif' align="center">&nbsp;Module Name</span>
		        </td>
				<td align=right width=32><%=Gui.Button(Translate.Translate("Fjern modul"), "if (confirm('" & Translate.Translate("Fjern modul?") & "\n(Module Name)')){location = 'Paragraph_Remove_Module.aspx?ParagraphID=" & HttpContext.Current.Request("ID") & "&ParagraphPageID=" & HttpContext.Current.Request("PageID") & "';}", 20)%></td>
				<td align=right width=32><%=Gui.HelpIcon("", "", "modules", "/Admin/Images/Icons/Help.gif")%></td>
		    </tr>
		</table>
		<%=Gui.GroupBoxEnd%>
		</td></tr></table>
-->
		<table cellpadding='2' cellspacing='0' border='0' width='590'><tr><td> 
		<%=Gui.GroupBoxStart(Translate.Translate("Modul"))%>
		<table cellpadding='2' cellspacing='0' border='0' width='100%'>
		    <tr valign=middle>
		        <td align=left nowrap>
		            <span style='font-size: 14; font-family: Verdana, Arial, Helvetica; font-weight: Bold;'><img src='/Admin/Images/Icons/Module_<%=strModuleSystemName%>.gif' align="center">&nbsp;<%=strModuleName%></span>
		        </td>
				<td align=right width=32><%if strModuleSettingsPage<>"" then%><%=Gui.Button(Translate.Translate("Opsætning",1), "window.open('/admin/module/" & strModuleSettingsPage & "', '" & strModuleSystemName &"', 'toolbar=no, directories=no, location=no, status=yes, menubar=no, resizable=no, scrollbars=yes, width=650, height=400');", 20)%><%End If%></td>
				<td align=right width=32><%=Gui.Button(Translate.Translate("Fjern"), "if (confirm('" & Translate.Translate("Fjern modul?") & "\n(" & strModuleName & ")')){location = 'Paragraph_Remove_Module.aspx?ParagraphID=" & HttpContext.Current.Request("ID") & "&ParagraphPageID=" & HttpContext.Current.Request("PageID") & "';}", 20)%></td>
				<td align=right width=32><%=Gui.HelpIcon("", "", "modules." & strModuleSystemName & ".paragraph", "/Admin/Images/Icons/Help.gif")%></td>
		    </tr>
		</table>
		<%=Gui.GroupBoxEnd%>
		</td></tr></table>
		<%=strArray(1)%>
  </body>
</html>
<%
	Translate.GetEditOnlineScript()
%>
