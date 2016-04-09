<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<HTML>
	<HEAD>
		<title>FilePublishingV2</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK rel="STYLESHEET" type="text/css" href="../Stylesheet.css">
		<script language=visualbasic runat=server>
		
		Sub btnOk_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
            If Not IsNothing(Base.Request("ReplicateFolder")) AndAlso Base.Request("ReplicateFolder").Length > 0 Then                
                Base.SetGs("/Globalsettings/Modules/FilePublishingV2/Replicate/Folder", Base.Request("ReplicateFolder"))
            End If
            If Not IsNothing(Base.Request("FilesPrForm")) AndAlso Base.Request("FilesPrForm").Length > 0 Then                
                Base.SetGs("/Globalsettings/Modules/FilePublishingV2/Upload/FilesPrForm", Base.Request("FilesPrForm"))
            End If
            Response.Redirect("/Admin/Module/ControlPanel.aspx")
        End Sub

        Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
            Response.Redirect("/Admin/Module/ControlPanel.aspx")
        End Sub 
		</script>
	</HEAD>
	<body>
<%=Gui.MakeHeaders(Translate.Translate("Kontrol Panel - %%","%%","FilePublishingV2"),Translate.Translate("Konfiguration"), "all")%>
<TABLE border="0" cellpadding="2" cellspacing="0" class="tabTable">
	<form id="FilePublishingV2Settings" method="post" runat="server">		
		<TR>
			<TD valign="top">
			<%=Gui.MakeModuleHeader("FilePublishingV2", Translate.Translate("FilePublishingV2"), False)%>				
				<dw:groupbox id="GroupBox1" runat="server" title="Upload">
				<TABLE border="0" cellpadding="2" cellspacing="0">						
						<TR valign="top">
							<TD width="170">
							<dw:translatelabel id="Translatelabel1" runat="server" text="Enkeltfil upload" /></TD>
							<TD>				
								<INPUT type="text" maxlength="255" class="std" style="width: 25px" size="3" value="<%= IIf(Base.GetGs("/Globalsettings/Modules/FilePublishingV2/Upload/FilesPrForm") <> "", Base.GetGs("/Globalsettings/Modules/FilePublishingV2/Upload/FilesPrForm") ,"5") %>" name="FilesPrForm" id="FilesPrForm">
								<dw:translatelabel id="Translatelabel2" runat="server" text="filer ad gangen." />								 
							</TD>
						</TR>
					</TABLE>
				</dw:groupbox>					
				<dw:groupbox id="Groupbox2" runat="server" title="Replicate">
				<TABLE border="0" cellpadding="2" cellspacing="0">						
						<TR valign="top">
							<TD width="170">
							<dw:translatelabel id="Translatelabel3" runat="server" text="Upload folder" />							
							<TD>								
								<%=Gui.FolderManager(Base.GetGs("/Globalsettings/Modules/FilePublishingV2/Replicate/Folder"),"ReplicateFolder")%>
							</TD>
						</TR>
					</TABLE>
				</dw:groupbox>
			</td>
			</tr>
					<tr>
						<td align="right">
							<asp:Button id="btnOk" runat="server" Text="Ok" CssClass="buttonSubmit" OnClick="btnOk_Click"></asp:Button>
							<asp:Button id="btnCancel" runat="server" Text="Cancel" CssClass="buttonSubmit" OnClick="btnCancel_Click"></asp:Button>&nbsp;
						</td>
					</tr>
			</form>
			</TBODY>
		</TABLE>
		<% Translate.GetEditOnlineScript() %>
	</BODY>
</HTML>
