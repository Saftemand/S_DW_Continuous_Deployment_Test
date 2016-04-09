<%@ Page Language="vb" ValidateRequest="false" AutoEventWireup="false" Codebehind="SitemapV2_edit.aspx.vb" Inherits="Dynamicweb.Admin.SitemapV2.SitemapV2_edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<input type="hidden" name="SitemapV2_settings" value="Menu, AreaID, PageSelected, FirstLevel, LastLevel, IncludeAllPages, Template, UseOwnStyles, <%=StyleSettings()%>">
<table width="100%" id="Table1" border="0">
	<tr>
		<td>
			<dw:moduleheader id="ModuleHeader1" runat="server" modulesystemname="SitemapV2"></dw:moduleheader>
		</td>
	</tr>
	<tr>
		<td>
			<dw:groupbox id="gb_General" runat="server" title="Generelt">
			<table cellpadding="2" cellspacing="0" border="0" id="Table3">
				<tr>
					<td valign="top" width="170px"><dw:translatelabel id="Translatelabel2" runat="server" text="Fra"></dw:translatelabel></td>
					<td>
						<label for="MenuCurrentArea"><input type="radio" onclick="EnableCurrentArea();" runat="server" value="CurrentArea" id="MenuCurrentArea" name="Menu"><dw:translatelabel id="Translatelabel35" runat="server" text="Aktuelle sproglag"></dw:translatelabel></label><br>
						<label for="MenuArea"><input type="radio" onclick="EnableArea();" runat="server" value="Area" id="MenuArea" name="Menu"><dw:translatelabel id="Translatelabel3" runat="server" text="sproglag"></dw:translatelabel></label><br>
						<label for="MenuPage"><input type="radio" onclick="EnablePage();" runat="server" value="Page" id="MenuPage" name="Menu"><dw:translatelabel id="Translatelabel4" runat="server" text="side"></dw:translatelabel></label>
					</td>
				</tr>
				<tr id="TrArea">
					<td><dw:translatelabel id="Translatelabel5" runat="server" text="Sproglag"></dw:translatelabel></td>
					<td><select id="AreaID" runat="server" name="AreaID" class="std"></select></td>
				</tr>
				<tr id="TrPage">
					<td><dw:translatelabel id="Translatelabel6" runat="server" text="Underpunkter til side"></dw:translatelabel></td>
					<td><dw:linkmanager id="PageSelected" name="PageSelected" runat="server" disablefilearchive disableparagraphselector/></td>
				</tr>
				<tr>
					<td><dw:translatelabel id="Translatelabel7" runat="server" text="Første niveau"></dw:translatelabel></td>
					<td><select id="FirstLevel" runat="server" name="FirstLevel" class="std" style="width: 100px;"></select></td>
				</tr>
				<tr>
					<td><dw:translatelabel id="Translatelabel8" runat="server" text="Sidste niveau"></dw:translatelabel></td>
					<td><select id="LastLevel" runat="server" name="LastLevel" class="std" style="width: 100px;"></select></td>
				</tr>
				<tr>
					<td><dw:translatelabel id="Translatelabel36" runat="server" text="Include"></dw:translatelabel></td>
					<td><input type="checkbox" name="IncludeAllPages" id="IncludeAllPages" runat="server" value="True"><label for="IncludeAllPages"><dw:translatelabel id="Translatelabel37" runat="server" text="Alle sider"></dw:translatelabel></label></td>
				</tr>
				<tr>
					<td><dw:translatelabel id="Translatelabel9" runat="server" text="Template"></dw:translatelabel></td>
                    <td><asp:literal runat="server" id="litTemplate"></asp:literal></td>
				</tr>
				<tr>
					<td><dw:translatelabel id="Translatelabel10" runat="server" text="Alternativ_stylesheet"></dw:translatelabel></td>
					<td><input type="checkbox" onclick="SetDivOwnStyles();" name="UseOwnStyles" id="UseOwnStyles" runat="server" value="True"></td>
				</tr>
			</table>
			</dw:groupbox>
			<div id="DivOwnStyles">
				<dw:groupbox id="gb_Style1" runat="server" title="Niveau 1">
					<table cellpadding="2" cellspacing="0" border="0" id="Table3">
						<tr>
							<td width="170px"><dw:translatelabel id="Translatelabel16" runat="server" text="Punktgrafik"></dw:translatelabel></td>
							<td><dw:FileArchive runat="server" name="Graphics1" id="Graphics1" DefaultFolder="" BrowseMode="browseTemplate" cssClass="std"></dw:FileArchive></td>
						</tr>
						<tr>
							<td><dw:translatelabel id="Translatelabel14" runat="server" text="Font"></dw:translatelabel></td>
							<td><select id="Font1" runat="server" name="Font1" class="std"></select></td>
						</tr>
						<tr>
							<td><dw:translatelabel id="Translatelabel17" runat="server" text="Fontstørrelse"></dw:translatelabel></td>
							<td><select id="FontSize1" runat="server" name="FontSize1" class="std" style="width: 100px;"></select></td>
						</tr>
						<tr>
							<td><dw:translatelabel id="Translatelabel18" runat="server" text="Fontfarve"></dw:translatelabel></td>
							<td><dw:ColorSelect runat="server" id="FontColor1" name="FontColor1"></dw:ColorSelect></td>
						</tr>
						<tr>
							<td><dw:translatelabel id="Translatelabel1" runat="server" text="Fed"></dw:translatelabel></td>
							<td><input type="checkbox" name="IsBold1" id="IsBold1" value="True" runat="server"></td>
						</tr>
					</table>
				</dw:groupbox>
				<dw:groupbox id="gb_Style2" runat="server" title="Niveau 2">
					<table cellpadding="2" cellspacing="0" border="0" id="Table4">
						<tr>
							<td width="170px"><dw:translatelabel id="Translatelabel11" runat="server" text="Punktgrafik"></dw:translatelabel></td>
							<td><dw:FileArchive runat="server" name="Graphics2" id="Graphics2" DefaultFolder="" BrowseMode="browseTemplate" cssClass="std"></dw:FileArchive></td>
						</tr>
						<tr>
							<td><dw:translatelabel id="Translatelabel12" runat="server" text="Font"></dw:translatelabel></td>
							<td><select id="Font2" runat="server" name="Font2" class="std"></select></td>
						</tr>
						<tr>
							<td><dw:translatelabel id="Translatelabel13" runat="server" text="Fontstørrelse"></dw:translatelabel></td>
							<td><select id="FontSize2" runat="server" name="FontSize2" class="std" style="width: 100px;"></select></td>
						</tr>
						<tr>
							<td><dw:translatelabel id="Translatelabel15" runat="server" text="Fontfarve"></dw:translatelabel></td>
							<td><dw:ColorSelect runat="server" id="FontColor2" name="FontColor2" first="false"></dw:ColorSelect></td>
						</tr>
						<tr>
							<td><dw:translatelabel id="Translatelabel19" runat="server" text="Fed"></dw:translatelabel></td>
							<td><input type="checkbox" name="IsBold2" id="IsBold2" value="True" runat="server"></td>
						</tr>
					</table>
				</dw:groupbox>
				<dw:groupbox id="gb_Style3" runat="server" title="Niveau 3">
					<table cellpadding="2" cellspacing="0" border="0" id="Table4">
						<tr>
							<td width="170px"><dw:translatelabel id="Translatelabel20" runat="server" text="Punktgrafik"></dw:translatelabel></td>
							<td><dw:FileArchive runat="server" name="Graphics3" id="Graphics3" DefaultFolder="" BrowseMode="browseTemplate" cssClass="std"></dw:FileArchive></td>
						</tr>
						<tr>
							<td><dw:translatelabel id="Translatelabel21" runat="server" text="Font"></dw:translatelabel></td>
							<td><select id="Font3" runat="server" name="Font3" class="std"></select></td>
						</tr>
						<tr>
							<td><dw:translatelabel id="Translatelabel22" runat="server" text="Fontstørrelse"></dw:translatelabel></td>
							<td><select id="FontSize3" runat="server" name="FontSize3" class="std" style="width: 100px;"></select></td>
						</tr>
						<tr>
							<td><dw:translatelabel id="Translatelabel23" runat="server" text="Fontfarve"></dw:translatelabel></td>
							<td><dw:ColorSelect runat="server" id="FontColor3" name="FontColor3" first="false"></dw:ColorSelect></td>
						</tr>
						<tr>
							<td><dw:translatelabel id="Translatelabel24" runat="server" text="Fed"></dw:translatelabel></td>
							<td><input type="checkbox" name="IsBold3" id="IsBold3" value="True" runat="server"></td>
						</tr>
					</table>
				</dw:groupbox>
				<dw:groupbox id="gb_Style4" runat="server" title="Niveau 4">
					<table cellpadding="2" cellspacing="0" border="0" id="Table4">
						<tr>
							<td width="170px"><dw:translatelabel id="Translatelabel25" runat="server" text="Punktgrafik"></dw:translatelabel></td>
							<td><dw:FileArchive runat="server" name="Graphics4" id="Graphics4" DefaultFolder="" BrowseMode="browseTemplate" cssClass="std"></dw:FileArchive></td>
						</tr>
						<tr>
							<td><dw:translatelabel id="Translatelabel26" runat="server" text="Font"></dw:translatelabel></td>
							<td><select id="Font4" runat="server" name="Font4" class="std"></select></td>
						</tr>
						<tr>
							<td><dw:translatelabel id="Translatelabel27" runat="server" text="Fontstørrelse"></dw:translatelabel></td>
							<td><select id="FontSize4" runat="server" name="FontSize4" class="std" style="width: 100px;"></select></td>
						</tr>
						<tr>
							<td><dw:translatelabel id="Translatelabel28" runat="server" text="Fontfarve"></dw:translatelabel></td>
							<td><dw:ColorSelect runat="server" id="FontColor4" name="FontColor4" first="false"></dw:ColorSelect></td>
						</tr>
						<tr>
							<td><dw:translatelabel id="Translatelabel29" runat="server" text="Fed"></dw:translatelabel></td>
							<td><input type="checkbox" name="IsBold4" id="IsBold4" value="True" runat="server"></td>
						</tr>
					</table>
				</dw:groupbox>
				<dw:groupbox id="gb_Style5" runat="server" title="Niveau 5">
					<table cellpadding="2" cellspacing="0" border="0" id="Table4">
						<tr>
							<td width="170px"><dw:translatelabel id="Translatelabel30" runat="server" text="Punktgrafik"></dw:translatelabel></td>
							<td><dw:FileArchive runat="server" name="Graphics5" id="Graphics5" DefaultFolder="" BrowseMode="browseTemplate" cssClass="std"></dw:FileArchive></td>
						</tr>
						<tr>
							<td><dw:translatelabel id="Translatelabel31" runat="server" text="Font"></dw:translatelabel></td>
							<td><select id="Font5" runat="server" name="Font5" class="std"></select></td>
						</tr>
						<tr>
							<td><dw:translatelabel id="Translatelabel32" runat="server" text="Fontstørrelse"></dw:translatelabel></td>
							<td><select id="FontSize5" runat="server" name="FontSize5" class="std" style="width: 100px;"></select></td>
						</tr>
						<tr>
							<td><dw:translatelabel id="Translatelabel33" runat="server" text="Fontfarve"></dw:translatelabel></td>
							<td><dw:ColorSelect runat="server" id="FontColor5" name="FontColor5" first="false"></dw:ColorSelect></td>
						</tr>
						<tr>
							<td><dw:translatelabel id="Translatelabel34" runat="server" text="Fed"></dw:translatelabel></td>
							<td><input type="checkbox" name="IsBold5" id="IsBold5" value="True" runat="server"></td>
						</tr>
					</table>
				</dw:groupbox>
			</div>
		</td>
	</tr>
</table>
<script language="javascript">
	if(document.getElementById('MenuArea').checked){
		EnableArea();
	}
	else if (document.getElementById('MenuCurrentArea').checked) {
		EnableCurrentArea();
	}
	else{
		EnablePage();
	}
	SetDivOwnStyles();
	function SetDivOwnStyles(){
		if(document.getElementById('UseOwnStyles').checked){
			EnableById('DivOwnStyles');
		}
		else{
			DisableById('DivOwnStyles');
		}
	}
	function EnablePage(){
		DisableById('TrArea');
		EnableById('TrPage');
	}
	function EnableArea(){
		DisableById('TrPage');
		EnableById('TrArea');
	}
	function EnableCurrentArea() {
		DisableById('TrPage');
		DisableById('TrArea');
	}
	function DisableById(id){
		document.getElementById(id).style.display='none';
	}
	function EnableById(id){
		document.getElementById(id).style.display='';
	}
</script>