<%@ Page CodeBehind="Sitemap_Edit.aspx.vb" Language="vb" ValidateRequest="false" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Sitemap_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<script language="VB" runat="Server">
Dim sql As String
Dim ParagraphID As Integer
Dim ParagraphModuleSettings As String
</script>

<%
'**************************************************************************************************
'	Current version:	2.0.0
'	Created:			27-03-2002
'	Last modfied:		15-06-2002
'
'	Purpose: Sitemap paragraph
'
'	Revision history:
'		2.0 - 15-06-2002 - Nicolai Pedersen
'		All over more or less.
'		1.0 - 27-03-2002 - Nicolai Pedersen
'		First version.
'**************************************************************************************************


If Request("ID") <> "" Then
	ParagraphID = Base.Chknumber(request("ID"))
Elseif Request("ParagraphID") <> "" Then
	ParagraphID = Base.Chknumber(request("ParagraphID"))
Else
	ParagraphID = 0
End If

Dim prop As new Properties

    If Base.ChkString(Request.QueryString("ParagraphModuleSystemName")) = "" Then 'ParagraphID > 0 Then
        prop = Base.GetParagraphModuleSettings(ParagraphID, True)
    Else
        prop.Value("SitemapLevels") = 25
        prop.Value("SitemapStart") = "1"
        prop.Value("SitemapType") = "1"
        prop.Value("SitemapLevels") = 10
        prop.Value("SitemapColumns") = 2
        prop.Value("SitemapIndent") = 15
        prop.Value("SitemapPagedescription") = 0
        prop.Value("SitemapLevel1Image") = ""
        prop.Value("SitemapLevel1Font") = "Verdana, Helvetica, Arial"
        prop.Value("SitemapLevel1FontSize") = "12px"
        prop.Value("SitemapLevel1FontColor") = "#000000"
        prop.Value("SitemapLevel1FontBold") = "1"
        prop.Value("SitemapLevel2Image") = ""
        prop.Value("SitemapLevel2Font") = "Verdana, Helvetica, Arial"
        prop.Value("SitemapLevel2FontSize") = "10px"
        prop.Value("SitemapLevel2FontColor") = "#000000"
        prop.Value("SitemapLevel2FontBold") = "1"
        prop.Value("SitemapLevel3Image") = ""
        prop.Value("SitemapLevel3Font") = "Verdana, Helvetica, Arial"
        prop.Value("SitemapLevel3FontSize") = "10px"
        prop.Value("SitemapLevel3FontColor") = "#000000"
        prop.Value("SitemapLevel4Image") = ""
        prop.Value("SitemapLevel4Font") = "Verdana, Helvetica, Arial"
        prop.Value("SitemapLevel4FontSize") = "10px"
        prop.Value("SitemapLevel4FontColor") = "#000000"
        prop.Value("SitemapLevel5Image") = ""
        prop.Value("SitemapLevel5Font") = "Verdana, Helvetica, Arial"
        prop.Value("SitemapLevel5FontSize") = "10px"
        prop.Value("SitemapLevel5FontColor") = "#000000"
	
        prop.Value("SiteMapTemplate") = "SiteMap.html"
        prop.Value("SiteMapTemplateColumn") = "SiteMapColumn.html"
        prop.Value("SiteMapTemplateListRow") = "SiteMapListRow.html"
        prop.Value("SiteMapTemplateListData") = "SiteMapListData.html"
        prop.Value("SiteMapTemplateTreeItem") = "SiteMapTree.html"
    End If

If prop.Value("SitemapType") = "3" Then
	prop.Value("SitemapType") = "2"
End If

If prop.Value("SiteMapTemplate") = "" Then prop.Value("SiteMapTemplate") = "SiteMap.html"
If prop.Value("SiteMapTemplateColumn") = "" Then prop.Value("SiteMapTemplateColumn") = "SiteMapColumn.html"
If prop.Value("SiteMapTemplateListRow") = "" Then prop.Value("SiteMapTemplateListRow") = "SiteMapListRow.html"
If prop.Value("SiteMapTemplateListData") = "" Then prop.Value("SiteMapTemplateListData") = "SiteMapListData.html"
If prop.Value("SiteMapTemplateTreeItem") = "" Then prop.Value("SiteMapTemplateTreeItem") = "SiteMapTree.html"

%>
<script language="javascript" type="text/javascript">
	/*
	function ColorPicker(exColor, fieldName){
		colorWin = window.open("../stylesheet/colorpicker.aspx?fieldname=" + fieldName+"&formname=paragraph_edit", "", "resizable=no,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=320,height=360");
	}
	
	function ValidateColor(obj, col){
		if ((col.charAt(0)=="#") && (col.charAt(1)<="f") && (col.charAt(2)<="f") && (col.charAt(3)<="f") && (col.charAt(4)<="f") && (col.charAt(5)<="f") && (col.charAt(6)<="f") && (col.length==7)){
			document.all[obj].style.backgroundColor=col;
		}
	}
	*/
	function ShowHideLevels(TypeID){
		if(TypeID == "1"){
		    document.getElementById("levels").style.display = "";
		}
		else{
		    document.getElementById("levels").style.display = "none";
		}
	}
	
	function ShowHideSitemapPageIDRow(val){
		if(val == "2"){
			document.getElementById("SitemapPageIDRow").style.display = "";
			document.getElementById("SitemapAreaIDRow").style.display = "none";
			
		}
		else{
		    document.getElementById("SitemapPageIDRow").style.display = "none";
			document.getElementById("SitemapAreaIDRow").style.display = "";
		}
	}

</script>
<input type="hidden" name="SiteMap_settings" value="SiteMapTemplate, SiteMapTemplateColumn, SiteMapTemplateListRow, SiteMapTemplateListData, SiteMapTemplateTreeItem, SitemapType, SitemapStart, SitemapPageID, SitemapAreaID, SitemapLevels, SitemapColumns, SitemapIndent, SitemapPagedescription, SitemapLevel1Image, SitemapLevel1Font, SitemapLevel1FontSize, SitemapLevel1FontColor, SitemapLevel1FontBold, SitemapLevel2Image, SitemapLevel2Font, SitemapLevel2FontSize, SitemapLevel2FontColor, SitemapLevel2FontBold, SitemapLevel3Image, SitemapLevel3Font, SitemapLevel3FontSize, SitemapLevel3FontColor, SitemapLevel4Image, SitemapLevel4Font, SitemapLevel4FontSize, SitemapLevel4FontColor, SitemapLevel5Image, SitemapLevel5Font, SitemapLevel5FontSize, SitemapLevel5FontColor">

<TR>
	<TD>
		<%=Gui.MakeModuleHeader("sitemap", "Sitemap")%>
	</TD>
</TR>
<tr>
	<td>
		<%=Gui.GroupboxStart(Translate.Translate("Indstillinger"))%>
		<table cellpadding=2 cellspacing=0>
			<tr>
				<td width="170" valign="top"><%=Translate.Translate("Type")%></td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><input type="radio" name="SitemapType" id="SitemapType1" value="1"<%If prop.Value("SitemapType") = "1" Then%> checked<%End If%> onClick="ShowHideLevels(this.value);"></td>
							<td><label for="SitemapType1"><%=Translate.Translate("Træstruktur")%></label></td>
						</tr>
						<tr>
							<td><input type="radio" name="SitemapType" id="SitemapType2" value="2"<%If prop.Value("SitemapType") = "2" Then%> checked<%End If%> onClick="ShowHideLevels(this.value);"></td>
							<td><label for="SitemapType2"><%=Translate.Translate("Alfabetisk")%></label></td>
						</tr>
						<!--tr>
							<td><input type="radio" name="SitemapType" id="SitemapType3" value="3"<%If prop.Value("SitemapType") = "3" Then%> checked<%End If%> onClick="ShowHideLevels(this.value);"></td>
							<td><label for="SitemapType3"><%=Translate.Translate("Alfabetisk søgeords indeks")%></label></td>
						</tr-->
					</table>			
				</td>
			</tr>
			<tr>
				<td width="170" valign="top"><%=Translate.Translate("Vis")%></td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><input type="radio" name="SitemapStart" id="SitemapStart1" value="1"<%If prop.Value("SitemapStart") = "1" Then%> checked<%End If%> onClick="ShowHideSitemapPageIDRow(this.value)"></td>
							<td><label for="SitemapStart1"><%=Translate.Translate("Alle sider")%></label></td>
						</tr>
						<tr>
							<td><input type="radio" name="SitemapStart" id="SitemapStart2" value="2"<%If prop.Value("SitemapStart") = "2" Then%> checked<%End If%> onClick="ShowHideSitemapPageIDRow(this.value)"></td>
							<td><label for="SitemapStart2"><%=Translate.Translate("Kun undersider til denne side")%></label></td>
						</tr>
					</table>			
				</td>
			</tr>
			<%If prop.Value("SitemapStart") = "2" Then%>
				<tr id="SitemapPageIDRow">
			<%Else%>
				<tr id="SitemapPageIDRow" style="display:none;">
			<%End If%>
				<td></td>
				<td>&nbsp;&nbsp;<%=Gui.LinkManager(prop.Value("SitemapPageID"), "SitemapPageID", "")%></td>
			</tr>
			<%If prop.Value("SitemapStart") = "2" Then%>
				<tr id="SitemapAreaIDRow" style="display:none;">
			<%Else%>
				<tr id="SitemapAreaIDRow">
			<%End If%>
				<td><%=Translate.Translate("Sproglag")%></td>
				<td><%=Gui.SelectArea("SitemapAreaID", prop.Value("SitemapAreaID"))%></td>
			</tr>
			<tr>
				<td width="170"><%=Translate.Translate("Antal niveauer")%></td>
				<td><%=Gui.SpacListExt(prop.Value("SitemapLevels"), "SitemapLevels", 1, 10, 1, "")%></td>
			</tr>
			<tr>
				<td width="170"><%=Translate.Translate("Antal kolonner")%></td>
				<td><%=Gui.SpacListExt(prop.Value("SitemapColumns"), "SitemapColumns", 1, 3, 1, "")%></td>
			</tr>
			<tr>
				<td width="170"><%=Translate.Translate("Indrykning")%></td>
				<td><%=Gui.SpacListExt(prop.Value("SitemapIndent"), "SitemapIndent", 0, 25, 1, "")%></td>
			</tr>
		</table>
		<%=Gui.GroupboxEnd%>
		<%=Gui.GroupboxStart(Translate.Translate("Templates"))%>
		<table border="0" cellpadding="2" cellspacing="0">
			<tr>
				<td width="170"><%=Translate.Translate("Sitemap")%></td>
				<td><%=Gui.FileManager(prop.Value("SiteMapTemplate"), "Templates/SiteMap", "SiteMapTemplate")%></td>
			</tr>
			<tr>
				<td width="170"><%=Translate.Translate("Kolonne")%></td>
				<td><%=Gui.FileManager(prop.Value("SiteMapTemplateColumn"), "Templates/SiteMap", "SiteMapTemplateColumn")%></td>
			</tr>
			<tr><td colspan="2">
				<strong><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Træstruktur"))%></strong>
			</td></tr>
			<tr>
				<td width="170"><%=Translate.Translate("Element")%></td>
				<td><%=Gui.FileManager(prop.Value("SiteMapTemplateTreeItem"), "Templates/SiteMap", "SiteMapTemplateTreeItem")%></td>
			</tr>
			<tr><td colspan="2">
				<strong><%=Translate.Translate("Template - %%", "%%", Translate.Translate("Alfabetisk"))%></strong>
			</td></tr>
			<tr>
				<td width="170"><%=Translate.Translate("Gruppe")%></td>
				<td><%=Gui.FileManager(prop.Value("SiteMapTemplateListRow"), "Templates/SiteMap", "SiteMapTemplateListRow")%></td>
			</tr>
			<tr>
				<td width="170"><%=Translate.Translate("Element")%></td>
				<td><%=Gui.FileManager(prop.Value("SiteMapTemplateListData"), "Templates/SiteMap", "SiteMapTemplateListData")%></td>
			</tr>
		</table>
		<%=Gui.GroupboxEnd%>
		<%=Gui.GroupboxStart(Translate.Translate("Niveau %%", "%%", "1"))%>
		<table border="0" cellpadding="2" cellspacing="0">
			<tr>
				<td width="170"><%=Translate.Translate("Punktgrafik")%></td>
				<td><%=Gui.FileManager(prop.Value("SitemapLevel1Image"), "Navigation", "SitemapLevel1Image")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Font")%></td>
				<td><%=Gui.FontFamilyList(prop.Value("SitemapLevel1Font"), "SitemapLevel1Font")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Fontstørrelse")%></td>
				<td><%=Gui.FontSizeList(prop.Value("SitemapLevel1FontSize"), "SitemapLevel1FontSize")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Fontfarve")%></td>
				<td><%=Gui.ColorSelect(prop.Value("SitemapLevel1FontColor"), "SitemapLevel1FontColor", False)%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Fed")%></td>
				<td><%=Gui.CheckBox(prop.Value("SitemapLevel1FontBold"), "SitemapLevel1FontBold")%>
			</tr>
		</table>
		<%=Gui.GroupboxEnd%>
		<%=Gui.GroupboxStart(Translate.Translate("Niveau %%", "%%", "2"))%>
		<table border="0" cellpadding="2" cellspacing="0">
			<tr>
				<td width="170"><%=Translate.Translate("Punktgrafik")%></td>
				<td><%=Gui.FileManager(prop.Value("SitemapLevel2Image"), "Navigation", "SitemapLevel2Image")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Font")%></td>
				<td><%=Gui.FontFamilyList(prop.Value("SitemapLevel2Font"), "SitemapLevel2Font")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Fontstørrelse")%></td>
				<td><%=Gui.FontSizeList(prop.Value("SitemapLevel2FontSize"), "SitemapLevel2FontSize")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Fontfarve")%></td>
				<td><%=Gui.ColorSelect(prop.Value("SitemapLevel2FontColor"), "SitemapLevel2FontColor", True)%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Fed")%></td>
				<td><%=Gui.CheckBox(prop.Value("SitemapLevel2FontBold"), "SitemapLevel2FontBold")%></td>
			</tr>
		</table>
		<%=Gui.GroupboxEnd%>
		<%If prop.Value("SitemapType") = "1" Then%>
		<span id="levels">
		<%Else%>
		<span id="levels" style="display:none">
		<%End If%>
		<%=Gui.GroupboxStart(Translate.Translate("Niveau %%", "%%", "3"))%>
		<table border="0" cellpadding="2" cellspacing="0">
			<tr>
				<td width="170"><%=Translate.Translate("Punktgrafik")%></td>
				<td><%=Gui.FileManager(prop.Value("SitemapLevel3Image"), "Navigation", "SitemapLevel3Image")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Font")%></td>
				<td><%=Gui.FontFamilyList(prop.Value("SitemapLevel3Font"), "SitemapLevel3Font")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Fontstørrelse")%></td>
				<td><%=Gui.FontSizeList(prop.Value("SitemapLevel3FontSize"), "SitemapLevel3FontSize")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Fontfarve")%></td>
				<td><%=Gui.ColorSelect(prop.Value("SitemapLevel3FontColor"), "SitemapLevel3FontColor", True)%></td>
			</tr>
		</table>
		<%=Gui.GroupboxEnd%>
		<%=Gui.GroupboxStart(Translate.Translate("Niveau %%", "%%", "4"))%>
		<table border="0" cellpadding="2" cellspacing="0">
			<tr>
				<td width="170"><%=Translate.Translate("Punktgrafik")%></td>
				<td><%=Gui.FileManager(prop.Value("SitemapLevel4Image"), "Navigation", "SitemapLevel4Image")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Font")%></td>
				<td><%=Gui.FontFamilyList(prop.Value("SitemapLevel4Font"), "SitemapLevel4Font")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Fontstørrelse")%></td>
				<td><%=Gui.FontSizeList(prop.Value("SitemapLevel4FontSize"), "SitemapLevel4FontSize")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Fontfarve")%></td>
				<td><%=Gui.ColorSelect(prop.Value("SitemapLevel4FontColor"), "SitemapLevel4FontColor", True)%></td>
			</tr>
		</table>
		<%=Gui.GroupboxEnd%>
		<%=Gui.GroupboxStart(Translate.Translate("Niveau %%", "%%", "5"))%>
		<table border="0" cellpadding="2" cellspacing="0">
			<tr>
				<td width="170"><%=Translate.Translate("Punktgrafik")%></td>
				<td><%=Gui.FileManager(prop.Value("SitemapLevel5Image"), "Navigation", "SitemapLevel5Image")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Font")%></td>
				<td><%=Gui.FontFamilyList(prop.Value("SitemapLevel5Font"), "SitemapLevel5Font")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Fontstørrelse")%></td>
				<td><%=Gui.FontSizeList(prop.Value("SitemapLevel5FontSize"), "SitemapLevel5FontSize")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Fontfarve")%></td>
				<td><%=Gui.ColorSelect(prop.Value("SitemapLevel5FontColor"), "SitemapLevel5FontColor", True)%></td>
			</tr>
		</table>
		<%=Gui.GroupboxEnd%>
		</span>
 	</td>
</tr>

<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>