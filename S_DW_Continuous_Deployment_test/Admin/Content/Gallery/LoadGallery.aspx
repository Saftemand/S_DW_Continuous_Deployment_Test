<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LoadGallery.aspx.vb" Inherits="Dynamicweb.Admin.LoadGallery" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title><%=Dynamicweb.Backend.Translate.Translate("Module themes")%></title>
    <dw:ControlResources ID="ControlResources1" runat="server" IncludeUIStylesheet="true" IncludePrototype="true" IncludeScriptaculous="true" />
    <link href="LoadGallery.css" rel="Stylesheet" />
</head>
<body>
    <form id="GalleryForm" runat="server">
        
        <div id="MainContent">
            
            <!-- Hidden -->
            <input type="hidden" id="InstallZip" name="InstallZip" value="" />


            <!-- Main Div - List -->
            <div id="ListContent">
            
                <!-- Toolbar -->
                <dw:Toolbar runat="server" ShowEnd="false">
                    <dw:ToolbarButton runat="server" Text="Close" Image="Cancel" OnClientClick="window.close();" />
                    <dw:ToolbarButton runat="server" Text="Help" Image="Help" OnClientClick="help();" />
                </dw:Toolbar>
                
                <!-- Subtitle -->
                <h2 class="subtitle"><dw:TranslateLabel runat="server" Text="Install theme" /></h2>

                <asp:Panel runat="server" ID="ContentPanel" Visible="false">
                    
                    <!-- Loop super galleries -->
                    <asp:Repeater runat="server" ID="GalleriesSuperRepeater" >
                    
                        <ItemTemplate>
                    
                            <dw:GroupBox runat="server" id="SuperGalleryGroupBox" Title="" DoTranslation="true">
                                    
                                <asp:Panel runat="server" ID="NoGalleriesPanel" Visible="false">
                                    <p class="NoGalleriesText">
                                        <asp:Literal runat="server" ID="NoGalleriesText"></asp:Literal>
                                    </p>
                                </asp:Panel>
                                    
                                <asp:DataList runat="server" ID="GalleryList" RepeatColumns="2" RepeatDirection="Horizontal" RepeatLayout="Table" ItemStyle-CssClass="Item"  >
                                    <ItemTemplate>
                                        <table id="table_<%#Eval("UniqueID") %>" onmouseover="MouseOver(<%#Eval("UniqueID") %>);" onmouseout="MouseOut(<%#Eval("UniqueID") %>);" >
                                            <tr>
                                                <td class="ThumbCell">
                                                    <img src="<%# Eval("SmallPreviewUrl") %>" alt="" />
                                                </td>
                                                <td class="InfoCell">
                                                    <table>
                                                        <tr class="InfoTextRow">
                                                            <td class="TextCell">
                                                                <h1>
                                                                    <%#Eval("Title")%>
                                                                </h1>
                                                                <span class="ShortDescription">
                                                                    <%#Eval("ShortDescription")%>
                                                                </span>
                                                            </td>
                                                        </tr>
                                                        <tr class="InfoButtonRow">
                                                            <td class="button_panel">
                                                                <input type="button" class="button_hidden" id="InstallButton_<%#Eval("UniqueID") %>" value="<%=Dynamicweb.Backend.Translate.Translate("Install") %>" onclick="javascript:Install('<%#Eval("GalleryZipUrl") %>');"/>
                                                                <input type="button" class="button_hidden" id="PreviewButton_<%#Eval("UniqueID") %>" value="<%=Dynamicweb.Backend.Translate.Translate("Preview") %>" onclick="javascript:ShowDetail(<%#Eval("UniqueID") %>);"/>
                                                                <input type="button" class="button_hidden" id="DownloadButton_<%#Eval("UniqueID") %>"  value="<%=Dynamicweb.Backend.Translate.Translate("Download files") %>" onclick="javascript:location.href = '<%#Eval("GalleryZipUrl") %>';" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:DataList>
                                
                                
                            </dw:GroupBox>
                        </ItemTemplate>

                    </asp:Repeater>

                    <!-- Upload new gallery -->
                    <dw:GroupBox runat="server" Title="Install new theme">
                        <div style="margin:10px 10px 10px 10px;">
                            <dw:TranslateLabel runat="server" Text="Choose a zip file containing a theme to install it" /><br />
                            <asp:FileUpload runat="server" ID="UploadFile" /><br />
                            <input type="button" value="<%=Dynamicweb.Backend.Translate.Translate("Install") %>" onclick="InstallNewZip();" />
                        </div>
                    </dw:GroupBox>

                    <div style="height:53px"></div>
                    
                    <!-- Status bar -->
                    <div id="BottomInformationBg">
	                    <table border="0" cellpadding="0" cellspacing="0">
		                    <tr>
			                    <td rowspan="2">
			                        <img src="/Admin/Content/Gallery/Images/gallery.png" alt="" />
			                    </td>
			                    <td align="right">
		                            <span id="GalleryCount" class="label" runat="server"></span>
			                    </td>
		                    </tr>
		                    <tr>
			                    <td>&nbsp;</td>
		                    </tr>
	                    </table>
	                </div>
    	            
	            </asp:Panel>
    	        
	            <!-- Loading panel -->
	            <div runat="server" ID="LoadingPanel">
	                <div id="LoadingDiv">
	                    <img src="/Admin/Module/eCom_Catalog/images/ajaxloading.gif" alt="" /><br /><br />
	                    <div id="Loading_WaitingForGallerySite">
    	                    <dw:TranslateLabel runat="server" Text="Loading themes from Dynamicweb Gallery Theme Site" />
	                    </div>
	                    <div id="Loading_InstallingGallery" style="display:none;">
	                        <dw:TranslateLabel runat="server" Text="Installing theme" />
	                    </div>
    	                
	                </div>
	            </div>

            </div>

            <!-- Detail divs -->
            <asp:Repeater runat="server" ID="GalleryRepeater" >
                <ItemTemplate>
                    <!-- Hidden to store zip url -->
                    <input type="hidden" id="ZipUrl_<%#Eval("UniqueID") %>" value="<%#Eval("GalleryZipUrl") %>" />
                    
                    <div id="GalleryDetail_<%#Eval("UniqueID") %>" style="display:none;">

                        <!-- Toolbar -->
                        <dw:Toolbar runat="server" ID="DetailToolbar" ShowEnd="false">
                            <dw:ToolbarButton runat="server" ID="DetailToolbarInstall" Text="Install" Image="Module" OnClientClick="Install();" />
                            <dw:ToolbarButton runat="server" ID="DetailToolbarDownload" Text="Download files" Image="Folder" OnClientClick="DownloadZip();" />
                            <dw:ToolbarButton runat="server" ID="DetailToolbarBack" Text="Back" Image="Undo" OnClientClick="CloseDetail();" />
                            <dw:ToolbarButton runat="server" ID="DetailToolbarClose" Text="Close" Image="Cancel" OnClientClick="window.close();" />
                            <dw:ToolbarButton runat="server" ID="DetailToolbarHelp" Text="Help" Image="Help" OnClientClick="help();" />
                        </dw:Toolbar>
                        
                        <!-- Toolbar for preview only -->
                        <dw:Toolbar runat="server" ID="DetailToolbarPreviewOnly" ShowEnd="false" Visible="false">
                            <dw:ToolbarButton runat="server" Text="Download files" Image="Folder" OnClientClick="DownloadZip();" />
                            <dw:ToolbarButton runat="server" Text="Close" Image="Cancel" OnClientClick="window.close();" />
                        </dw:Toolbar>
                        
                        <!-- Subtitle -->
                        <h2 class="subtitle"><dw:TranslateLabel runat="server" Text="Preview" /></h2>
                        
                        <div class="PreviewDiv">
                            
                            <h1>
                                <%#Eval("Title")%>
                            </h1>
                            
                            <p class="Description">
                                <%#Eval("Description")%>
                            </p>
                            
                            <p class="HelpText">
                                <%#Eval("HelpText")%>
                            </p>
                            
                            <img id="preview_<%#Eval("UniqueID") %>_medium" 
                                 alt="" 
                                 style="cursor:pointer; display:none;" 
                                 onclick="javascript:switchImage(<%#Eval("UniqueID") %>, 'large')"
                                 title="<%=Dynamicweb.Backend.Translate.Translate("Click to enlarge") %>"
                            />
                            
                            <img id="preview_<%#Eval("UniqueID") %>_large"
                                 alt=""  
                                 style="cursor:pointer; display:none;" 
                                 onclick="javascript:switchImage(<%#Eval("UniqueID") %>, 'medium')" 
                                 title="<%=Dynamicweb.Backend.Translate.Translate("Click to scale down") %>"
                            />

                            <input type="hidden" id="preview_src_<%#Eval("UniqueID") %>_medium" value="<%# Eval("MediumPreviewUrl") %>" />
                            <input type="hidden" id="preview_src_<%#Eval("UniqueID") %>_large" value="<%# Eval("LargePreviewUrl") %>" />
                        </div>


                    </div>
                </ItemTemplate>
            </asp:Repeater>
            
                
        </div>
        
        <div id="RenamedFilesDiv" style="display:none;">
            <!-- Toolbar -->
            <dw:Toolbar runat="server" ShowEnd="false">
                <dw:ToolbarButton runat="server" Text="Close" Image="Cancel" OnClientClick="window.close();" />
            </dw:Toolbar>
            
            <!-- Subtitle -->
            <h2 class="subtitle"><dw:TranslateLabel runat="server" Text="Theme installed" /></h2>
            
            <div style="margin:10px 10px 10px 10px;">
            
                <span style="font-weight:bold"><dw:TranslateLabel runat="server" Text="The theme was successfully installed, but the following files had to be renamed because there were existing files with the same names:" /></span>
                <br /><br />
                <asp:Repeater runat="server" ID="RenamedFilesRepeater">
                    <ItemTemplate>
                        <%#CType(Container.DataItem, System.Collections.Generic.KeyValuePair(Of String, String)).Key%>&nbsp;
                        <dw:TranslateLabel runat="server" Text="was renamed to" />&nbsp;
                        <%#CType(Container.DataItem, System.Collections.Generic.KeyValuePair(Of String, String)).Value%><br />
                        
                    </ItemTemplate>
                    
                </asp:Repeater>
            </div>
            
        </div>

        
    </form>
    
    <script type="text/javascript">
        var selectedItem;

        if ('<%=Page.IsPostBack %>' == 'False' && <%=PreviewOnlyId %> == -1) {
            $('GalleryForm').submit();
        }

        function InstallNewZip() {
            // Check file
            if ($('UploadFile').value == '')
                return;

            // Show loading div
            ShowInstallingModule();

            // Submit
            document.forms[0].submit();
        }
        
        function ShowInstallingModule() {
            $('ContentPanel').style.display = 'none';
            $('Loading_WaitingForGallerySite').style.display = 'none';
            $('Loading_InstallingGallery').style.display = 'block';
            $('LoadingPanel').style.display = 'block';
        }
        

        function DownloadZip() {
            location.href = $('ZipUrl_' + selectedItem).value;
        }

        function Install(galleryZip) {
            if (!galleryZip)
                galleryZip = $('ZipUrl_' + selectedItem).value;

            // Show loading div
            ShowInstallingModule();

            $('InstallZip').value = galleryZip;
            $('GalleryForm').submit();
        }
    
        function MouseOver(itemIndex) {
            $('table_' + itemIndex).className = 'TableMouseOver';
            $('InstallButton_' + itemIndex).className = 'button_shown';
            $('PreviewButton_' + itemIndex).className = 'button_shown';
            $('DownloadButton_' + itemIndex).className = 'button_shown';
        }
        function MouseOut(itemIndex) {
            $('table_' + itemIndex).className = '';
            $('InstallButton_' + itemIndex).className = 'button_hidden';
            $('PreviewButton_' + itemIndex).className = 'button_hidden';
            $('DownloadButton_' + itemIndex).className = 'button_hidden';
        }
        function ShowDetail(itemIndex) {
            // Switch div
            $('ListContent').style.display = 'none';
            $('GalleryDetail_' + itemIndex).style.display = 'block';

            // Disable swapping images if medium image is the same as large image
            if ($('preview_src_' + itemIndex + '_medium').value == $('preview_src_' + itemIndex + '_large').value) {
                var mediumImg = $('preview_' + itemIndex + '_medium');
                mediumImg.onclick = '';
                mediumImg.style.cursor = '';
                mediumImg.title = '';
            }
             
            // Load medium image
            switchImage(itemIndex, 'medium');
           
            // Set selected item
            selectedItem = itemIndex;
        }
        function CloseDetail() {
            $('ListContent').style.display = 'block';
            $('GalleryDetail_' + selectedItem).style.display = 'none';
        }

        function switchImage(itemIndex, imageSize) {
            // Hide both
            $('preview_' + itemIndex + '_medium').style.display = 'none';
            $('preview_' + itemIndex + '_large').style.display = 'none';

            // Show selected
            var img = $('preview_' + itemIndex + '_' + imageSize);
            img.style.display = 'inline';
            if (img.src == '')
                img.src = $('preview_src_' + itemIndex + '_' + imageSize).value;
        }
    
        if ('<%=WasError %>' == 'True') {
            alert('<%=ErrorMessage %>');
        }

        if ('<%=HasAppliedGallery %>' == 'True') {
            if ('<%=renamedFiles.Count %>' != '0') {
                $('MainContent').style.display = 'none';
                $('RenamedFilesDiv').style.display = 'block';
            }

            alert('<%=Dynamicweb.Backend.Translate.JsTranslate("The theme was successfully applied to the paragraph.") %>');

            try {
                opener.reloadModuleSettings();
            } catch (ex) { }
            
            if ('<%=renamedFiles.Count %>' == '0')
                window.close();
        }

        if ('<%=InstallNewZipMessage %>' != '')
            alert('<%=InstallNewZipMessage %>');
        
        
        // Preview only
        if (<%=PreviewOnlyId %> != -1) {
            ShowDetail(<%=PreviewOnlyId %>);
        }
        
        //Help window
        function help() {
        <%=Dynamicweb.Gui.Help("", "page.paragraph.themes.explore") %>
        }
        
    </script>
    
</body>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
