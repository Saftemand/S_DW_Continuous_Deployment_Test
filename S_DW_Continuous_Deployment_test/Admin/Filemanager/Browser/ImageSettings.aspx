<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ImageSettings.aspx.vb" Inherits="Dynamicweb.Admin.ImageSettingsForm" %>
<%@ Register TagPrefix="dw" Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><dw:TranslateLabel ID="lbTitle" Text="Image settings" runat="server" /></title>
        <dw:ControlResources ID="ctrlResources" runat="server"></dw:ControlResources>

        <style type="text/css">
            html, body
            {
                background-color: #f0f0f0;
                overflow: hidden;
                border-right: none !important;
            }
            
            div.grid-container
            {
	            margin-top: 10px;
	            margin-left: 4px;
	            margin-right: 4px;
	            border: 1px solid #bdcce0;
	            height: 110px;
	            overflow: auto;
	            background-color: #ffffff;
            }

            .popup-progress
            {
	            padding-top: 150px !important;
	            height: 280px !important;
            }
        </style>

	    <script type="text/javascript">

	        function onLoadSettingForm() {
                <%if WorkMode = Mode.AllSettings or WorkMode = Mode.OnlyResize Then %>
	                if (!$('chkImgIsActive').checked) onImgIsActiveChecked($('chkImgIsActive'));
	                if ($('chkImgOverwriteOriginal').checked) onImgOverwriteChecked($('chkImgOverwriteOriginal'));
	                $('chkOutputFormat').disabled = $('chkImgOverwriteOriginal').checked; 
	            <%End If%>
	            var subTitle = "<%=Translate.Translate("inactive")%>";
	            <%If ResizeSettingsMode = ImageHandling.ResizeSettingsMode.Inactive Then%>
	            disableResizeSettingsProperties(true, false, subTitle);
	            <% ElseIf ResizeSettingsMode = ImageHandling.ResizeSettingsMode.Inherited Then%>
	            subTitle = "<%=Translate.Translate("inherited")%>";
	            disableResizeSettingsProperties(true, false, subTitle);
                <% Else%>
	            disableResizeSettingsProperties(false, undefined, subTitle);
	            <%End If%>
	            $("chkImgIsActive").on("click", function (e, el) {
	                disableResizeSettingsProperties(!el.checked, undefined, subTitle);
	            });
	        }

	        function disableResizeSettingsProperties(disable, isActive, subtitle) {
	            if (!window.resizeSettigsTitle) {
	                window.resizeSettigsTitle = $$(".gb-resize-images legend")[0].innerHTML;
	            }

	            var title = window.resizeSettigsTitle;
	            if (disable) {
	                title += "(" + subtitle + ")";
	            }
	            if (isActive !== undefined) {
	                $("chkImgIsActive").checked = isActive;
	            }
	            $$(".gb-resize-images legend")[0].innerHTML = title;
	            $("txtImgWidth").disabled = disable;
	            $("txtImgHeight").disabled = disable;
	            $("cboImgCrop").disabled = disable;
	            $("cboImgQuality").disabled = disable;
	            $("chkImgOverwriteOriginal").disabled = disable;
	            $("txtImgPostfix").disabled = disable;
	            $("chkOutputFormat").disabled = disable;
	            $("cboOutputFormat").disabled = disable;
	            $("chkLimitExtensions").disabled = disable;
	            $("txtLimitExtensions").disabled = disable;
	            $("chkApplySettingsToSubfolders").disabled = disable;
	        }

	        function onImgIsActiveChecked(sender) {
                var isEnable = sender.checked;
                SetValidatorEnable($('ImgWidthValidator'), isEnable);
                SetValidatorEnable($('ImgHeightValidator'), isEnable);
                SetValidatorEnable($('ImgDimensionsValidator'), isEnable);
                SetValidatorEnable($('ImgPostfixRequiredValidator'), isEnable && !$('chkImgOverwriteOriginal').checked);
                SetValidatorEnable($('ImgPostfixRegularExpressionValidator'), isEnable && !$('chkImgOverwriteOriginal').checked);
	        }

	        function onImgOverwriteChecked(sender) {
	            $('divNewImagePostfix').style.display = sender.checked ? 'none' : '';

                var isEnable = sender.checked;
	            if (isEnable) {
	                $('chkOutputFormat').checked = false;
	                $('cboOutputFormat').style.display = 'none';
	            }
	            $('chkOutputFormat').disabled = sender.checked;
	            SetValidatorEnable($('ImgPostfixRequiredValidator'), !isEnable && $('chkImgIsActive').checked);
	            SetValidatorEnable($('ImgPostfixRegularExpressionValidator'), !isEnable && $('chkImgIsActive').checked);
	        }

            function SetValidatorEnable(val, isEnable){
                ValidatorEnable(val, isEnable);
                if (isEnable){
                    // ValidatorEnable, when enabled, is fires validation, that is not good, but we trick it:)
                    val.isvalid = true;
                    ValidatorUpdateDisplay(val);
                }
            }

	        function onOutputFormatChecked(sender) {
	            $('cboOutputFormat').style.display = sender.checked ? '' : 'none';
	        }

	        function onLimitExtensionsChecked(sender) {
	            $('divLimitExtensions').style.display = sender.checked ? '' : 'none';
	        }

	        function onPutInsubfolderChecked(sender) {
	            $('divSubfolderName').style.display = sender.checked ? '' : 'none';
	            $('divThumbPostfix').style.display = sender.checked ? 'none' : '';
	        }

	        function validateImgDimensions(sender, args) {
	            var w = parseInt($('txtImgWidth').value);
	            var h = parseInt($('txtImgHeight').value);
	            if ($('cboImgCrop').value == '5') {
	                args.IsValid = (h > 0 || w > 0);
	                $('ImgDimensionsValidator').innerHTML = "Specify width or height";
	            }
	            else {
	                args.IsValid = (h > 0 && w > 0);
	                $('ImgDimensionsValidator').innerHTML = "Specify width and height";
	            }
	        }

	        function closeDialog(needConfirm, reload) {
	            //top.right.document.getElementById('imageSettingsPopUp').style.display = "none";
                if (needConfirm)
                {
                    if (confirm('<%= Translate.JsTranslate("Are you sure you want to perform a resize?") %>'))
	                    window.parent.applyImageSettings(true);
                    else
                    {
                        var src = document.location.href.replace("&action=reload", "");
                        document.location.href = src + "&action=reload"
                    }
                }
                else	window.parent.applyImageSettings(reload);
	            return reload;
            }

            /*gridThumbnails events*/
            function addThmb(){
                dwGrid_gridThumbnails.addRow();
                var inputs = $$('#gridThumbnails input[type="checkbox"]');
                if (inputs.length == 1) inputs[0].checked = true;
            }

            function delThmb(link){
                var row = dwGrid_gridThumbnails.findContainingRow(link);
                if (row) {
                    if (confirm('<%= Translate.JsTranslate("Do you want to delete this row?") %>')) {
                        dwGrid_gridThumbnails.deleteRows([row]);
                    }
                }
            }

	    </script>
</head>
<body onload="onLoadSettingForm();">
    <dw:Infobar Message="" runat="server" Type="Information" Title="No write permissions" Action="" ID="noAccessWarning" Visible="False"></dw:Infobar>
    <form id="settingForm" runat="server" >
            <div>
                <dw:GroupBox ID="gbResizeImages" Title="Resize images in folder" runat="server" ClassName="gb-resize-images">
                    <table border="0" width="100%">
                        <tr>
                            <td width="120px">
                                <dw:TranslateLabel ID="lblIsActive" Text="Active" runat="server" />
                            </td>
                            <td width="100px">
                                <asp:CheckBox ID="chkImgIsActive" Checked="true" runat="server" onclick="onImgIsActiveChecked(this);" />
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="lblWidth" Text="Width" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox class="std" ID="txtImgWidth" Width="50" MaxLength="5" runat="server" />
                            </td>
                            <td align="right" style="padding-right: 5px;">
                                <asp:RegularExpressionValidator Display="Dynamic" ID="ImgWidthValidator" ValidationExpression="[0-9]+" ControlToValidate="txtImgWidth"
                                    runat="server" ErrorMessage="Only numbers allowed"  ValidationGroup="imgValidationGroup" />
                                <asp:CustomValidator Display="Dynamic" ID="ImgDimensionsValidator" ClientValidationFunction="validateImgDimensions" 
                                    runat="server" ErrorMessage="Specify width and height"   ValidationGroup="imgValidationGroup" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="lblHeight" Text="Height" runat="server" />
                            </td>
                            <td>
                                <asp:TextBox class="std" ID="txtImgHeight" Width="50" MaxLength="5" runat="server" />
                            </td>
                            <td align="right" style="padding-right: 5px;">
                                <asp:RegularExpressionValidator Display="Dynamic" ID="ImgHeightValidator" ValidationExpression="[0-9]+" ControlToValidate="txtImgHeight"
                                    runat="server" ErrorMessage="Only numbers allowed"  ValidationGroup="imgValidationGroup" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="lblCropOffset" Text="Crop offset" runat="server" />
                            </td>
                            <td colspan="2">
                                <asp:DropDownList  class="std" ID="cboImgCrop" runat="server" style="width: 150px">
                                    <asp:ListItem Text="Center" Value="0" />
                                    <asp:ListItem Text="From upper left" Value="1" />
                                    <asp:ListItem Text="From lower left" Value="2" />
                                    <asp:ListItem Text="From lower right" Value="3" />
                                    <asp:ListItem Text="From upper right" Value="4" />
                                    <asp:ListItem Text="Keep aspect ratio" Value="5" Selected="True" />
                                    <asp:ListItem Text="Fit image" Value="6" />
                                </asp:DropDownList>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="lblQuality" Text="Quality" runat="server" />
                            </td>
                            <td>
                                <select runat="server" class="std" id="cboImgQuality" style="width: 150px">
	                                 <option value="10">10</option>
	                                 <option value="20">20</option>
	                                 <option value="30">30</option>
	                                 <option value="40">40</option>
	                                 <option value="50">50</option>
	                                 <option value="60">60</option>
	                                 <option value="70">70</option>
	                                 <option value="80">80</option>
	                                 <option value="90">90</option>
	                                 <option value="100" selected="selected">100</option>
	                            </select>
                            </td>
                            <td  align="right" style="padding-right: 5px;">
                                <asp:RegularExpressionValidator Display="Dynamic" ID="ImgPostfixRegularExpressionValidator" ValidationExpression="[a-zA-Z0-9\-_()]+" ControlToValidate="txtImgPostfix"
                                        runat="server" ErrorMessage="Value is not valid"  ValidationGroup="imgValidationGroup" />
                                <asp:RequiredFieldValidator  Display="Dynamic"  ID="ImgPostfixRequiredValidator" ControlToValidate="txtImgPostfix"
                                        runat="server" ErrorMessage="Required value" ValidationGroup="imgValidationGroup" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="lblOverwrite" Text="Overwrite original" runat="server" />
                            </td>
                            <td>
                                <asp:CheckBox  ID="chkImgOverwriteOriginal" Checked="true" runat="server" onclick="onImgOverwriteChecked(this);" />
                            </td>
                            <td align="right" style="padding-right: 5px;">
                                <div id="divNewImagePostfix" runat="server">
                                    <dw:TranslateLabel ID="lblNewImagePostfix" Text="Resized image postfix" runat="server" />
                                    <asp:TextBox class="std" ID="txtImgPostfix" Width="150" runat="server" /> 
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="lblOutputFormat" Text="Enforce output format" runat="server" />
                            </td>
                            <td>
                                <asp:CheckBox  ID="chkOutputFormat" runat="server" onclick="onOutputFormatChecked(this);" />
                            </td>
                            <td align="right" style="padding-right: 5px;">
                                    <asp:DropDownList style="width: 252px;" class="std" ID="cboOutputFormat" runat="server">
                                    </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="lblLimitExtensions" Text="Limit to these extensions" runat="server" />
                            </td>
                            <td>
                                <asp:CheckBox  ID="chkLimitExtensions" runat="server" onclick="onLimitExtensionsChecked(this);" />
                            </td>
                            <td align="right"  style="padding-right: 5px;">
                                <div id="divLimitExtensions" runat="server">
                                    <asp:TextBox class="std" ID="txtLimitExtensions" runat="server" />
                                    <img style="position: absolute" title="<%= Translate.Translate("Use comma as separator (.png, .gif, e.t.c.)") %>" src="/Admin/Images/Ribbon/Icons/Small/information.png" />
                                </div>
                            </td>
                        </tr>
                        <%If Base.HasVersion("8.6.1.0") Then%>	
                        <tr>
                            <td>
                                <dw:TranslateLabel ID="TranslateLabel1" Text="Apply to subfolders" runat="server" />
                            </td>
                            <td>
                                <asp:CheckBox  ID="chkApplySettingsToSubfolders" runat="server" />
                            </td>
                            <td>
                            </td>
                        </tr>
                        <%End If%>	
                    </table>
                </dw:GroupBox>
                <br />
                <dw:GroupBox ID="gbThumbnails" Title="Thumbnails" runat="server">
                    <div class="grid-container">
                        <dw:EditableGrid runat="server" ID="gridThumbnails" ClientIDMode="AutoID" AllowAddingRows="True" AutoGenerateColumns="false">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelected" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField >
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" ID="txtWidth" Text="" CssClass="NewUIinput" style="width: 40px;" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" ID="txtHeight" Text="" CssClass="NewUIinput" style="width: 40px;" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                         <select runat="server" class="std" id="cboCrop" style="width: 120px">
	                                         <option value="0">Center</option>
	                                         <option value="1">From upper left</option>
	                                         <option value="2">From lower left</option>
	                                         <option value="3">From lower right</option>
	                                         <option value="4">From upper right</option>
	                                         <option value="5" selected="selected">Keep aspect ratio</option>
	                                         <option value="6">Fit image</option>
	                                    </select>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                         <select runat="server" class="std" id="cboQuality" style="width: 50px">
	                                         <option value="10">10</option>
	                                         <option value="20">20</option>
	                                         <option value="30">30</option>
	                                         <option value="40">40</option>
	                                         <option value="50">50</option>
	                                         <option value="60">60</option>
	                                         <option value="70">70</option>
	                                         <option value="80">80</option>
	                                         <option value="90">90</option>
	                                         <option value="100" selected="selected">100</option>
	                                    </select>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ControlStyle-Width="20">
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" ID="txtPostfix" Text="" CssClass="NewUIinput" style="width: 100px;" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField >
                                    <ItemTemplate>
                                        <asp:TextBox runat="server" ID="txtSubfolder" Text="" CssClass="NewUIinput" style="width: 140px;" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="20px">
                                    <ItemTemplate>
                                        <span>
                                            <img id="imgError" runat='server' src="/Admin/Images/Ribbon/Icons/Small/Error.png" style="display: none" alt="" title="" border="0" />
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-Width="20px">
                                    <ItemTemplate>
                                        <span>
                                            <a href="javascript:void(0);" onclick="javascript:delThmb(this);">
                                                <img src="/Admin/Images/Ribbon/Icons/Small/Delete.png" alt="" title="<%= Translate.Translate("Delete")%>" border="0" />
                                            </a>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </dw:EditableGrid>
                    </div>
                </dw:GroupBox>
                <table width="100%">
                <tr>
                    <td align="right">
                         <div class="popup-dialog-buttons">
                            <asp:Button ID="btnSave" runat="server" Text="Ok"  CssClass="newUIbutton" OnClick="SaveButtonClick" ValidationGroup="imgValidationGroup" />
                            <button onclick="closeDialog(false, false);" class="dialog-button-cancel" type="button"><%= Translate.Translate("Cancel")%></button>
                        </div>                   
                    </td>
                </tr>
                </table>
            </div>

    </form>    

    <%Translate.GetEditOnlineScript()%>
    </body>
</html>
