<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EditDesign.aspx.vb" Inherits="Dynamicweb.Admin.EditDesign" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<dw:ControlResources ID="ctrlResources" runat="server" IncludeUIStylesheet="true" IncludePrototype="false" />
	<title>Edit design</title>

	<script type="text/javascript" src="editdesign.js"></script>
    <script>
        function changeColor(textbox) {
            document.getElementById(textbox.id + 'Preview').style.background = textbox.value;
            apply(true);
        }
    </script>

	<link rel="Stylesheet" href="EditDesign.css" />
</head>
<body onclick="apply(false);" runat="server" id="theBody">
	<form id="LayoutForm" runat="server" method="post" target="saveframe">
		<asp:HiddenField ID="LogoFolder" runat="server" Value="/Files/Templates/Design" />
		<dw:RibbonBar runat="server" ID="myribbon">
			<dw:RibbonBarTab ID="RibbonBarTab1" runat="server" Name="Layout">
				<dw:RibbonBarGroup ID="RibbonBarGroup1" runat="server" Name="Tools">
					<dw:RibbonBarButton runat="server" ID="apply" Size="Small" Image="Save" Text="Anvend" OnClientClick="apply(true);" />
					<dw:RibbonBarButton runat="server" ID="close" Size="Small" Image="Cancel" Text="Close" OnClientClick="close();" />
					<dw:RibbonBarButton runat="server" ID="RibbonBarButton7" Size="Small" Image="MagicWand" Text="Colors" OnClientClick="document.getElementById('previewFrame').src='ColorGen.aspx?hex=' + document.getElementById('basicColor').value.replace('#', '') + '&dt=' + new Date().getTime();" />
				</dw:RibbonBarGroup>
				<dw:RibbonBarGroup ID="RibbonbarGroup10" runat="server" Name="Layout">
					<dw:RibbonBarPanel ID="RibbonbarPanel1" runat="server">
						<dw:Richselect ID="AreaLayout" runat="server" Height="45" Itemheight="45" Itemwidth="300">
						</dw:Richselect>
					</dw:RibbonBarPanel>
				</dw:RibbonBarGroup>
				<dw:RibbonBarGroup ID="RibbonBarGroup4" runat="server" Name="Indstillinger">
					<dw:RibbonBarPanel ID="RibbonbarPanel13" runat="server">
						Basisfarve<dw:ColorSelect runat="server" ID="basicColor" First="true" Value="#003366" />
					</dw:RibbonBarPanel>
				</dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonBarGroup13" runat="server" Name="Farvesæt">
					<dw:RibbonBarPanel ID="RibbonbarPanel3" runat="server">
						<div class="richselectDiv">
							<dw:Richselect ID="ColorSets" runat="server" Height="30" Itemheight="30">
							</dw:Richselect>
						</div>
					</dw:RibbonBarPanel>
				</dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonBarGroup15" runat="server" Name="Farver i farvesæt">
					<dw:RibbonBarPanel ID="RibbonbarPanel15" runat="server"><br />
                    <label for="CustomColor1" style="width:82px;float:left;padding-top:5px;">Primær farve </label><dw:ColorSelect runat="server" ID="CustomColor1" First="false" Value="#003366" /><br /><br />
                    <label for="CustomColor2" style="width:82px;float:left;padding-top:5px;">Baggrundsfarve </label><dw:ColorSelect runat="server" ID="CustomColor2" First="false" Value="#003366" />
                    
					</dw:RibbonBarPanel>
                    <dw:RibbonBarPanel ID="RibbonbarPanel17" runat="server"><br />
                    <label for="CustomColor3" style="width:102px;float:left;padding-top:5px;">Sekundær baggrund </label><dw:ColorSelect runat="server" ID="CustomColor3" First="false" Value="#003366" /><br /><br />
                    <label for="CustomColor4" style="width:102px;float:left;padding-top:5px;">Call to action </label><dw:ColorSelect runat="server" ID="CustomColor4" First="false" Value="#003366" />
                       
					</dw:RibbonBarPanel>
				</dw:RibbonBarGroup>
			</dw:RibbonBarTab>
			<dw:RibbonBarTab ID="RibbonbarTab3" Name="Logo" runat="server">
				<dw:RibbonBarGroup ID="RibbonBarGroup7" runat="server" Name="Tools">
					<dw:RibbonBarButton runat="server" ID="RibbonBarButton1" Size="Small" Image="Save" Text="Anvend" OnClientClick="apply(true);" />
					<dw:RibbonBarButton runat="server" ID="RibbonBarButton2" Size="Small" Image="Cancel" Text="Close" OnClientClick="close();" />
					<dw:RibbonBarButton runat="server" ID="logoColorPick" Size="Small" Image="MagicWand" Text="Vælg farve fra logo" OnClientClick="document.getElementById('previewFrame').src='ColorPick.aspx?file=' + document.getElementById('logo_path').value + '&dt=' + new Date().getTime();" />
				</dw:RibbonBarGroup>
				<dw:RibbonBarGroup ID="RibbonBarGroup12" runat="server" Name="Indstillinger">
					<dw:RibbonBarPanel ID="RibbonbarPanel2" runat="server">
						Logo
						<dw:FileManager ID="logo" runat="server" Folder="System" FullPath="true" Extensions="jpg,jpeg,gif,png,bmp" OnChange="apply(false);" />
						<br />
						Linie 1
						<input type="text" runat="server" name="LogoTextPrimary" id="LogoTextPrimary" style="height: 12px;" /><br />
						Linie 2
						<input type="text" runat="server" name="LogoTextSecondary" id="LogoTextSecondary" style="height: 12px;" />
					</dw:RibbonBarPanel>
				</dw:RibbonBarGroup>
				<dw:RibbonBarGroup ID="RibbonbarGroup19" runat="server" Name="Primær farver">
					<dw:RibbonBarPanel ID="RibbonbarPanel4" runat="server">
						<div class="richselectDiv">
							Baggrundsfarve
							<dw:Richselect ID="LogoBackgroundColor" runat="server" Height="26" Itemheight="30" Itemwidth="350" Width="80">
							</dw:Richselect>
						</div>
					</dw:RibbonBarPanel>

				</dw:RibbonBarGroup>
				<dw:RibbonBarGroup ID="RibbonBarGroup17" runat="server" Name="Primær font">
					<dw:RibbonBarPanel ID="RibbonbarPanel12" runat="server">
						<div class="richselectDiv">
							<dw:Richselect ID="LogoPrimaryFont" runat="server" Height="15" Itemheight="30">
							</dw:Richselect>
						</div>
						<div class="richselectDiv">
							<dw:Richselect ID="LogoPrimaryFontSize" runat="server" Height="15" Itemheight="30">
							</dw:Richselect>
						</div>
						<div class="richselectDiv">
							<dw:Richselect ID="LogoPrimaryColor" runat="server" Height="15" Itemheight="15" Itemwidth="340">
							</dw:Richselect>
						</div>
						<div style="clear: both;">
							<input type="checkbox" value="bold" name="LogoPrimaryFontWeight" id="LogoPrimaryFontWeight" runat="server" /><label for="LogoPrimaryFontWeight">Fed</label>
							<input type="checkbox" value="bold" name="LogoPrimaryFontItalic" id="LogoPrimaryFontItalic" runat="server" /><label for="LogoPrimaryFontItalic">Kursiv</label>
						</div>
					</dw:RibbonBarPanel>
				</dw:RibbonBarGroup>
				<dw:RibbonBarGroup ID="RibbonBarGroup1720" runat="server" Name="Sekundær font">
					<dw:RibbonBarPanel ID="RibbonbarPanel120" runat="server">
						<div class="richselectDiv">
							<dw:Richselect ID="LogoSecondaryFont" runat="server" Height="15" Itemheight="30">
							</dw:Richselect>
						</div>
						<div class="richselectDiv">
							<dw:Richselect ID="LogoSecondaryFontSize" runat="server" Height="15" Itemheight="30">
							</dw:Richselect>
						</div>
						<div class="richselectDiv">
							<dw:Richselect ID="LogoSecondaryColor" runat="server" Height="15" Itemheight="15" Itemwidth="340">
							</dw:Richselect>
						</div>
						<div style="clear: both;">
							<input type="checkbox" value="bold" name="LogoSecondaryFontWeight" id="LogoSecondaryFontWeight" runat="server" /><label for="LogoSecondaryFontWeight">Fed</label>
							<input type="checkbox" value="bold" name="LogoSecondaryFontItalic" id="LogoSecondaryFontItalic" runat="server" /><label for="LogoSecondaryFontItalic">Kursiv</label>
						</div>
					</dw:RibbonBarPanel>
				</dw:RibbonBarGroup>
			</dw:RibbonBarTab>
			<dw:RibbonBarTab ID="grpLayout" Name="Navigation" runat="server">
				<dw:RibbonBarGroup ID="RibbonBarGroup8" runat="server" Name="Tools">
					<dw:RibbonBarButton runat="server" ID="RibbonBarButton3" Size="Small" Image="Save" Text="Anvend" OnClientClick="apply(true);" />
					<dw:RibbonBarButton runat="server" ID="RibbonBarButton4" Size="Small" Image="Cancel" Text="Close" OnClientClick="close();" />
				</dw:RibbonBarGroup>
				<dw:RibbonBarGroup ID="RibbonBarGroup2" runat="server" Name="Basisfarve">
					<dw:RibbonBarPanel ID="RibbonbarPanel5" runat="server">
						<div class="richselectDiv">
							<dw:Richselect ID="NavigationBackgroundColor" runat="server" Height="15" Itemheight="15" Itemwidth="340">
							</dw:Richselect>
						</div>
					</dw:RibbonBarPanel>
				</dw:RibbonBarGroup>
				<dw:RibbonBarGroup ID="RibbonBarGroup14" runat="server" Name="Font">
					<dw:RibbonBarPanel ID="RibbonbarPanel6" runat="server">
						<div class="richselectDiv">
							<dw:Richselect ID="NavigationFont" runat="server" Height="15" Itemheight="30">
							</dw:Richselect>
						</div>
						<div class="richselectDiv">
							<dw:Richselect ID="NavigationFontSize" runat="server" Height="15" Itemheight="30">
							</dw:Richselect>
						</div>
						<div class="richselectDiv">
							<dw:Richselect ID="NavigationFontColor" runat="server" Height="15" Itemheight="15" Itemwidth="340">
							</dw:Richselect>
						</div>
					</dw:RibbonBarPanel>
				</dw:RibbonBarGroup>
				<dw:RibbonBarGroup ID="RibbonBarGroup26" runat="server" Name="Sitemap">
					<dw:RibbonBarPanel ID="RibbonbarPanel85" runat="server">
						<div class="richselectDiv">
							<dw:Richselect ID="SitemapFont" runat="server" Height="15" Itemheight="30">
							</dw:Richselect>
						</div>
						<div class="richselectDiv">
							<dw:Richselect ID="SitemapBackgroundColor" runat="server" Height="15" Itemheight="15" Itemwidth="340">
							</dw:Richselect>
						</div>
					</dw:RibbonBarPanel>
				</dw:RibbonBarGroup>
			</dw:RibbonBarTab>
			<dw:RibbonBarTab ID="RibbonbarTab2" Name="Tekster" runat="server">
				<dw:RibbonBarGroup ID="RibbonBarGroup9" runat="server" Name="Tools">
					<dw:RibbonBarButton runat="server" ID="RibbonBarButton5" Size="Small" Image="Save" Text="Anvend" OnClientClick="apply(true);" />
					<dw:RibbonBarButton runat="server" ID="RibbonBarButton6" Size="Small" Image="Cancel" Text="Close" OnClientClick="close();" />
				</dw:RibbonBarGroup>
				<dw:RibbonBarGroup ID="RibbonBarGroup3" runat="server" Name="Overskrift">
					<dw:RibbonBarPanel ID="RibbonbarPanel8" runat="server">
						<div class="richselectDiv">
							<dw:Richselect ID="H1Font" runat="server" Height="15" Itemheight="30">
							</dw:Richselect>
						</div>
						<div class="richselectDiv">
							<dw:Richselect ID="H1FontSize" runat="server" Height="15" Itemheight="30">
							</dw:Richselect>
						</div>
						<div class="richselectDiv">
							<dw:Richselect ID="H1FontColor" runat="server" Height="15" Itemheight="15" Itemwidth="340">
							</dw:Richselect>
						</div>
						<div style="clear: both;">
							<input type="checkbox" value="bold" name="H1FontWeight" id="H1FontWeight" runat="server" /><label for="H1FontWeight">Fed</label>
						</div>
					</dw:RibbonBarPanel>
				</dw:RibbonBarGroup>
				<dw:RibbonBarGroup ID="RibbonBarGroup5" runat="server" Name="Underoverskrift">
					<dw:RibbonBarPanel ID="RibbonbarPanel09" runat="server">
						<div class="richselectDiv">
							<dw:Richselect ID="H2Font" runat="server" Height="15" Itemheight="30">
							</dw:Richselect>
						</div>
						<div class="richselectDiv">
							<dw:Richselect ID="H2FontSize" runat="server" Height="15" Itemheight="30">
							</dw:Richselect>
						</div>
						<div class="richselectDiv">
							<dw:Richselect ID="H2FontColor" runat="server" Height="15" Itemheight="15" Itemwidth="340">
							</dw:Richselect>
						</div>
						<div style="clear: both;">
							<input type="checkbox" value="bold" name="H2FontWeight" id="H2FontWeight" runat="server" /><label for="H2FontWeight">Fed</label>
						</div>
					</dw:RibbonBarPanel>
				</dw:RibbonBarGroup>
				<dw:RibbonBarGroup ID="RibbonBarGroup11" runat="server" Name="Overskrift 3">
					<dw:RibbonBarPanel ID="RibbonbarPanel10" runat="server">
						<div class="richselectDiv">
							<dw:Richselect ID="H3Font" runat="server" Height="15" Itemheight="30">
							</dw:Richselect>
						</div>
						<div class="richselectDiv">
							<dw:Richselect ID="H3FontSize" runat="server" Height="15" Itemheight="30">
							</dw:Richselect>
						</div>
						<div class="richselectDiv">
							<dw:Richselect ID="H3FontColor" runat="server" Height="15" Itemheight="15" Itemwidth="340">
							</dw:Richselect>
						</div>
						<div style="clear: both;">
							<input type="checkbox" value="bold" name="H3FontWeight" id="H3FontWeight" runat="server" /><label for="H3FontWeight">Fed</label>
						</div>
					</dw:RibbonBarPanel>
				</dw:RibbonBarGroup>
				<dw:RibbonBarGroup ID="RibbonBarGroup6" runat="server" Name="Tekst">
					<dw:RibbonBarPanel ID="RibbonbarPanel7" runat="server">
						<div class="richselectDiv">
							<dw:Richselect ID="TextFont" runat="server" Height="15" Itemheight="30">
							</dw:Richselect>
						</div>
						<div class="richselectDiv">
							<dw:Richselect ID="TextFontSize" runat="server" Height="15" Itemheight="30">
							</dw:Richselect>
						</div>
						<div class="richselectDiv">
							<dw:Richselect ID="TextFontColor" runat="server" Height="15" Itemheight="15" Itemwidth="340">
							</dw:Richselect>
						</div>
						<div style="clear: both;">
							<input type="checkbox" value="bold" name="TextFontWeight" id="TextFontWeight" runat="server" /><label for="TextFontWeight">Fed</label>
						</div>
					</dw:RibbonBarPanel>
				</dw:RibbonBarGroup>
			</dw:RibbonBarTab>
			<dw:RibbonBarTab ID="RibbonbarTab5" Name="Baggrund" runat="server">
				<dw:RibbonBarGroup ID="RibbonBarGroup20" runat="server" Name="Tools">
					<dw:RibbonBarButton runat="server" ID="RibbonBarButton10" Size="Small" Image="Save" Text="Anvend" OnClientClick="apply(true);" />
					<dw:RibbonBarButton runat="server" ID="RibbonBarButton11" Size="Small" Image="Cancel" Text="Close" OnClientClick="close();" />
				</dw:RibbonBarGroup>
				<dw:RibbonBarGroup ID="RibbonBarGroup23" runat="server" Name="Baggrund">
					<dw:RibbonBarPanel ID="RibbonbarPanel16" runat="server">
						Baggrundsbillede <dw:FileManager ID="BackgroundImage" runat="server" Folder="templates/designs/settings/images" FullPath="true" Extensions="jpg,jpeg,gif,png,bmp" OnChange="apply(false);" />
                        <!--div style="clear: both;">
							<input type="checkbox" value="bold" name="TextFontWeight" id="Checkbox1" runat="server" /><label for="TextFontWeight">Gentag horisontalt</label>
						</div>
                        <div style="clear: both;">
							<input type="checkbox" value="bold" name="TextFontWeight" id="Checkbox2" runat="server" /><label for="TextFontWeight">Gentag vertikalt</label>
						</div-->
					</dw:RibbonBarPanel>
				</dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonBarGroup21" runat="server" Name="Midterbaggrund">
					<dw:RibbonBarPanel ID="RibbonbarPanel14" runat="server">
                    <label for="WrapperBackground" style="width:102px;float:left;padding-top:5px;">Midterbaggrund </label><asp:TextBox runat="server" ID="WrapperBackground" onkeyup="changeColor(this);" style="width:66px;text-transform:uppercase;float:left;" MaxLength="7" /><div id="WrapperBackgroundPreview" style="POSITION:relative; top: 2px; LEFT:2px; HEIGHT:20px; width:17px; padding-left:17px; cursor: pointer; BORDER:#666666 1px solid; display:inline;float:left;" runat="server">&nbsp;&nbsp;&nbsp;</div>
					</dw:RibbonBarPanel>
				</dw:RibbonBarGroup>
			</dw:RibbonBarTab>
			<dw:RibbonBarTab ID="RibbonbarTab4" Name="Form / call to action" runat="server">
				<dw:RibbonBarGroup ID="RibbonBarGroup16" runat="server" Name="Tools">
					<dw:RibbonBarButton runat="server" ID="RibbonBarButton8" Size="Small" Image="Save" Text="Anvend" OnClientClick="apply(true);" />
					<dw:RibbonBarButton runat="server" ID="RibbonBarButton9" Size="Small" Image="Cancel" Text="Close" OnClientClick="close();" />
				</dw:RibbonBarGroup>
				<dw:RibbonBarGroup ID="RibbonBarGroup18" runat="server" Name="Form">
					<dw:RibbonBarPanel ID="RibbonbarPanel11" runat="server">
						<div class="richselectDiv">
							Baggrundsfarve
							<dw:Richselect ID="FormBackgroundColor" runat="server" Height="15" Itemheight="15" Itemwidth="340">
							</dw:Richselect>
						</div>
					</dw:RibbonBarPanel>
				</dw:RibbonBarGroup>
				<dw:RibbonBarGroup ID="RibbonBarGroup22" runat="server" Name="Call to action">
					<dw:RibbonBarPanel ID="RibbonbarPanel111" runat="server">
						<div class="richselectDiv">
							<dw:Richselect ID="CallToActionColor" runat="server" Height="15" Itemheight="15" Itemwidth="340">
							</dw:Richselect>
						</div>
					</dw:RibbonBarPanel>
				</dw:RibbonBarGroup>
			</dw:RibbonBarTab>
		</dw:RibbonBar>
	</form>
	<div id="preview">
		<iframe name="previewFrame" id="previewFrame" src="/Default.aspx?dt=12" frameborder="0"></iframe>
	</div>
	<iframe name="saveframe" id="saveframe" src="" frameborder="0" scrolling="no"></iframe>
</body>
</html>
