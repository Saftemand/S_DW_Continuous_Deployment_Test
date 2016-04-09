<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="GetImage.aspx.vb"  Inherits="Dynamicweb.Admin.GetImage" Async="true" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Get image</title>
    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" runat="server" />
    <link href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET" />
    <link href="/Admin/Module/Common/Stylesheet.css" type="text/css" rel="stylesheet" />
    <script src="/Admin/Content/JsLib/prototype-1.6.0.2.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        function validateResolution(sender, args) {
            args.IsValid = validateRange('Resolution', 72, 300);
        }

        function validateCompression(sender, args) {
            args.IsValid = validateRange('Compression', 1, 100);
        }

        function validateColors(sender, args) {
            args.IsValid = validateRange('Colors', 1, 256);
        }

        function validateRange(id, from, to) {
            var val = document.getElementById(id).value;
            var valInt = -1;
            var ret = false;

            ret = val.match(/[0-9]+/);
            if (ret) {
                valInt = parseInt(val);
                ret = (val >= from && val <= to);
            }

            return ret;
        }

        function validateDimensions(sender, args) {
            var w = document.getElementById('Width').value;
            var h = document.getElementById('Height').value;
            args.IsValid = (h.length > 0 || w.length > 0);
        }

        function validateFileName(sender, args) {
            var val = document.getElementById('Filename').value;
            args.IsValid = ((val.length == 0) ||
	                (val.indexOf('/') < 0 && val.indexOf('\\') < 0));
            if(args.IsValid){
                var strArray = val.split('.');
                if(strArray.length == 1){
                    document.getElementById('Filename').value = val + "." +  document.getElementById('Format').value;
                }
                else{
                    document.getElementById('Filename').value = strArray[0] + "." +  document.getElementById('Format').value;
                }
            }
        }

        function onDimensionsChanged() {
            var w = document.getElementById('Width').value;
            var h = document.getElementById('Height').value;
            if(h.length > 0 || w.length > 0){
                document.getElementById('DimensionsValidator').style.display = 'none';
            }
        }

        function saveAndClose() {
            $('DoSaveAndClose').value = 'True';
            document.getElementById('form1').submit();
        }

        function save() {
            $('DoSave').value = 'True';
            document.getElementById('form1').submit();
        }

        function showStartFrame() {
            location = '/Admin/Content/Management/Start.aspx';
        }

        function help() {
            <%=Gui.Help("", "administration.managementcenter.designer.imagehandler") %>
        }

        function validateAltFile() {
            var altFile = document.getElementById('altFmImage_path');
            if(altFile==""){
            alert("Specify AltFile");
            }
        }
        
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <input type="hidden" id="DoSaveAndClose" name="DoSaveAndClose" />
    <input type="hidden" id="DoSave" name="DoSave" />
    <dw:Toolbar ID="Toolbar" runat="server" ShowEnd="false">
        <dw:ToolbarButton ID="ButtonSave" runat="server" Image="Save" Text="Save" OnClientClick="save();" />
        <dw:ToolbarButton ID="ButtonSaveAndClose" runat="server" Image="SaveAndClose" Text="Save and close"
            OnClientClick="saveAndClose();" />
        <dw:ToolbarButton ID="ButtonCancel" runat="server" Image="Cancel" Text="Cancel" OnClientClick="javascript:showStartFrame();" />
        <dw:ToolbarButton ID="ButtonHelp" runat="server" Image="Help" Text="Help" OnClientClick="help();" />
    </dw:Toolbar>
    <h2 class="subtitle">
        <dw:TranslateLabel ID="TranslateLabel1" Text="Image handler" runat="server" />
    </h2>
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr valign="top">
            <td>
                <dw:GroupBoxStart doTranslation="True" ID="gbBasicOptionsStart" Title="General"
                    runat="server" />
                <table width="100%">
                    <tr>
                        <td width="150">
                            <dw:TranslateLabel ID="TranslateLabel2" Text="File" runat="server" />
                        </td>
                        <td>
                            <dw:FileManager ID="Image" ShowPreview="false" Name="fmImage" Extensions="jpg,png,gif,jpeg,bmp"
                                runat="server" FullPath="true" />
                        </td>
                        <td align="right">
                            <asp:Label ID="ValidImageFile" runat="server"  Text="Specify image file" style="display: none;"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td width="150">
                            <dw:TranslateLabel ID="TranslateLabel3" Text="Alternative file" runat="server" />
                        </td>
                        <td>
                            <dw:FileManager ID="AlternativeImage" ShowPreview="false" Name="altFmImage"
                                Extensions="jpg,png,gif,jpeg,bmp" runat="server" FullPath="true" OnChange="validateAltFile();"/>
                        </td>
                        <td align="right">
                            <asp:Label ID="Label1" runat="server" Text="Specify alternative image file" style="color: red; display: none;"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="TranslateLabel4" Text="Width" runat="server" />
                        </td>
                        <td>
                            <asp:TextBox ID="Width" CssClass="std" Width="50" MaxLength="5" runat="server" />
                        </td>
                        <td align="right">
                            <asp:RegularExpressionValidator ID="WidthValidator" ValidationExpression="[0-9]+"
                                ControlToValidate="Width" runat="server" ErrorMessage="Only numbers allowed" />
                        </td>

                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="TranslateLabel5" Text="Height" runat="server" />
                        </td>
                        <td>
                            <asp:TextBox ID="Height" CssClass="std" Width="50" MaxLength="5" runat="server" />
                        </td>
                        <td align="right">
                            <asp:RegularExpressionValidator Display="Dynamic" ID="HeightValidator" ValidationExpression="[0-9]+"
                                ControlToValidate="Height" runat="server" ErrorMessage="Only numbers allowed" />
                            <asp:CustomValidator Display="Dynamic" ID="DimensionsValidator" ClientValidationFunction="validateDimensions" runat="server"
                                OnServerValidate="ValidateDimensions" ErrorMessage="Specify width or height" />
                        </td>
                    </tr>
                </table>
                <dw:GroupBoxEnd ID="gbBasicOptionsEnd" runat="server" />
                <dw:GroupBoxStart ID="gbImageOptionsStart" doTranslation="True" Title="Image" runat="server" />
                <table width="100%">
                    <tr>
                        <td width="150">
                            <dw:TranslateLabel ID="TranslateLabel6" Text="Color mode" runat="server" />
                        </td>
                        <td>
                            <asp:DropDownList ID="ColorSpace" CssClass="std" runat="server">
                                <asp:ListItem Text="RGB" Value="RGB" Selected="True" />
                                <asp:ListItem Text="CMYK" Value="CMYK" />
                                <asp:ListItem Text="Gray scale" Value="Grayscale" />
                            </asp:DropDownList>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="TranslateLabel7" Text="Crop offset" runat="server" />
                        </td>
                        <td colspan="2">
                            <asp:DropDownList ID="Crop" runat="server">
                                <asp:ListItem Text="Center" Value="0" Selected="True" />
                                <asp:ListItem Text="From upper left" Value="1" />
                                <asp:ListItem Text="From lower left" Value="2" />
                                <asp:ListItem Text="From lower right" Value="3" />
                                <asp:ListItem Text="From upper right" Value="4" />
                                <asp:ListItem Text="Keep aspect ratio" Value="5" />
                                <asp:ListItem Text="Fit image" Value="6" />
                            </asp:DropDownList>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="TranslateLabel8" Text="Format" runat="server" />
                        </td>
                        <td>
                            <asp:DropDownList CssClass="std" ID="Format" runat="server" AutoPostBack="True" CausesValidation="False">
                                <asp:ListItem Text="JPEG" Value="jpg" Selected="True" />
                                <asp:ListItem Text="GIF" Value="gif" />
                                <asp:ListItem Text="PNG" Value="png" />
                                <asp:ListItem Text="TIFF" Value="tiff" />
                                <asp:ListItem Text="BMP" Value="bmp" />
                                <asp:ListItem Text="PSD" Value="psd" />
                                <asp:ListItem Text="PDF" Value="pdf" />
                            </asp:DropDownList>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr id="rowJPEG" runat="server" visible="False">
                        <td width="150">
                            <dw:TranslateLabel ID="TranslateLabel9" Text="Compression" runat="server" />
                        </td>
                        <td>
                            <asp:TextBox CssClass="std" ID="Compression" Width="50" MaxLength="3" runat="server" />
                        </td>
                        <td align="right">
                            <asp:CustomValidator ID="CompressionValidator" ClientValidationFunction="validateCompression"
                                OnServerValidate="ValidateCompression" ControlToValidate="Compression" runat="server"
                                ErrorMessage="Value is not valid" />
                        </td>
                    </tr>
                    <tr id="rowGIF" runat="server" visible="False">
                        <td width="150">
                            <dw:TranslateLabel ID="TranslateLabel10" Text="Colors" runat="server" />
                        </td>
                        <td>
                            <asp:TextBox CssClass="std" ID="Colors" Width="50" MaxLength="3" runat="server" />
                        </td>
                        <td align="right">
                            <asp:CustomValidator ID="ColorsValidator" ClientValidationFunction="validateColors"
                                OnServerValidate="ValidateColors" ControlToValidate="Colors" runat="server" ErrorMessage="value is not valid" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="TranslateLabel11" Text="Resolution" runat="server" />
                        </td>
                        <td>
                            <asp:TextBox ID="Resolution" MaxLength="3" CssClass="std" Width="50" runat="server" />
                        </td>
                        <td align="right">
                            <asp:CustomValidator ID="ResolutionValidator" ControlToValidate="Resolution" ClientValidationFunction="validateResolution"
                                OnServerValidate="ValidateResolution" runat="server" ErrorMessage="Value is not valid" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            
                        </td>
                        <td align="left" style="width:15px;">
                            <input type="checkbox" id="DoNotUpscale" name="DoNotUpscale" value="True" runat="server" />
							<label for="DoNotUpscale"><dw:TranslateLabel ID="TranslateLabel16" Text="Do not upscale" runat="server" /></label>
                        </td>
                        <td style="color:#a9a9a9;" align="left">
                            <dw:TranslateLabel ID="UpscaleHint" Text="If width and height is more than original image size then checkbox will be set automatically." runat="server" />
                        </td>
                    </tr>
                </table>
                <dw:GroupBoxEnd ID="gbImageOptionsEnd" runat="server" />
                <dw:GroupBoxStart doTranslation="True" ID="gbMiscOptionsStart" Title="Miscellaneous"
                    runat="server" />
                <table width="100%">
                    <tr>
                        <td width="150">
                            <dw:TranslateLabel ID="TranslateLabel12" Text="File name" runat="server" />
                        </td>
                        <td>
                            <asp:TextBox ID="Filename" CssClass="std" runat="server"/>
                        </td>
                        <td align="right">
                            <asp:CustomValidator ID="FileNameValidator" ClientValidationFunction="validateFileName"
                                OnServerValidate="ValidateFileName" ControlToValidate="Filename" ErrorMessage="Value is not valid"
                                runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                           
                        </td>
                        <td>
                            <input type="checkbox" id="ForceDownload" name="ForceDownload" value="True" runat="server" />
							<label for="ForceDownload"><dw:TranslateLabel ID="TranslateLabel13" Text="Download" runat="server" /></label>
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
                <dw:GroupBoxEnd ID="gbMiscOptionsEnd" runat="server" />
                <dw:GroupBoxStart doTranslation="True" ID="gbResultsStart" Title="Results" runat="server" />
                <table width="100%">
                    <tr>
                        <td width="150">
                            <asp:Button ID="cmdOK" class="std" Width="100" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="TranslateLabel14" Text="Image URL" runat="server" />
                        </td>
                        <td> 
                            <asp:TextBox ID="txURL" CssClass="std" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dw:TranslateLabel ID="TranslateLabel15" Text="Image SRC" runat="server" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtSRC" CssClass="std" runat="server" />
                        </td>
                    </tr>
                </table>
                <table width="100%">
                    <tr>
                        <td colspan="2">
                             <asp:Label ID="ImageLabel" runat="server"  Text="Image"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
	                        <div id="imagewrap" style="border:1px dashed #a9a9a9" runat="server" visible="false">
								<asp:Image ID="imgImage" runat="server" Visible="false" />           
							</div>                 
                        </td>
                    </tr>
                </table>
                <dw:GroupBoxEnd ID="gbResultsEnd" runat="server" />
            </td>
        </tr>
    </table>
    </form>
    <% Translate.GetEditOnlineScript()%>
    <script type="text/javascript">
        // Do close?
        if ('<%=DoClose %>' == 'True')
            showStartFrame();

        // Init the save-flag
        $('DoSaveAndClose').value = 'False';
        $('DoSave').value = 'False';
    </script>
</body>
</html>
