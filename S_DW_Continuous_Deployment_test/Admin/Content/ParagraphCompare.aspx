<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ParagraphCompare.aspx.vb" Inherits="Dynamicweb.Admin.ParagraphCompare" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>
		<dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Sammenlign versioner" />
	</title>
	<dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true">
	</dw:ControlResources>

	<script type="text/javascript">
		var versionID = <%=Dynamicweb.Base.Request("VersionID")%>;
		function restore() {
			top.opener.restore(versionID);
			top.close();
			top.opener.focus();
		}
		
		function html(){
			var loc = '<%=Dynamicweb.Base.GetHttpUrl(True, True).toLower().Replace("&htmlcompare=" & Dynamicweb.Base.Request("htmlCompare"), "") %>' + '&htmlCompare=<%=(Not Dynamicweb.Base.ChkBoolean(Dynamicweb.Base.Request("htmlCompare"))).toString.toLower()%>';
			location = loc;
		}
		
		function changeCompare(version){
			var loc = '<%=Dynamicweb.Base.GetHttpUrl(True, True).toLower().Replace("&versionid=" & Dynamicweb.Base.Request("VersionID"), "") %>' + '&VersionID=' + version;
			location = loc;
		}
	</script>

	<style type="text/css">
		.ci
		{
			color: black !important;
			background-color: #80FF80 !important;
		}
		.cd
		{
			color: black !important;
			background-color: #FF8080 !important;
		}
		td
		{
			vertical-align: top;
		}
		.h1
		{
			font-size: 13px;
			font-weight: bold;
		}
		.h2
		{
			font-size: 12px;
			font-weight: bold;
		}
		.h3
		{
			font-size: 11px;
			font-weight: bold;
		}
		.g
		{
			background-color:#DDECFF;
			white-space:nowrap;
		}
		.t
		{
			right:17px;
			border-collapse:collapse;
		}
		.t td
		{
			border:solid 1px #8DAED9;
			padding:5px;
		}
		tr.g td
		{
			border-top:solid 0px white;
			background: url('/Admin/Images/Ribbon/UI/List/PipeL.gif' ) top left repeat-x;
		}
		.inlineToolbar ul
		{
			border-bottom-style:none;
		}
	</style>
</head>
<body style="border-right-style:none;border-left-style:none;">
<h1 class="title" style="display:inherit;">
	<dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Sammenlign versioner" />
</h1>
<div style="position: fixed; top: 0px; right: 0px;">
	<dw:Toolbar ID="Toolbar1" runat="server" ShowEnd="false" ShowStart="false">
		<dw:ToolbarButton ID="ToolbarButton2" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/Error.png" Text="Luk" OnClientClick="top.close();top.opener.focus();">
		</dw:ToolbarButton>
	</dw:Toolbar>
</div>
<div style="position: fixed; top: 27px; right: 0px;bottom:0px;left:0px;overflow:auto;">
<table class="t">
	<tr class="g">
		<td width="170"><strong>
			
		</strong></td>
		<td width="30%"><strong>
			<dw:TranslateLabel ID="pubLabel" runat="server" Text="Published" />
			<dw:TranslateLabel ID="draftLabel" runat="server" Text="Kladde" />
			<span runat="server" id="appstate" style="display:none;"></span>
		</strong></td>
		<td width="30%" style="padding:0px;"><strong>
			<div style="float:left;padding:5px;">
			<dw:TranslateLabel ID="compareversionLabel" runat="server" Text="Tidligere versioner" />
			</div>
			<div style="float:right;" class="inlineToolbar">
			<dw:Toolbar ID="Toolbar2" runat="server" ShowEnd="false" ShowStart="false">
				<dw:ToolbarButton ID="ToolbarButton1" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/document_ok.png" Text="Gendan" OnClientClick="restore();">
				</dw:ToolbarButton>
			</dw:Toolbar>
			</div>
		</strong></td>
		<td width="30%" style="padding:0px;"><strong>
			<div style="float:left;padding:5px;">
			<dw:TranslateLabel ID="TranslateLabel8" runat="server" Text="Compare" />
			</div>
			<div style="float:right;" class="inlineToolbar">
			<dw:Toolbar ID="Toolbar3" runat="server" ShowEnd="false" ShowStart="false">
				<dw:ToolbarButton ID="showHtml" runat="server" Divide="None" ImagePath="/Admin/Images/Ribbon/Icons/Small/text_code_colored.png" Text="HTML" OnClientClick="html();">
				</dw:ToolbarButton>
			</dw:Toolbar>
			</div>
			
		</strong></td>
	</tr>
	<tr id="versionRow" runat="server">
		<td class="g"><strong>
			<dw:TranslateLabel ID="TranslateLabel14" runat="server" Text="Version" />
		</strong></td>
		<td id="VersionPub" runat="server"></td>
		<td id="VersionOld" runat="server"></td>
		<td id="Td3" runat="server"></td>
	</tr>
	<tr>
		<td class="g"><strong>
			<dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Afsnitsnavn" />
		</strong></td>
		<td id="HeadingPub" runat="server"></td>
		<td id="HeadingOld" runat="server"></td>
		<td id="HeadingCompare" runat="server"></td>
	</tr>
	<tr>
		<td class="g"><strong>
			<dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Tekst" />
		</strong></td>
		<td id="TextPub" runat="server"></td>
		<td id="TextOld" runat="server"></td>
		<td id="TextCompare" runat="server"></td>
	</tr>
	<tr>
		<td class="g"><strong>
			<dw:TranslateLabel ID="TranslateLabel9" runat="server" Text="Billede" />
		</strong></td>
		<td id="ImagePub" runat="server"></td>
		<td id="ImageOld" runat="server"></td>
		<td id="ImageCompare" runat="server"></td>
	</tr>
	<tr>
		<td class="g"><strong>
			<dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Link" />
		</strong></td>
		<td id="LinkPub" runat="server"></td>
		<td id="LinkOld" runat="server"></td>
		<td id="LinkCompare" runat="server"></td>
	</tr>
	<tr>
		<td class="g"><strong>
			<dw:TranslateLabel ID="TranslateLabel10" Text="Alt-tekst" runat="server" />
		</strong></td>
		<td id="AltPub" runat="server"></td>
		<td id="AltOld" runat="server"></td>
		<td id="AltCompare" runat="server"></td>
	</tr>
	<tr>
		<td class="g"><strong>
			<dw:TranslateLabel ID="TranslateLabel11" Text="Template" runat="server" />
		</strong></td>
		<td id="TemplatePub" runat="server"></td>
		<td id="TemplateOld" runat="server"></td>
		<td id="TemplateCompare" runat="server"></td>
	</tr>
	<tr>
		<td class="g"><strong>
			<dw:TranslateLabel ID="TranslateLabel12" Text="Aktiv fra" runat="server" />
		</strong></td>
		<td id="PubfromPub" runat="server"></td>
		<td id="PubfromOld" runat="server"></td>
		<td id="PubfromCompare" runat="server"></td>
	</tr>
	<tr>
		<td class="g"><strong>
			<dw:TranslateLabel ID="TranslateLabel13" Text="Aktiv til" runat="server" />
		</strong></td>
		<td id="PubtoPub" runat="server"></td>
		<td id="PubtoOld" runat="server"></td>
		<td id="PubtoCompare" runat="server"></td>
	</tr>
	<tr>
		<td class="g"><strong>
			<dw:TranslateLabel ID="TranslateLabel16" Text="Redigeret" runat="server" />
		</strong></td>
		<td id="EditPub" runat="server"></td>
		<td id="EditOld" runat="server"></td>
		<td id="EditCompare" runat="server"></td>
	</tr>
	<tr>
		<td class="g"><strong>
			<dw:TranslateLabel ID="TranslateLabel18" Text="Bruger" runat="server" />
		</strong></td>
		<td id="UserPub" runat="server"></td>
		<td id="UserOld" runat="server"></td>
		<td id="UserCompare" runat="server"></td>
	</tr>
</table>
</div>
</body>
</html>
