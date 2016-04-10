<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Edit.aspx.vb" Inherits="Dynamicweb.Admin.Edit1" EnableViewState="False" EnableEventValidation="false" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
    <meta http-equiv="Content-type" content="text/html;charset=UTF-8" />
    <title>
		<dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Billedredigering" />
	</title>
    <dw:ControlResources runat="server" IncludePrototype="true" IncludeScriptaculous="true" ></dw:ControlResources>
    <link type="text/css" rel="stylesheet" charset="utf-8" href="Edit.css" />
    <script type="text/javascript" language="javascript" charset="utf-8" src="Edit.js"></script>
    <script type="text/javascript" language="javascript">
        var winOpener = opener;
        var winPreview = opener.opener;
        var e = null;
        function page_load() {
            var image = $('image');
            e = new ImageEditor(image);
            initActions(e);
            initAjaxIndicator();
            initResizeDialog();
            initResizeSelectionDialog();
            initColorCorrectionDialog();
            initSaveAsDialog();
        };

        function help() {
            <%=Gui.Help("", "modules.filearchive.general.file.option.image.edit") %>
        }
    </script>
    <!--[if IE]><style>.hasLayout { zoom: 1; }</style><![endif]-->
</head>
<body onload="page_load()">
    <dw:Infobar Message="" runat="server" Type="Information" Title="No write permissions" Action="" ID="noAccessWarning" Visible="False"></dw:Infobar>
    <form id="form1" runat="server" onsubmit="return false;">
        <dw:Ribbonbar runat="server" ID="Toolbar">
	        <dw:RibbonbarTab ID="TabEditor" Active="true" Name="Image" runat="server">
	            <dw:RibbonbarGroup ID="GroupFile" Name="File" runat="server">
	                <dw:RibbonbarButton ID="cmdSaveAs" Image="SaveAs" Size="Large" Text="Gem som" runat="server"
	                    OnClientClick="e.executeSaveAs();" />
	                <dw:RibbonbarButton ID="cmdSave" KeyboardShortcut="ctrl+s" Image="Save" Size="Small" Text="Gem" runat="server"
	                    OnClientClick="e.executeSaveAndClose(false);" />
	                <dw:RibbonbarButton ID="cmdSaveAndClose" Image="SaveAndClose" Size="Small" Text="Gem og luk" runat="server"
	                    OnClientClick="e.executeSaveAndClose(true);" />
	                <dw:RibbonbarButton ID="cmdCancel" Image="Cancel" Size="Small" Text="Reset" runat="server"
	                    OnClientClick="e.executeCommand('cancel');" />
	            </dw:RibbonbarGroup>
	            <dw:RibbonbarGroup ID="GroupEdit" Name="Billede" runat="server">
	                <dw:RibbonbarButton ID="cmdResize" ImagePath="/Admin/Images/Filemanager/Resize.png" Size="Small" Text="Resize" runat="server"
	                    OnClientClick="e.executeResize();" />
	                <dw:RibbonbarButton ID="cmdCrop" ImagePath="/Admin/Images/Filemanager/Crop.png" Size="Small" Text="Crop" Disabled="true" runat="server"
	                    OnClientClick="e.executeCommand('crop');" />
	                <dw:RibbonbarButton ID="cmdResizeSelection" ImagePath="/Admin/Images/Filemanager/ResizeSelection.png" Size="Small" Text="Resize selection" Disabled="true" runat="server"
	                    OnClientClick="e.executeResizeSelection();" />
	            </dw:RibbonbarGroup>
	            <dw:RibbonbarGroup ID="GroupOptions" Name="Rotation" runat="server">
	                <dw:RibbonbarButton ID="cmdRotateCCW90" runat="server" Text="Rotate left 90<sup>o</sup>" ImagePath="/Admin/Images/Filemanager/RotateLeft.png" Size="Small"
	                    OnClientClick="e.executeCommand('rotateCCW90');" />
	                <dw:RibbonbarButton ID="cmdRotateCW90" runat="server" Text="Rotate right 90<sup>o</sup>" ImagePath="/Admin/Images/Filemanager/RotateRight.png" Size="Small"
	                    OnClientClick="e.executeCommand('rotateCW90');" />
	                <dw:RibbonbarButton ID="cmdRotate180" runat="server" Text="Rotate 180<sup>o</sup>" ImagePath="/Admin/Images/Filemanager/Rotate180.png" Size="Small"
	                    OnClientClick="e.executeCommand('rotate180');" />
	                <dw:RibbonbarButton ID="cmdFlipVertical" runat="server" Text="Flip vertical" ImagePath="/Admin/Images/Filemanager/FlipVertical.png" Size="Small"
	                    OnClientClick="e.executeCommand('flipVertical');" />
	                <dw:RibbonbarButton ID="cmdFlipHorizontal" runat="server" Text="Flip horisontal" ImagePath="/Admin/Images/Filemanager/FlipHorisontal.png" Size="Small"
	                    OnClientClick="e.executeCommand('flipHorizontal');" />
	            </dw:RibbonbarGroup>
	            <dw:RibbonbarGroup ID="groupHelp" runat="server" Name="Help">
	                <dw:RibbonbarButton ID="cmdHelp" runat="server" Text="Help" Image="Help" OnClientClick="help();" />
				</dw:RibbonbarGroup>
	        </dw:RibbonbarTab>
	        <dw:RibbonBarTab ID="TabEffects" Name="Effects" runat="server">
	            <dw:RibbonBarGroup ID="GroupEffects" Name="Effects" runat="server">
	                <dw:RibbonBarButton ID="cmdEffectColorCorrection" Size="Large" ImagePath="/Admin/Images/Ribbon/Icons/colors.png" Text="Color correction" runat="server"
	                    OnClientClick="e.executeEffectColorCorrection();" />
	                <dw:RibbonBarButton ID="cmdEffectGrayscale" Size="Small" ImagePath="/Admin/Images/Filemanager/Grayscale.png" Text="Grayscale" runat="server"
	                    OnClientClick="e.executeCommand('effectGrayscale');" />
	                <dw:RibbonBarButton ID="cmdEffectSepia" Size="Small" ImagePath="/Admin/Images/Filemanager/Sepia.png" Text="Sepia" runat="server"
	                    OnClientClick="e.executeCommand('effectSepia');" />
	                <dw:RibbonBarButton ID="cmdEffectBlackAndWhite" Size="Small" ImagePath="/Admin/Images/Filemanager/BlackAndWhite.png" Text="Black and white" runat="server"
	                    OnClientClick="e.executeCommand('effectBlackAndWhite');" />
	                <dw:RibbonBarButton ID="cmdEffectNegative" Size="Small" ImagePath="/Admin/Images/Filemanager/Negative.png" Text="Negative" runat="server"
	                    OnClientClick="e.executeCommand('effectNegative');" />
	            </dw:RibbonBarGroup>
	        </dw:RibbonBarTab>
	    </dw:Ribbonbar>
	<input id="originalImage" type="hidden" runat="server" />
	<input id="editedImage" type="hidden" runat="server" />
	<div id="rulerWrapper" class="hasLayout">
	    <div id="rulers" class="hasLayout">
		    <div id="imagearea" class="hasLayout">
			    <img id="image" class="hasLayout" src="#" alt="edited image" runat="server" />
			    <div id="image-crop" class="imageeditor-crop" oncontextmenu="<%= ContextMenu.GetContextMenuAction("ContextMenuSelection", "crop")%>"></div>
		    </div>
		</div>
    </div>
    <div id="statusBar">
		<span class="statusBarItem"><img src="/Admin/Images/Filemanager/CursorPosition.png" alt="" /><span id="imagestatus-cursor">0 x 0</span></span>
		<img src="/Admin/Images/Nothing.gif" class="seperator" alt="" />
		<span class="statusBarItem"><img src="/Admin/Images/Filemanager/SelectionSize.png" alt="" /> <span id="imagestatus-selection"><dw:TranslateLabel runat="server" Text="nothing selected" /></span>  </span>
		<img src="/Admin/Images/Nothing.gif" class="seperator" alt="" />
		<span class="statusBarItem"><img src="/Admin/Images/Filemanager/ImageSize.png" alt="" /><span id="imagestatus-size">image size</span></span>
		<img src="/Admin/Images/Nothing.gif" class="seperator" alt="" />
		<span class="statusBarItem"><img src="/Admin/Images/Filemanager/size.png" alt="" /><span id="imagestatus-filesize"><asp:Label runat="server" ID="imagestatusLabel">0 kb</asp:Label></span></span>
	</div>
    <div id="loading" style="display: none;">
    </div>
    
    <dw:ContextMenu ID="ContextMenuImage1" runat="server">
        <dw:ContextMenuButton Text="Resize image" Divide="None" runat="server"
            ImagePath="/Admin/Images/Filemanager/Resize.png" OnClientClick="e.executeResize();" />
        <dw:ContextMenuButton Text="Rotate left 90<sup>o</sup>" Divide="None" runat="server"
            ImagePath="/Admin/Images/Filemanager/RotateLeft.png" OnClientClick="e.executeCommand('rotateCCW90');"/>
        <dw:ContextMenuButton Text="Rotate right 90<sup>o</sup>" Divide="None" runat="server"
        ImagePath="/Admin/Images/Filemanager/RotateRight.png" OnClientClick="e.executeCommand('rotateCW90');"/>
        <dw:ContextMenuButton Text="Rotate 180<sup>o</sup>" Divide="None" runat="server"
        ImagePath="/Admin/Images/Filemanager/Rotate180.png" OnClientClick="e.executeCommand('rotate180');" />
        <dw:ContextMenuButton Text="Flip vertical" Divide="None" runat="server"
        ImagePath="/Admin/Images/Filemanager/FlipVertical.png" OnClientClick="e.executeCommand('flipVertical');" />
        <dw:ContextMenuButton Text="Flip horisontal" Divide="None" runat="server"
        ImagePath="/Admin/Images/Filemanager/FlipHorisontal.png" OnClientClick="e.executeCommand('flipHorizontal');" />
    </dw:ContextMenu>

    <dw:ContextMenu ID="ContextMenuSelection" runat="server">
        <dw:ContextMenuButton runat="server" Divide="None" Text="Resize selection"
            ImagePath="/Admin/Images/Filemanager/Resize.png" OnClientClick="e.executeResizeSelection();">
        </dw:ContextMenuButton>
        <dw:ContextMenuButton runat="server" Divide="None" runat="server" Text="Crop"
            ImagePath="/Admin/Images/Filemanager/Crop.png" OnClientClick="e.executeCommand('crop');">
        </dw:ContextMenuButton>
    </dw:ContextMenu>

    <dw:Dialog id="resizeDialog" runat="server" Width="300" Title="Resize"
        ShowOkButton = "true" OkAction = "e.executeResize(true);"
        ShowCancelButton = "true" CancelAction="dialog.hide('resizeDialog');">
        <div class="input-form">
            <fieldset>
            <legend><dw:TranslateLabel runat="server" Text="Resize" />:</legend>
            <table>
                <tr>
                    <td><img src="resize-horizontal.png" alt="-" /></td>
                    <th><label for="resizeDialogWidth"><dw:TranslateLabel runat="server" Text="Horizontal" />:</label></th>
                    <td><input type="text" id="resizeDialogWidth" maxlength="4" class="std" style="width:30px; text-align: center;" value="" /> px</td>
                </tr>
                <tr>
                    <td><img src="resize-vertical.png" alt="-" /></td>
                    <th><label for="resizeDialogHeight"><dw:TranslateLabel runat="server" Text="Vertical" />:</label></th>
                    <td><input type="text" id="resizeDialogHeight" maxlength="4" class="std" style="width:30px; text-align: center;" value="" /> px</td>
                </tr>
                <tr style="height:40px">
                    <td colspan="3" style="font-weight:bold;">
                        <input type="checkbox" id="resizeDialogMaintainAspectRatio"  value="" />
                        <label for="resizeDialogMaintainAspectRatio"><dw:TranslateLabel runat="server" Text="Maintain aspect ratio" /></label>
                    </td>
                </tr>
            </table>
            </fieldset>
        </div>
    </dw:Dialog>
    <dw:Dialog id="resizeSelectionDialog" runat="server" Width="300" Title="Resize selection"
        ShowOkButton = "true" OkAction = "e.executeResizeSelection(true);"
        ShowCancelButton = "true" CancelAction="dialog.hide('resizeSelectionDialog');">
        <div class="input-form">
            <fieldset>
            <legend><dw:TranslateLabel runat="server" Text="Resize selection" />:</legend>
            <table>
                <tr>
                    <td><img src="resize-horizontal.png" alt="-" /></td>
                    <th><label for="resizeSelectionWidth"><dw:TranslateLabel runat="server" Text="Horizontal" />:</label></th>
                    <td><input type="text" id="resizeSelectionWidth" maxlength="4" class="std" style="width:30px; text-align: center;" value="" /> px</td>
                </tr>
                <tr>
                    <td><img src="resize-vertical.png" alt="-" /></td>
                    <th><label for="resizeSelectionHeight"><dw:TranslateLabel runat="server" Text="Vertical" />:</label></th>
                    <td><input type="text" id="resizeSelectionHeight" maxlength="4" class="std" style="width:30px; text-align: center;" value="" /> px</td>
                </tr>
            </table>
            </fieldset>
        </div>
    </dw:Dialog>
    <dw:Dialog id="colorCorrectionDialog" runat="server" Width="450" Title="Color correction"
        ShowOkButton = "false"
        ShowCancelButton = "false">
        <div class="input-form">
            <fieldset>
            <legend><dw:TranslateLabel runat="server" Text="Color correction" />:</legend>
                <table>
                <tr>
                    <th><dw:TranslateLabel runat="server" Text="Brightness" />:</th><td><img src="/Admin/Images/Filemanager/Effects.png" alt="" /></td>
                    <td><div id="brightness-slider" class="slider-bg" style="width:209px;height:28px;">
                            <div id="brightness-slider-thumb" class="slider-thumb" style="width:17px;height:21px;"></div>
                        </div></td>
                    <td><input type="text" id="brightness-value" maxlength="3" class="std" style="width:30px; text-align: center;" value=""/></td>
                </tr>
                <tr>
                    <th><dw:TranslateLabel runat="server" Text="Contrast" />:</th><td><img src="/Admin/Images/Filemanager/Contrast.png" alt="" /></td>
                    <td><div id="contrast-slider" class="slider-bg" style="width:209px;height:28px;">
                            <div id="contrast-slider-thumb" class="slider-thumb" style="width:17px;height:21px;"></div>
                        </div></td>
                    <td><input type="text" id="contrast-value" maxlength="3" class="std" style="width:30px; text-align: center;" value=""/></td>
                </tr>
                <tr>
                    <th><dw:TranslateLabel runat="server" Text="Saturation" />:</th><td><img src="/Admin/Images/Filemanager/Saturation.png" alt="" /></td>
                    <td><div id="saturation-slider" class="slider-bg" style="width:209px;height:28px;">
                            <div id="saturation-slider-thumb" class="slider-thumb" style="width:17px;height:21px;"></div>
                        </div></td>
                    <td><input type="text" id="saturation-value" maxlength="3" class="std" style="width:30px; text-align: center;" value=""/></td>
                </tr>
            </table>            
            </fieldset>
            <div style="height: 30px;">
                <div style="text-align:right; padding-top:20px; float:right;">
                    <dw:Button runat="server" Name="Preview" OnClick="e.executeEffectColorCorrection(true, true);" />
                    <dw:Button runat="server" Name="Reset" OnClick="resetColorCorrectionSliders(); e.reloadImage();" />
                    <dw:Button runat="server" Name="Ok" CssClass="button" OnClick="e.executeEffectColorCorrection(true);" />
                    <dw:Button runat="server" Name="Cancel" OnClick="e.reloadImage(); dialog.hide('colorCorrectionDialog');" />
                </div>
            </div>
        </div>
    </dw:Dialog>
    <dw:Dialog id="SaveAsDialog" runat="server" Width="420" Title="Save as"
        ShowOkButton = "true" OkAction = "e.executeSaveAs(true);"
        ShowCancelButton = "true" CancelAction="dialog.hide('SaveAsDialog');">
        <div class="input-form">
            <fieldset>
            <legend><dw:TranslateLabel runat="server" Text="Save as" />:</legend>
            <table>
                <tr>
                    <th><label for="saveAsDialogDirectory"><dw:TranslateLabel runat="server" Text="Directory" />:</label></th>
                    <td><dw:FolderManager id="saveAsDialogDirectory" Name="saveAsDialogDirectory" Folder="" runat="server" /></td>
                </tr>
                <tr>
                    <th><label for="saveAsDialogFile"><dw:TranslateLabel runat="server" Text="File name" />:</label></th>
                    <td style="white-space:nowrap;">
                        <input type="text" id="saveAsDialogFile" name="saveAsDialogFile" class="std"/>
                    </td>
                </tr>
                <tr>
                    <th><label for="saveAsDialogType"><dw:TranslateLabel runat="server" Text="File type" />:</label></th>
                    <td>
                        <select id="saveAsDialogType" name="saveAsDialogType" class="std" style="width:50px;">
                            <option value="auto" selected="selected">auto</option>
                            <option value="bmp">bmp</option>
                            <option value="jpg">jpg</option>
                            <option value="gif">gif</option>
                            <option value="png">png</option>
                        </select>
                    </td>
                </tr>
                <tr id="saveAsDialogOptions_jpg" style="display:none;">
                    <th>
                        <label for="saveAsDialogJpegCompression"><dw:TranslateLabel runat="server" Text="Compression" />:</label>
                    </th>
                    <td>
                        <select id="saveAsDialogJpegCompression" name="saveAsDialogJpegCompression" class="std" style="width:50px;">
                            <option value="10">10</option>
                            <option value="20">20</option>
                            <option value="30">30</option>
                            <option value="40">40</option>
                            <option value="50">50</option>
                            <option value="60">60</option>
                            <option value="70">70</option>
                            <option value="80">80</option>
                            <option value="90" selected="selected">90</option>
                            <option value="100">100</option>
                        </select>
                    </td>
                </tr>
                <tr id="saveAsDialogOptions_gif" style="display:none;">
                    <th>
                        <label for="saveAsDialogGifColors"><dw:TranslateLabel runat="server" Text="Colors" />:</label>
                    </th>
                    <td>
                        <select id="saveAsDialogGifColors" name="saveAsDialogGifColors" class="std" style="width:50px;">
                            <option value="2">2</option>
                            <option value="4">4</option>
                            <option value="8">8</option>
                            <option value="16">16</option>
                            <option value="32">32</option>
                            <option value="64">64</option>
                            <option value="128">128</option>
                            <option value="256" selected="selected">256</option>
                        </select>
                    </td>
                </tr>
<%--                <tr id="saveAsDialogOptions_png" style="display:none;">
                    <th>
                        <label for="saveAsDialogPngBits">Bitdepth:</label>
                    </th>
                    <td>
                        <select id="saveAsDialogPngBits" name="saveAsDialogPngBits" class="std" style="width:50px;">
                            <option value="8">8</option>
                            <option value="24" selected="selected">24</option>
                        </select>
                    </td>
                </tr>
--%>            </table>
            </fieldset>
        </div>
    </dw:Dialog>
    </form>
</body>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()%>

</html>

